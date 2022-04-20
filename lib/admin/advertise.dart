import 'package:con/preclass_quiz/preclassintro.dart';
import 'package:url_launcher/url_launcher.dart';
import '../donatepage.dart';
import 'package:flutter/material.dart';

class MainBanner {
  List banner = [
    const Banner(),
    const Banner(),
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
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class Advertise {
  List advertises = [
    Advert('images/ad1.png', 'https://www.komipo.co.kr/kor/main/main.do'),
    Advert('images/ad2.png', 'https://www.skens.com/sk/main/index.do'),
    Advert('images/ad3.png', 'http://www.lng-tml.com/'),
    Advert('images/ad4.png', 'http://www.cniwbc.co.kr/'),
  ];
}

Future<void> goWebLink(String urllink) async {
  final url = urllink;
  if (await canLaunch(url)) {
    await launch(url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }
}

Container Advert(String images, String urllink) {
  return Container(
    child: GestureDetector(
      onTap: () {
        goWebLink(urllink);
      },
      child: Image.asset(images),
    ),
  );
}
