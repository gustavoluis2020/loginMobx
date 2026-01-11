import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
}
