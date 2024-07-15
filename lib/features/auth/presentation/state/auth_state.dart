import 'package:gadget_store/features/auth/domain/entity/student_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final StudentEntity currentUser;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    required this.currentUser,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      currentUser: StudentEntity(
        fname: 'fname',
        lname: 'lname',
        phone: 'phone',
        username: 'username',
        password: 'password',
      ),
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    StudentEntity? currentUser,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error, currentUser: $currentUser)';
}
