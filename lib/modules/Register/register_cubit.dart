import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somo1_app/constants.dart';
import 'package:somo1_app/models/user_model.dart';
import 'package:somo1_app/modules/Register/register_state.dart';
import 'register_screen.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, phone: phone, email: email, uId: uId!);
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  var suffix = Icons.visibility_outlined;
  bool obscureText = true;

  void changePasswordVisibility() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
