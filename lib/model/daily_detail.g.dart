// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyDetail _$DailyDetailFromJson(Map<String, dynamic> json) {
  return DailyDetail(
      json['id'] as int,
      json['title'] as String,
      json['image'] as String,
      json['share_url'] as String,
      json['image_source'] as String);
}

Map<String, dynamic> _$DailyDetailToJson(DailyDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'share_url': instance.shareUrl,
      'image_source': instance.imageSource
    };
