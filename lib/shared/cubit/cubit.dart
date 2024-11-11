import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/modules/settings/settings.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/states.dart';
import '../../models/post_model.dart';
import '../../models/message_model.dart';
import '../../modules/feeds/feeds.dart';
import '../../modules/users/users.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel userModel = UserModel();

  String todayDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    String x = '${formattedDate}  ${formattedTime}';

    return x;
  }

  // var date = todayDate();

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(uId);
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      print(userModel.phone);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNavIndex(index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

  File? profilePicked;
  final picker = ImagePicker();

  Future pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profilePicked = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickProfileImageErrorState());
    }
  }

  File? coverPicked;

  Future pickCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverPicked = File(pickedFile.path);
      emit(PickCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickCoverImageErrorState());
    }
  }

  void uploadProfileImage({
    required String Name,
    required String Bio,
    required String Phone,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profilePicked!.path).pathSegments.last}')
        .putFile(profilePicked!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userDataUpdate(
          Name: Name,
          Bio: Bio,
          Phone: Phone,
          profile: value,
        );
        // emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String Name,
    required String Bio,
    required String Phone,
  }) {
    emit(UpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverPicked!.path).pathSegments.last}')
        .putFile(coverPicked!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        userDataUpdate(
          Name: Name,
          Bio: Bio,
          Phone: Phone,
          cover: value,
        );
        // emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadCoverImageErrorState());
    });
  }

  void userDataUpdate(
      {required String Name,
      required String Bio,
      required String Phone,
      String? profile,
      String? cover}) {
    emit(UpdateUserDataLoadingState());

    UserModel model = UserModel(
      name: Name,
      bio: Bio,
      phone: Phone,
      email: userModel.email,
      uId: userModel.uId,
      profileimage: profile ?? userModel.profileimage,
      coverimage: cover ?? userModel.coverimage,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      profilePicked = null;
      coverPicked = null;
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }

  File? postImagePicked;

  Future pickPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImagePicked = File(pickedFile.path);
      emit(PickPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickPostImageErrorState());
    }
  }

  void removePostImage() {
    postImagePicked = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String? dateTime,
    required String? text,
  }) {
    emit(CreateNewPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImagePicked!.path).pathSegments.last}')
        .putFile(postImagePicked!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(CreateNewPostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(CreateNewPostErrorState());
    });
  }

  void createNewPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(CreateNewPostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      profileImage: userModel.profileimage,
      uId: userModel.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      removePostImage();
      emit(CreateNewPostSuccessState());
      getPosts();
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(CreateNewPostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> postsLikes = [];

  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          postsLikes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      }
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });

    // FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
    //   posts = [];
    //   postsId = [];
    //   postsLikes = [];
    //   for (var element in event.docs) {
    //     element.reference.collection('likes').get().then((value) {
    //       postsLikes.add(value.docs.length);
    //       postsId.add(element.id);
    //       posts.add(PostModel.fromJson(element.data()));
    //     }).catchError((error) {});
    //   }
    //   emit(GetPostsSuccessState());
    // });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  //GetAllUserDataLoadingState
  List<UserModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      emit(GetAllUserDataLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        }
        emit(GetAllUserDataSuccessState());
      }).catchError((error) {
        emit(GetAllUserDataErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String dateTime,
    required String text,
    required String receiverId,
  }) {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel.uId,
    );

    // add to my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    // add to receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SendMessageSuccessState());
    });
  }
}
