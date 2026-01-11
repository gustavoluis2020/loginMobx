import 'package:login_mobx/features/text_notes/domain/usecases/get_text_notes_usecase.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/usecases/usecase.dart';

part 'statistics_store.g.dart';

class StatisticsStore = StatisticsStoreBase with _$StatisticsStore;

abstract class StatisticsStoreBase with Store {
  final GetTextNotesUseCase getNotesUseCase;

  StatisticsStoreBase(this.getNotesUseCase);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  int lineCount = 0;

  @observable
  int totalEdits = 0;

  @observable
  int totalChars = 0;

  @observable
  int totalCharsNoSpaces = 0;

  @observable
  int lettersCount = 0;

  @observable
  int numbersCount = 0;

  @observable
  int wordCount = 0;

  @observable
  double averageCharsPerNote = 0;

  @action
  Future<void> loadStatistics() async {
    isLoading = true;
    final result = await getNotesUseCase(NoParams());

    result.fold((l) => errorMessage = l.message, (notes) {
      lineCount = notes.length;
      totalEdits = notes.fold(0, (sum, note) => sum + note.editCount);
      totalChars = notes.fold(0, (sum, note) => sum + note.content.length);
      totalCharsNoSpaces = notes.fold(0, (sum, note) => sum + note.content.replaceAll(RegExp(r'\s'), '').length);
      averageCharsPerNote = lineCount > 0 ? totalChars / lineCount : 0;

      int letters = 0;
      int numbers = 0;
      int words = 0;

      for (final note in notes) {
        words += note.content.trim().isEmpty
            ? 0
            : note.content.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;

        for (int i = 0; i < note.content.length; i++) {
          final char = note.content[i];
          if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
            letters++;
          } else if (RegExp(r'[0-9]').hasMatch(char)) {
            numbers++;
          }
        }
      }

      lettersCount = letters;
      numbersCount = numbers;
      wordCount = words;
    });

    isLoading = false;
  }
}
