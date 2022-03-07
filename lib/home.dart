import 'package:con/mypage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'home_coupon.dart';
import 'home_file.dart';
import 'home_info.dart';
import 'home_map.dart';
import 'home_notice.dart';
import 'home_qna.dart';
import 'home_schedule.dart';
import 'advertise.dart';

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
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6),
        child: MaterialButton(
            elevation: 1.5,
            highlightElevation: 1.5,
            highlightColor: Colors.grey[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: lockstate
                ? lock()
                    ? Colors.grey[200]
                    : Colors.white
                : Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: 25, bottom: 25),
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

  @override
  Widget build(BuildContext context) {
    int selectedindex = 0;
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

    return Scaffold(
      body: SingleChildScrollView(
        physics: coolphone ? NeverScrollableScrollPhysics() : null,
        child: SafeArea(
          child: Column(children: [
            SizedBox(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 25, top: 25, bottom: 25),
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
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => (MyPage())));
                        },
                        child: const Icon(
                          Icons.person,
                          color: Color.fromRGBO(40, 120, 100, 100),
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                width: size.width,
                height: size.width * .45,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      homeButtons(
                          InfoPage(), false, '행사정보', Icons.wysiwyg_outlined),
                      homeButtons(MapPage(), false, '지도', Icons.map_outlined),
                      homeButtons(SchedulePage(), false, '행사일정',
                          Icons.assignment_outlined),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      homeButtons(NoticePage(), false, '행사공지', Icons.list),
                      homeButtons(QnaPage(), false, '문의', Icons.phone),
                      homeButtons(
                          CouponPage(), true, '쿠폰', Icons.wallet_giftcard),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      homeButtons(
                          FilePage(), false, '행사자료', Icons.file_copy_outlined),
                    ],
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 25),
            //   child: SizedBox(
            //       height: 81,
            //       child: ads(context, ad.advertises[selectedindex])),
            // ), //이게 원래 하던거!!!!!!
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber.withAlpha(20)),
                width: size.width,
                height: 80,
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 3000,
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
          ]),
        ),
      ),
    );
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
