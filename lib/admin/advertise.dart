import 'package:con/preclass_quiz/preclassintro.dart';
import 'package:url_launcher/url_launcher.dart';
import '../donatepage.dart';
import 'package:flutter/material.dart';

class MainBanner {
  List banner = [
    const Banner(),
    const Banners(),
  ];
}

class Banner extends StatelessWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PreclassIntroPage()));
        },
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class Banners extends StatelessWidget {
  const Banners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DonatePage()));
        },
      ),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class Advertise {
  List advertises = [
    Row(
      children: [
        Expanded(
            child: advert(
                'images/ad1.png', 'https://www.komipo.co.kr/kor/main/main.do')),
        Expanded(
            child: advert(
                'images/ad2.png', 'https://www.skens.com/sk/main/index.do')),
      ],
    ),
    Row(
      children: [
        Expanded(child: advert('images/ad3.png', 'http://www.lng-tml.com/')),
        Expanded(child: advert('images/ad4.png', 'http://www.cniwbc.co.kr/')),
      ],
    ),
  ];
}

Future<void> goWebLink(String urllink) async {
  final url = urllink;
  if (await canLaunch(url)) {
    await launch(url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }
}

Container advert(String images, String urllink) {
  return Container(
    child: GestureDetector(
      onTap: () {
        goWebLink(urllink);
      },
      child: Image.asset(images),
    ),
  );
}
