import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/features/text_notes/domain/repositories/text_note_repository.dart';
import 'package:login_mobx/features/text_notes/domain/usecases/delete_text_note_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockTextNoteRepository extends Mock implements TextNoteRepository {}

void main() {
  late DeleteTextNoteUseCase usecase;
  late MockTextNoteRepository mockTextNoteRepository;

  setUp(() {
    mockTextNoteRepository = MockTextNoteRepository();
    usecase = DeleteTextNoteUseCase(mockTextNoteRepository);
  });

  const tId = '1';

  test('should delete text note from the repository', () async {
    // arrange
    when(() => mockTextNoteRepository.deleteTextNote(any())).thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(tId);
    // assert
    expect(result, const Right(null));
    verify(() => mockTextNoteRepository.deleteTextNote(tId));
    verifyNoMoreInteractions(mockTextNoteRepository);
  });
}
