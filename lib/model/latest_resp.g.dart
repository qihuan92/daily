// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestDailyResp _$LatestDailyRespFromJson(Map<String, dynamic> json) {
  return LatestDailyResp(
      (json['top_stories'] as List)
          ?.map((e) =>
              e == null ? null : DailyItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['stories'] as List)
          ?.map((e) =>
              e == null ? null : DailyItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LatestDailyRespToJson(LatestDailyResp instance) =>
    <String, dynamic>{
      'top_stories': instance.topStories,
      'stories': instance.stories
    };
