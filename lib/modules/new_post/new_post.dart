import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        UserModel model = cubit.userModel;

        return Scaffold(
          appBar: defAppBar(context: context, title: 'Create Post', actions: [
            TextButton(
              child: const Text(
                'POST',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (cubit.postImagePicked == null) {
                  cubit.createNewPost(
                    text: textController.text,
                    dateTime: cubit.todayDate(),
                  );
                } else {
                  cubit.uploadPostImage(
                    text: textController.text,
                    dateTime: cubit.todayDate(),
                  );
                }
                textController.text = "";
              },
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (state is CreateNewPostLoadingState)
                      const LinearProgressIndicator(),
                    if (state is CreateNewPostLoadingState)
                      const SizedBox(
                        height: 10.0,
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage('${cubit.userModel.profileimage}'),
                          radius: 25.0,
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${model.name}',
                                style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4),
                              ),
                              Text(
                                'public',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[600],
                                    height: 1.4),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: TextFormField(
                        controller: textController,
                        maxLines: 10,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'What Is On Your Mind, ${model.name!.split(' ').first} ...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (cubit.postImagePicked != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                              height: 400.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(7.0),
                                      topLeft: Radius.circular(7.0)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          FileImage(cubit.postImagePicked!)))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 18,
                              child: IconButton(
                                  onPressed: () {
                                    cubit.removePostImage();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    if (cubit.postImagePicked != null)
                      SizedBox(
                        height: 20.0,
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              cubit.pickPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(IconBroken.Image_2),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text('Add Photo')
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {}, child: const Text('#tags')),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
