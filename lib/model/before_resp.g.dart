// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'before_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeforeResp _$BeforeRespFromJson(Map<String, dynamic> json) {
  return BeforeResp(
      json['date'] as String,
      (json['stories'] as List)
          ?.map((e) =>
              e == null ? null : DailyItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$BeforeRespToJson(BeforeResp instance) =>
    <String, dynamic>{'date': instance.date, 'stories': instance.stories};
