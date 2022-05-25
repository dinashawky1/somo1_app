import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somo1_app/constants.dart';
import 'package:somo1_app/models/user_model.dart';
import 'package:somo1_app/shared/states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? model; 
  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      model = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(SocialGetUserErrorState(error.toString()));
    });
  }
}
