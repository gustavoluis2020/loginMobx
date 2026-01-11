import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/text_note_entity.dart';
import '../../domain/usecases/delete_text_note_usecase.dart';
import '../../domain/usecases/get_text_notes_usecase.dart';
import '../../domain/usecases/save_text_note_usecase.dart';

part 'text_notes_store.g.dart';

class TextNotesStore = TextNotesStoreBase with _$TextNotesStore;

abstract class TextNotesStoreBase with Store {
  final GetTextNotesUseCase getNotesUseCase;
  final SaveTextNoteUseCase saveNoteUseCase;
  final DeleteTextNoteUseCase deleteNoteUseCase;

  TextNotesStoreBase(this.getNotesUseCase, this.saveNoteUseCase, this.deleteNoteUseCase);

  @observable
  ObservableList<TextNoteEntity> notes = ObservableList<TextNoteEntity>();

  @observable
  String currentText = '';

  @observable
  String? editingId;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  bool get canSave => currentText.trim().isNotEmpty;

  @action
  void setText(String value) {
    currentText = value;
  }

  @action
  Future<void> loadNotes() async {
    isLoading = true;
    final result = await getNotesUseCase(NoParams());
    result.fold((l) => errorMessage = l.message, (r) => notes = ObservableList.of(r));
    isLoading = false;
  }

  @action
  Future<void> saveNote() async {
    if (!canSave) return;

    final id = editingId ?? const Uuid().v1();
    int editCount = 0;

    if (editingId != null) {
      final existingNote = notes.firstWhere(
        (element) => element.id == editingId,
        orElse: () => TextNoteEntity(id: 'temp', content: ''),
      );
      if (existingNote.id != 'temp') {
        editCount = existingNote.editCount + 1;
      }
    }

    final note = TextNoteEntity(id: id, content: currentText.trim(), editCount: editCount);

    isLoading = true;
    final result = await saveNoteUseCase(note);

    result.fold((l) => errorMessage = l.message, (r) async {
      currentText = '';
      editingId = null;
      await loadNotes();
    });
    isLoading = false;
  }

  @action
  Future<void> deleteNote(String id) async {
    isLoading = true;
    final result = await deleteNoteUseCase(id);
    result.fold((l) => errorMessage = l.message, (r) async {
      if (editingId == id) {
        editingId = null;
        currentText = '';
      }
      await loadNotes();
    });
    isLoading = false;
  }

  @action
  void startEditing(TextNoteEntity note) {
    editingId = note.id;
    currentText = note.content;
  }
}
