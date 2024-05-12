import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';
import 'package:delivery_app/theming_and_state_management/presentation/home/home_screen.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/login_bloc.dart';
import 'package:delivery_app/theming_and_state_management/presentation/theme.dart';
import 'package:delivery_app/theming_and_state_management/presentation/widgets/delivery_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const logoSize = 45.0;

class LoginScreen extends StatelessWidget {
  LoginScreen._();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginBloc(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
        localRepositoryInterface: context.read<LocalRepositoryInterface>(),
      ),
      builder: (_, __) => LoginScreen._(),
    );
  }

  void login(BuildContext context) async {
    final bloc = context.read<LoginBloc>();
    final result = await bloc.login();
    if (result) {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => HomeScreen.init(context),
        ));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login incorrect'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    const moreSize = 50.0;
    final bloc = context.watch<LoginBloc>();
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Positioned(
                          bottom: logoSize,
                          left: -moreSize / 2,
                          right: -moreSize / 2,
                          height: width + moreSize,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.5, 1.0],
                                  colors: deliveryGradients,
                                ),
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(size.width / 2))),
                          )),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).canvasColor,
                            radius: logoSize,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/images/logo.png',
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ))
                    ],
                  )),
              Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          Text(
                            'Username',
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle
                                          ?.color,
                                    ),
                          ),
                          TextField(
                            controller: bloc.usernameTextController,
                            decoration: InputDecoration(
                              hintText: 'username',
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Password',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle
                                          ?.color,
                                    ),
                          ),
                          TextField(
                              controller: bloc.passwordTextController,
                              decoration: InputDecoration(
                                hintText: 'password',
                                prefixIcon: Icon(
                                  Icons.lock_open_outlined,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(25),
                child: DeliveryButton(
                  onTap: () => login(context),
                  text: 'Login',
                ),
              ),
            ],
          ),
          Positioned.fill(
              child: (bloc.loginState == LoginState.loading)
                  ? Container(
                      color: Colors.black26,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox.shrink())
        ],
      ),
    );
  }
}
