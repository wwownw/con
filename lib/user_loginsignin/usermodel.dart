class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phone;
  String? affiliation;
  bool? admin;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.phone,
      this.affiliation,
      this.admin});

  //서버 데이터 받는
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        phone: map['phone'],
        affiliation: map['affiliation'],
        admin: map['admin']);
  }

  //서버로 보내는
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'affiliation': affiliation,
      'admin': admin,
    };
  }
}
