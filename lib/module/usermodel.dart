import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? attached;
  String? email;
  String? name;
  String? phone;
  String? uid;

  UserModel({this.attached, this.email, this.name, this.phone, this.uid});

  //서버 데이터 받는
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map('uid'),
      email: map('email'),
      name: map('name'),
      phone: map('phone'),
      attached: map('attached'),
    );
  }

  //서버로 보내는
  Map<String, dynamic> toMap() {
    return {
      'attached': attached,
      'email': email,
      'name': name,
      'phone': phone,
      'uid': uid,
    };
  }
}
