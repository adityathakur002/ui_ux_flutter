import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/features/product/domain/entity/product_entity.dart';
import 'package:gadget_store/features/product/presentation/viewmodel/product_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(productViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final _gap = const SizedBox(height: 10);
  List<String> batches = ["Men", "Women", "Children"];
  String? _dropDownValue;

  final nameController = TextEditingController(text: 'Nykie');
  final priceController = TextEditingController(text: '400');
  final descController =
      TextEditingController(text: 'Its good and awesome product');
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height * 0.90,
          alignment: Alignment.center,
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.grey[300],
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _browseImage(ref, ImageSource.camera);
                                Navigator.pop(context);
                                // Upload image it is not null
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text('Camera'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _browseImage(ref, ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.image),
                              label: const Text('Gallery'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _img != null
                          ? FileImage(_img!)
                          : const AssetImage('assets/images/add_icon.jpg')
                              as ImageProvider,
                    ),
                  ),
                ),
                _gap,
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber, width: 2.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter ProductName';
                    }
                    return null;
                  },
                ),
                _gap,
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amber, width: 2.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter ProductPrice';
                    }
                    return null;
                  },
                ),
                _gap,
                DropdownButtonFormField(
                  items: batches
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _dropDownValue = value;
                  },
                  value: _dropDownValue,
                  decoration: const InputDecoration(
                    labelText: 'Select Category',
                  ),
                  validator: ((value) {
                    if (value == null) {
                      return 'Please select Category';
                    }
                    return null;
                  }),
                ),
                _gap,
                TextFormField(
                  controller: descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                  ),
                ),
                _gap,
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      var product = ProductEntity(
                        image: productState.imageName,
                        name: nameController.text,
                        price: priceController.text,
                        desc: descController.text,
                        category: _dropDownValue!,
                      );

                      ref
                          .read(productViewModelProvider.notifier)
                          .addProduct(product);

                      if (productState.error != null) {
                        showSnackBar(
                          message: productState.error.toString(),
                          context: context,
                          color: Colors.red,
                        );
                      } else {
                        showSnackBar(
                          message: 'Product Added',
                          context: context,
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}



// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gadget_store/features/product/domain/entity/product_entity.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../../../core/common/snackbar/my_snackbar.dart';
// import '../viewmodel/product_viewmodel.dart';

// class AddProduct extends ConsumerStatefulWidget {
//   const AddProduct({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _AddProductState();
// }

// class _AddProductState extends ConsumerState<AddProduct> {
//   final _key = GlobalKey<FormState>();
//   checkCameraPermission() async {
//     if (await Permission.camera.request().isRestricted ||
//         await Permission.camera.request().isDenied) {
//       await Permission.camera.request();
//     }
//   }

//   File? _img;
//   Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _img = File(image.path);
//           ref.watch(productViewModelProvider.notifier).uploadImage(_img!);
//         });
//       } else {
//         return;
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   final _gap = const SizedBox(height: 8);
//   final _nameController = TextEditingController(text: 'product1');
//   final _priceController = TextEditingController(text: '300');
//   final _categoryController = TextEditingController(text: 'Men');
//   final _descController = TextEditingController(
//       text:
//           'The Classic Cotton T-shirt offers timeless style and unbeatable comfort. Made from 100% premium cotton, this versatile wardrobe staple features a regular fit and a crew neckline.');
//   @override
//   Widget build(BuildContext context) {
//     var productState = ref.read(productViewModelProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('New Product'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: Form(
//               key: _key,
//               child: Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.grey[300],
//                         context: context,
//                         isScrollControlled: true,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(20),
//                           ),
//                         ),
//                         builder: (context) => Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   _browseImage(ref, ImageSource.camera);
//                                   Navigator.pop(context);
//                                   // Upload image it is not null
//                                 },
//                                 icon: const Icon(Icons.camera),
//                                 label: const Text('Camera'),
//                               ),
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   _browseImage(ref, ImageSource.gallery);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(Icons.image),
//                                 label: const Text('Gallery'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: SizedBox(
//                       height: 200,
//                       width: 200,
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: _img != null
//                             ? FileImage(_img!)
//                             : const AssetImage('assets/images/profile.png')
//                                 as ImageProvider,
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Product Name',
//                     ),
//                     validator: ((value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter first name';
//                       }
//                       return null;
//                     }),
//                   ),
//                   _gap,
//                   TextFormField(
//                     controller: _priceController,
//                     decoration: const InputDecoration(
//                       labelText: 'Price',
//                     ),
//                     validator: ((value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter last name';
//                       }
//                       return null;
//                     }),
//                   ),
//                   _gap,
//                   TextFormField(
//                     controller: _categoryController,
//                     decoration: const InputDecoration(
//                       labelText: 'Category',
//                     ),
//                     validator: ((value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter last name';
//                       }
//                       return null;
//                     }),
//                   ),
//                   // Text('P'),
//                   _gap,
//                   TextFormField(
//                     controller: _descController,
//                     decoration: const InputDecoration(
//                       labelText: 'Description',
//                     ),
//                     maxLines: 3,
//                     validator: ((value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter last name';
//                       }
//                       return null;
//                     }),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   SizedBox(
//                     // width: double.infinity,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                             const Color.fromARGB(255, 243, 156,
//                                 33)), // Set the background color to blue
//                       ),
//                       onPressed: () {
//                         if (_key.currentState!.validate()) {
//                           var product = ProductEntity(
//                             image: productState.imageName,
//                             name: _nameController.text,
//                             price: _priceController.text,
//                             desc: _descController.text,
//                             category: _categoryController.text,
//                           );

//                           ref
//                               .read(productViewModelProvider.notifier)
//                               .addProduct(product);

//                           if (productState.error != null) {
//                             showSnackBar(
//                               message: productState.error.toString(),
//                               context: context,
//                               color: Colors.red,
//                             );
//                           } else {
//                             showSnackBar(
//                               message: 'added successfully',
//                               context: context,
//                             );
//                           }
//                         }
//                       },
//                       child: const Text(
//                         'Add Product',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
