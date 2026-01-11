import 'package:hive/hive.dart';
import '../../domain/entities/text_note_entity.dart';

class TextNoteModel extends TextNoteEntity {
  const TextNoteModel({required super.id, required super.content, required super.editCount});

  factory TextNoteModel.fromEntity(TextNoteEntity entity) {
    return TextNoteModel(id: entity.id, content: entity.content, editCount: entity.editCount);
  }
}

class TextNoteModelAdapter extends TypeAdapter<TextNoteModel> {
  @override
  final int typeId = 1;

  @override
  TextNoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read()};
    return TextNoteModel(
      id: fields[0] as String,
      content: fields[1] as String,
      editCount: (fields[2] as int?) ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, TextNoteModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.editCount);
  }
}
