import 'package:json_annotation/json_annotation.dart';

part 'daily_detail.g.dart';

@JsonSerializable()
class DailyDetail {
  int id;

  String title;

  @JsonKey(name: 'share_url')
  String shareUrl;

  String image;

  @JsonKey(name: 'image_source')
  String imageSource;

  String body;

  List<String> css;

  DailyDetail(this.id, this.title, this.shareUrl, this.image, this.imageSource,
      this.body, this.css);

  factory DailyDetail.fromJson(Map<String, dynamic> json) =>
      _$DailyDetailFromJson(json);
}
