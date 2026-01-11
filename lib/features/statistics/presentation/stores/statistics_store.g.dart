// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatisticsStore on StatisticsStoreBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'StatisticsStoreBase.isLoading',
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
    name: 'StatisticsStoreBase.errorMessage',
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

  late final _$lineCountAtom = Atom(
    name: 'StatisticsStoreBase.lineCount',
    context: context,
  );

  @override
  int get lineCount {
    _$lineCountAtom.reportRead();
    return super.lineCount;
  }

  @override
  set lineCount(int value) {
    _$lineCountAtom.reportWrite(value, super.lineCount, () {
      super.lineCount = value;
    });
  }

  late final _$totalEditsAtom = Atom(
    name: 'StatisticsStoreBase.totalEdits',
    context: context,
  );

  @override
  int get totalEdits {
    _$totalEditsAtom.reportRead();
    return super.totalEdits;
  }

  @override
  set totalEdits(int value) {
    _$totalEditsAtom.reportWrite(value, super.totalEdits, () {
      super.totalEdits = value;
    });
  }

  late final _$totalCharsAtom = Atom(
    name: 'StatisticsStoreBase.totalChars',
    context: context,
  );

  @override
  int get totalChars {
    _$totalCharsAtom.reportRead();
    return super.totalChars;
  }

  @override
  set totalChars(int value) {
    _$totalCharsAtom.reportWrite(value, super.totalChars, () {
      super.totalChars = value;
    });
  }

  late final _$totalCharsNoSpacesAtom = Atom(
    name: 'StatisticsStoreBase.totalCharsNoSpaces',
    context: context,
  );

  @override
  int get totalCharsNoSpaces {
    _$totalCharsNoSpacesAtom.reportRead();
    return super.totalCharsNoSpaces;
  }

  @override
  set totalCharsNoSpaces(int value) {
    _$totalCharsNoSpacesAtom.reportWrite(value, super.totalCharsNoSpaces, () {
      super.totalCharsNoSpaces = value;
    });
  }

  late final _$lettersCountAtom = Atom(
    name: 'StatisticsStoreBase.lettersCount',
    context: context,
  );

  @override
  int get lettersCount {
    _$lettersCountAtom.reportRead();
    return super.lettersCount;
  }

  @override
  set lettersCount(int value) {
    _$lettersCountAtom.reportWrite(value, super.lettersCount, () {
      super.lettersCount = value;
    });
  }

  late final _$numbersCountAtom = Atom(
    name: 'StatisticsStoreBase.numbersCount',
    context: context,
  );

  @override
  int get numbersCount {
    _$numbersCountAtom.reportRead();
    return super.numbersCount;
  }

  @override
  set numbersCount(int value) {
    _$numbersCountAtom.reportWrite(value, super.numbersCount, () {
      super.numbersCount = value;
    });
  }

  late final _$wordCountAtom = Atom(
    name: 'StatisticsStoreBase.wordCount',
    context: context,
  );

  @override
  int get wordCount {
    _$wordCountAtom.reportRead();
    return super.wordCount;
  }

  @override
  set wordCount(int value) {
    _$wordCountAtom.reportWrite(value, super.wordCount, () {
      super.wordCount = value;
    });
  }

  late final _$averageCharsPerNoteAtom = Atom(
    name: 'StatisticsStoreBase.averageCharsPerNote',
    context: context,
  );

  @override
  double get averageCharsPerNote {
    _$averageCharsPerNoteAtom.reportRead();
    return super.averageCharsPerNote;
  }

  @override
  set averageCharsPerNote(double value) {
    _$averageCharsPerNoteAtom.reportWrite(value, super.averageCharsPerNote, () {
      super.averageCharsPerNote = value;
    });
  }

  late final _$loadStatisticsAsyncAction = AsyncAction(
    'StatisticsStoreBase.loadStatistics',
    context: context,
  );

  @override
  Future<void> loadStatistics() {
    return _$loadStatisticsAsyncAction.run(() => super.loadStatistics());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
lineCount: ${lineCount},
totalEdits: ${totalEdits},
totalChars: ${totalChars},
totalCharsNoSpaces: ${totalCharsNoSpaces},
lettersCount: ${lettersCount},
numbersCount: ${numbersCount},
wordCount: ${wordCount},
averageCharsPerNote: ${averageCharsPerNote}
    ''';
  }
}
