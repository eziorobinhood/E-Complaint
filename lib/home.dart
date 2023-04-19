import 'package:ecomplaint/common/widgets/custom_button.dart';
import 'package:ecomplaint/pages/listproblems.dart';
import 'package:ecomplaint/services/problems.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController problemcontroller = TextEditingController();
  final Problems problems = Problems();
  XFile? image;
  String? _selectedOption;
  final ImagePicker picker = ImagePicker();
  List<String> _options = [
    'Garbage',
    'Pothole',
    'Transportation',
    'Drainage',
    'Pipeline',
    'Electricity',
    'Traffic'
  ];
  void uploadProblems() {
    problems.ProblemUploader(context: context, problem: problemcontroller.text);
    print(problemcontroller.text);
  }

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Submission"),
        leading: null,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
              child: Text(
                "Raise Complaint here",
                style: GoogleFonts.poppins(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * .1,
                  10,
                  MediaQuery.of(context).size.width * .1,
                  0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90.0),
                )),
                value: _selectedOption,
                items: _options.map((String option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * .1,
                  10,
                  MediaQuery.of(context).size.width * .1,
                  0),
              child: TextFormField(
                controller: problemcontroller,
                autofocus: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                    labelText: "Problem Description"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
                text: "Upload Image",
                onTap: () {
                  myAlert();
                }),
            SizedBox(
              height: 10,
            ),
            Container(
              child: CustomButton(
                text: "Submit",
                onTap: () {
                  uploadProblems();
                },
              ),
            )
          ],
        )),
      ),
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(25),
                      child: CustomButton(
                          text: "From Gallery",
                          onTap: () {
                            Navigator.pop(context);
                            getImage(ImageSource.gallery);
                          })),
                  Container(
                      margin: EdgeInsets.all(25),
                      child: CustomButton(
                          text: "From Camera",
                          onTap: () {
                            Navigator.pop(context);
                            getImage(ImageSource.camera);
                          })),
                ],
              ),
            ),
          );
        });
  }
}
