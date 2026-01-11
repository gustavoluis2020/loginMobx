// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_notes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TextNotesStore on TextNotesStoreBase, Store {
  Computed<bool>? _$canSaveComputed;

  @override
  bool get canSave => (_$canSaveComputed ??= Computed<bool>(
    () => super.canSave,
    name: 'TextNotesStoreBase.canSave',
  )).value;

  late final _$notesAtom = Atom(
    name: 'TextNotesStoreBase.notes',
    context: context,
  );

  @override
  ObservableList<TextNoteEntity> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<TextNoteEntity> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$currentTextAtom = Atom(
    name: 'TextNotesStoreBase.currentText',
    context: context,
  );

  @override
  String get currentText {
    _$currentTextAtom.reportRead();
    return super.currentText;
  }

  @override
  set currentText(String value) {
    _$currentTextAtom.reportWrite(value, super.currentText, () {
      super.currentText = value;
    });
  }

  late final _$editingIdAtom = Atom(
    name: 'TextNotesStoreBase.editingId',
    context: context,
  );

  @override
  String? get editingId {
    _$editingIdAtom.reportRead();
    return super.editingId;
  }

  @override
  set editingId(String? value) {
    _$editingIdAtom.reportWrite(value, super.editingId, () {
      super.editingId = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'TextNotesStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'TextNotesStoreBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadNotesAsyncAction = AsyncAction(
    'TextNotesStoreBase.loadNotes',
    context: context,
  );

  @override
  Future<void> loadNotes() {
    return _$loadNotesAsyncAction.run(() => super.loadNotes());
  }

  late final _$saveNoteAsyncAction = AsyncAction(
    'TextNotesStoreBase.saveNote',
    context: context,
  );

  @override
  Future<void> saveNote() {
    return _$saveNoteAsyncAction.run(() => super.saveNote());
  }

  late final _$deleteNoteAsyncAction = AsyncAction(
    'TextNotesStoreBase.deleteNote',
    context: context,
  );

  @override
  Future<void> deleteNote(String id) {
    return _$deleteNoteAsyncAction.run(() => super.deleteNote(id));
  }

  late final _$TextNotesStoreBaseActionController = ActionController(
    name: 'TextNotesStoreBase',
    context: context,
  );

  @override
  void setText(String value) {
    final _$actionInfo = _$TextNotesStoreBaseActionController.startAction(
      name: 'TextNotesStoreBase.setText',
    );
    try {
      return super.setText(value);
    } finally {
      _$TextNotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startEditing(TextNoteEntity note) {
    final _$actionInfo = _$TextNotesStoreBaseActionController.startAction(
      name: 'TextNotesStoreBase.startEditing',
    );
    try {
      return super.startEditing(note);
    } finally {
      _$TextNotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notes: ${notes},
currentText: ${currentText},
editingId: ${editingId},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
canSave: ${canSave}
    ''';
  }
}
