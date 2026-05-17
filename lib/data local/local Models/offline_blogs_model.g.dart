// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_blogs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineBlogsModelAdapter extends TypeAdapter<OfflineBlogsModel> {
  @override
  final typeId = 0;

  @override
  OfflineBlogsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineBlogsModel(
      slug: fields[12] as String,
      content: fields[13] as String,
      shareCount: (fields[14] as num).toInt(),
      thumbnail: fields[1] as String?,
      id: (fields[0] as num).toInt(),
      title: fields[2] as String,
      publishedAt: fields[4] as String,
      authorID: (fields[5] as num).toInt(),
      authorName: fields[6] as String,
      authorImage: fields[7] as String?,
      categoryID: (fields[9] as num).toInt(),
      categoryName: fields[10] as String,
      viewCount: (fields[3] as num).toInt(),
      excerpt: fields[8] as String,
      updatedAt: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineBlogsModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.viewCount)
      ..writeByte(4)
      ..write(obj.publishedAt)
      ..writeByte(5)
      ..write(obj.authorID)
      ..writeByte(6)
      ..write(obj.authorName)
      ..writeByte(7)
      ..write(obj.authorImage)
      ..writeByte(8)
      ..write(obj.excerpt)
      ..writeByte(9)
      ..write(obj.categoryID)
      ..writeByte(10)
      ..write(obj.categoryName)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.slug)
      ..writeByte(13)
      ..write(obj.content)
      ..writeByte(14)
      ..write(obj.shareCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineBlogsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
