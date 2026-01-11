import '../models/text_note_model.dart';

abstract class TextNoteLocalDataSource {
  Future<List<TextNoteModel>> getTextNotes();
  Future<void> saveTextNote(TextNoteModel note);
  Future<void> deleteTextNote(String id);
}
