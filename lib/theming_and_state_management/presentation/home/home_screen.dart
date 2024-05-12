import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/cart_bloc.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/local_storage_repository.dart';
import 'package:delivery_app/theming_and_state_management/presentation/home/cart/cart_screen.dart';
import 'package:delivery_app/theming_and_state_management/presentation/home/products/products_screen.dart';
import 'package:delivery_app/theming_and_state_management/presentation/home/profile/profile_screen.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/home_bloc.dart';
import 'package:delivery_app/theming_and_state_management/presentation/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._();

  static Widget init(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeBloc(
            apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
            localRepositoryInterface: context.read<LocalRepositoryInterface>(),
          )..loadUser(),
          builder: (_, __) => const HomeScreen._(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);

    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: IndexedStack(index: bloc.indexSelected, children: [
            ProductsScreen.init(context),
            const Placeholder(),
            const CartScreen(),
            const Placeholder(),
            ProfileScreen.init(context),
          ]),
        ),
        _DeliveryNavigationBar(
          index: bloc.indexSelected,
        ),
      ]),
    );
  }
}

class _DeliveryNavigationBar extends StatelessWidget {
  final int? index;

  const _DeliveryNavigationBar({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);
    final cartBloc = Provider.of<CartBloc>(context);
    final user = bloc.user;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).canvasColor,
            border: Border.all(
              color: Theme.of(context).bottomAppBarTheme.color!,
              width: 2,
            )),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Material(
                  child: IconButton(
                    onPressed: () => bloc.updateIndexSelected(0),
                    icon: const Icon(Icons.home),
                    color: index == 0
                        ? DeliveryColors.green
                        : DeliveryColors.lightGrey,
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  child: IconButton(
                    onPressed: () => bloc.updateIndexSelected(1),
                    icon: const Icon(Icons.store),
                    color: index == 1
                        ? DeliveryColors.green
                        : DeliveryColors.lightGrey,
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  child: Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: DeliveryColors.purple,
                          radius: 23,
                          child: IconButton(
                              color: index == 2
                                  ? DeliveryColors.green
                                  : DeliveryColors.white,
                              onPressed: () => bloc.updateIndexSelected(2),
                              icon: const Icon(Icons.shopping_basket)),
                        ),
                        cartBloc.totalItems == 0
                            ? const SizedBox.shrink()
                            : Positioned(
                                right: 0,
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.pinkAccent,
                                    child: Text(cartBloc.totalItems.toString()),
                                  ),
                                ))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  child: IconButton(
                      color: index == 3
                          ? DeliveryColors.green
                          : DeliveryColors.lightGrey,
                      onPressed: () => bloc.updateIndexSelected(3),
                      icon: const Icon(Icons.favorite_border)),
                ),
              ),
              InkWell(
                  onTap: () => bloc.updateIndexSelected(4),
                  child: user?.image == null
                      ? const SizedBox.shrink()
                      : CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage(user!.image!),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
