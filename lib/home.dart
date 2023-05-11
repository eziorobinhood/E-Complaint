import 'package:ecomplaint/common/widgets/custom_button.dart';
import 'package:ecomplaint/pages/list.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ecomplaint/services/problems.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'constants/utils.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //Geolocator code goes here:

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  TextEditingController problemcontroller = TextEditingController();
  final Problems problems = Problems();
  XFile? image;
  String? _selectedOption;
  final ImagePicker picker = ImagePicker();
  final List<String> _options = [
    'Garbage',
    'Pothole',
    'Transportation',
    'Drainage',
    'Pipeline',
    'Electricity',
    'Traffic'
  ];
  void uploadProblems() {
    problems.ProblemUploader(
        context: context,
        problem: problemcontroller.text,
        problemtype: _selectedOption!,
        problemlocation: _currentAddress ?? "",
        image: image!);
    print(problemcontroller.text);
    print(_selectedOption);
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
                hint: Text("Select the type of problem"),
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
                  _getCurrentPosition();
                  if (_currentAddress == null || _currentAddress == "") {
                    showSnackbar(context, "Again Press submit");
                  } else {
                    uploadProblems();
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: CustomButton(
                  text: "View all",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ListProblems()));
                  }),
            ),
            Text('ADDRESS: ${_currentAddress ?? ""}'),
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
