import 'package:delivery_app/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/request/login_request.dart';
import 'package:flutter/material.dart';

enum LoginState {
  loading,
  initial,
}

class LoginBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;

  final ApiRepositoryInterface apiRepositoryInterface;

  LoginBloc({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var loginState = LoginState.initial;

  Future<bool> login() async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;

    try {
      loginState = LoginState.loading;
      notifyListeners();
      final loginRequest =
          await apiRepositoryInterface.login(LoginRequest(username, password));

      await localRepositoryInterface.saveToken(loginRequest.token);
      await localRepositoryInterface.saveUser(loginRequest.user);

      loginState = LoginState.initial;
      notifyListeners();

      return true;
    } on AuthException catch (_) {
      loginState = LoginState.initial;
      notifyListeners();
      return false;
    }
  }
}
