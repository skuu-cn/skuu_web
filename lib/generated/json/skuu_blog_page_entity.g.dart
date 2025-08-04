import 'package:skuu/generated/json/base/json_convert_content.dart';
import 'package:skuu/app/data/models/skuu_blog_page_entity.dart';

SkuuBlogPageEntity $SkuuBlogPageEntityFromJson(Map<String, dynamic> json) {
  final SkuuBlogPageEntity skuuBlogPageEntity = SkuuBlogPageEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    skuuBlogPageEntity.code = code;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    skuuBlogPageEntity.message = message;
  }
  final SkuuBlogPageData? data = jsonConvert.convert<SkuuBlogPageData>(
      json['data']);
  if (data != null) {
    skuuBlogPageEntity.data = data;
  }
  return skuuBlogPageEntity;
}

Map<String, dynamic> $SkuuBlogPageEntityToJson(SkuuBlogPageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['data'] = entity.data.toJson();
  return data;
}

extension SkuuBlogPageEntityExtension on SkuuBlogPageEntity {
  SkuuBlogPageEntity copyWith({
    int? code,
    String? message,
    SkuuBlogPageData? data,
  }) {
    return SkuuBlogPageEntity()
      ..code = code ?? this.code
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

SkuuBlogPageData $SkuuBlogPageDataFromJson(Map<String, dynamic> json) {
  final SkuuBlogPageData skuuBlogPageData = SkuuBlogPageData();
  final List<SkuuBlogPageDataRecords>? records = (json['records'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<SkuuBlogPageDataRecords>(
          e) as SkuuBlogPageDataRecords).toList();
  if (records != null) {
    skuuBlogPageData.records = records;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    skuuBlogPageData.total = total;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    skuuBlogPageData.size = size;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    skuuBlogPageData.current = current;
  }
  final List<dynamic>? orders = (json['orders'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (orders != null) {
    skuuBlogPageData.orders = orders;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    skuuBlogPageData.optimizeCountSql = optimizeCountSql;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    skuuBlogPageData.searchCount = searchCount;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    skuuBlogPageData.pages = pages;
  }
  return skuuBlogPageData;
}

Map<String, dynamic> $SkuuBlogPageDataToJson(SkuuBlogPageData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['records'] = entity.records.map((v) => v.toJson()).toList();
  data['total'] = entity.total;
  data['size'] = entity.size;
  data['current'] = entity.current;
  data['orders'] = entity.orders;
  data['optimizeCountSql'] = entity.optimizeCountSql;
  data['searchCount'] = entity.searchCount;
  data['pages'] = entity.pages;
  return data;
}

extension SkuuBlogPageDataExtension on SkuuBlogPageData {
  SkuuBlogPageData copyWith({
    List<SkuuBlogPageDataRecords>? records,
    String? total,
    String? size,
    String? current,
    List<dynamic>? orders,
    bool? optimizeCountSql,
    bool? searchCount,
    String? pages,
  }) {
    return SkuuBlogPageData()
      ..records = records ?? this.records
      ..total = total ?? this.total
      ..size = size ?? this.size
      ..current = current ?? this.current
      ..orders = orders ?? this.orders
      ..optimizeCountSql = optimizeCountSql ?? this.optimizeCountSql
      ..searchCount = searchCount ?? this.searchCount
      ..pages = pages ?? this.pages;
  }
}

SkuuBlogPageDataRecords $SkuuBlogPageDataRecordsFromJson(
    Map<String, dynamic> json) {
  final SkuuBlogPageDataRecords skuuBlogPageDataRecords = SkuuBlogPageDataRecords();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    skuuBlogPageDataRecords.id = id;
  }
  final String? squareId = jsonConvert.convert<String>(json['squareId']);
  if (squareId != null) {
    skuuBlogPageDataRecords.squareId = squareId;
  }
  final int? topicId = jsonConvert.convert<int>(json['topicId']);
  if (topicId != null) {
    skuuBlogPageDataRecords.topicId = topicId;
  }
  final int? categary = jsonConvert.convert<int>(json['categary']);
  if (categary != null) {
    skuuBlogPageDataRecords.categary = categary;
  }
  final int? blogType = jsonConvert.convert<int>(json['blogType']);
  if (blogType != null) {
    skuuBlogPageDataRecords.blogType = blogType;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    skuuBlogPageDataRecords.content = content;
  }
  final String? resources = jsonConvert.convert<String>(json['resources']);
  if (resources != null) {
    skuuBlogPageDataRecords.resources = resources;
  }
  final int? shareType = jsonConvert.convert<int>(json['shareType']);
  if (shareType != null) {
    skuuBlogPageDataRecords.shareType = shareType;
  }
  final bool? deleted = jsonConvert.convert<bool>(json['deleted']);
  if (deleted != null) {
    skuuBlogPageDataRecords.deleted = deleted;
  }
  final String? creator = jsonConvert.convert<String>(json['creator']);
  if (creator != null) {
    skuuBlogPageDataRecords.creator = creator;
  }
  final String? updater = jsonConvert.convert<String>(json['updater']);
  if (updater != null) {
    skuuBlogPageDataRecords.updater = updater;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    skuuBlogPageDataRecords.createTime = createTime;
  }
  final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
  if (updateTime != null) {
    skuuBlogPageDataRecords.updateTime = updateTime;
  }
  return skuuBlogPageDataRecords;
}

Map<String, dynamic> $SkuuBlogPageDataRecordsToJson(
    SkuuBlogPageDataRecords entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['squareId'] = entity.squareId;
  data['topicId'] = entity.topicId;
  data['categary'] = entity.categary;
  data['blogType'] = entity.blogType;
  data['content'] = entity.content;
  data['resources'] = entity.resources;
  data['shareType'] = entity.shareType;
  data['deleted'] = entity.deleted;
  data['creator'] = entity.creator;
  data['updater'] = entity.updater;
  data['createTime'] = entity.createTime;
  data['updateTime'] = entity.updateTime;
  return data;
}

extension SkuuBlogPageDataRecordsExtension on SkuuBlogPageDataRecords {
  SkuuBlogPageDataRecords copyWith({
    String? id,
    String? squareId,
    int? topicId,
    int? categary,
    int? blogType,
    String? content,
    String? resources,
    int? shareType,
    bool? deleted,
    String? creator,
    String? updater,
    String? createTime,
    String? updateTime,
  }) {
    return SkuuBlogPageDataRecords()
      ..id = id ?? this.id
      ..squareId = squareId ?? this.squareId
      ..topicId = topicId ?? this.topicId
      ..categary = categary ?? this.categary
      ..blogType = blogType ?? this.blogType
      ..content = content ?? this.content
      ..resources = resources ?? this.resources
      ..shareType = shareType ?? this.shareType
      ..deleted = deleted ?? this.deleted
      ..creator = creator ?? this.creator
      ..updater = updater ?? this.updater
      ..createTime = createTime ?? this.createTime
      ..updateTime = updateTime ?? this.updateTime;
  }
}