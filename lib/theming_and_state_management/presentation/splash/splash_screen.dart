import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';
import 'package:delivery_app/theming_and_state_management/presentation/home/home_screen.dart';
import 'package:delivery_app/theming_and_state_management/presentation/login/login_screen.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/splash_bloc.dart';
import 'package:delivery_app/theming_and_state_management/presentation/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen._();

// CON ESTE MÉTODO ESTATICO PARA PODER INSTANCIAR LA CLASE
  static Widget init(BuildContext context) {
    //inyección de provider
    return ChangeNotifierProvider(
      create: (_) => SplashBloc(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
        localRepositoryInterface: context.read<LocalRepositoryInterface>(),
      ),
      builder: (_, __) => SplashScreen._(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _init() async {
    final bloc = context.read<SplashBloc>();
    final result = await bloc.validateSession();
    if (result) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => HomeScreen.init(context),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => LoginScreen.init(context),
      ));
    }
  }

  @override
  void initState() {
// RENDERIZAR EL WIDGET
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: deliveryGradients),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 45,
                backgroundColor: DeliveryColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset('assets/images/logo.png'),
                )),
            const SizedBox(height: 10),
            Text(
              'DeliveryApp',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold, color: DeliveryColors.white),
            )
          ],
        ),
      ),
    );
  }
}
