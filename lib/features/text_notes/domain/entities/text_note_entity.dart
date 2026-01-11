import 'package:equatable/equatable.dart';

class TextNoteEntity extends Equatable {
  final String id;
  final String content;
  final int editCount;

  const TextNoteEntity({required this.id, required this.content, this.editCount = 0});

  @override
  List<Object?> get props => [id, content, editCount];
}
