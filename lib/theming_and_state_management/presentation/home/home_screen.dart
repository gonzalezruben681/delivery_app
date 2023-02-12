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
          builder: (_, __) => HomeScreen._(),
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
            CartScreen(onShopping: () {
              bloc.updateIndexSelected(0);
            }),
            const Placeholder(),
            ProfileScreen.init(context),
          ]),
        ),
        _DeliveryNavigationBar(
            index: bloc.indexSelected,
            onIndexSelected: (index) {
              bloc.updateIndexSelected(index);
            }),
      ]),
    );
  }
}

class _DeliveryNavigationBar extends StatelessWidget {
  final int? index;
  final ValueChanged<int> onIndexSelected;

  const _DeliveryNavigationBar({
    Key? key,
    this.index,
    required this.onIndexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);
    final cartBloc = Provider.of<CartBloc>(context);
    final user = bloc.user;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).canvasColor,
            border: Border.all(
              color: Theme.of(context).bottomAppBarColor,
              width: 2,
            )),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                child: IconButton(
                  onPressed: () => onIndexSelected(0),
                  icon: Icon(Icons.home),
                  color: index == 0
                      ? DeliveryColors.green
                      : DeliveryColors.lightGrey,
                ),
              ),
              Material(
                child: IconButton(
                  onPressed: () => onIndexSelected(1),
                  icon: Icon(Icons.store),
                  color: index == 1
                      ? DeliveryColors.green
                      : DeliveryColors.lightGrey,
                ),
              ),
              Material(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: DeliveryColors.purple,
                      radius: 23,
                      child: IconButton(
                          color: index == 2
                              ? DeliveryColors.green
                              : DeliveryColors.white,
                          onPressed: () => onIndexSelected(2),
                          icon: Icon(Icons.shopping_basket)),
                    ),
                    cartBloc.totalItems == 0
                        ? const SizedBox.shrink()
                        : Positioned(
                            right: 0,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.pinkAccent,
                              child: Text(cartBloc.totalItems.toString()),
                            ))
                  ],
                ),
              ),
              Material(
                child: IconButton(
                    color: index == 3
                        ? DeliveryColors.green
                        : DeliveryColors.lightGrey,
                    onPressed: () => onIndexSelected(3),
                    icon: Icon(Icons.favorite_border)),
              ),
              InkWell(
                  onTap: () => onIndexSelected(4),
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
