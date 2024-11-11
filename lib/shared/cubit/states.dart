abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

class NewPostState extends AppStates {}

//get user data

class GetUserDataLoadingState extends AppStates {}

class GetUserDataSuccessState extends AppStates {}

class GetUserDataErrorState extends AppStates {
  final String error;
  GetUserDataErrorState(this.error);
}

//get all users

class GetAllUserDataLoadingState extends AppStates {}

class GetAllUserDataSuccessState extends AppStates {}

class GetAllUserDataErrorState extends AppStates {
  final String error;
  GetAllUserDataErrorState(this.error);
}

// get posts

class GetPostsLoadingState extends AppStates {}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {
  final String error;
  GetPostsErrorState(this.error);
}

class PickProfileImageSuccessState extends AppStates {}

class PickProfileImageErrorState extends AppStates {}

class PickCoverImageSuccessState extends AppStates {}

class PickCoverImageErrorState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {}

class UploadCoverImageSuccessState extends AppStates {}

class UploadCoverImageErrorState extends AppStates {}

class UpdateUserDataLoadingState extends AppStates {}

class UpdateUserDataErrorState extends AppStates {}

// post

class CreateNewPostLoadingState extends AppStates {}

class CreateNewPostSuccessState extends AppStates {}

class CreateNewPostErrorState extends AppStates {}

class PickPostImageSuccessState extends AppStates {}

class PickPostImageErrorState extends AppStates {}

class RemovePostImageState extends AppStates {}

// post like

class LikePostSuccessState extends AppStates {}

class LikePostErrorState extends AppStates {}

// chat

class SendMessageSuccessState extends AppStates {}

class SendMessageErrorState extends AppStates {}

class GetMessageSuccessState extends AppStates {}

class GetMessageErrorState extends AppStates {}
