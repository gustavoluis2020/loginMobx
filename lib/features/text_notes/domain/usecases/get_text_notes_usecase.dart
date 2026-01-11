import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/text_note_entity.dart';
import '../repositories/text_note_repository.dart';

class GetTextNotesUseCase implements UseCase<List<TextNoteEntity>, NoParams> {
  final TextNoteRepository repository;

  GetTextNotesUseCase(this.repository);

  @override
  Future<Either<Failure, List<TextNoteEntity>>> call(NoParams params) async {
    return await repository.getTextNotes();
  }
}
