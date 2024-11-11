import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var userModel = cubit.userModel;
        File? profilePicked = cubit.profilePicked;
        File? coverPicked = cubit.coverPicked;
        nameController.text = userModel.name.toString();
        phoneController.text = userModel.phone.toString();
        bioController.text = userModel.bio.toString();

        return Scaffold(
          appBar: defAppBar(context: context, title: 'Edit Profile', actions: [
            TextButton(
                onPressed: () {
                  cubit.userDataUpdate(
                      Name: nameController.text,
                      Bio: bioController.text,
                      Phone: phoneController.text);

                  // if (cubit.coverPicked == null &&
                  //     cubit.profilePicked == null) {
                  //   cubit.userDataUpdate(
                  //       Name: nameController.text,
                  //       Bio: bioController.text,
                  //       Phone: phoneController.text);
                  // }
                  // if (cubit.profilePicked != null) {
                  //   cubit.uploadProfileImage(
                  //       Name: nameController.text,
                  //       Bio: bioController.text,
                  //       Phone: phoneController.text);
                  // }
                  // if (cubit.profilePicked != null) {
                  //   cubit.uploadCoverImage(
                  //       Name: nameController.text,
                  //       Bio: bioController.text,
                  //       Phone: phoneController.text);
                  // }
                },
                child: const Text(
                  'UPDATE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              width: 15.0,
            )
          ]),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  if (state is UpdateUserDataLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 235,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                  height: 180.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(7.0),
                                          topLeft: Radius.circular(7.0)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: coverPicked == null
                                            ? NetworkImage(
                                                '${userModel.coverimage}')
                                            : FileImage(coverPicked)
                                                as ImageProvider,
                                      ))),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 18,
                                  child: IconButton(
                                      onPressed: () {
                                        cubit.pickCoverImage();
                                      },
                                      icon: const Icon(
                                        IconBroken.Camera,
                                        size: 20,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 58.5,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundImage: profilePicked == null
                                    ? NetworkImage('${userModel.profileimage}')
                                    : FileImage(profilePicked) as ImageProvider,
                                radius: 55.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                radius: 18,
                                child: IconButton(
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    cubit.pickProfileImage();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  // const SizedBox(
                  //   height: 15.0,
                  // ),
                  //
                  if (cubit.profilePicked != null || cubit.coverPicked != null)
                    Row(
                      children: [
                        if (cubit.profilePicked != null)
                          Expanded(
                              child: defButton(
                                  text: 'upload Profile',
                                  function: () {
                                    cubit.uploadProfileImage(
                                        Name: nameController.text,
                                        Bio: bioController.text,
                                        Phone: phoneController.text);
                                  })),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (cubit.coverPicked != null)
                          Expanded(
                              child: defButton(
                                  text: 'upload cover',
                                  function: () {
                                    cubit.uploadCoverImage(
                                        Name: nameController.text,
                                        Bio: bioController.text,
                                        Phone: phoneController.text);
                                  })),
                      ],
                    ),
                  if (cubit.profilePicked != null || cubit.coverPicked != null)
                    const SizedBox(
                      height: 15.0,
                    ),
                  defFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      label: 'Name',
                      prefix: IconBroken.Profile,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name Field Must Not Be Empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  defFormField(
                      controller: bioController,
                      keyboardType: TextInputType.text,
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Bio Field Must Not Be Empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 12.0,
                  ),
                  defFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      label: 'Phone Number',
                      prefix: IconBroken.Call,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone Number Field Must Not Be Empty';
                        }
                        return null;
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
