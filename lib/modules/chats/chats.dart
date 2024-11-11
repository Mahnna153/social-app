import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        List<UserModel> users = cubit.users;
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(context, users[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1.0,
                  ),
                ),
            itemCount: users.length);
      },
    );
  }

  Widget buildChatItem(BuildContext context, UserModel model) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(model: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.profileimage}'),
                radius: 30.0,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      style: const TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          height: 1.4),
                    ),
                    if (model.bio != "write your bio...")
                      Text(
                        '${model.bio}',
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
        ),
      );
}
