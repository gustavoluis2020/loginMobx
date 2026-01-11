import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/core/usecases/usecase.dart';
import 'package:login_mobx/features/text_notes/domain/entities/text_note_entity.dart';
import 'package:login_mobx/features/text_notes/domain/repositories/text_note_repository.dart';
import 'package:login_mobx/features/text_notes/domain/usecases/get_text_notes_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockTextNoteRepository extends Mock implements TextNoteRepository {}

void main() {
  late GetTextNotesUseCase usecase;
  late MockTextNoteRepository mockTextNoteRepository;

  setUp(() {
    mockTextNoteRepository = MockTextNoteRepository();
    usecase = GetTextNotesUseCase(mockTextNoteRepository);
  });

  const tTextNote = TextNoteEntity(id: '1', content: 'Test Note');
  final tNoteList = [tTextNote];

  test('should get list of text notes from the repository', () async {
    // arrange
    when(() => mockTextNoteRepository.getTextNotes()).thenAnswer((_) async => Right(tNoteList));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tNoteList));
    verify(() => mockTextNoteRepository.getTextNotes());
    verifyNoMoreInteractions(mockTextNoteRepository);
  });
}
