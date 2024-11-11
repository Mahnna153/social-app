import 'package:flutter/material.dart';

MaterialColor defColor = Colors.blue;

// void signOut(context){
//   CacheHelper.removeData(key: 'token').then((value) {
//   String? t = CacheHelper.getData(key: 'token');
//   print(t);
//   navigateAndKill(context, ShopLoginScreen());
//   });
// }

/// Print Long String
void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}

String? uId = '';
