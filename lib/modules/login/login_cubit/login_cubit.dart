import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:somo1_app/constants.dart';
import 'login_states.dart';
import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value.user!.email);
      // print(value.user!.uid);
      emit(LoginSuccessState(uId.toString()));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  var suffix = Icons.visibility_outlined;
  bool obscureText = true;

  void changePasswordVisibility() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
