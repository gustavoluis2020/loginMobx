import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/core/error/failures.dart';
import 'package:login_mobx/core/usecases/usecase.dart';
import 'package:login_mobx/features/text_notes/domain/entities/text_note_entity.dart';
import 'package:login_mobx/features/text_notes/domain/usecases/delete_text_note_usecase.dart';
import 'package:login_mobx/features/text_notes/domain/usecases/get_text_notes_usecase.dart';
import 'package:login_mobx/features/text_notes/domain/usecases/save_text_note_usecase.dart';
import 'package:login_mobx/features/text_notes/presentation/stores/text_notes_store.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTextNotesUseCase extends Mock implements GetTextNotesUseCase {}

class MockSaveTextNoteUseCase extends Mock implements SaveTextNoteUseCase {}

class MockDeleteTextNoteUseCase extends Mock implements DeleteTextNoteUseCase {}

void main() {
  late TextNotesStore store;
  late MockGetTextNotesUseCase mockGetTextNotesUseCase;
  late MockSaveTextNoteUseCase mockSaveTextNoteUseCase;
  late MockDeleteTextNoteUseCase mockDeleteTextNoteUseCase;

  setUp(() {
    mockGetTextNotesUseCase = MockGetTextNotesUseCase();
    mockSaveTextNoteUseCase = MockSaveTextNoteUseCase();
    mockDeleteTextNoteUseCase = MockDeleteTextNoteUseCase();
    store = TextNotesStore(mockGetTextNotesUseCase, mockSaveTextNoteUseCase, mockDeleteTextNoteUseCase);

    registerFallbackValue(NoParams());
    registerFallbackValue(const TextNoteEntity(id: '1', content: 'content'));
  });

  const tTextNote = TextNoteEntity(id: '1', content: 'Test Note');
  final tNoteList = [tTextNote];

  group('loadNotes', () {
    test('should get data from the use case', () async {
      // arrange
      when(() => mockGetTextNotesUseCase(any())).thenAnswer((_) async => Right(tNoteList));
      // act
      await store.loadNotes();
      // assert
      verify(() => mockGetTextNotesUseCase(any()));
      expect(store.notes, equals(tNoteList));
      expect(store.isLoading, false);
    });

    test('should set errorMessage when getting data fails', () async {
      // arrange
      when(() => mockGetTextNotesUseCase(any())).thenAnswer((_) async => Left(CacheFailure('Error')));
      // act
      await store.loadNotes();
      // assert
      expect(store.errorMessage, 'Error');
      expect(store.isLoading, false);
    });
  });

  group('saveNote', () {
    test('should call save usecase and reload notes', () async {
      // arrange
      store.setText('New Content');
      when(() => mockSaveTextNoteUseCase(any())).thenAnswer((_) async => const Right(null));
      when(() => mockGetTextNotesUseCase(any())).thenAnswer((_) async => Right(tNoteList));

      // act
      await store.saveNote();

      // assert
      verify(() => mockSaveTextNoteUseCase(any()));
      verify(() => mockGetTextNotesUseCase(any()));
      expect(store.currentText, '');
      expect(store.editingId, null);
    });

    test('should increment edit count when saving an existing note', () async {
      // arrange
      const initialNote = TextNoteEntity(id: '1', content: 'Old Content', editCount: 5);
      store.notes.add(initialNote);
      store.startEditing(initialNote);
      store.setText('New Content');

      when(() => mockSaveTextNoteUseCase(any())).thenAnswer((_) async => const Right(null));
      when(() => mockGetTextNotesUseCase(any())).thenAnswer((_) async => Right([initialNote]));

      // act
      await store.saveNote();

      // assert
      // Verify editCount is 6 (5 + 1)
      final captured = verify(() => mockSaveTextNoteUseCase(captureAny())).captured;
      final savedNote = captured.last as TextNoteEntity;
      expect(savedNote.id, '1');
      expect(savedNote.content, 'New Content');
      expect(savedNote.editCount, 6);
    });

    test('should not save if text is empty', () async {
      // arrange
      store.setText('   ');
      // act
      await store.saveNote();
      // assert
      verifyNever(() => mockSaveTextNoteUseCase(any()));
    });
  });

  group('deleteNote', () {
    test('should call delete usecase and reload notes', () async {
      // arrange
      when(() => mockDeleteTextNoteUseCase(any())).thenAnswer((_) async => const Right(null));
      when(() => mockGetTextNotesUseCase(any())).thenAnswer((_) async => Right(<TextNoteEntity>[]));

      // act
      await store.deleteNote('1');

      // assert
      verify(() => mockDeleteTextNoteUseCase('1'));
      verify(() => mockGetTextNotesUseCase(any()));
      expect(store.notes.isEmpty, true);
    });
  });

  group('UI interactions', () {
    test('startEditing should set editingId and currentText', () {
      store.startEditing(tTextNote);
      expect(store.editingId, tTextNote.id);
      expect(store.currentText, tTextNote.content);
    });

    test('setText should update currentText', () {
      store.setText('Updated');
      expect(store.currentText, 'Updated');
    });

    test('canSave should return true only if text is not empty', () {
      store.setText('');
      expect(store.canSave, false);
      store.setText('  ');
      expect(store.canSave, false);
      store.setText('Data');
      expect(store.canSave, true);
    });
  });
}
