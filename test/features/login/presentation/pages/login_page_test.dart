import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:login_mobx/core/error/failures.dart';
import 'package:login_mobx/features/login/domain/entities/user_entity.dart';
import 'package:login_mobx/features/login/domain/usecases/login_usecase.dart';
import 'package:login_mobx/features/login/presentation/pages/login_page.dart';
import 'package:login_mobx/features/login/presentation/stores/login_store.dart';
import 'package:login_mobx/features/text_notes/presentation/stores/text_notes_store.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockTextNotesStore extends Mock implements TextNotesStore {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockTextNotesStore mockTextNotesStore;

  setUp(() async {
    mockLoginUseCase = MockLoginUseCase();
    mockTextNotesStore = MockTextNotesStore();
    await GetIt.I.reset();
    GetIt.I.registerFactory<LoginStore>(() => LoginStore(mockLoginUseCase));
    GetIt.I.registerFactory<TextNotesStore>(() => mockTextNotesStore);
    registerFallbackValue(LoginParams(email: 'e', password: 'p'));

    when(() => mockTextNotesStore.loadNotes()).thenAnswer((_) async {});
    when(() => mockTextNotesStore.currentText).thenReturn('');
    when(() => mockTextNotesStore.notes).thenReturn(ObservableList());
    when(() => mockTextNotesStore.setText(any())).thenReturn(null);
    when(() => mockTextNotesStore.isLoading).thenReturn(false);
    when(() => mockTextNotesStore.canSave).thenReturn(false);
    when(() => mockTextNotesStore.errorMessage).thenReturn(null);
    when(() => mockTextNotesStore.editingId).thenReturn(null);
  });

  Widget createWidgetUnderTest() {
    return const MaterialApp(home: LoginPage());
  }

  testWidgets('should display email and password fields', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('button should be disabled initially', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('button should be enabled when form is valid', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextField).first, 'teste@email.com');
    await tester.enterText(find.byType(TextField).last, '123456');
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('should show snackbar on error', (tester) async {
    // arrange
    when(() => mockLoginUseCase(any())).thenAnswer((_) async => Left(ServerFailure('Erro no servidor')));

    await tester.pumpWidget(createWidgetUnderTest());

    // Enter valid data
    await tester.enterText(find.byType(TextField).first, 'teste@email.com');
    await tester.enterText(find.byType(TextField).last, '123456');
    await tester.pump();

    // Tap login
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Erro no servidor'), findsOneWidget);
  });

  testWidgets('should show success message on login success', (tester) async {
    // arrange
    const tUser = UserEntity(name: 'Usuário Teste', email: 'e', token: 't');
    when(() => mockLoginUseCase(any())).thenAnswer((_) async => const Right(tUser));

    await tester.pumpWidget(createWidgetUnderTest());

    // Enter valid data
    await tester.enterText(find.byType(TextField).first, 'teste@email.com');
    await tester.enterText(find.byType(TextField).last, '123456');
    await tester.pump();

    // Tap login
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(); // Allow navigation loop

    expect(find.text('Sair'), findsOneWidget);
  });

  testWidgets('should show error message on invalid email', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextField).first, 'invalid');
    await tester.pump();

    expect(find.text('Email inválido'), findsOneWidget);
  });

  testWidgets('should show error message on invalid password', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextField).last, '123');
    await tester.pump();

    expect(find.text('Senha precisa ter no minimo 6 caracteres'), findsOneWidget);
  });
}
