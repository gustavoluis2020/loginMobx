import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/text_note_entity.dart';

abstract class TextNoteRepository {
  Future<Either<Failure, List<TextNoteEntity>>> getTextNotes();
  Future<Either<Failure, void>> saveTextNote(TextNoteEntity note);
  Future<Either<Failure, void>> deleteTextNote(String id);
}
