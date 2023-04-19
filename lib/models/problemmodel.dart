import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Problemstatement {
  final String problem;
  Problemstatement({
    required this.problem,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'problem': problem,
    };
  }

  factory Problemstatement.fromMap(Map<String, dynamic> map) {
    return Problemstatement(
      problem: map['problem'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Problemstatement.fromJson(String source) =>
      Problemstatement.fromMap(json.decode(source) as Map<String, dynamic>);
}
