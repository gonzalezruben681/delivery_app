import 'package:delivery_app/theming_and_state_management/domain/model/product.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/cart_bloc.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/products_bloc.dart';
import 'package:delivery_app/theming_and_state_management/presentation/theme.dart';
import 'package:delivery_app/theming_and_state_management/presentation/widgets/delivery_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsBloc(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
      )..loadProduct(),
      builder: (_, __) => const ProductsScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsBloc = context.watch<ProductsBloc>();
    final cartBloc = context.watch<CartBloc>();

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Products',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: const[]),
      body: productsBloc.productList.isNotEmpty
          ? GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: productsBloc.productList.length,
              itemBuilder: (context, index) {
                final product = productsBloc.productList[index];
                return _ItemProduct(
                  product: product,
                  onTap: () {
                    cartBloc.add(product);
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  const _ItemProduct({Key? key, this.product, required this.onTap})
      : super(key: key);

  final Product? product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    product!.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(product!.name),
                const SizedBox(height: 10),
                Text(
                  product!.description,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: DeliveryColors.lightGrey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text('\$ ${product!.price} USD',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                    )),
              ],
            ),
          ),
          DeliveryButton(
            onTap: onTap,
            text: 'Add',
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
          )
        ]),
      ),
    );
  }
}
