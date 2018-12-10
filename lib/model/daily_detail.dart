import 'package:json_annotation/json_annotation.dart';

part 'daily_detail.g.dart';

@JsonSerializable()
class DailyDetail {
  int id;

  String title;

  @JsonKey(name: 'share_url')
  String shareUrl;

  @JsonKey(name: 'image_source')
  String imageSource;

  DailyDetail(this.id, this.title, this.shareUrl, this.imageSource);

  factory DailyDetail.fromJson(Map<String, dynamic> json) =>
      _$DailyDetailFromJson(json);
}
