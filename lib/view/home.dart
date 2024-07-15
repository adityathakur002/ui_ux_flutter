import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/features/home/presentation/widgets/product_widgets.dart';
import 'package:gadget_store/features/product/presentation/viewmodel/product_viewmodel.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    var productState = ref.watch(productViewModelProvider);
    List<String> tabs = ["All", "Category", "Top", "Recommended"];
    List imageList = [
      'assets/images/image1.jpg',
      'assets/images/image2.jpg',
      'assets/images/image3.jpeg',
      'assets/images/image4.jpg',
    ];
    List productTitles = [
      "Warm Zipper",
      "Knitted Wool",
      "Zipper Win",
      "Child Win",
    ];
    List prices = [
      "Rs300",
      "Rs500",
      "Rs800",
      "Rs100",
    ];
    List reviews = [
      "34",
      "567",
      "34",
      "56",
    ];

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: 50,
                      width: width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black12.withOpacity(0.05),
                        //     blurRadius: 2,
                        //     spreadRadius: 1,
                        //   ),
                        // ],
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFFEF6969),
                          ),
                          border: InputBorder.none,
                          label: Text('Find Your Product'),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: width / 6,
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black12.withOpacity(0.05),
                        //     blurRadius: 2,
                        //     spreadRadius: 1,
                        //   ),
                        // ],
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Color(0xFFEF6969),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 150,
                  width: width,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0DD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('assets/images/main.png'),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: ((context, index) {
                      return FittedBox(
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: FittedBox(
                            child: Text(
                              tabs[index],
                              style: const TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: imageList.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          imageList[index],
                                          fit: BoxFit.cover,
                                          width: 150,
                                          height: 150,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: Color(0xFFEF6969),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                productTitles[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 22,
                                  ),
                                  Text(
                                    '(${reviews[index]})',
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    prices[index],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Newest Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CourseWidget(courseList: productState.products, ref: ref)
                // GridView.builder(
                //   itemCount: productTitles.length,
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     childAspectRatio: 0.73,
                //     crossAxisSpacing: 2,
                //   ),
                //   itemBuilder: (context, index) {
                //     return Container(
                //       margin: const EdgeInsets.only(right: 15),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           SizedBox(
                //             height: 150,
                //             width: 150,
                //             child: Stack(
                //               children: [
                //                 InkWell(
                //                   onTap: () {},
                //                   child: ClipRRect(
                //                     borderRadius: BorderRadius.circular(10),
                //                     child: Image.asset(
                //                       imageList[index],
                //                       fit: BoxFit.cover,
                //                       width: 150,
                //                       height: 150,
                //                     ),
                //                   ),
                //                 ),
                //                 Positioned(
                //                   right: 10,
                //                   top: 10,
                //                   child: Container(
                //                     height: 30,
                //                     width: 30,
                //                     decoration: BoxDecoration(
                //                       color: Colors.white,
                //                       borderRadius: BorderRadius.circular(20),
                //                     ),
                //                     child: const Center(
                //                       child: Icon(
                //                         Icons.favorite,
                //                         color: Color(0xFFEF6969),
                //                       ),
                //                     ),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           const SizedBox(height: 10),
                //           Text(
                //             productTitles[index],
                //             style: const TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           const SizedBox(height: 10),
                //           Row(
                //             children: [
                //               const Icon(
                //                 Icons.star,
                //                 color: Colors.amber,
                //                 size: 22,
                //               ),
                //               Text(
                //                 '(${reviews[index]})',
                //               ),
                //               const SizedBox(width: 10),
                //               Text(
                //                 prices[index],
                //                 style: const TextStyle(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
