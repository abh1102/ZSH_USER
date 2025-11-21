import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/features/choose_plan/logic/cubit/my_plan_cubit.dart';
import 'package:zanadu/features/choose_plan/presentations/my_plan_screen.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/health_coach/logic/cubit/health_coach_cubit/health_coach_cubit.dart';
import 'package:zanadu/features/health_coach/logic/cubit/question_cubit/question_cubit.dart';
import 'package:zanadu/features/health_coach/logic/cubit/special_question_cubit/special_question_cubit.dart';
import 'package:zanadu/features/health_coach/presentations/first_form.dart';
import 'package:zanadu/features/health_coach/presentations/health_coach_detail_screen.dart';
import 'package:zanadu/features/health_coach/presentations/health_coach_new_browse.dart';
import 'package:zanadu/features/health_coach/presentations/question_inform_screen.dart';
import 'package:zanadu/features/health_coach/presentations/review_screen.dart';
import 'package:zanadu/features/health_coach/presentations/special_first_from.dart';
import 'package:zanadu/features/health_coach/presentations/special_question_inform_screen.dart';
import 'package:zanadu/features/health_coach/presentations/special_review_screen.dart';
import 'package:zanadu/features/home/presentations/home_bottombar.dart';
import 'package:zanadu/features/login/logic/provider/login_provider.dart';
import 'package:zanadu/features/login/presentations/login_screen.dart';
import 'package:zanadu/features/offerings/data/models/current_selected_coach_model.dart';
import 'package:zanadu/features/offerings/logic/cubit/add_to_plan/add_to_plan_cubit.dart';
import 'package:zanadu/features/offerings/logic/cubit/get_video_cubit/get_video_cubit.dart';
import 'package:zanadu/features/offerings/logic/cubit/offering_id/offering_id_cubit.dart';
import 'package:zanadu/features/offerings/presentations/all_see_all.dart';
import 'package:zanadu/features/offerings/presentations/browse_offering_detail_screen.dart';
import 'package:zanadu/features/offerings/presentations/browse_see_all.dart';
import 'package:zanadu/features/offerings/presentations/key_video_detail.dart';
import 'package:zanadu/features/offerings/presentations/new_browse_offering_add_to_plan.dart';
import 'package:zanadu/features/offerings/presentations/offering_screen.dart';
import 'package:zanadu/features/offerings/presentations/video_details.dart';
import 'package:zanadu/features/onboarding/presentations/onboarding_two.dart';
import 'package:zanadu/features/onboarding/presentations/splash_screen.dart';
import 'package:zanadu/features/onboarding/presentations/splash_screen_one.dart';
import 'package:zanadu/features/onboarding/presentations/splash_screen_two.dart';
import 'package:zanadu/features/onetimepasscode/presentation/one_time_password.dart';
import 'package:zanadu/features/profile/logic/cubits/about_cubit/about_cubit.dart';
import 'package:zanadu/features/profile/logic/cubits/get_all_health_cubit/get_health_cubit.dart';
import 'package:zanadu/features/profile/logic/cubits/notification_cubit/notification_cubit.dart';
import 'package:zanadu/features/profile/logic/provider/edit_profile_provider.dart';
import 'package:zanadu/features/profile/presentations/calendar_reminder_screen.dart';
import 'package:zanadu/features/profile/presentations/edit_profile_screen.dart';
import 'package:zanadu/features/profile/presentations/help_and_support/about_us.dart';
import 'package:zanadu/features/profile/presentations/help_and_support/help_support_screen.dart';
import 'package:zanadu/features/profile/presentations/help_and_support/technical_issue.dart';
import 'package:zanadu/features/profile/presentations/my_account/auth_phone.dart';
import 'package:zanadu/features/profile/presentations/my_account/auth_screen.dart';
import 'package:zanadu/features/profile/presentations/my_account/change_email.dart';
import 'package:zanadu/features/profile/presentations/my_account/change_pass_email.dart';
import 'package:zanadu/features/profile/presentations/my_account/change_pass_pass.dart';
import 'package:zanadu/features/profile/presentations/my_account/change_password.dart';
import 'package:zanadu/features/profile/presentations/my_account/change_phone.dart';
import 'package:zanadu/features/profile/presentations/my_account/my_account_screen.dart';
import 'package:zanadu/features/profile/presentations/my_account/one_time_pass_pass.dart';
import 'package:zanadu/features/profile/presentations/my_account/one_time_passcode.dart';
import 'package:zanadu/features/profile/presentations/my_account/two_factor_auth.dart';
import 'package:zanadu/features/profile/presentations/pdf_viewer_screen.dart';
import 'package:zanadu/features/profile/presentations/profile_notification.dart';
import 'package:zanadu/features/profile/presentations/profile_screen.dart';
import 'package:zanadu/features/profile/presentations/zh_score_card.dart';
import 'package:zanadu/features/sessions/data/model/all_session_model.dart'
    hide CoachInfo;
import 'package:zanadu/features/sessions/logic/cubit/add_group_session_cubit/add_group_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/add_one_session_cubit/add_one_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/book_slot_group_cubit/book_slot_group_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/cancel_reschedule_session_cubit/cancel_reschedule_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/session_cubit/session_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/today_schedule_session_cubit/today_schedule_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/provider/session_provider.dart';
import 'package:zanadu/features/sessions/presentations/add_to_plan_group_session.dart';
import 'package:zanadu/features/sessions/presentations/add_to_plan_one_one_session.dart';
import 'package:zanadu/features/sessions/presentations/in_session_message.dart';
import 'package:zanadu/features/sessions/presentations/one_on_one_description.dart';
import 'package:zanadu/features/sessions/presentations/one_one_session_schedule.dart';
import 'package:zanadu/features/sessions/presentations/one_session_reschedule.dart';
import 'package:zanadu/features/sessions/presentations/session_description_page.dart';
import 'package:zanadu/features/sessions/presentations/sessions_screen.dart';
import 'package:zanadu/features/sessions/presentations/sesson_book_slot.dart';
import 'package:zanadu/features/signup/logic/provider/signup_provider.dart';
import 'package:zanadu/features/signup/presentations/signUp_first.dart';
import 'package:zanadu/features/signup/presentations/signup_second.dart';
import 'package:zanadu/features/video_calling/group_video_screens.dart';

import '../features/profile/presentations/help_and_support/tickethistoryscreen.dart';

/// All of the screens in the app will be added here for reference
class Screens {
  static const splash = "splash";
  static const welcome = "welcome";
  static const homeBottomBar = "homeBottomBar";
  static const home = "home";
  static const login = "login";
  static const splashOne = "splashOne";
  static const splashTwo = 'splashTwo';
  static const onboardingTwo = 'onboardingTwo';
  static const signupscreenfirst = 'signupscreenfirst';
  static const signupscreensecond = 'signupscreensecond';
  static const oneTimePassword = 'oneTimePassword';
  static const forgetPassword = 'forgetPassword';
  static const forgetPasswordTwo = 'forgetPasswordTwo';
  static const forgetPasswordThree = 'forgetPasswordThree';
  static const browseOfferingDetail = 'browseOfferingDetail';
  static const browseOfferingDetailAddPlan = 'browseOfferingDetailAddPlan';
  static const profile = 'profile';
  static const session = 'session';
  static const offering = 'offering';
  static const inSessionMessage = 'inSessionMessage';
  static const myZhScoreCard = 'myZhScoreCard';
  static const editProfileScreen = 'editProfileScreen';
  static const editProfileNotificationScreen = 'editProfileNotificationScreen';
  static const calenderReminder = 'calenderReminder';
  static const myAccount = 'myAccount';
  static const myPlan = "myPlan";
  static const helpSupport = 'helpSupport';
  static const ticketHistoryScreen="ticketHistoryScreen";
  static const helpSupportAbout = 'helpSupportAbout';
  static const changePassword = 'changePassword';
  static const changePassPassword = 'changePassPassword';
  static const changePassEmail = 'changePassEmail';
  static const changeEmail = 'changeEmail';
  static const changePhone = 'changePhone';
  static const profileOneTimePasscode = 'profileOneTimePasscode';
  static const profileOneTimePassPasscode = 'profileOneTimePassPasscode';
  static const healthCoachDetail = 'healthCoachDetail';
  static const firstForm = 'firstForm';
  static const sessionBookSlot = 'sessionBookSlot';
  static const oneOnOneSession = 'oneOnOneSession';
  static const addPlanGroupSession = 'addPlanGroupSession';
  static const addPlanOneOneSession = 'addPlanOneOneSession';
  static const sessionDescripPage = 'sessionDescripPage';
  static const browseOfferingNew = 'browseOfferingNew';
  static const browseSeeAll = 'browseSeeAll';
  static const allBrowseSeeAll = 'allBrowseSeeAll';
  static const helpSupportTechnical = 'helpSupportTechnical';
  static const oneOneOneSessDesc = 'oneOneOneSessDesc';
  static const videoDetailScren = 'videoDetailScren';
  static const keyVideoDetailScren = 'keyVideoDetailScren';
  static const groupVideoCalling = 'oneOneVideoCalling';
  static const groupVideoCallingNew = 'oneOneVideoCallingNew';
  static const twoFactorAuth = 'twoFactorAuth';
  static const authBarCodeScreen = 'authBarCodeScreen';
  static const authPhoneScreen = 'authPhoneScreen';
  static const oneSessionRescheduled = 'oneSessionRescheduled';
  static const oneOneVideo = 'oneOneVideo';
  static const viewPdfScreen = "viewPdfScreen";
  static const healthBrowseNewAddToPlan = 'healthBrowseNewAddToPlan';

  static const questionInformScreen = 'questionInformScreen';
  static const specialQuestionInformScreen = 'specialQuestionInformScreen';
  static const reviewScreen = 'reviewScreen';
  static const specialReviewScreen = 'specialReviewScreen';
  static const specialFirstDiscoveryForm = 'specialFirstDiscoveryForm';
}

class Routes {
  /// Global NavigatorKey to be used inside the MaterialApp
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Implementation of the onGenerateRoute function inside the MaterialApp
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screens.splash:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Screens.splashOne:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreenOne(),
        );

      case Screens.splashTwo:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreenTwo(),
        );

      case Screens.onboardingTwo:
        return CupertinoPageRoute(
          builder: (context) => const OnBoardingTwoScreen(),
        );

      case Screens.signupscreenfirst:
        return CupertinoPageRoute(
          builder: (context) => const SignUpScreenFirst(),
        );

      case Screens.signupscreensecond:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SignUpProvider(context),
            child: const SignUpSecondScreen(),
          ),
        );

      case Screens.login:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => LoginProvider(context),
            child:
                LoginScreen(isBackButton: settings.arguments as bool? ?? false),
          ),
        );

      case Screens.oneTimePassword:
        return CupertinoPageRoute(
          builder: (context) => const OneTimePassword(),
        );

      case Screens.homeBottomBar:
        return CupertinoPageRoute(
          builder: (context) => const HomeBottomBar(),
        );
      case Screens.ticketHistoryScreen:
        return CupertinoPageRoute(
          builder: (context) => TicketHistoryScreen(),
        );

      case Screens.browseOfferingDetail:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OfferingIdCubit(),
            child: BrowseOfferingDetailScreen(id: settings.arguments as String),
          ),
        );

      case Screens.profile:
        return CupertinoPageRoute(
          builder: (context) => const ProfileScreen(),
        );

      case Screens.session:
        return CupertinoPageRoute(
          builder: (context) => const SessionScreen(),
        );

      case Screens.offering:
        return CupertinoPageRoute(
          builder: (context) => const OfferingScreen(),
        );

      case Screens.inSessionMessage:
        return CupertinoPageRoute(
          builder: (context) => const InSessionMessageScreen(),
        );

      case Screens.myZhScoreCard:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => GetHealthCubit(),
            child: const MyZhScoreCardScreen(isAppBar: false),
          ),
        );

      case Screens.editProfileScreen:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => EditProfileProvider(context),
            child: const EditProfileScreen(),
          ),
        );

      case Screens.editProfileNotificationScreen:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => NotificationCubit(),
            child: const ProfileNotificationScreen(),
          ),
        );

      case Screens.calenderReminder:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AllSessionCubit(),
            child: const CalendarReminderScreen(),
          ),
        );

      case Screens.myAccount:
        return CupertinoPageRoute(
          builder: (context) => const MyAccountScreen(),
        );

      case Screens.myPlan:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => MyPlanCubit(),
            child: const MyPlanScreen(),
          ),
        );

      case Screens.helpSupport:
        return CupertinoPageRoute(
          builder: (context) => const HelpSupportScreen(),
        );

      case Screens.helpSupportAbout:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AboutCubit(),
            child: const HelpSupportAboutUs(),
          ),
        );

      case Screens.changePassword:
        return CupertinoPageRoute(
          builder: (context) => const ChangePasswordScreen(),
        );

      case Screens.changePassPassword:
        return CupertinoPageRoute(
          builder: (context) => const ChangePassPasswordScreen(),
        );

      case Screens.changeEmail:
        return CupertinoPageRoute(
          builder: (context) => const ChangeEmailScreen(),
        );

      case Screens.changePassEmail:
        return CupertinoPageRoute(
          builder: (context) => const ChangePassEmailScreen(),
        );

      case Screens.changePhone:
        return CupertinoPageRoute(
          builder: (context) => const ChangePhoneScreen(),
        );

      case Screens.profileOneTimePasscode:
        return CupertinoPageRoute(
          builder: (context) => const ProfileOneTimePassword(),
        );

      case Screens.profileOneTimePassPasscode:
        return CupertinoPageRoute(
          builder: (context) =>
              ProfileOneTimePassPassword(email: settings.arguments as String),
        );

      case Screens.healthCoachDetail:
        return CupertinoPageRoute(
          builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AllHealthCoachCubit()),
                BlocProvider(create: (context) => AddToPlanCubit()),
                BlocProvider(create: (context) => GetVideoCubit()),
              ],
              child: HealthCoachDetailScreen(
                healthCoach: settings.arguments as AllHealthCoachesModel,
              )),
        );

      case Screens.firstForm:
        return CupertinoPageRoute(
          builder: (context) => FirstDiscoveryForm(
            questionIndex: settings.arguments as int,
          ),
        );

      case Screens.sessionBookSlot:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => SessionBookingCubit(),
                child: SessionBookSlotScreen(
                  session: settings.arguments as Sessions,
                )));

      case Screens.oneOnOneSession:
        var arguments = settings.arguments as Map<String, dynamic>?;

        // Check if arguments is not null before accessing its values
        if (arguments != null) {
          String coachId = arguments['coachId'];
          String offeringId = arguments['offeringId'];
          // Use date and name in your screen
          return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => SessionProvider(context),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => TodayScheduleSessionCubit(),
                  ),
                  BlocProvider(
                    create: (context) => AddOneSessionCubit(),
                  ),
                ],
                child: OneOneSessionScheduleScreen(
                  coachId: coachId,
                  offeringId: offeringId,
                ),
              ),
            ),
          );
        } else {
          // Handle the case where arguments is null
          return null;
        }

      case Screens.addPlanGroupSession:
        var arguments = settings.arguments as Map<String, dynamic>?;

        // Check if arguments is not null before accessing its values
        if (arguments != null) {
          String coachId = arguments['coachId'];
          String offeringId = arguments['offeringId'];
          // Use date and name in your screen
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AddGroupSessionCubit(),
              child: AddPlanGroupSessionScreen(
                coachId: coachId,
                offeringId: offeringId,
              ),
            ),
          );
        } else {
          // Handle the case where arguments is null
          return null;
        }

      case Screens.addPlanOneOneSession:
        var arguments = settings.arguments as Map<String, dynamic>?;

        // Check if arguments is not null before accessing its values
        if (arguments != null) {
          String myCoachId = arguments['myCoachId'];
          String offeringId = arguments['offeringId'];
          // Use date and name in your screen
          return CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AddOneSessionCubit()),
                BlocProvider(
                    create: (context) => CancelRescheduleSessionCubit()),
              ],
              child: AddPlanOneOneSessionScreen(
                myCoachId: myCoachId,
                offeringId: offeringId,
              ),
            ),
          );
        } else {
          // Handle the case where arguments is null
          return null;
        }

      case Screens.sessionDescripPage:
        return CupertinoPageRoute(
          builder: (context) => SessionDescriptiontScreen(
              session: settings.arguments as Sessions),
        );

      case Screens.browseOfferingNew:
        var arguments = settings.arguments as Map<String, dynamic>?;

        // Check if arguments is not null before accessing its values
        if (arguments != null) {
          AllHealthCoachesModel healthCoach = arguments['healthCoach'];
          bool isFetch = arguments['isFetch'];
          String category = arguments['category'];
          // Use date and name in your screen

          return CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AddToPlanCubit(),
                ),
                BlocProvider(
                  create: (context) => GetVideoCubit(),
                )
              ],
              child: BrowseOfferingNewAddToPlan(
                healthCoach: healthCoach,
                isFetch: isFetch,
                category: category,
              ),
            ),
          );
        } else {
          // Handle the case where arguments is null
          return null;
        }

      case Screens.healthBrowseNewAddToPlan:
        return CupertinoPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => GetVideoCubit()),
              BlocProvider(create: (context) => AddToPlanCubit()),
            ],
            child: HealthBrowseNewAddToPlan(
                healthCoach: settings.arguments as CurrentSelectedCoachModel),
          ),
        );

      case Screens.reviewScreen:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => QuestionCubit(),
              child: const DiscoveryFormReviewScreen()),
        );

      case Screens.browseSeeAll:
        return CupertinoPageRoute(
          builder: (context) =>
              BrowseSeeAllScreen(coachInfo: settings.arguments as CoachInfo),
        );

      case Screens.allBrowseSeeAll:
        var arguments = settings.arguments as Map<String, dynamic>?;

        // Check if arguments is not null before accessing its values
        if (arguments != null) {
          CoachInfo coachInfo = arguments['coachInfo'];
          List<MyVideos> videos = arguments['videos'];

          // Use date and name in your screen

          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => GetVideoCubit(),
              child: AllBrowseSeeAllScreen(
                coachInfo: coachInfo,
                videos: videos,
              ),
            ),
          );
        } else {
          // Handle the case where arguments is null
          return null;
        }

      case Screens.helpSupportTechnical:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AboutCubit(),
            child: const HelpSupportTechnicalIssue(),
          ),
        );

      case Screens.oneOneOneSessDesc:
        return CupertinoPageRoute(
          builder: (context) => OneOnOneSessionDescription(
              session: settings.arguments as Sessions),
        );

      case Screens.videoDetailScren:
        return CupertinoPageRoute(
          builder: (context) =>
              MyVideosDetailScreen(videos: settings.arguments as MyVideos),
        );

      case Screens.keyVideoDetailScren:
        var arguments = settings.arguments as Map<String, dynamic>?;

        if (arguments != null) {
          MyVideos videos = arguments['videos'];
          String coachId = arguments['coachId'];

          return CupertinoPageRoute(
            builder: (context) => KeyMyVideosDetailScreen(
              videos: videos,
              coachId: coachId,
            ),
          );
        } else {
          return null;
        }

      case Screens.groupVideoCallingNew:
        var arguments = settings.arguments as Map<String, dynamic>?;

        if (arguments != null) {
          String channelId = arguments['channelId'];
          String sessionId = arguments['sessionId'];
          int uid = arguments['uid'];
          String chatroomId = arguments['chatroomId'];
          return CupertinoPageRoute(
            builder: (context) => GroupVideoCallNew(
              channelId: channelId,
              sessionId: sessionId,
              uid: uid,
              chatroomId: chatroomId,
            ),
          );
        } else {
          return null;
        }

      case Screens.twoFactorAuth:
        return CupertinoPageRoute(
          builder: (context) => const TwoFactorAuthScreen(),
        );

      case Screens.authBarCodeScreen:
        return CupertinoPageRoute(
          builder: (context) => const AuthBarCodeScreen(),
        );

      case Screens.authPhoneScreen:
        return CupertinoPageRoute(
          builder: (context) => const AuthPhoneScreen(),
        );

      case Screens.questionInformScreen:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => QuestionCubit(),
              child: const QuestionInformScreen()),
        );

      case Screens.specialQuestionInformScreen:
        var arguments = settings.arguments as Map<String, dynamic>?;

        if (arguments != null) {
          String category = arguments['category'];
          String coachId = arguments['coachId'];
          String offeringId = arguments['offeringId'];

          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => SpecialQuestionCubit(),
                child: SpecialQuestionInformScreen(
                    category: category,
                    coachId: coachId,
                    offeringId: offeringId)),
          );
        } else {
          return null;
        }

      case Screens.specialReviewScreen:
        var arguments = settings.arguments as Map<String, dynamic>?;

        if (arguments != null) {
          String coachId = arguments['coachId'];
          String offeringId = arguments['offeringId'];
          String category = arguments['category'];

          return CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => SpecialQuestionCubit()),
                BlocProvider(create: (context) => AddToPlanCubit()),
              ],
              child: SpecialDiscoveryFormReviewScreen(
                coachId: coachId,
                offeringId: offeringId,
                category: category,
              ),
            ),
          );
        } else {
          return null;
        }

      case Screens.specialFirstDiscoveryForm:
        var arguments = settings.arguments as Map<String, dynamic>?;

        if (arguments != null) {
          int questionIndex = arguments['questionIndex'];
          String category = arguments['category'];
          String coachId = arguments['coachId'];
          String offeringId = arguments['offeringId'];

          return CupertinoPageRoute(
            builder: (context) => SpecialFirstDiscoveryForm(
              questionIndex: questionIndex,
              category: category,
              coachId: coachId,
              offeringId: offeringId,
            ),
          );
        } else {
          return null;
        }


            case Screens.viewPdfScreen:
        return CupertinoPageRoute(
          builder: (context) => PdfViewerScreen(
            pdfPath: settings.arguments as File,
          ),
        );

      case Screens.oneSessionRescheduled:
        var arguments = settings.arguments as Map<String, dynamic>?;

        // Check if arguments is not null before accessing its values
        if (arguments != null) {
          String coachId = arguments['coachId'];
          String sessionId = arguments['sessionId'];
          // Use date and name in your screen
          return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => SessionProvider(context),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => CancelRescheduleSessionCubit()),
                  BlocProvider(
                      create: (context) => TodayScheduleSessionCubit()),
                ],
                child: OneOneSessionRescheduleScreen(
                  sessionId: sessionId,
                  coachId: coachId,
                ),
              ),
            ),
          );
        } else {
          // Handle the case where arguments is null
          return null;
        }

      default:
        return null;
    }
  }

  /// Returns the current BuildContext at any point in the app
  static BuildContext get currentContext => navigatorKey.currentContext!;

  /// Implementation of Navigator.pushNamed() function
  static void goTo(String route, {Object? arguments}) {
    Navigator.pushNamed(currentContext, route, arguments: arguments);
  }

  /// Implementation of Navigator.pushReplacementNamed() function
  static void goToReplacement(String route, {Object? arguments}) {
    Navigator.pushReplacementNamed(currentContext, route, arguments: arguments);
  }

  /// Implementation of Navigator.pushReplacementNamed() function
  static void closeAllAndGoTo(String route, {Object? arguments}) {
    Navigator.popUntil(currentContext, (route) => route.isFirst);
    Navigator.pushReplacementNamed(currentContext, route, arguments: arguments);
  }

  /// Implementation of Navigator.pop() function
  static void goBack() {
    Navigator.pop(currentContext);
  }

  static void handleDeepLink(Uri uri) {
    print("hreeeeeeeeeeeeeeeggggggggggggggg");
    if (uri.pathSegments.isNotEmpty) {
      final path = uri.pathSegments[0];

      switch (path) {
        case 'signup':
          final String? code = uri.queryParameters['code'];

          showSnackBar(code.toString());

          Routes.closeAllAndGoTo(Screens.signupscreensecond);

          break;

        // Add more deep link paths...

        default:
          // Handle unknown paths or do nothing
          break;
      }
    } else {
      print("this is uri $uri");
    }
  }
}
