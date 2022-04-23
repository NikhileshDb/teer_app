// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TeerResult {
  int? firstRound;
  int? secondRound;
  DateTime date;
  String provider;
  TeerResult({
    this.firstRound,
    this.secondRound,
    required this.date,
    required this.provider,
  });

  TeerResult copyWith({
    int? firstRound,
    int? secondRound,
    DateTime? date,
    String? provider,
  }) {
    return TeerResult(
      firstRound: firstRound ?? this.firstRound,
      secondRound: secondRound ?? this.secondRound,
      date: date ?? this.date,
      provider: provider ?? this.provider,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstRound': firstRound,
      'secondRound': secondRound,
      'date': date,
      'provider': provider,
    };
  }

  factory TeerResult.fromMap(Map<String, dynamic> map) {
    return TeerResult(
      firstRound: map['firstRound'] != null ? map['firstRound'] as int : null,
      secondRound:
          map['secondRound'] != null ? map['secondRound'] as int : null,
      date: DateTime.parse(map['date']),
      provider: map['provider'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeerResult.fromJson(String source) =>
      TeerResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeerResult(firstRound: $firstRound, secondRound: $secondRound, date: $date, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeerResult &&
        other.firstRound == firstRound &&
        other.secondRound == secondRound &&
        other.date == date &&
        other.provider == provider;
  }

  @override
  int get hashCode {
    return firstRound.hashCode ^
        secondRound.hashCode ^
        date.hashCode ^
        provider.hashCode;
  }
}
