import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Problemstatement {
  final String problem;
  final String problemtype;
  final String problemlocation;
  final String problemimage;
  Problemstatement({
    required this.problem,
    required this.problemtype,
    required this.problemlocation,
    required this.problemimage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'problem': problem,
      'problemtype': problemtype,
      'problemlocation': problemlocation,
      'problemurl': problemimage,
    };
  }

  factory Problemstatement.fromMap(Map<String, dynamic> map) {
    return Problemstatement(
      problem: map['problem'] as String,
      problemtype: map['problemtype'] as String,
      problemlocation: map['problemlocation'] as String,
      problemimage: map['problemurl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Problemstatement.fromJson(String source) =>
      Problemstatement.fromMap(json.decode(source) as Map<String, dynamic>);
}
