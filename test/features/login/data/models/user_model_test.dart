import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/features/login/data/models/user_model.dart';
import 'package:login_mobx/features/login/domain/entities/user_entity.dart';

void main() {
  const tUserModel = UserModel(name: 'Test', email: 'test@email.com', token: '123');

  test('should be a subclass of UserEntity', () async {
    expect(tUserModel, isA<UserEntity>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      final Map<String, dynamic> jsonMap = {'name': 'Test', 'email': 'test@email.com', 'token': '123'};

      final result = UserModel.fromJson(jsonMap);

      expect(result.name, tUserModel.name);
      expect(result.email, tUserModel.email);
      expect(result.token, tUserModel.token);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tUserModel.toJson();
      final expectedMap = {'name': 'Test', 'email': 'test@email.com', 'token': '123'};
      expect(result, expectedMap);
    });
  });
}
