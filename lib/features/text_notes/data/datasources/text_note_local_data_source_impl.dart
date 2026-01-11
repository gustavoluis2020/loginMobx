import 'package:hive/hive.dart';
import '../models/text_note_model.dart';
import 'text_note_local_data_source.dart';

class TextNoteLocalDataSourceImpl implements TextNoteLocalDataSource {
  final Box<TextNoteModel> box;

  TextNoteLocalDataSourceImpl({required this.box});

  @override
  Future<List<TextNoteModel>> getTextNotes() async {
    return box.values.toList();
  }

  @override
  Future<void> saveTextNote(TextNoteModel note) async {
    await box.put(note.id, note);
  }

  @override
  Future<void> deleteTextNote(String id) async {
    await box.delete(id);
  }
}
