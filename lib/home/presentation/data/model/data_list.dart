import 'package:json_annotation/json_annotation.dart';

part 'data_list.g.dart';

@JsonSerializable()
class DataList {
  final int? userId, id;
  final String? title, body;

  DataList({this.userId, this.id, this.title, this.body});

  factory DataList.fromJson(Map<String, dynamic> json) =>
      _$DataListFromJson(json);

  Map<String, dynamic> toJson() => _$DataListToJson(this);
}
