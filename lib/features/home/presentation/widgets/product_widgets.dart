import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/config/constants/api_endpoint.dart';
import 'package:gadget_store/features/product/domain/entity/product_entity.dart';
import 'package:gadget_store/features/product/presentation/viewmodel/product_viewmodel.dart';

class CourseWidget extends StatelessWidget {
  final WidgetRef ref;
  final List<ProductEntity> courseList;
  const CourseWidget({super.key, required this.courseList, required this.ref});

  @override
  Widget build(BuildContext context) {
    List reviews = [
      "34",
      "567",
      "34",
      "56",
      "34",
      "46",
      "45",
      "567",
      "38",
      "89"
    ];
    return GridView.builder(
      itemCount: courseList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.73,
        crossAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        ref
                            .read(productViewModelProvider.notifier)
                            .getProductById(
                                context, courseList[index].productId!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: courseList[index].image != null
                                ? NetworkImage(ApiEndpoints.imageUrl +
                                    courseList[index].image!)
                                : const NetworkImage(
                                    'https://www.alamodelabel.in/cdn/shop/files/6C16E25D-CA48-4EB5-AF54-338C5FF2859C_600x.jpg?v=1700554266'),
                            fit: BoxFit.contain,
                          ),
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
                          borderRadius: BorderRadius.circular(20),
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
                courseList[index].name,
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
                    courseList[index].price,
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
      },
    );
  }
}
