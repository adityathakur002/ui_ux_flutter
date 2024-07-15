import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/use_case/order_use_case.dart';
import '../state/order_state.dart';

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>(
  (ref) => CartViewModel(
    ref.read(cartUseCaseProvider),
  ),
);

class CartViewModel extends StateNotifier<CartState> {
  final CartUseCase cartUseCase;

  CartViewModel(this.cartUseCase) : super(CartState.initial()) {
    getAllCarts();
  }

  Future<void> addCart(CartEntity cart) async {
    state.copyWith(isLoading: true);

    var data = await cartUseCase.addCart(cart);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> getAllCarts() async {
    state = state.copyWith(isLoading: true);

    var data = await cartUseCase.getAllCarts();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, allcarts: r),
    );
  }

  Future<void> getCart(BuildContext context, String user) async {
    state = state.copyWith(isLoading: true);

    var data = await cartUseCase.getCart(user);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, carts: r),
    );
  }

  Future<void> deleteCart(BuildContext context, CartEntity cart) async {
    state.copyWith(isLoading: true);

    var data = await cartUseCase.deleteCart(cart.orderId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.carts.remove(cart);

        state = state.copyWith(isLoading: false, error: null);

        // showSnackBar(

        //   message: 'Product deleted successfully',

        //   context: context,

        // );
      },
    );
  }
}
