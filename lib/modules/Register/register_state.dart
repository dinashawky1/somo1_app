abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  get uId => null;
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends RegisterStates {
  var uId;
}

class CreateUserErrorState extends RegisterStates {
  final String error;
  CreateUserErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}
