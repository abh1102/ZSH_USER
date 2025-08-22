part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginHealthLoadedState extends LoginState {
  final UserModel user;
  LoginHealthLoadedState(this.user);
}

class LoginLoadedState extends LoginState {
  final UserModel user;
  LoginLoadedState(this.user);
}

class PasswordChangedState extends LoginState {
  final String message;
  PasswordChangedState(this.message);
}

class ForgetPasswordChangedState extends LoginState {
  final String message;
  ForgetPasswordChangedState(this.message);
}

class ForgetPassEmailSentLoadState extends LoginState {
  final String message;
  ForgetPassEmailSentLoadState(this.message);
}

class ChangePhoneOtpSentLoadState extends LoginState {
  final String message;
  ChangePhoneOtpSentLoadState(this.message);
}

class ForgetPassOtpVerifyLoadState extends LoginState {
  final String message;
  ForgetPassOtpVerifyLoadState(this.message);
}

class ChangePhoneOtpVerifyLoadState extends LoginState {
  final String message;
  ChangePhoneOtpVerifyLoadState(this.message);
}

class ChangedPhoneChangedState extends LoginState {
  final String message;
  ChangedPhoneChangedState(this.message);
}

class UserUpdatedState extends LoginState {
  final UserModel user;
  UserUpdatedState(this.user);
}

class LoginLogoutState extends LoginState {}


class LoginDeleteUserState extends LoginState {
  final String message;

  LoginDeleteUserState(this.message);
}
class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
