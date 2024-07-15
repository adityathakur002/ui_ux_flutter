import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/features/auth/presentation/state/auth_state.dart';

import '../../../../config/routes/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/student_entity.dart';
import '../../domain/use_case/auth_usecase.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.read(authUseCaseProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase)
      : super(
          AuthState(
            isLoading: false,
            currentUser: StudentEntity(
                fname: 'fname',
                lname: 'lname',
                phone: 'phone',
                username: 'username',
                password: 'password'),
          ),
        );

  Future<void> registerStudent(StudentEntity student) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerStudent(student);
    data.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loginStudent(
      BuildContext context, String username, String password) async {
    state = state.copyWith(isLoading: true);
    // bool isLogin = false;
    var data = await _authUseCase.loginStudent(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        Navigator.pushNamed(context, AppRoute.homeRoute);
        getUser(context, username);
      },
    );
  }

  Future<void> uploadImage(File file) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.uploadProfilePicture(file);
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
    }, (imageName) {
      state = state.copyWith(isLoading: false, imageName: imageName);
    });
  }

  Future<void> getUser(BuildContext context, String username) async {
    state = state.copyWith(isLoading: true);

    var data = await _authUseCase.getUser(username);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);

        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state =
            state.copyWith(isLoading: false, currentUser: success, error: null);
      },
    );
  }
}
