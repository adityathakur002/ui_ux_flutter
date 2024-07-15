import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadget_store/config/routes/app_route.dart';
import 'package:gadget_store/features/auth/domain/use_case/auth_usecase.dart';
import 'package:gadget_store/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  late AuthUseCase mockAuthUsecase;

  // We are doing these for dashboard

  late bool isLogin;

  setUpAll(() async {
    // Because these mocks are already created in the register_view_test.dart file
    mockAuthUsecase = MockAuthUseCase();

    isLogin = true;
  });

  testWidgets('login test with username and password and open dashboard',
      (WidgetTester tester) async {
    when(mockAuthUsecase.loginStudent('jawed', 'jawed@123'))
        .thenAnswer((_) async => Right(isLogin));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Type in first textformfield/TextField
    await tester.enterText(find.byType(TextField).at(0), 'jawed');
    // Type in second textformfield
    await tester.enterText(find.byType(TextField).at(1), 'jawed@123');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Login'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Dashboard View'), findsOneWidget);
  });
}
