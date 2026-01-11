import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/core/error/failures.dart';
import 'package:login_mobx/core/usecases/usecase.dart';
import 'package:login_mobx/features/statistics/presentation/stores/statistics_store.dart';
import 'package:login_mobx/features/text_notes/domain/entities/text_note_entity.dart';
import 'package:login_mobx/features/text_notes/domain/usecases/get_text_notes_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTextNotesUseCase extends Mock implements GetTextNotesUseCase {}

void main() {
  late StatisticsStore store;
  late MockGetTextNotesUseCase mockGetTextNotesUseCase;

  setUp(() {
    mockGetTextNotesUseCase = MockGetTextNotesUseCase();
    store = StatisticsStore(mockGetTextNotesUseCase);
    registerFallbackValue(NoParams());
  });

  group('StatisticsStore', () {
    test('initial values should be correct', () {
      expect(store.isLoading, false);
      expect(store.errorMessage, null);
      expect(store.lineCount, 0);
      expect(store.totalEdits, 0);
      expect(store.totalChars, 0);
      expect(store.totalCharsNoSpaces, 0);
      expect(store.lettersCount, 0);
      expect(store.numbersCount, 0);
      expect(store.wordCount, 0);
      expect(store.averageCharsPerNote, 0);
    });

    test('should load statistics correctly', () async {
      // arrange
      final notes = [
        const TextNoteEntity(id: '1', content: 'abc 123', editCount: 2),
        const TextNoteEntity(id: '2', content: 'Hello World', editCount: 0),
      ];

      when(() => mockGetTextNotesUseCase(any())).thenAnswer((_) async => Right(notes));

      // act
      await store.loadStatistics();

      // assert
      verify(() => mockGetTextNotesUseCase(any()));
      expect(store.isLoading, false);
      expect(store.lineCount, 2);
      expect(store.totalEdits, 2);
      expect(store.totalChars, 18);
      expect(store.totalCharsNoSpaces, 16);
      expect(store.lettersCount, 13);
      expect(store.numbersCount, 3);
      expect(store.wordCount, 4);
      expect(store.averageCharsPerNote, 9.0);
    });

    test('should handle empty list correctly', () async {
      // arrange
      when(() => mockGetTextNotesUseCase(any())).thenAnswer((_) async => const Right([]));

      // act
      await store.loadStatistics();

      // assert
      expect(store.lineCount, 0);
      expect(store.totalEdits, 0);
      expect(store.totalChars, 0);
      expect(store.totalCharsNoSpaces, 0);
      expect(store.lettersCount, 0);
      expect(store.numbersCount, 0);
      expect(store.wordCount, 0);
      expect(store.averageCharsPerNote, 0);
    });

    test('should set errorMessage when getting data fails', () async {
      // arrange
      when(
        () => mockGetTextNotesUseCase(any()),
      ).thenAnswer((_) async => Left(CacheFailure('Error loading stats')));

      // act
      await store.loadStatistics();

      // assert
      expect(store.isLoading, false);
      expect(store.errorMessage, 'Error loading stats');
    });
  });
}
