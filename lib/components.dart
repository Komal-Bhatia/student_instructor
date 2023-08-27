// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentinstructor_app/enrolledCourseDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSans extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontweight;
  final alignment;
  const OpenSans(
      {super.key,
      this.text,
      this.size,
      this.fontweight,
      this.color,
      this.alignment});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == null ? TextAlign.center : alignment,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color == null ? Colors.white : color,
        fontWeight: fontweight == null ? FontWeight.normal : fontweight,
      ),
    );
  }
}

DialogBox(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Color(0xff102C57),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 2.0),
      ),
      title: OpenSans(
        text: title,
        size: 20.0,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: OpenSans(
            text: "Ok",
            size: 20.0,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}

//Social Media Links in Drawer Widget
class SocialMediaUrls extends StatelessWidget {
  final imagepath;
  final url;
  const SocialMediaUrls({Key? key, required this.imagepath, required this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await launchUrl(Uri.parse(url));
      },
      icon: SvgPicture.asset(imagepath, width: 40.0),
    );
  }
}

class TextForm extends StatefulWidget {
  final text;

  final containerWidhth;

  final hinttext;

  final controller;

  final validator;

  final Function(String text) onChanged;

  const TextForm(
      {super.key,
      required this.text,
      required this.containerWidhth,
      required this.hinttext,
      this.controller,
      this.validator,
      required this.onChanged});

  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: widget.containerWidhth,
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            validator: widget.validator,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: widget.hinttext,
            ),
          ),
        )
      ],
    );
  }
}

TextEditingController _firstName = TextEditingController();
TextEditingController _lastName = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _mobilePhone = TextEditingController();
TextEditingController _courseName = TextEditingController();

final formkey = GlobalKey<FormState>();

ShowDialog(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: width / 1.5,
        child: AlertDialog(
          title: const Text('Enter Details'),
          content: Form(
            key: formkey,
            child: Column(
              children: [
                TextForm(
                  text: "First Name",
                  containerWidhth: width / 3,
                  hinttext: "First Name",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 3) {
                      return "Please Enter Valid Name";
                    }
                  },
                  controller: _firstName,
                ),
                TextForm(
                  text: "Last Name",
                  containerWidhth: width / 3,
                  hinttext: "Last Name",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 3) {
                      return "Please Enter Valid Name";
                    }
                  },
                  controller: _lastName,
                ),
                TextForm(
                  text: "Email",
                  containerWidhth: width / 3,
                  onChanged: (text) => null,
                  hinttext: "Email Id",
                  validator: (text) {
                    if (text.toString().isEmpty ||
                        !text.toString().contains("@gmail.com")) {
                      return "Please Enter Valid Email";
                    }
                  },
                  controller: _email,
                ),
                TextForm(
                  text: "Mobile Number",
                  containerWidhth: width / 3,
                  onChanged: (text) => null,
                  hinttext: "Mobile Number",
                  validator: (text) {
                    if (text.toString().isEmpty ||
                        text.toString().length < 10) {
                      return "Please Enter Valid Mobile Number";
                    }
                  },
                  controller: _mobilePhone,
                ),
                TextForm(
                  text: "Course Name",
                  containerWidhth: width / 3,
                  onChanged: (text) => null,
                  hinttext: "Selected Course Name",
                  validator: (text) {
                    if (text.toString().isEmpty) {
                      return "Please Enter Valid Name Of Course";
                    }
                  },
                  controller: _courseName,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final addData = AddDataFireStore();
                if (formkey.currentState!.validate()) {
                  if (await addData.addResponse(_firstName.text, _lastName.text,
                      _email.text, _mobilePhone.text, _courseName.text)) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EnrolledCourseMaterial(),
                    ));

                    formkey.currentState!.reset();
                  } else {
                    DialogBox(
                        context, 'Please Check Validations and Fill Again');
                  }
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      );
    },
  );
}

class AddDataFireStore {
  CollectionReference respose =
      FirebaseFirestore.instance.collection('studentsInfoAfterEnrolled');

  Future addResponse(
    final firstName,
    final lastName,
    final email,
    final number,
    final courseName,
  ) async {
    return respose
        .add({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'number': number,
          'course': courseName,
        })
        .then((value) => true)
        .catchError(
          (error) {
            return false;
          },
        );
  }
}
