import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/features/order/domain/entity/order_entity.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../auth/presentation/viewmodel/auth_view_model.dart';
import '../../../order/presentation/viewmodel/order_view_model.dart';
import '../../../splash/presentation/viewmodel/splash_view_model.dart';
import '../viewmodel/product_viewmodel.dart';

class SingleProductView extends ConsumerStatefulWidget {
  const SingleProductView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SingleProductViewState();
}

class _SingleProductViewState extends ConsumerState<SingleProductView> {
  int data = 1;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;

    var productState = ref.read(productViewModelProvider);

    var userState = ref.read(authViewModelProvider);

    var splashState = ref.read(splashViewModelProvider);

    var cartState = ref.read(cartViewModelProvider);

    return Scaffold(
      // appBar: AppBar(

      //   title: const Text('Single Product'),

      // ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height / 2.5,
              width: width,
              decoration: const BoxDecoration(
                color: Color(0xFFD4ECF7),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Container(
                height: 140,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: productState.singleProduct.image != null
                          ? NetworkImage(ApiEndpoints.imageUrl +
                              productState.singleProduct.image!)
                          : const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWPflSnEeFYOxW8Bjxm3POxg9cqJClPksvA6pSoGCK9bW03vcCMC2mAcCzYeSyOlibPdA&usqp=CAU'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Flexible(
              child: Container(
                height: height / 2,
                width: width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productState.singleProduct.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Rs. ${productState.singleProduct.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.redAccent,
                        ),
                      ),
                      RatingBar.builder(
                        unratedColor: const Color.fromARGB(255, 223, 221, 221),
                        itemSize: 28,
                        initialRating: 3.4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        productState.singleProduct.desc,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // lighter shade of grey
                              borderRadius:
                                  BorderRadius.circular(20), // rounded corners
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12), // padding around the row
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      data = data + 1;
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                  color: Colors.blue, // color of the add button
                                ),
                                Text(
                                  data.toString(),
                                  style: const TextStyle(
                                    fontSize: 18, // increase font size
                                    fontWeight:
                                        FontWeight.bold, // make text bold
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      data = data - 1;
                                    });
                                  },
                                  icon: const Icon(CupertinoIcons.minus),
                                  color:
                                      Colors.blue, // color of the minus button
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // TableCalendar(
            //   firstDay: DateTime.utc(2010, 10, 16),
            //   lastDay: DateTime.utc(2030, 3, 14),
            //   focusedDay: DateTime.now(),
            // ),

            // DatePickerWidget(
            //   initialDate: DateTime.now(),
            //   onDateSelected: (selectedDate) {
            //     // Handle the selected date as needed
            //     // print('Selected date: $selectedDate');
            //   },
            // ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  var order = CartEntity(
                    userId: userState.currentUser.id!,
                    productId: productState.singleProduct.productId!,
                    name: productState.singleProduct.name,
                    image: productState.singleProduct.image!,
                    price: productState.singleProduct.price,
                    quantity: data.toString(),
                  );
                  ref.read(cartViewModelProvider.notifier).addCart(order);

                  if (cartState.error != null) {
                    showSnackBar(
                      message: cartState.error.toString(),
                      context: context,
                      color: Colors.red,
                    );
                  } else {
                    showSnackBar(
                      message: 'Your Order Confirmed !',
                      context: context,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'Order Now',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
