abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}
