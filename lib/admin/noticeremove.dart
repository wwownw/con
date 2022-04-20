import 'package:con/notice/addnotice.dart';
import 'package:con/notice/noticemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeRemovePage extends StatefulWidget {
  const NoticeRemovePage({Key? key}) : super(key: key);

  @override
  State<NoticeRemovePage> createState() => _NoticeRemovePageState();
}

class _NoticeRemovePageState extends State<NoticeRemovePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '행사공지',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: const NoticeRemove(),
    );
  }
}

class NoticeRemove extends StatefulWidget {
  const NoticeRemove({Key? key}) : super(key: key);

  @override
  _NoticeRemoveState createState() => _NoticeRemoveState();
}

class _NoticeRemoveState extends State<NoticeRemove> {
  FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

  List noticedList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getNoticeList();

    if (resultant == null) {
      print('Unable to retrive');
    } else {
      setState(() {
        noticedList = resultant;
      });
    }
  }

  deleteNoticeList(item) {
    final DocumentReference noticeList =
        FirebaseFirestore.instance.collection('notice').doc(item);

    noticeList.delete().whenComplete(() => print('delete complete'));
  }

  @override
  Widget build(BuildContext context) {
    // final ref = fb.ref().child('notice');
    // return Scaffold(
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: Colors.white,
    //     child: const Icon(Icons.add),
    //     onPressed: () {
    //       Navigator.of(context)
    //           .push(MaterialPageRoute(builder: (context) => const AddNotice()));
    //     },
    //   ),
    //   backgroundColor: Colors.grey[100],
    //   body: Padding(
    //     padding: const EdgeInsets.only(top: 20.0, bottom: 20),
    //     child: FirebaseAnimatedList(
    //       query: ref,
    //       itemBuilder: (context, snapshot, animation, index) {
    //         return Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //           child: GestureDetector(
    //             onTap: () {
    //               Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (context) => const Noticee()));
    //             },
    //             child: ListTile(
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(20),
    //               ),
    //               tileColor: Colors.white,
    //               trailing: IconButton(
    //                 icon: const Icon(
    //                   Icons.delete,
    //                   color: Colors.red,
    //                 ),
    //                 onPressed: () {
    //                   ref.child(snapshot.key!).remove();
    //                 },
    //               ),
    //               title: Padding(
    //                 padding:
    //                     const EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Expanded(
    //                           child: Text(
    //                             snapshot.child('noticeTitle').value.toString(),
    //                             maxLines: 1,
    //                             overflow: TextOverflow.ellipsis,
    //                             style: const TextStyle(
    //                               fontSize: 18,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     const Divider(),
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                           child: Text(
    //                             snapshot.child('created').value.toString(),
    //                             style: TextStyle(
    //                                 fontSize: 13,
    //                                 fontWeight: FontWeight.normal,
    //                                 color: Colors.grey.shade500),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 5),
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                           child: Text(
    //                             snapshot.child('noticed').value.toString(),
    //                             style: TextStyle(
    //                                 fontSize: 16,
    //                                 fontWeight: FontWeight.normal,
    //                                 color: Colors.grey.shade700),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddNotice()));
        },
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView.builder(
          itemCount: noticedList.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              tileColor: Colors.white,
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    noticedList.removeAt(index);
                    deleteNoticeList(
                        '${noticedList[index]['created']}, ${noticedList[index]['noticeTitle']}');
                  });
                },
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            noticedList[index]['noticeTitle'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Divider(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            noticedList[index]['created'],
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            noticedList[index]['creator'],
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.lightGreen.shade800),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            noticedList[index]['notice'],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
