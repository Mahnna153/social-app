import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        UserModel userModel = cubit.userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 235,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 180.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(7.0),
                                topLeft: Radius.circular(7.0)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage('${userModel.coverimage}'))),
                      ),
                    ),
                    CircleAvatar(
                      radius: 58.5,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage('${userModel.profileimage}'),
                        radius: 55.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 9.0,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '98',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 9.0,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '45',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 9.0,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 9.0,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '77',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 9.0,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Update Profile'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: const Icon(
                      IconBroken.Edit,
                      size: 18.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
