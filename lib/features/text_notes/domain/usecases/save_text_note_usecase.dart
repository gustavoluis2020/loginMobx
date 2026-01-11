import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/text_note_entity.dart';
import '../repositories/text_note_repository.dart';

class SaveTextNoteUseCase implements UseCase<void, TextNoteEntity> {
  final TextNoteRepository repository;

  SaveTextNoteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(TextNoteEntity params) async {
    return await repository.saveTextNote(params);
  }
}
