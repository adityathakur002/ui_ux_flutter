import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/config/routes/app_route.dart';
import 'package:gadget_store/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:gadget_store/features/product/presentation/viewmodel/product_viewmodel.dart';
import 'package:gadget_store/features/product/presentation/widget/load_product.dart';

class AboutUs extends ConsumerStatefulWidget {
  const AboutUs({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutUsState();
}

class _AboutUsState extends ConsumerState<AboutUs> {
  @override
  Widget build(BuildContext context) {
    var productState = ref.watch(productViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.addProductRoute);
                  },
                  child: const Text('Add Product')),
              ElevatedButton(
                  onPressed: () {
                    ref.watch(cartViewModelProvider.notifier).getAllCarts();
                    Navigator.pushNamed(context, AppRoute.orderViewRoute);
                  },
                  child: const Text('See Order')),
            ],
          ),
          Flexible(
              child: LoadProduct(lstProducts: productState.products, ref: ref))
        ],
      ),
    );
  }
}
