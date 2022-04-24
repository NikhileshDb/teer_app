import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommonNumberModel {
  final List<dynamic> commonNumber;
  final String provider;
  final DateTime date;
  final int house;
  final int ending;
  CommonNumberModel({
    required this.commonNumber,
    required this.provider,
    required this.date,
    required this.house,
    required this.ending,
  });

  CommonNumberModel copyWith({
    List<dynamic>? commonNumber,
    String? provider,
    DateTime? date,
    int? house,
    int? ending,
  }) {
    return CommonNumberModel(
      commonNumber: commonNumber ?? this.commonNumber,
      provider: provider ?? this.provider,
      date: date ?? this.date,
      house: house ?? this.house,
      ending: ending ?? this.ending,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commonNumber': commonNumber,
      'provider': provider,
      'date': date,
      'house': house,
      'ending': ending,
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
      house: map['house'] as int,
      ending: map['ending'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommonNumberModel.fromJson(String source) =>
      CommonNumberModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommonNumberModel(commonNumber: $commonNumber, provider: $provider, date: $date, house: $house, ending: $ending)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommonNumberModel &&
        listEquals(other.commonNumber, commonNumber) &&
        other.provider == provider &&
        other.date == date &&
        other.house == house &&
        other.ending == ending;
  }

  @override
  int get hashCode {
    return commonNumber.hashCode ^
        provider.hashCode ^
        date.hashCode ^
        house.hashCode ^
        ending.hashCode;
  }
}
