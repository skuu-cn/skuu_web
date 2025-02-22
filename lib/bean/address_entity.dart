import 'dart:convert';

import 'package:skuu/generated/json/address_entity.g.dart';
import 'package:skuu/generated/json/base/json_field.dart';

export 'package:skuu/generated/json/address_entity.g.dart';

@JsonSerializable()
class AddressEntity {
	late int id;
	late String name;
	late String distance;
	late String detail;

	AddressEntity();

	factory AddressEntity.fromJson(Map<String, dynamic> json) => $AddressEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddressEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}