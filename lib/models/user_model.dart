import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somo1_app/constants.dart';

class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late bool isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
  });

  UserModel.fromJson(json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
