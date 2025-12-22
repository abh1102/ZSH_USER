import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class ZendeskWebViewChat extends StatefulWidget {
  final String zendeskKey;

  const ZendeskWebViewChat({
    super.key,
    this.zendeskKey = 'f38d7cd6-0e6d-4c89-a53e-7523f425030b',
  });

  @override
  State<ZendeskWebViewChat> createState() => _ZendeskWebViewChatState();
}

class _ZendeskWebViewChatState extends State<ZendeskWebViewChat> {
  late WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error: ${error.description}');
            setState(() {
              _errorMessage = error.description;
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );

    if (Platform.isAndroid) {
      _controller.setUserAgent(
        'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36',
      );
    }

    _controller.loadRequest(
      Uri.parse('https://zanadu-zendesk.web.app'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFF6C63FF),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Loading Zendesk Chat...',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (_errorMessage != null && !_isLoading)
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.w),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: Colors.red,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Failed to load chat',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });
                      _initializeWebView();
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
