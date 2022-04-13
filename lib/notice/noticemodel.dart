class NoticeModel {
  late String? created;
  String noticeTitle;
  String notice;

  NoticeModel({
    this.created,
    required this.notice,
    required this.noticeTitle,
  });

  //서버 데이터 받는
  factory NoticeModel.fromMap(map) {
    return NoticeModel(
      created: map['created'],
      noticeTitle: map['noticeTitle'],
      notice: map['notice'],
    );
  }

  //서버로 보내는
  Map<String, dynamic> toMap() {
    return {
      'created': created,
      'noticeTitle': noticeTitle,
      'notice': notice,
    };
  }
}
