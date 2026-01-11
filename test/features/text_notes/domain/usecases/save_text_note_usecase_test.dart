import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/features/text_notes/domain/entities/text_note_entity.dart';
import 'package:login_mobx/features/text_notes/domain/repositories/text_note_repository.dart';
import 'package:login_mobx/features/text_notes/domain/usecases/save_text_note_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockTextNoteRepository extends Mock implements TextNoteRepository {}

void main() {
  late SaveTextNoteUseCase usecase;
  late MockTextNoteRepository mockTextNoteRepository;

  setUp(() {
    mockTextNoteRepository = MockTextNoteRepository();
    usecase = SaveTextNoteUseCase(mockTextNoteRepository);
    registerFallbackValue(const TextNoteEntity(id: '1', content: 'content'));
  });

  const tTextNote = TextNoteEntity(id: '1', content: 'Test Note');

  test('should save text note to the repository', () async {
    // arrange
    when(() => mockTextNoteRepository.saveTextNote(any())).thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(tTextNote);
    // assert
    expect(result, const Right(null));
    verify(() => mockTextNoteRepository.saveTextNote(tTextNote));
    verifyNoMoreInteractions(mockTextNoteRepository);
  });
}
