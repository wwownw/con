import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '지역정보',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: const InterPagee(),
    );
  }
}

class InterPagee extends StatefulWidget {
  const InterPagee({Key? key}) : super(key: key);

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
          useOnDownloadStart: true,
          allowFileAccessFromFileURLs: true),
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
        initialUrlRequest: URLRequest(url: Uri.parse('https://www.naver.com/')),
        initialOptions: options,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
      ),
    );
  }
}
