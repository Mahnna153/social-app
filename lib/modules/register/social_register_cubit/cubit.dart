import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/social_register_cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitiateState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      print(
          value.user!.uid + "DDDDDDDDDDDDDDDDDOOOOOOOOOOOONNNNNNNNNNNNEEEEEEE");
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        profileimage:
            'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?size=626&ext=jpg&ga=GA1.2.1578537062.1665933372',
        bio: 'write your bio...',
        coverimage:
            'https://img.freepik.com/free-psd/abstract-black-gold-lines-luxury-background_271628-879.jpg?size=626&ext=jpg&ga=GA1.2.1578537062.1665933372');

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      print('crete Done :)');
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" +
          error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void chandPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialRegisterVisibilityState());
  }
}
