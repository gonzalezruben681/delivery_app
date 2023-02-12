import 'package:flutter/material.dart';

import 'package:delivery_app/theming_and_state_management/domain/model/user.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';

class HomeBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  HomeBloc({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  User? user;
  int indexSelected = 0;

//cargando el usuario
  void loadUser() async {
    user = await localRepositoryInterface.getUser();
    notifyListeners();
  }

// cada vez que cambie el index va a refrescar
  void updateIndexSelected(int index) {
    indexSelected = index;
    notifyListeners();
  }

  //  Future<void> logOut() async {
  //   final token = await localRepositoryInterface.getToken();
  //   await apiRepositoryInterface.logout(token!);
  //   await localRepositoryInterface.clearAllData();
  // }
}
