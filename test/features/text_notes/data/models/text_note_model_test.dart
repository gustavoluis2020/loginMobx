import 'package:flutter_test/flutter_test.dart';
import 'package:login_mobx/features/text_notes/data/models/text_note_model.dart';
import 'package:login_mobx/features/text_notes/domain/entities/text_note_entity.dart';

void main() {
  const tTextNoteModel = TextNoteModel(id: '1', content: 'Test Content', editCount: 1);

  test('should be a subclass of TextNoteEntity', () async {
    expect(tTextNoteModel, isA<TextNoteEntity>());
  });

  test('fromEntity should return a valid model', () {
    const entity = TextNoteEntity(id: '1', content: 'Test Content', editCount: 1);
    final result = TextNoteModel.fromEntity(entity);
    expect(result, tTextNoteModel);
  });
}
