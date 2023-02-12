import 'package:flutter/material.dart';

import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';

class ProfileBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  ProfileBloc({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  bool isDark = false;
  // final switchNotifier = ValueNotifier<bool>(false); // solo para que se refresque un widget en especifico (micro notificadores)

  void loadTheme() async {
    isDark = await localRepositoryInterface.isDarkMode() ?? false;
    // switchNotifier.value = isDark;
    notifyListeners();
  }

  void updateTheme(bool isDarkvalue) {
    localRepositoryInterface.saveDarkMode(isDarkvalue);
    isDark = isDarkvalue;
    notifyListeners();
    // switchNotifier.value = isDark;
  }

  Future<void> logOut() async {
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token!);
    await localRepositoryInterface.clearAllData();
  }
}
