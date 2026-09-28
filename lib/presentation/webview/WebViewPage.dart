import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:figma_design/i18n/strings.g.dart';

/// 네이티브 인앱 웹뷰. 앱을 벗어나지 않고 앱 내부에서 웹페이지를 띄운다.
///
/// [url] 을 라우트 인자로 받아 로드한다. (예: 도움말/공지 링크)
@RoutePage()
class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.url});

  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _loading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.webview.title)),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading) const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
