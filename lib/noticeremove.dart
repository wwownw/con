import 'package:con/notice/addnotice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'notice/noticee.dart';

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
  final fb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('notice');

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
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Noticee()));
                },
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
                      ref.child(snapshot.key!).remove();
                    },
                  ),
                  title: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.child('noticeTitle').value.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.child('created').value.toString(),
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey.shade500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.child('noticed').value.toString(),
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
            );
          },
        ),
      ),
    );
  }
}
