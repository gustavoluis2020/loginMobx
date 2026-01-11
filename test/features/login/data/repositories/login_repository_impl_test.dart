import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/core/error/failures.dart';
import 'package:login_mobx/features/login/data/datasources/login_remote_data_source.dart';
import 'package:login_mobx/features/login/data/models/user_model.dart';
import 'package:login_mobx/features/login/data/repositories/login_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}

void main() {
  late LoginRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = LoginRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tEmail = 'test@email.com';
  const tPassword = 'password';
  final tUserModel = UserModel(name: 'Test', email: tEmail, token: '123');

  group('login', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(() => mockRemoteDataSource.login(tEmail, tPassword)).thenAnswer((_) async => tUserModel);

      // act
      final result = await repository.login(tEmail, tPassword);

      // assert
      verify(() => mockRemoteDataSource.login(tEmail, tPassword));
      expect(result.toString(), Right(tUserModel).toString());
    });

    test('should return failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(() => mockRemoteDataSource.login(tEmail, tPassword)).thenThrow(Exception('Error'));

      // act
      final result = await repository.login(tEmail, tPassword);

      // assert
      verify(() => mockRemoteDataSource.login(tEmail, tPassword));
      expect(result.isLeft(), true);
      result.fold((failure) => expect(failure, isA<InvalidCredentialsFailure>()), (r) => null);
    });
  });
}
