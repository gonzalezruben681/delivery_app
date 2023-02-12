import 'package:delivery_app/theming_and_state_management/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';

class MainBloc extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;

  ThemeData? currentTheme;

  MainBloc({
    required this.localRepositoryInterface,
  });

  void loadTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode() ?? false;
    updateTheme(isDark ? darkTheme : lightTheme);
  }

  void updateTheme(ThemeData theme) {
    currentTheme = theme;
    notifyListeners();
  }
}
