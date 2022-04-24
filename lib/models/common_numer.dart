import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommonNumberModel {
  final List<dynamic> commonNumber;
  final String provider;
  final DateTime date;
  CommonNumberModel({
    required this.commonNumber,
    required this.provider,
    required this.date,
  });

  CommonNumberModel copyWith({
    List<int>? commonNumber,
    String? provider,
    DateTime? date,
  }) {
    return CommonNumberModel(
      commonNumber: commonNumber ?? this.commonNumber,
      provider: provider ?? this.provider,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commonNumber': commonNumber,
      'provider': provider,
      'date': date,
    };
  }

  factory CommonNumberModel.fromMap(Map<String, dynamic> map) {
    List<String> newList = [];

    final list = map['commonNumber'];
    list.map((e) => newList.add(e.toString()));
    return CommonNumberModel(
      commonNumber: newList.map((e) => int.parse(e)).toList(),
      provider: map['provider'] as String,
      date: map['date'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommonNumberModel.fromJson(String source) =>
      CommonNumberModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CommonNumberModel(commonNumber: $commonNumber, provider: $provider, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommonNumberModel &&
        listEquals(other.commonNumber, commonNumber) &&
        other.provider == provider &&
        other.date == date;
  }

  @override
  int get hashCode => commonNumber.hashCode ^ provider.hashCode ^ date.hashCode;
}
