import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/social_login_cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitiateState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void chandPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialLoginVisibilityState());
  }
}
