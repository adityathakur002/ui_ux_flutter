import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:gadget_store/features/order/presentation/widget/load_order.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  Widget build(BuildContext context) {
    var cartState = ref.watch(cartViewModelProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'My Orders',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Text(cartState.carts.length.toString()),
          Flexible(
            child: LoadCart(ref: ref, lstCarts: cartState.carts),
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
