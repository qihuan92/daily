import 'package:daily/model/daily_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'before_resp.g.dart';

@JsonSerializable()
class BeforeResp {
  String date;

  List<DailyItem> stories;

  BeforeResp(this.date, this.stories);

  factory BeforeResp.fromJson(Map<String, dynamic> json) =>
      _$BeforeRespFromJson(json);
}