import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/text_note_repository.dart';

class DeleteTextNoteUseCase implements UseCase<void, String> {
  final TextNoteRepository repository;

  DeleteTextNoteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteTextNote(params);
  }
}
