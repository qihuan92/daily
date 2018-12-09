import 'package:daily/model/daily_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'latest_resp.g.dart';

@JsonSerializable()
class LatestDailyResp {
  @JsonKey(name: 'top_stories')
  List<DailyItem> topStories;
  List<DailyItem> stories;

  LatestDailyResp(this.topStories, this.stories);

  factory LatestDailyResp.fromJson(Map<String, dynamic> json) =>
      _$LatestDailyRespFromJson(json);
}
