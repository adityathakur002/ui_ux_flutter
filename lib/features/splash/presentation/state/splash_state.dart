import 'package:gadget_store/features/auth/domain/entity/student_entity.dart';

class SplashState {
  final bool isLoading;

  final String? error;

  final StudentEntity user;

  SplashState({
    required this.isLoading,
    this.error,
    required this.user,
  });

  factory SplashState.initial() {
    return SplashState(
      isLoading: false,
      error: null,
      user: StudentEntity(
          fname: 'fname',
          lname: 'lname',
          phone: 'phone',
          username: 'username',
          password: 'password'),
    );
  }

  SplashState copyWith({
    bool? isLoading,
    StudentEntity? user,
    String? error,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
