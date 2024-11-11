import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

import 'layout/app_layout.dart';
import 'modules/login/social_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();


  uId = CacheHelper.getData(key: 'uId');
  print(uId);

  // print(token);

  Widget? startWidget;

  if (uId != null) {
    startWidget = const SocialAppLayoutScreen();
    // if (token != null) startWidget = ShopLayoutScreen();
    // if (token == null) startWidget = ShopLoginScreen();
  } else {
    startWidget = SocialLoginScreen();
  }

  runApp(MyApp(
    // isDark: isDark,
    startWidget: startWidget,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // bool? isDark;
  //
  Widget? startWidget;
  //{required this.isDark, required this.startWidget}
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: ThemeMode.light,
            //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget, //startWidget
          );
        },
      ),
    );
  }
}
