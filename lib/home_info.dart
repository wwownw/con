import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    //TODO: 행사정보 + 각종 정보
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          '행사정보',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: InterPage(),
    );
  }
}

Row newAppBar(BuildContext context, text) {
  var size = MediaQuery.of(context).size;
  Row newappbar = Row(
    children: [
      Container(
          width: size.width * .333,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BackButton(),
              ),
            ],
          )),
      Container(
        width: size.width * .333,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    ],
  );
  return newappbar;
}

class InterPage extends StatefulWidget {
  @override
  _InterPageState createState() => _InterPageState();
}

class _InterPageState extends State<InterPage> {
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
            URLRequest(url: Uri.parse('https://conf.imweb.me/info')),
        initialOptions: options,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
      ),
    );
  }
}