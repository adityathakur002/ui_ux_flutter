import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/use_case/product_use_case.dart';
import '../state/product_state.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>(
  (ref) => ProductViewModel(
    ref.read(productUseCaseProvider),
  ),
);

class ProductViewModel extends StateNotifier<ProductState> {
  final ProductUseCase productUseCase;

  ProductViewModel(this.productUseCase) : super(ProductState.initial()) {
    getAllProducts();
  }

  Future<void> addProduct(ProductEntity product) async {
    state.copyWith(isLoading: true);

    var data = await productUseCase.addProduct(product);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> getAllProducts() async {
    state = state.copyWith(isLoading: true);

    var data = await productUseCase.getAllProducts();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, products: r),
    );
  }

  Future<void> uploadImage(File file) async {
    state = state.copyWith(isLoading: true);
    var data = await productUseCase.uploadProfilePicture(file);
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
    }, (imageName) {
      state = state.copyWith(isLoading: false, imageName: imageName);
    });
  }

  Future<void> getProductById(BuildContext context, String productId) async {
    state = state.copyWith(isLoading: true);

    var data = await productUseCase.getProductById(productId);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, singleProduct: r, error: null);

        Navigator.pushNamed(context, AppRoute.singleProductRoute);
      },
    );
  }

  Future<void> editProduct(
      BuildContext context, String productId, ProductEntity product) async {
    state = state.copyWith(isLoading: true);

    var data = await productUseCase.editProduct(productId, product);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );

        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);

        showSnackBar(
          message: 'Product Updated successfully',
          context: context,
        );
      },
    );
  }

  Future<void> deleteProduct(
      BuildContext context, ProductEntity product) async {
    state.copyWith(isLoading: true);

    var data = await productUseCase.deleteProduct(product.productId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.products.remove(product);

        state = state.copyWith(isLoading: false, error: null);

        // showSnackBar(

        //   message: 'Product deleted successfully',

        //   context: context,

        // );
      },
    );
  }
}
