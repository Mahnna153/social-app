import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var posts = cubit.posts;

        return ConditionalBuilder(
          //
          condition: posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 5.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: const [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/attractive-woman-with-happy-expression-advices-use-this-copy-space-wisely_273609-18278.jpg?size=626&ext=jpg&ga=GA1.2.1578537062.1665933372'),
                        fit: BoxFit.cover,
                        height: 235.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate With Friends',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildPostItem(posts[index], context, index);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8.0,
                      );
                    },
                    itemCount: posts.length),
                const SizedBox(
                  height: 8.0,
                )
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, int index) => Card(
        elevation: 5.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${model.profileImage}'),
                    radius: 25.0,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 18,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[600],
                              height: 1.4),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 20.0,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1.0,
                ),
              ),
              Text(
                '${model.text}',
                style: const TextStyle(
                    fontSize: 15.4, height: 1.3, fontWeight: FontWeight.bold),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 4.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(right: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               padding: EdgeInsets.zero,
              //               minWidth: 1.0,
              //               child: Text(
              //                 '#software_development',
              //                 style: TextStyle(color: defColor, fontSize: 14),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(right: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               padding: EdgeInsets.zero,
              //               minWidth: 1.0,
              //               child: Text(
              //                 '#software',
              //                 style: TextStyle(color: defColor, fontSize: 14),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(right: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               padding: EdgeInsets.zero,
              //               minWidth: 1.0,
              //               child: Text(
              //                 '#flutter',
              //                 style: TextStyle(color: defColor, fontSize: 14),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(right: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               padding: EdgeInsets.zero,
              //               minWidth: 1.0,
              //               child: Text(
              //                 '#dart',
              //                 style: TextStyle(color: defColor, fontSize: 14),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(right: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               padding: EdgeInsets.zero,
              //               minWidth: 1.0,
              //               child: Text(
              //                 '#android',
              //                 style: TextStyle(color: defColor, fontSize: 14),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(right: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               padding: EdgeInsets.zero,
              //               minWidth: 1.0,
              //               child: Text(
              //                 '#coding',
              //                 style: TextStyle(color: defColor, fontSize: 14),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 330.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${model.postImage}'))),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 20.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${AppCubit.get(context).postsLikes[index]}',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                              size: 20.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '0 comments',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.grey[300],
                width: double.infinity,
                height: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '${AppCubit.get(context).userModel.profileimage}'),
                              radius: 18.0,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              'write a comment...',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 20.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Like',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        AppCubit.get(context)
                            .likePost(AppCubit.get(context).postsId[index]);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
