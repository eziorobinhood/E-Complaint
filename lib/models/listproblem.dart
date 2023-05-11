import 'dart:convert';
import 'package:ecomplaint/services/problems.dart';
import 'package:http/http.dart' as http;

class ProblemsList {
  final String problem;
  final String problemtype;
  final String problemlocation;
  final String problemimage;

  ProblemsList(
      this.problem, this.problemtype, this.problemlocation, this.problemimage);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'problem': problem,
      'problemtype': problemtype,
      'problemlocation': problemlocation,
      'problemimage': problemimage,
    };
  }

  Future<ProblemsList> fetchProblems() async {
    final res = await http
        .get(Uri.parse("http://192.168.229.202:3000/problems/getallproblems"));
    if (res.statusCode == 200) {
      return ProblemsList.fromJson(jsonDecode(res.body()));
    } else {
      throw Exception('Failed to load album');
    }
  }

  factory ProblemsList.fromMap(Map<String, dynamic> map) {
    return ProblemsList(
      map['problem'] as String,
      map['problemtype'] as String,
      map['problemlocation'] as String,
      map['problemimage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProblemsList.fromJson(String source) =>
      ProblemsList.fromMap(json.decode(source) as Map<String, dynamic>);
}
