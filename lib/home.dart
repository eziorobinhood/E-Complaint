import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

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
        title: Text("E-Complaint"),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Raise Complaint here",
            style: Theme.of(context).textTheme.headline3,
          ),
          Container(
            padding: EdgeInsets.all(50),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.report_problem_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  labelText: "Problem Description"),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                myAlert();
              },
              child: Text(
                "Upload Image",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(40),
            child: ElevatedButton(
              child: Text("Submit"),
              onPressed: () {
                SnackBar snackBar = SnackBar(
                  content: Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                      ),
                      Text(
                        "   Problem Submitted",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  backgroundColor: Color.fromARGB(111, 0, 0, 0),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          )
        ],
      )),
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
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ImageSource.gallery);
                      },
                      child: Text(
                        "From Gallery",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(25),
                    child: ElevatedButton(
                      child: Text("From Camera"),
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ImageSource.camera);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
