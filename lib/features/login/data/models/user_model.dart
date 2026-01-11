import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.name, required super.email, required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: json['name'], email: json['email'], token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'token': token};
  }
}
