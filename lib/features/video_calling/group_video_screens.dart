import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:developer';
import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/models/agora_user.dart';
import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/sessions/data/repository/all_session_repository.dart';
import 'package:zanadu/features/sessions/widgets/feedback_dialog.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/video_calling/chat_screen.dart';
import 'package:zanadu/features/video_calling/logic/chat_provider.dart';
import 'package:zanadu/features/video_calling/widgets/build_container.dart';
import 'package:zanadu/widgets/format_duration_call.dart';
import 'package:zanadu/widgets/generate_username.dart';
import 'package:zanadu/widgets/video_call_appbar.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart' as RtcRemoteView;
import 'package:agora_rtc_engine/agora_rtc_engine.dart' as RtcLocalView;

class GroupVideoCallNew extends StatefulWidget {
  final String channelId;
  final String sessionId;
  final int uid;
  final String chatroomId;
  const GroupVideoCallNew(
      {Key? key,
      required this.channelId,
      required this.sessionId,
      required this.uid,
      required this.chatroomId})
      : super(key: key);

  @override
  State<GroupVideoCallNew> createState() => _GroupVideoCallNewState();
}

class _GroupVideoCallNewState extends State<GroupVideoCallNew> {
  // Height of the video container

  AllSessionRepository allSessionRepository = AllSessionRepository();

  Future<void> attendSession() async {
    await allSessionRepository.attendSession(widget.sessionId);
  }

  bool isLoading = true;

  double left = max(0, screenWidth - 150); // Width of the video container
  double top = max(0, screenHeight - 410);

  int volume = 100;

  bool myMute = false;
  bool myVideo = false;

  Map<int, bool> isMutedMap = {};
  Map<int, bool> isVideoMap = {};

  late StreamController<int> _timerStreamController;
  late AgoraClient client;

  bool isTimerRunning = false;
  late Timer timer = Timer(Duration.zero, () {});

  int durationInSeconds = 0;

  List<int> remoteUsers = [];
  Map<int, String> userInfos = {};

  // Update channel media options to publish camera or screen capture streams

  void startTimer() {
    if (mounted) {
      if (!isTimerRunning) {
        isTimerRunning = true;
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (mounted) {
            setState(() {
              durationInSeconds++;
              _timerStreamController.add(durationInSeconds);
            });
          }
        });
      }
    }
  }

  void stopTimer() {
    isTimerRunning = false;
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();

    _timerStreamController = StreamController<int>();

    client = AgoraClient(
      agoraRtmClientEventHandler: AgoraRtmClientEventHandler(
        onMessageReceived: (RtmMessage m, String s) async {
          if (m.text == "Mute") {
            setState(() {
              myMute = true;
            });
            await client.engine.muteLocalAudioStream(true);
          }
          if (m.text == "Video") {
            setState(() {
              myVideo = true;
            });

            await client.engine.muteLocalVideoStream(true);
          }
        },
        onTokenExpired: () {},
      ),
      agoraRtmChannelEventHandler: AgoraRtmChannelEventHandler(
        onMessageReceived: (message, fromMember) {
          String jsonString = message.text;
          Map<String, dynamic> jsonMap = jsonDecode(jsonString);

          int uid = jsonMap['rtcId'];

          print("new user joined $jsonMap");

          if (uid == widget.uid) {
            String username = jsonMap['username'] ?? '';
            setState(() {
              remoteUsers.add(uid);
              isMutedMap[uid] = false;
              isVideoMap[uid] = false;
              userInfos[uid] = username;
            });
          }
        },
      ),
      agoraEventHandlers: AgoraRtcEventHandlers(
        onStreamMessageError: (f, df, ddf, dfdfe, effd, ere) {
          print("error");
        },
        onStreamMessage: (
          RtcConnection connection,
          int uid,
          int streamId,
          Uint8List data,
          int length,
          int sentTs,
        ) async {
          if (data.toString() == [0].toString()) {
            showSnackBar("This call will end in three second");
            Future.delayed(const Duration(seconds: 3), () {
              disconnectAgora();
            });
          }
          if (data.toString() == [1].toString()) {
            setState(() {
              myMute = true;
            });
            await client.engine.muteLocalAudioStream(true);
          }
          if (data.toString() == [2].toString()) {
            setState(() {
              myVideo = true;
            });

            await client.engine.muteLocalVideoStream(true);
          }
        },
        onUserMuteAudio: (connection, uid, mute) {
          setState(() {
            isMutedMap[uid] = mute;
          });
        },
        onUserMuteVideo: (connection, uid, mute) {
          setState(() {
            isVideoMap[uid] = mute;
          });
        },
        onUserOffline: (connection, remoteUid, reason) async {
          setState(() {
            client.sessionController.removeUser(uid: remoteUid); // RTM cleanup
            remoteUsers.remove(remoteUid);
            userInfos.remove(remoteUid); // 🟢 Fix: Remove the name entry
            isMutedMap.remove(remoteUid); // 🟢 Optional cleanup
            isVideoMap.remove(remoteUid); // 🟢 Optional cleanup
            remoteUsers.remove(remoteUid);
          });
        },
        onJoinChannelSuccess: (connection, uid) {
          setupChatClient();
          setupListeners();
          eventhandler();
          joinNow();
          startTimer();
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
          attendSession();
          List<AgoraUser> allUsers = client.sessionController.value.users;

          Future.delayed(const Duration(seconds: 2), () {
            if (allUsers.isNotEmpty == true) {
              addExistingUser(client.sessionController.value.userRtmMap);
            }
          });
        },
        onLeaveChannel: (connections, state) {
          stopTimer();
          agoraChatClient.chatManager.removeEventHandler("MESSAGE_HANDLER");
          agoraChatClient.removeConnectionEventHandler("CONNECTION_HANDLER");
          ChatClient.getInstance.chatManager
              .removeMessageEvent("UNIQUE_HANDLER_ID_one");
          _messageStreamController.close();

          // Leave the chat room and log out
          remoteUsers.clear();
          clearMessageArray();
          leaveNow();
          giveRatingDialog(context, widget.sessionId);
        },
        onUserInfoUpdated: (uid, userInfo) {},
        onUserJoined: (connection, remoteUid, elapsed) {
          // remoteUsers.add(remoteUid);
        },
      ),
      agoraChannelData: AgoraChannelData(
          clientRoleType: ClientRoleType.clientRoleAudience,
          channelProfileType:
              ChannelProfileType.channelProfileLiveBroadcasting),
      agoraConnectionData: AgoraConnectionData(
        rtmEnabled: true,
        rtmUid: myuid.toString(),
        uid: myuid,
        rtmChannelName: widget.channelId,
        tokenUrl: serverUrl,
        username: myUser?.userInfo?.profile?.fullName ?? "",
        appId: "ede000c814e14e748484a0a896c2477d",
        channelName: widget.channelId,
      ),
      enabledPermission: [
        Permission.audio,
        Permission.bluetoothConnect,
        Permission.camera,
        Permission.microphone,
      ],
    );

    initAgora();
  }

  void initAgora() async {
    await client.initialize();

    await client.engine.enableVideo();

    await client.engine.startPreview();
  }

  void clearMessageArray() {
    var groupchat = Provider.of<GroupChatProvider>(context, listen: false);
    groupchat.clear();
  }

  void addExistingUser(Map<String, Map<String, dynamic>>? userRtmMap) {
    var data = userRtmMap?.entries.toList();
    print("userRtmMap data: $data");

    // Step 1: Get list of AgoraUser uids from sessionController
    final agoraUsers = client.sessionController.value.users;
    final agoraUserUids = agoraUsers.map((user) => user.uid).toList();
    print("AgoraUser UIDs: $agoraUserUids");

    if (data != null && data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        var newText = data[i].value;
        var textString = newText['text'];
        Map<String, dynamic> jsonMap = jsonDecode(textString);

        int uid = jsonMap['rtcId'];
        String username = jsonMap['username'];

        // Step 2: Only add user if uid is present in AgoraUser list
        if (agoraUserUids.contains(uid)) {
          if (!remoteUsers.contains(uid)) {
            remoteUsers.add(uid);
            isMutedMap[uid] = false;
            isVideoMap[uid] = false;
            userInfos[uid] = username;
          }
        }
      }
      setState(() {});
    }
  }

  void disconnectAgora() {
    if (mounted) {
      client.sessionController.clearUsers();
      client.sessionController.dispose();
      remoteUsers.clear();
      userInfos.clear();
      isMutedMap.clear();
      isVideoMap.clear();

      client.engine.stopPreview();
      client.engine.leaveChannel();

      client.engine.release();

      ///////chatiingggggggg
      agoraChatClient.chatManager.removeEventHandler("MESSAGE_HANDLER");
      agoraChatClient.removeConnectionEventHandler("CONNECTION_HANDLER");
      ChatClient.getInstance.chatManager
          .removeMessageEvent("UNIQUE_HANDLER_ID_one");
      _messageStreamController.close();

      // Leave the chat room and log out
      clearMessageArray();

      leaveNow();
      timer.cancel();
      if (!_timerStreamController.isClosed) {
        _timerStreamController.close();
      }
    }
    Routes.goBack();
  }

  void muteLocalAudio() async {
    setState(() {
      myMute = !myMute;
    });

    await client.engine.muteLocalAudioStream(myMute);
  }

  void muteVideoAudio() async {
    setState(() {
      myVideo = !myVideo;
    });

    await client.engine.muteLocalVideoStream(myVideo);
  }

////////////////////////////////////////////////////
  /////chatting
  ///

  static const String appKey = "411096181#1276438";

  String token =
      "007eJxTYAhTlIuPY8ta26az+eOlo9/V3WpsJkQf5nc62f95f/nD1HUKDKkpqQYGBskWhiapQGRuYgGEiQaJFpZmyUYm5uYpaySPpzYEMjJcdrvFwMjACsSMDCC+CkOiQZpBmmmSgW6yeUqKrqFhaqpuorFhim6KcbKhRWqqRWKaUTIAigYoxQ==";
  late ChatClient agoraChatClient;
  bool isJoined = false;

  ScrollController scrollController = ScrollController();
  TextEditingController messageBoxController = TextEditingController();
  String messageContent = "";

  final StreamController<String> _messageStreamController =
      StreamController<String>.broadcast();

  void showLog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(message),
      ),
    );
  }

  void setupChatClient() async {
    ChatOptions options = ChatOptions(
      appKey: appKey,
      acceptInvitationAlways: true,
      autoLogin: false,
    );
    agoraChatClient = ChatClient.getInstance;
    await agoraChatClient.init(options);
    await ChatClient.getInstance.startCallback();
  }

  void setupListeners() {
    agoraChatClient.addConnectionEventHandler(
      "CONNECTION_HANDLER",
      ConnectionEventHandler(
        onConnected: onConnected,
        onDisconnected: onDisconnected,
        onTokenWillExpire: onTokenWillExpire,
        onTokenDidExpire: onTokenDidExpire,
      ),
    );

    agoraChatClient.chatManager.addEventHandler(
      "MESSAGE_HANDLER",
      ChatEventHandler(onMessagesReceived: onMessagesReceived),
    );
  }

  void onMessagesReceived(List<ChatMessage> messages) {
    for (var msg in messages) {
      if (msg.body.type == MessageType.TXT) {
        ChatTextMessageBody body = msg.body as ChatTextMessageBody;

        // Check if the message is for the chatroom and not sent by the local user
        if (msg.chatType == ChatType.ChatRoom &&
            msg.from !=
                generateUsername(myUser?.userInfo?.profile?.fullName ?? "",
                    myuid.toString())) {
          _messageStreamController.add(body.content);

          print("Message from ${msg.from}");
        }
      } else {
        String msgType = msg.body.type.name;

        // Check if the message is for the chatroom
        if (msg.chatType == ChatType.ChatRoom) {
          print("Received $msgType message, from ${msg.from}");
        }
      }
    }
  }

  void onTokenWillExpire() {
    // The token is about to expire. Get a new token
    // from the token server and renew the token.
  }

  void onTokenDidExpire() {
    // The token has expired
  }

  void onDisconnected() {
    // Disconnected from the Chat server
  }

  void onConnected() {
    // showLog("Connected");
  }

  void joinNow() async {
    try {
      // await agoraChatClient.login(userId, "1234567890");
      await agoraChatClient.login(
          generateUsername(
              myUser?.userInfo?.profile?.fullName ?? "", myuid.toString()),
          myuid.toString());

      showGreenSnackBar(
          "Logged in successfully as ${myUser?.userInfo?.profile?.fullName?.split(' ')[0]}",
          duration: const Duration(seconds: 1));
      setState(() {
        isJoined = true;
      });
    } on ChatError catch (e) {
      if (e.code == 200) {
        // Already logged in
        setState(() {
          isJoined = true;
        });
      } else {
        showLog("Login failed, code: ${e.code}, desc: ${e.description}");
      }
    }

    try {
      await ChatClient.getInstance.chatRoomManager
          .joinChatRoom(widget.chatroomId);
      showGreenSnackBar("Chat room joined",
          duration: const Duration(seconds: 1));
      //print("Join");
    } on ChatError catch (e) {
      print(e);
    }
  }

  void leaveNow() async {
    try {
      await agoraChatClient.logout(true);
      print("Logged out successfully");
    } on ChatError catch (e) {
      if (mounted) {
        print("Logout failed, code: ${e.code}, desc: ${e.description}");
      }
    }
  }

  @override
  void dispose() {
    remoteUsers.clear();
    userInfos.clear();
    isMutedMap.clear();
    isVideoMap.clear();
    remoteUsers.clear();

    client.sessionController.dispose();
    client.engine.stopPreview();
    client.engine.release();

    timer.cancel();
    if (!_timerStreamController.isClosed) {
      _timerStreamController.close();
    }
    disconnectAgora();
    super.dispose();
  }

  void displayMessage(
      String text, bool isSentMessage, String name, String time) {
    var groupchat = Provider.of<GroupChatProvider>(context, listen: false);

    groupchat.addGroupMessage(isSentMessage
        ? buildOutgoingMessage(text, name, time)
        : buildIncomingMessage(text, name, time));

    setState(() {
      scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
    });
  }

  void eventhandler() async {
    ChatClient.getInstance.chatManager.addMessageEvent(
      "UNIQUE_HANDLER_ID_two",
      ChatMessageEvent(
        onSuccess: (msgId, msg) {
          if (msg.body.type == MessageType.TXT) {
            ChatTextMessageBody body = msg.body as ChatTextMessageBody;
            // Extract sender's username and timestamp
            String senderUsername = msg.from ?? ""; // Sender's username
            DateTime timestamp =
                DateTime.fromMillisecondsSinceEpoch(msg.serverTime);
            String formattedTime = DateFormat.jm().format(timestamp);

            displayMessage(body.content, true, senderUsername, formattedTime);
            print("Message sent ${msg.from}");
          } else {
            String msgType = msg.body.type.name;
            print("sent $msgType message, from ${msg.from}");
          }
          print(msg);
          //showLog(msg.body.toString());
        },
        onError: (msgId, msg, error) {},
        onProgress: (msgId, progress) {},
      ),
    );

    ChatClient.getInstance.chatManager.addEventHandler(
      "UNIQUE_HANDLER_ID_two",
      ChatEventHandler(
        onMessagesReceived: (messages) {
          // showLog("message received");
          for (var msg in messages) {
            if (msg.body.type == MessageType.TXT) {
              ChatTextMessageBody body = msg.body as ChatTextMessageBody;
              String senderUsername = msg.from ?? ""; // Sender's username
              DateTime timestamp =
                  DateTime.fromMillisecondsSinceEpoch(msg.serverTime);
              String formattedTime = DateFormat.jm().format(timestamp);
              displayMessage(
                  body.content, false, senderUsername, formattedTime);
              print("Message from ${msg.from}");
            } else {
              String msgType = msg.body.type.name;
              print("Received $msgType message, from ${msg.from}");
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: VideoCallingAppBar(
          onpressed: () {
            client.engine.switchCamera();
          },
          callWidget: StreamBuilder<int>(
            stream: _timerStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return simpleText(
                  'Call: ${formatDuration(snapshot.data!)}',
                  color: AppColors.textDark,
                );
              } else {
                return simpleText('Calculating', color: AppColors.textDark);
              }
            },
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: SizedBox(
                height: screenHeight,
                width: MediaQuery.of(context).size.width,
                child: buildVideoContainer(),
              ),
            ),
            Positioned(
              left: left,
              top: top,
              child: GestureDetector(
                onPanUpdate: (details) {
                  left = max(0, left + details.delta.dx);
                  top = max(0, top + details.delta.dy);
                  setState(() {});
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: myVideo == false
                        ? RtcLocalView.AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: client.engine,
                              canvas: const VideoCanvas(uid: 0),
                            ),
                          )
                        : Container(
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AgoraVideoButtons(
                client: client,
                enabledButtons: const [
                  // BuiltInButtons.toggleMic,
                  // BuiltInButtons.toggleCamera,
                  // BuiltInButtons.callEnd,
                ],
                extraButtons: [
                  RawMaterialButton(
                    onPressed: () async {
                      muteLocalAudio();
                    },
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.mic,
                      color: myMute ? Colors.red : Colors.blueAccent,
                      size: 20.0,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () async {
                      disconnectAgora();
                    },
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.red,
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () async {
                      muteVideoAudio();
                    },
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.video_call,
                      color: myVideo ? Colors.red : Colors.blueAccent,
                      size: 20.0,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () async {
                      showMessageScreen(context);
                    },
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.chat,
                      color: Colors.blueAccent,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showMessageScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ChatScreen(
          chatRoomId: widget.chatroomId,
        );
      },
    );
  }

  Widget buildVideoContainer() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else {
      if (remoteUsers.isEmpty) {
        return Center(
          child: simpleText(
            'No users',
          ),
        );
      } else {
        int uid = remoteUsers[0];

        return Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.black),
              child: isVideoMap[uid] == false
                  ? RtcRemoteView.AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: client.engine,
                        canvas: VideoCanvas(
                          uid: uid,
                          renderMode: RenderModeType.renderModeFit,
                        ),
                        connection: RtcConnection(
                          channelId: widget.channelId,
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.black,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: simpleText(
                            userInfos[uid] ?? '',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ))),
                  Row(
                    children: [
                      Icon(
                        Icons.mic,
                        color: isMutedMap[uid]! ? Colors.red : Colors.green,
                      ),
                      width(7),
                      Icon(
                        Icons.video_call,
                        color: isVideoMap[uid]! ? Colors.red : Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }
    }
  }
}
