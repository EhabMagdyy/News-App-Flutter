import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebViewPage extends StatefulWidget {
  final String url;

  const NewsWebViewPage({super.key, required this.url});

  @override
  State<NewsWebViewPage> createState() => _NewsWebViewPageState();
}

class _NewsWebViewPageState extends State<NewsWebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('Loading progress: $progress%');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('HTTP Error');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('Navigation to ${request.url} prevented');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E1),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFFFF5E1)),
        backgroundColor: const Color(0xFF0C1844),
        toolbarHeight: 60.0,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "News",
              style: TextStyle(
                color: Color(0xFFFFF5E1),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Mate",
              style: TextStyle(
                color: Color(0xFFFF6900),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
