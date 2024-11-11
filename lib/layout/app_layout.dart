import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialAppLayoutScreen extends StatelessWidget {
  const SocialAppLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is NewPostState) {
        navigateTo(context, NewPostScreen());
      }
    }, builder: (context, state) {
      var cubit = AppCubit.get(context);

      return Scaffold(
        appBar: AppBar(
          title: Text('${cubit.titles[cubit.currentIndex]}'),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
            IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeBottomNavIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat), label: 'Chats'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Upload), label: 'Post'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Location), label: 'Users'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting), label: 'Settings'),
          ],
        ),
      );
    });
  }
}
