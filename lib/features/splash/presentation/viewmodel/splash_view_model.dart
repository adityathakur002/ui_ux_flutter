import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gadget_store/features/splash/presentation/state/splash_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../config/routes/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../auth/domain/use_case/auth_usecase.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, SplashState>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
      ref.read(authUseCaseProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<SplashState> {
  final UserSharedPrefs _userSharedPrefs;
  final AuthUseCase _authUseCase;
  SplashViewModel(this._userSharedPrefs, this._authUseCase)
      : super(SplashState.initial());

  init(BuildContext context) async {
    final data = await _userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) {
      if (token != null) {
        bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
// We will not do navigation like this,
// we will use mixin and navigator class for this
          Navigator.pushNamed(context, AppRoute.loginRoute);
        } else {
          Navigator.popAndPushNamed(context, AppRoute.homeRoute);
          // getUserInfo(context, token);
        }
      } else {
        Navigator.pushNamed(context, AppRoute.loginRoute);
      }
    });
  }

  bool isValidToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

// 10 digit
    int expirationTimestamp = decodedToken['exp'];
// 13
    final currentDate = DateTime.now().millisecondsSinceEpoch;
// If current date is greater than expiration timestamp then token is expired
    return currentDate > expirationTimestamp * 1000;
  }

  String isUser(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    String user = decodedToken['role'];

    return user;
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
        state = state.copyWith(isLoading: false, user: success, error: null);
      },
    );
  }

  void getUserInfo(BuildContext context, String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    String currentuser = decodedToken['username'];

    getUser(context, currentuser);
  }
}
