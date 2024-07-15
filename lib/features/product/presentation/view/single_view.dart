import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleProduct extends ConsumerStatefulWidget {
  const SingleProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SingleProductState();
}

class _SingleProductState extends ConsumerState<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Single Product'),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height / 1.9,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 224, 224, 224),
              image: DecorationImage(
                image: AssetImage('assets/images/image1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ImageName',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rs.4000',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.withOpacity(0.7)),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          const Text(
            'Best for women',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //Ratings
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
            height: 20,
          ),
          const Text(
              'Clothes are items worn on the body for protection, modesty, comfort, or style. They are an essential part of human life and have evolved over time to reflect cultural, social'),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 22,
                    color: Color.fromARGB(255, 218, 103, 9),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: 250,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 218, 103, 9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
