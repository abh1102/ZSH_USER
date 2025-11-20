import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';

import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/data/model/get_answer_model.dart';
import 'package:zanadu/features/health_coach/data/repository/health_coach_repository.dart';
import 'package:zanadu/features/login/data/model/login_model.dart';
import 'package:zanadu/features/login/data/model/user_model.dart';
import 'package:zanadu/features/login/data/repository/login_repository.dart';
import 'package:zanadu/features/login/logic/services/preference_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  final LoginRepository _repository = LoginRepository();

  final HealthCoachRepository healthrepository = HealthCoachRepository();

  Future<void> login(
      {required String email,
      required String password,
      bool rememberMe = false}) async {
    emit(LoginLoadingState());
    try {
      LoginModel loginModel =
          await _repository.logIn(email: email, password: password);

      if (loginModel.role == "COACH") {
        emit(LoginErrorState("This is User App Please Download Coach app"));

        return;
      }

      // Call the fetchUserInfo function to get user details
      UserModel userModel =
          await _repository.fetchUserInfo(token: loginModel.accessToken ?? '');

      await Preferences.saveAccessToken(loginModel.accessToken ?? "");

      if (rememberMe == true) {
        // If "Remember Me" is checked, store the access token
        print("saving the data");
        await Preferences.saveUserDetails(
          email,
          password,
        );
        print("saving the dataaaaaaaaaaaaaaaaaaa");
      }

      //to locally store the user model
      myUser = userModel;
      userEmail = loginModel.email;
      myuid = loginModel.uid;
      // myuid = generateUnique9DigitNumber(loginModel.uid ?? 123456789);

      if (loginModel.email != null && loginModel.email!.isNotEmpty) {
        await Preferences.saveUserEmail(loginModel.email!);
      }

      List<GetAnswerModel> healthIntakeAnswers = await healthrepository
          .fetchAllHealthIntakeAnswer(userModel.userInfo?.userId ?? '');

      if (healthIntakeAnswers.isEmpty) {
        print("emptyyyyyyyyyyyyyyyyyyyyyyiiiiii");
        // If health intake data is empty, navigate to the appropriate screen
        emit(LoginHealthLoadedState(userModel));
        return;
      }

      emit(LoginLoadedState(userModel));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> updateUser({
    String? fullName,
    String? dob,
    String? gender,
    List<String>? topHealthChallenges,
    String? state,
    String? image,
  }) async {
    emit(LoginLoadingState());
    try {
      // Call the updateUser function from the repository
      await _repository.editProfile(
        fullName: fullName,
        dob: dob,
        gender: gender,
        topHealthChallenges: [],
        state: state,
        image: image,
      );

      // Update the locally stored user model

      UserModel userModel = await _repository.fetchUserInfo(token: accessToken);

      myUser = userModel;

      emit(UserUpdatedState(userModel));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(LoginLoadingState());
    try {
      // Get the user token from preferences

      // Call the changePassword function from the repository
      String message = await _repository.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      // Update the locally stored user model

      emit(PasswordChangedState(message));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }


// remove profile photo


  Future<void> removeProfilePhoto() async {
    emit(LoginLoadingState());
    try {
      // Call the updateUser function from the repository
      await _repository.removeProfilePhoto();

      // Update the locally stored user model

      UserModel userModel =
          await _repository.fetchUserInfo(token: accessToken);

      myUser = userModel;

      emit(LoginLoadedState(userModel));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }


  Future<void> logout() async {
    emit(LoginLoadingState());
    try {
      await Preferences.clear();
      // Clear stored user details
      Routes.closeAllAndGoTo(Screens.login);
      showGreenSnackBar("Logout Successfully");
      emit(LoginLogoutState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(LoginLoadingState());
    try {
      String message = await _repository.forgotPassword(email: email);
      emit(ForgetPassEmailSentLoadState(message));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> verifyForgotPasswordOTP({
    required String email,
    required int otp,

    
  }) async {
    emit(LoginLoadingState());
    try {
      String message = await _repository.verifyForgotPasswordOTP(
        email: email,
        otp: otp,
      );
      emit(ForgetPassOtpVerifyLoadState(message));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> changeForgottenPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(LoginLoadingState());
    try {
      // Call the changeForgottenPassword function from the repository
      String message = await _repository.changeForgottenPassword(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      emit(ForgetPasswordChangedState(message));
    } catch (e) {
      // Handle the error scenario or update the UI as needed
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> getChangePhoneOtp() async {
    emit(LoginLoadingState());
    try {
      // Call the repository function to get OTP for changing the phone number
      String message = await _repository.getChangePhoneOtp();

      // Emit a state indicating success or handle the OTP as needed
      // For example, you might want to navigate to the next screen with the OTP
      emit(ChangePhoneOtpSentLoadState(message));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> verifyChangePhoneOtp({required int otp}) async {
    emit(LoginLoadingState());
    try {
      String message = await _repository.verifyChangePhoneOtp(otp: otp);

      // Check the response message and perform actions accordingly
      emit(ChangePhoneOtpVerifyLoadState(message));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> changePhoneNumber({required String phone}) async {
    emit(LoginLoadingState());
    try {
      String message = await _repository.changePhoneNumber(phone: phone);
      UserModel userModel = await _repository.fetchUserInfo(token: accessToken);

      myUser = userModel;

      emit(ChangedPhoneChangedState(message));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> deleteUser(String status) async {
    emit(LoginLoadingState());
    try {
      final message = await _repository.deleteUser(status);
      await Preferences.clear();
      // Clear stored user details

      emit(LoginDeleteUserState(message));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
