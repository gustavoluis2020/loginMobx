import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/core/error/failures.dart';
import 'package:login_mobx/features/text_notes/data/datasources/text_note_local_data_source.dart';
import 'package:login_mobx/features/text_notes/data/models/text_note_model.dart';
import 'package:login_mobx/features/text_notes/data/repositories/text_note_repository_impl.dart';
import 'package:login_mobx/features/text_notes/domain/entities/text_note_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockTextNoteLocalDataSource extends Mock implements TextNoteLocalDataSource {}

void main() {
  late TextNoteRepositoryImpl repository;
  late MockTextNoteLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockTextNoteLocalDataSource();
    repository = TextNoteRepositoryImpl(localDataSource: mockLocalDataSource);
    registerFallbackValue(const TextNoteModel(id: '1', content: 'Test', editCount: 1));
  });

  const tTextNoteModel = TextNoteModel(id: '1', content: 'Test Note', editCount: 1);
  // ignore: unused_local_variable
  const tTextNoteEntity = TextNoteEntity(id: '1', content: 'Test Note');
  final tNoteList = [tTextNoteModel];

  group('getTextNotes', () {
    test('should return list of text notes when call to data source is successful', () async {
      // arrange
      when(() => mockLocalDataSource.getTextNotes()).thenAnswer((_) async => tNoteList);
      // act
      final result = await repository.getTextNotes();
      // assert
      verify(() => mockLocalDataSource.getTextNotes());
      expect(result, Right<Failure, List<TextNoteEntity>>(tNoteList));
    });

    test('should return CacheFailure when call to data source is unsuccessful', () async {
      // arrange
      when(() => mockLocalDataSource.getTextNotes()).thenThrow(Exception());
      // act
      final result = await repository.getTextNotes();
      // assert
      verify(() => mockLocalDataSource.getTextNotes());
      expect(result, isA<Left<Failure, List<TextNoteEntity>>>());
    });
  });

  group('saveTextNote', () {
    test('should call saveTextNote on datasource', () async {
      // arrange
      when(() => mockLocalDataSource.saveTextNote(any())).thenAnswer((_) async => Future.value());
      // act
      final result = await repository.saveTextNote(tTextNoteEntity);
      // assert
      verify(() => mockLocalDataSource.saveTextNote(any()));
      expect(result, const Right(null));
    });
  });

  group('deleteTextNote', () {
    test('should call deleteTextNote on datasource', () async {
      // arrange
      when(() => mockLocalDataSource.deleteTextNote(any())).thenAnswer((_) async => Future.value());
      // act
      final result = await repository.deleteTextNote('1');
      // assert
      verify(() => mockLocalDataSource.deleteTextNote('1'));
      expect(result, const Right(null));
    });
  });
}
