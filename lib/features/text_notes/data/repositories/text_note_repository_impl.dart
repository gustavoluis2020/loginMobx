import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/text_note_entity.dart';
import '../../domain/repositories/text_note_repository.dart';
import '../datasources/text_note_local_data_source.dart';
import '../models/text_note_model.dart';

class TextNoteRepositoryImpl implements TextNoteRepository {
  final TextNoteLocalDataSource localDataSource;

  TextNoteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<TextNoteEntity>>> getTextNotes() async {
    try {
      final notes = await localDataSource.getTextNotes();
      return Right(notes);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTextNote(TextNoteEntity note) async {
    try {
      await localDataSource.saveTextNote(TextNoteModel.fromEntity(note));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTextNote(String id) async {
    try {
      await localDataSource.deleteTextNote(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
