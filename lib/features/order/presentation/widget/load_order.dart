import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/config/constants/api_endpoint.dart';
import 'package:gadget_store/features/order/presentation/viewmodel/order_view_model.dart';

import '../../domain/entity/order_entity.dart';

class LoadCart extends StatelessWidget {
  final WidgetRef ref;

  final List<CartEntity> lstCarts;

  const LoadCart({super.key, required this.lstCarts, required this.ref});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: lstCarts.length,
      itemBuilder: ((context, index) => InkWell(
            onDoubleTap: () => {},
            child: ListTile(
              // leading: const Icon(Icons.person),

              leading: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(
                          ApiEndpoints.imageUrl + lstCarts[index].image),
                      fit: BoxFit.fill),
                ),
              ),
              // leading: const Icon(Icons.person),

              title: Text(
                lstCarts[index].name,
              ),

              subtitle: Text(
                ' Rs. ${lstCarts[index].price}',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),

              trailing: Wrap(children: [
                Text(
                  'Qty: ${lstCarts[index].quantity!}',
                  style: const TextStyle(
                    fontSize: 19,
                  ),
                ),
                const SizedBox(width: 20),
                // IconButton(
                //   onPressed: () {
                // ref
                //     .read(cartViewModelProvider.notifier)
                //     .deleteCart(context, lstCarts[index]);
                //   },
                //   icon: const Icon(CupertinoIcons.delete),
                // ),
                TextButton(
                    onPressed: () {
                      ref
                          .read(cartViewModelProvider.notifier)
                          .deleteCart(context, lstCarts[index]);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ))
              ]),
            ),
          )),
    );
  }
}
