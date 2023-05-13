// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ecomplaint/services/problems.dart';
import 'package:flutter/material.dart';

class ListProblems extends StatefulWidget {
  const ListProblems({Key? key}) : super(key: key);

  @override
  State<ListProblems> createState() => _ListProblemsState();
}

class ProblemList {
  final String problem;
  final String problemtype;
  final String problemlocation;
  final String problemimage;

  ProblemList(
      this.problem, this.problemtype, this.problemlocation, this.problemimage);
}

class _ListProblemsState extends State<ListProblems> {
  final Problems problemservices = Problems();
  String url = "http://192.168.43.163:3000/problems/getallproblems";
  @override
  void initState() {
    super.initState();
  }

  Future<List> fetchAllProblems() async {
    http.Response res = await http.get(Uri.parse(url));
    var responseData = json.decode(res.body);
    List addresslist = [];
    for (var problems in responseData) {
      addresslist.add(problems);
    }
    return addresslist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Problems"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: fetchAllProblems(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              String? selectedOption;
              List<String> options = [
                "Problem Status",
                "Unsolved",
                "Resources Assigned",
                "In progress",
                "Solved"
              ];
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) => ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  title: Text(
                    'Problem Type:${snapshot.data[index]['problemtype']}',
                    style: GoogleFonts.josefinSans(
                        fontSize: 20, color: Colors.black),
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Center(
                          child: Image.network(
                            '${snapshot.data[index]['problemurl']}',
                            width: 400,
                            height: 200,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Problem Description:  ${snapshot.data[index]['problem']}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Problem Location:   ${snapshot.data[index]['problemlocation']}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.black),
                        ),
                        Row(
                          children: [
                            Text("Status of the Problem",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.black)),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              height: 50,
                              width: 200,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 48, 48, 48),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(50)),
                                child: DropdownButtonFormField(
                                  alignment: Alignment.center,
                                  elevation: 20,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none),
                                  value: selectedOption,
                                  items: options.map((String option) {
                                    return DropdownMenuItem(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedOption = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_upward_outlined),
                              label: Text("Upvote"),
                            ),
                            FloatingActionButton.extended(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_downward_outlined),
                              label: Text("0"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
