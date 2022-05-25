import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void navigateAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => Widget), (route) => false);
}

void navigateTO(context, Widget) {}

String? uId;
