import 'package:daily/model/DailyItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LatestDailyResp.g.dart';

@JsonSerializable()
class LatestDailyResp {
  List<DailyItem> top_stories;
  List<DailyItem> stories;

  LatestDailyResp(this.top_stories, this.stories);

  factory LatestDailyResp.fromJson(Map<String, dynamic> json) =>
      _$LatestDailyRespFromJson(json);
}
