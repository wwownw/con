import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'home_info.dart';

class FilePage extends StatefulWidget {
  const FilePage({Key? key}) : super(key: key);

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    //TODO: 외부 게시판 연동해서 파일 다운받을 수 있게 + pdf뷰어 해야함 (웹뷰?)
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          '행사자료',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: InterPagee(),
    );
  }
}

class InterPagee extends StatefulWidget {
  @override
  _InterPageeState createState() => _InterPageeState();
}

class _InterPageeState extends State<InterPagee> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InAppWebView(
        key: webViewKey,
        initialUrlRequest:
            URLRequest(url: Uri.parse('https://conf.imweb.me/file')),
        initialOptions: options,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
      ),
    );
  }
}
