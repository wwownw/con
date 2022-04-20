import 'dart:io';

import 'package:con/user_loginsignin/mypage.dart';
import 'package:con/coupon/couponcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import 'document/document.dart';
import 'document/pdfapi.dart';
import 'document/pdfviewpage.dart';
import 'notice/notice.dart';
import 'admin/advertise.dart';

// ignore: use_key_in_widget_constructors
class HomeItem extends StatefulWidget {
  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  bool lock() {
    var lockstate = LockState();
    lockstate.locate();
    lockstate.visited();
    return lockstate.lockstate;
  }

  Expanded homeButtons(
      StatefulWidget page, bool lockstate, String name, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        child: MaterialButton(
            elevation: 1,
            highlightElevation: 1,
            highlightColor: Colors.grey[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: lockstate
                ? lock()
                    ? Colors.grey[200]
                    : Colors.white
                : Colors.white,
            child: Container(
              margin: const EdgeInsets.only(top: 25, bottom: 25),
              child: Column(
                children: [
                  Center(
                    child: toIcon(context, icon),
                  ),
                  Divider(
                    height: 10,
                    thickness: 0,
                    color: Colors.white.withAlpha(0),
                  ),
                  Center(
                    child: Text(
                      name,
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                  )
                ],
              ),
            ),
            onPressed: () {
              if (lockstate) {
                if (lock()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('행사장에 방문한 경우에만 활성화되는 메뉴입니다.')));
                } else {
                  Navigator.push(
                      context, CupertinoPageRoute(builder: (context) => page));
                }
              } else {
                Navigator.push(
                    context, CupertinoPageRoute(builder: (context) => page));
              }
            }),
      ),
    );
  }

  Expanded goPdfButtons(
      String pdfName, bool lockstate, String name, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        child: MaterialButton(
            elevation: 1,
            highlightElevation: 1,
            highlightColor: Colors.grey[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.only(top: 25, bottom: 25),
              child: Column(
                children: [
                  Center(
                    child: toIcon(context, icon),
                  ),
                  Divider(
                    height: 10,
                    thickness: 0,
                    color: Colors.white.withAlpha(0),
                  ),
                  Center(
                    child: Text(
                      name,
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                  )
                ],
              ),
            ),
            onPressed: () async {
              final url = pdfName;
              final file = await PDFapi.loadFirebased(url);
              if (file == null) return;
              openPDF(context, file);
            }),
      ),
    );
  }

  Expanded goWebButtons(
      String urllink, bool lockstate, String name, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        child: MaterialButton(
            elevation: 1,
            highlightElevation: 1,
            highlightColor: Colors.grey[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.only(top: 25, bottom: 25),
              child: Column(
                children: [
                  Center(
                    child: toIcon(context, icon),
                  ),
                  Divider(
                    height: 10,
                    thickness: 0,
                    color: Colors.white.withAlpha(0),
                  ),
                  Center(
                    child: Text(
                      name,
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                  )
                ],
              ),
            ),
            onPressed: () async {
              goWebLink(urllink);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool coolphone = true;

    void heightcheck() {
      if (size.height < 780) {
        coolphone = false;
      }
    }

    heightcheck();

    bool isOpen = false;

    var ad = Advertise();
    var bn = MainBanner();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        physics: coolphone ? const NeverScrollableScrollPhysics() : null,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25, bottom: 25),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                '2022',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                '대한민국지속가능발전대회',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => (const MyPage())));
                          },
                          child: Icon(
                            Icons.person,
                            color: Colors.lightGreen.shade700,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: size.width,
                height: size.width * .5,
                child: Swiper(
                  viewportFraction: 0.83,
                  scale: 0.9,
                  pagination:
                      const SwiperPagination(margin: EdgeInsets.all(15)),
                  itemCount: bn.banner.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: bn.banner[index],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        goPdfButtons('introduce.pdf', false, '대회소개',
                            Icons.wysiwyg_outlined),
                        goWebButtons('https://www.brcn.go.kr/tour/sub04_02.do',
                            false, '지역정보', Icons.map_outlined),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        goPdfButtons('program.pdf', false, '대회일정',
                            Icons.assignment_outlined),
                        homeButtons(
                            const NoticePage(), false, '대회공지', Icons.list),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        homeButtons(const FilePage(), false, '대회자료',
                            Icons.file_copy_outlined),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: size.width,
                  height: 80,
                  child: Swiper(
                    autoplay: true,
                    autoplayDelay: 2000,
                    itemCount: ad.advertises.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ad.advertises[index],
                      );
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(40),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openPDF(BuildContext context, File file) async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)));
  }
}

Icon toIcon(BuildContext context, icon) {
  Icon toicon = Icon(
    icon,
    size: 22,
    color: Colors.grey[800],
  );
  return toicon;
}
