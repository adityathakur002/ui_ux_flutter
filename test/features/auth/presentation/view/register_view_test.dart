import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gadget_store/config/routes/app_route.dart';
import 'package:gadget_store/features/auth/domain/entity/student_entity.dart';
import 'package:gadget_store/features/auth/domain/use_case/auth_usecase.dart';
import 'package:gadget_store/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;

  late StudentEntity authEntity;

  setUpAll(() async {
    mockAuthUsecase = MockAuthUseCase();

    authEntity = StudentEntity(
      id: null,
      fname: 'jawed',
      lname: 'akthar',
      image: '',
      phone: '1234567890',
      username: 'jawed',
      password: 'jawed@123',
    );
  });

  testWidgets('register view ...', (tester) async {
    when(mockAuthUsecase.registerStudent(authEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    
    await tester.enterText(find.byType(TextFormField).at(0), 'jawed');
    
    await tester.enterText(find.byType(TextFormField).at(1), 'akthar');
    
    await tester.enterText(find.byType(TextFormField).at(2), '1234567890');
    
    await tester.enterText(find.byType(TextFormField).at(3), 'jawed');
    
    await tester.enterText(find.byType(TextFormField).at(4), 'jawed123');

    //=========================== Find the dropdownformfield===========================

    await tester.tap(find.text('Flutter'));
    await tester.tap(find.text('API'));

    await tester.tap(find.text('OK'));

    await tester.pumpAndSettle();

    //=========================== Find the register button===========================
    //=========================== Find the register button===========================
    final registerButtonFinder = find.widgetWithText(ElevatedButton, 'Test');

    await tester.tap(registerButtonFinder);

    // await tester.pumpAndSettle();

    // expect(find.text('Successfully registered'), findsOneWidget);
  });
}
