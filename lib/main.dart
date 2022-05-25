import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somo1_app/Network/cacheHelper.dart';
import 'package:somo1_app/modules/HomeLayout/home_layout.dart';
import 'package:somo1_app/modules/Register/register_screen.dart';
import 'package:somo1_app/modules/Register/register_state.dart';
import 'package:somo1_app/shared/cubit.dart';
import 'package:somo1_app/shared/states.dart';
import 'package:somo1_app/shared/styles/bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  await CacheHelper.init();
  await Firebase.initializeApp();

  late Widget widget;
  var uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = HomeLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(Somo1App(startWidget: widget));
}

class Somo1App extends StatelessWidget {
  final Widget startWidget;
  Somo1App({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialCubit()..getUserData()),
      ],
      child: BlocProvider(
        create: (context) => SocialCubit(),
        child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
          ),
        ),
      ),
    );
  }
}
