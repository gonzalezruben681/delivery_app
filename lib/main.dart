import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/theming_and_state_management/data/datasourse/api_repository_impl.dart';
import 'package:delivery_app/theming_and_state_management/data/datasourse/local_repository_impl.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/main_bloc.dart';
import 'theming_and_state_management/presentation/provider/cart_bloc.dart';
import 'theming_and_state_management/presentation/splash/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //dependency injection
        Provider<ApiRepositoryInterface>(create: (_) => ApiRepositoryImpl()),

        Provider<LocalRepositoryInterface>(
            create: (_) => LocalRepositoryImpl()),

        ChangeNotifierProvider(
          create: (context) {
            return MainBloc(
              localRepositoryInterface:
                  context.read<LocalRepositoryInterface>(),
            )..loadTheme();
          },
        ),
        ChangeNotifierProvider(create: (_) => CartBloc()),
      ],
      child: Builder(builder: (newContext) {
        return Consumer<MainBloc>(builder: (context, bloc, _) {
          return bloc.currentTheme == null
              ? const SizedBox.shrink()
              : MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: bloc.currentTheme,
                  title: 'Material App',
                  home: SplashScreen.init(newContext),
                );
        });
      }),
    );
  }
}
