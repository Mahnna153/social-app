abstract class SocialRegisterStates {}

class SocialRegisterInitiateState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String erro;

  SocialRegisterErrorState(this.erro);
}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final String erro;

  SocialCreateUserErrorState(this.erro);
}

class SocialRegisterVisibilityState extends SocialRegisterStates {}
