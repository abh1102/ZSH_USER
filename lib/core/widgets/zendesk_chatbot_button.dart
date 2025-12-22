import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ZendeskChatbotButton extends StatefulWidget {
  final String zendeskKey;

  const ZendeskChatbotButton({
    super.key,
    this.zendeskKey = 'f38d7cd6-0e6d-4c89-a53e-7523f425030b',
  });

  @override
  State<ZendeskChatbotButton> createState() => _ZendeskChatbotButtonState();
}

class _ZendeskChatbotButtonState extends State<ZendeskChatbotButton> {
  bool _isChatOpen = false;
  Offset _position = Offset(0, 0);
  bool _isDragging = false;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Zendesk page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Zendesk page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Zendesk error: ${error.description}');
          },
        ),
      )
      ..loadHtmlString(_getZendeskHtml(), baseUrl: 'https://static.zdassets.com');
  }

  String _getZendeskHtml() {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Zendesk Chat</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        html, body {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: #fff;
        }
        #loading {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-size: 16px;
            color: #666;
        }
        .spinner {
            border: 3px solid #f3f3f3;
            border-top: 3px solid #6C63FF;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin-bottom: 16px;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        #error {
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            padding: 20px;
            text-align: center;
        }
        #error h3 {
            color: #e74c3c;
            margin-bottom: 10px;
        }
        #error p {
            color: #666;
            font-size: 14px;
            margin-bottom: 20px;
        }
        #error button {
            background: #6C63FF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        iframe[id^="launcher"] {
            display: none !important;
        }
    </style>
</head>
<body>
    <div id="loading">
        <div class="spinner"></div>
        <div>Connecting to support...</div>
    </div>
    
    <div id="error">
        <h3>⚠️ Connection Error</h3>
        <p>Unable to load Zendesk chat. Please check your internet connection.</p>
        <button onclick="location.reload()">Retry</button>
    </div>
    
    <script>
        var loadTimeout;
        var maxRetries = 3;
        var retryCount = 0;
        
        // Configure Zendesk before loading
        window.zESettings = {
            webWidget: {
                launcher: {
                    mobile: {
                        labelVisible: false
                    }
                },
                offset: {
                    mobile: {
                        horizontal: '0px',
                        vertical: '0px'
                    }
                },
                zIndex: 999999
            }
        };
        
        // Set timeout for loading
        loadTimeout = setTimeout(function() {
            if (retryCount < maxRetries) {
                retryCount++;
                console.log('Retry attempt: ' + retryCount);
                loadZendesk();
            } else {
                document.getElementById('loading').style.display = 'none';
                document.getElementById('error').style.display = 'flex';
            }
        }, 10000);
        
        function loadZendesk() {
            var script = document.createElement('script');
            script.id = 'ze-snippet';
            script.src = 'https://static.zdassets.com/ekr/snippet.js?key=${widget.zendeskKey}';
            script.async = true;
            script.onload = function() {
                clearTimeout(loadTimeout);
                initZendesk();
            };
            script.onerror = function() {
                console.error('Failed to load Zendesk script');
                if (retryCount < maxRetries) {
                    retryCount++;
                    setTimeout(loadZendesk, 2000);
                } else {
                    document.getElementById('loading').style.display = 'none';
                    document.getElementById('error').style.display = 'flex';
                }
            };
            document.body.appendChild(script);
        }
        
        function initZendesk() {
            var checkInterval = setInterval(function() {
                if (typeof zE !== 'undefined') {
                    clearInterval(checkInterval);
                    clearTimeout(loadTimeout);
                    
                    document.getElementById('loading').style.display = 'none';
                    
                    // Open the messenger
                    try {
                        zE('messenger', 'open');
                        console.log('Zendesk messenger opened successfully');
                    } catch(e) {
                        console.error('Error opening messenger:', e);
                        document.getElementById('error').style.display = 'flex';
                    }
                }
            }, 100);
            
            // Timeout after 5 seconds
            setTimeout(function() {
                if (typeof zE === 'undefined') {
                    clearInterval(checkInterval);
                    document.getElementById('loading').style.display = 'none';
                    document.getElementById('error').style.display = 'flex';
                }
            }, 5000);
        }
        
        // Start loading
        loadZendesk();
    </script>
</body>
</html>
    ''';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    _position = Offset(size.width - 80.w, size.height - 150.h);
  }

  void _toggleChat() {
    setState(() {
      _isChatOpen = !_isChatOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        if (_isChatOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleChat,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        if (_isChatOpen)
          Positioned(
            right: 20.w,
            bottom: 100.h,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                width: size.width * 0.9,
                height: size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.support_agent,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Zendesk Support',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                            onPressed: _toggleChat,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                        ),
                        child: WebViewWidget(
                          controller: _webViewController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
            onPanStart: (details) {
              setState(() {
                _isDragging = true;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                _position = Offset(
                  (_position.dx + details.delta.dx).clamp(0.0, size.width - 60.w),
                  (_position.dy + details.delta.dy).clamp(0.0, size.height - 60.h),
                );
              });
            },
            onPanEnd: (details) {
              setState(() {
                _isDragging = false;
              });
            },
            onTap: () {
              if (!_isDragging) {
                _toggleChat();
              }
            },
            child: Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                _isChatOpen ? Icons.close : Icons.chat_bubble,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
