import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';

class LoginProvider with ChangeNotifier {
  final BuildContext context;
  LoginProvider(this.context) {
    _listenToLoginCubit();
  }

  bool rememberMe = false;
  bool isLoading = false;
  String error = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StreamSubscription? _loginSubscription;

  void _listenToLoginCubit() {
    _loginSubscription =
        BlocProvider.of<LoginCubit>(context).stream.listen((loginState) {
      if (loginState is LoginLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (loginState is LoginErrorState) {
        isLoading = false;
        error = loginState.error;
        showSnackbar(
            loginState.error); // Show the Snackbar with the error message
        notifyListeners();
      } else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(
          seconds:
              3), // Set the duration for how long the Snackbar should be visible
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void logIn() async {
    if (!formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    BlocProvider.of<LoginCubit>(context)
        .login(email: email, password: password, rememberMe: rememberMe);
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _loginSubscription?.cancel();
    super.dispose();
  }
}
