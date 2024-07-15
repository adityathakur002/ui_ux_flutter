import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/order_view_model.dart';
import '../widget/load_order.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  @override
  Widget build(BuildContext context) {
    var cartState = ref.watch(cartViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('View Order')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              ' Orders',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Text(cartState.carts.length.toString()),
          Flexible(
            child: LoadCart(ref: ref, lstCarts: cartState.allcarts),
          ),
          // if (cartState.carts.isNotEmpty) ...{
          //   Flexible(
          //     child: LoadCart(ref: ref, lstCarts: cartState.carts),
          //   ),
          // } else ...{
          //   const Text(
          //     "Order Empty",
          //     style: TextStyle(color: Colors.red, fontSize: 20),
          //   )
          // }
        ]),
      ),
    );
  }
}
