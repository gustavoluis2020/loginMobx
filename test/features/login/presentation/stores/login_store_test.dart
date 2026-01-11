import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/core/error/failures.dart';
import 'package:login_mobx/features/login/domain/entities/user_entity.dart';
import 'package:login_mobx/features/login/domain/usecases/login_usecase.dart';
import 'package:login_mobx/features/login/presentation/stores/login_store.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginStore store;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    store = LoginStore(mockLoginUseCase);
    registerFallbackValue(LoginParams(email: 'e', password: 'p'));
  });

  final tUser = UserEntity(name: 'Test', email: 'test@email.com', token: '123');

  test('should update email', () {
    store.setEmail('test@email.com');
    expect(store.email, 'test@email.com');
  });

  test('should update password', () {
    store.setPassword('123456');
    expect(store.password, '123456');
  });

  test('isEmailValid should return true for valid email', () {
    store.setEmail('test@email.com');
    expect(store.isEmailValid, true);
  });

  test('isEmailValid should return false for invalid email', () {
    store.setEmail('test');
    expect(store.isEmailValid, false);
  });

  test('isPasswordValid should return true for password >= 6', () {
    store.setPassword('123456');
    expect(store.isPasswordValid, true);
  });

  test('isPasswordValid should return false for password < 6', () {
    store.setPassword('123');
    expect(store.isPasswordValid, false);
  });

  test('emailError should return error message when email is invalid', () {
    store.setEmail('invalid');
    expect(store.emailError, 'Email inválido');
  });

  test('emailError should return null when email is valid', () {
    store.setEmail('test@email.com');
    expect(store.emailError, null);
  });

  test('emailError should return null when email is empty', () {
    store.setEmail('');
    expect(store.emailError, null);
  });

  test('passwordError should return error message when password is short', () {
    store.setPassword('123');
    expect(store.passwordError, 'Senha precisa ter no minimo 6 caracteres');
  });

  test('passwordError should return null when password is valid', () {
    store.setPassword('123456');
    expect(store.passwordError, null);
  });

  test('login should success', () async {
    // arrange
    store.setEmail('test@email.com');
    store.setPassword('123456');
    when(() => mockLoginUseCase(any())).thenAnswer((_) async => Right(tUser));

    // act
    await store.login();

    // assert
    expect(store.user, tUser);
    expect(store.isLoading, false);
    expect(store.errorMessage, null);
  });

  test('login should fail', () async {
    // arrange
    store.setEmail('test@email.com');
    store.setPassword('123456');
    when(() => mockLoginUseCase(any())).thenAnswer((_) async => Left(InvalidCredentialsFailure('Error')));

    // act
    await store.login();

    // assert
    expect(store.user, null);
    expect(store.isLoading, false);
    expect(store.errorMessage, 'Error');
  });
}
