import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/config/constants/api_endpoint.dart';
import 'package:gadget_store/features/product/presentation/viewmodel/product_viewmodel.dart';

import '../../domain/entity/product_entity.dart';

class LoadProduct extends StatelessWidget {
  final WidgetRef ref;

  final List<ProductEntity> lstProducts;

  const LoadProduct({super.key, required this.lstProducts, required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lstProducts.length,
      // itemBuilder: ((context, index) => const Text('ldjflj'))
      // Card(
      //       elevation: 5, // Card elevation
      //       margin: const EdgeInsets.all(16), // Card margin
      //       child: Padding(
      //         padding: const EdgeInsets.all(16),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               lstProducts[index].name,
      //               style: const TextStyle(
      //                   fontSize: 18, fontWeight: FontWeight.bold),
      //             ),
      //             const SizedBox(height: 8),
      //             const Text(
      //               'Experience: 4 years',
      //               style: TextStyle(fontSize: 16),
      //             ),
      //             const SizedBox(height: 8),
      //             const Text(
      //               'Category: all',
      //               style: TextStyle(fontSize: 16),
      //             ),
      //           ],
      //         ),
      //       ),
      //     )),
//         );
//   }
// }
      itemBuilder: ((context, index) => ListTile(
            // leading: CircleAvatar(

            //   radius: 60,

            //   backgroundImage: NetworkImage(

            //     ApiEndpoints.imageUrl + lstProducts[index].productImage!,

            //   ),

            //   backgroundColor: Colors.transparent,

            // ),

            leading: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                image: DecorationImage(
                    image: lstProducts[index].image != null
                        ? NetworkImage(
                            ApiEndpoints.imageUrl + lstProducts[index].image!)
                        : const NetworkImage(
                            'data:image/jpeg;base64,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'),
                    fit: BoxFit.fill),
              ),
            ),
            title: Text(lstProducts[index].name),
            subtitle: Text(lstProducts[index].price.toString()),
            trailing: Wrap(
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                            'Are you sure you want to delete ${lstProducts[index].name}?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                ref
                                    .read(productViewModelProvider.notifier)
                                    .deleteProduct(context, lstProducts[index]);
                                Navigator.pop(context);
                              },
                              child: const Text('Yes')),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    // ref

                    //     .read(productViewModelProvider.notifier)

                    //     .getProductToEdit(context, lstProducts[index].productId!);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         EditProductView(product: lstProducts[index]),
                    //   ),
                    // );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          )),
    );
  }
}
