import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  late String? created;
  String? noticeTitle;
  String? notice;
  String? creator;

  NoticeModel({
    this.created,
    this.notice,
    this.noticeTitle,
    this.creator,
  });

  //서버 데이터 받는
  factory NoticeModel.fromMap(map) {
    return NoticeModel(
      created: map['created'],
      noticeTitle: map['noticeTitle'],
      notice: map['notice'],
      creator: map['creator'],
    );
  }

  //서버로 보내는
  Map<String, dynamic> toMap() {
    return {
      'created': created,
      'noticeTitle': noticeTitle,
      'notice': notice,
      'creator': creator,
    };
  }
}

class DatabaseManager {
  final CollectionReference noticeList =
      FirebaseFirestore.instance.collection('notice');

  Future getNoticeList() async {
    List itemList = [];

    try {
      await noticeList
          .orderBy('created', descending: true)
          .get()
          .then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          itemList.add(element.data());
        }
      });
      return itemList;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
