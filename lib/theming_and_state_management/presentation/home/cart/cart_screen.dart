import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/theming_and_state_management/domain/model/product_card.dart';
import 'package:delivery_app/theming_and_state_management/presentation/theme.dart';
import 'package:delivery_app/theming_and_state_management/presentation/widgets/delivery_button.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key, required this.onShopping}) : super(key: key);

  final VoidCallback onShopping;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: bloc.totalItems == 0
          ? _EmptyCart(onShopping: onShopping)
          : _FullCart(),
    );
  }
}

class _FullCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBloc>();
    final total = bloc.totalPrice.toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemExtent: 230,
                itemCount: bloc.cartList.length,
                itemBuilder: (BuildContext context, int index) {
                  final productCart = bloc.cartList[index];
                  return _ShoppingCardProduct(
                      productCart: productCart,
                      onDelete: () {
                        bloc.deleteProduct(productCart);
                      },
                      onIncrement: () {
                        bloc.increment(productCart);
                      },
                      onDecrement: () {
                        bloc.decrement(productCart);
                      });
                },
              ),
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).canvasColor,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sub total',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                            Text('0.0 usd',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                            Text(
                              'Free',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                            Text(
                              '\$$total USD',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                          ],
                        ),
                        Spacer(),
                        DeliveryButton(
                          onTap: () {},
                          text: 'Checkout',
                        )
                      ]),
                ),
              ),
            )),
      ],
    );
  }
}

class _ShoppingCardProduct extends StatelessWidget {
  const _ShoppingCardProduct(
      {Key? key,
      this.productCart,
      required this.onDelete,
      required this.onIncrement,
      required this.onDecrement})
      : super(key: key);

  final ProductCart? productCart;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final product = productCart!.product;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Card(
            elevation: 8,
            color: Theme.of(context).canvasColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: ClipOval(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(product.name),
                          const SizedBox(height: 10),
                          Text(
                            product.description,
                            style: Theme.of(context)
                                .textTheme
                                .overline
                                ?.copyWith(color: DeliveryColors.lightGrey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: onDecrement,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: DeliveryColors.white,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: DeliveryColors.purple,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(productCart!.quantity.toString()),
                                ),
                                InkWell(
                                  onTap: onIncrement,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: DeliveryColors.purple,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: DeliveryColors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text('\$ ${product.price}',
                                    style: TextStyle(
                                      color: DeliveryColors.green,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              onTap: onDelete,
              child: CircleAvatar(
                backgroundColor: DeliveryColors.pink,
                child: Icon(Icons.delete_outlined),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({Key? key, required this.onShopping}) : super(key: key);

  final VoidCallback onShopping;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/cara-triste.png',
          height: 90,
          color: DeliveryColors.purple,
        ),
        const SizedBox(height: 20),
        Text(
          'Therew are no products',
          style: TextStyle(color: Theme.of(context).colorScheme.background),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(DeliveryColors.purple),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
            onPressed: onShopping,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Go shopping',
                style: TextStyle(color: DeliveryColors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
