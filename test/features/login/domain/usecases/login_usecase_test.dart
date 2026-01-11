import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/features/login/domain/entities/user_entity.dart';
import 'package:login_mobx/features/login/domain/repositories/login_repository.dart';
import 'package:login_mobx/features/login/domain/usecases/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late LoginUseCase usecase;
  late MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = LoginUseCase(mockLoginRepository);
  });

  final tUser = UserEntity(name: 'Test', email: 'test@email.com', token: '123');
  const tEmail = 'test@email.com';
  const tPassword = 'password';

  test('should get user entity from the repository', () async {
    // arrange
    when(() => mockLoginRepository.login(tEmail, tPassword)).thenAnswer((_) async => Right(tUser));

    // act
    final result = await usecase(LoginParams(email: tEmail, password: tPassword));

    // assert
    expect(result, Right(tUser));
    verify(() => mockLoginRepository.login(tEmail, tPassword));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
