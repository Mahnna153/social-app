import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import '../../models/user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;
  ChatDetailsScreen({Key? key, required this.model}) : super(key: key);

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMessages(receiverId: model.uId!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            var messages = cubit.messages;
            return Scaffold(
              appBar: AppBar(
                leading: const Icon(IconBroken.Arrow___Left_2),
                titleSpacing: 0.0,
                title: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${model.profileimage}'),
                      radius: 23.0,
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      '${model.name}',
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          height: 1.4),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                var message = messages[index];
                                if (cubit.userModel.uId == message.senderId) {
                                  return myChatItem(message);
                                }
                                return receiverChatItem(message);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                              itemCount: messages.length)),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 47,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black54,
                                ),
                                borderRadius: BorderRadius.circular(22.0),
                              ),
                              child: TextFormField(
                                  controller: textController,
                                  style: const TextStyle(fontSize: 18.5),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      right: 5,
                                      left: 10,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Type Your Message Here...',
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: defColor),
                              child: IconButton(
                                  onPressed: () {
                                    cubit.sendMessage(
                                        dateTime: DateTime.now().toString(),
                                        text: textController.text,
                                        receiverId: model.uId!);
                                  },
                                  icon: const Icon(
                                    IconBroken.Send,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget myChatItem(MessageModel message) => Align(
        child: Container(
          child: Text(
            '${message.text}',
            style: const TextStyle(fontSize: 18.0),
          ),
          decoration: BoxDecoration(
              color: defColor.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0))),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        ),
        alignment: Alignment.centerRight,
      );
  Widget receiverChatItem(MessageModel message) => Align(
        child: Container(
          child: Text(
            '${message.text}',
            style: const TextStyle(fontSize: 18.0),
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        ),
        alignment: Alignment.centerLeft,
      );
}
