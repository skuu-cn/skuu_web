import 'package:skuu/generated/json/base/json_field.dart';
import 'package:skuu/generated/json/huati_entity.g.dart';
import 'dart:convert';
export 'package:skuu/generated/json/huati_entity.g.dart';

@JsonSerializable()
class HuatiEntity {
	late int code;
	late String name;

	HuatiEntity();

	factory HuatiEntity.fromJson(Map<String, dynamic> json) => $HuatiEntityFromJson(json);

	Map<String, dynamic> toJson() => $HuatiEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}