abstract class SocialLoginStates {}

class SocialLoginInitiateState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String erro;

  SocialLoginErrorState(this.erro);
}

class SocialLoginVisibilityState extends SocialLoginStates {}
