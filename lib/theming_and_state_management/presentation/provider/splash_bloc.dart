import 'package:flutter/material.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';

class SplashBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;

  final ApiRepositoryInterface apiRepositoryInterface;

  SplashBloc({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  Future<bool> validateSession() async {
    final token = await localRepositoryInterface.getToken();
    if (token != null) {
      final user = await apiRepositoryInterface.getUserFromToken(token);
      await localRepositoryInterface.saveUser(user);
      return true;
    } else {
      return false;
    }
  }
}
