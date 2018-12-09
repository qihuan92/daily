import 'package:json_annotation/json_annotation.dart';

part 'daily_item.g.dart';

@JsonSerializable()
class DailyItem {
  int id;
  String title;
  String image;
  List<String> images;

  DailyItem(this.id, this.title, this.image, this.images);

  factory DailyItem.fromJson(Map<String, dynamic> json) =>
      _$DailyItemFromJson(json);
}
