import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/main_bloc.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/home_bloc.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/profile_bloc.dart';
import 'package:delivery_app/theming_and_state_management/presentation/splash/splash_screen.dart';
import 'package:delivery_app/theming_and_state_management/presentation/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileBloc(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
        localRepositoryInterface: context.read<LocalRepositoryInterface>(),
      )..loadTheme(),
      builder: (_, __) => ProfileScreen._(),
    );
  }

  Future<void> logout(BuildContext context) async {
    final profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    await profileBloc.logOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => SplashScreen.init(context)),
        (route) => false);
  }

  void onThemeUpdated(BuildContext context, bool isDark) {
    final profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    profileBloc.updateTheme(isDark);
    final mainBloc = context.read<MainBloc>();
    mainBloc.loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);

    final profileBloc = Provider.of<ProfileBloc>(context);

    final user = homeBloc.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: user?.image != null
          ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(
                  child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: DeliveryColors.green),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(user?.image ?? ''),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user?.name ?? 'Username',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.background),
                  )
                ],
              )),
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Card(
                          color: Theme.of(context).canvasColor,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Personal Information',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                                  const SizedBox(height: 25),
                                  Text(
                                    user?.username ?? '',
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Dark Mode',
                                      ),
                                      Spacer(),
                                      Switch(
                                        value: profileBloc.isDark,
                                        onChanged: (val) =>
                                            onThemeUpdated(context, val),
                                        activeColor: DeliveryColors.purple,
                                      ),
                                      // ValueListenableBuilder<bool>(
                                      //     valueListenable:
                                      //         profileBloc.switchNotifier,
                                      //     builder: (_, value, __) {
                                      //       return Switch(
                                      //         value: value,
                                      //         onChanged: (val) =>
                                      //             onThemeUpdated(context, val),
                                      //         activeColor:
                                      //             DeliveryColors.purple,
                                      //       );
                                      //     }),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  DeliveryColors.purple),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: () => logout(context),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Log Out',
                              style: TextStyle(color: DeliveryColors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ])
          : const SizedBox.shrink(),
    );
  }
}
