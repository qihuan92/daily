// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyItem _$DailyItemFromJson(Map<String, dynamic> json) {
  return DailyItem(
      json['id'] as int,
      json['title'] as String,
      json['image'] as String,
      (json['images'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$DailyItemToJson(DailyItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'images': instance.images
    };
