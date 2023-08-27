import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentinstructor_app/components.dart';
import 'package:studentinstructor_app/teacherHomePage.dart';
import 'package:intl/intl.dart';

class TeacherCourseSelected extends StatelessWidget {
  const TeacherCourseSelected({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tata Neu'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20.0,
        ),
        centerTitle: true,
        // backgroundColor: const Color(0xfff162451),
        backgroundColor: const Color(0xff102C57),
        iconTheme: IconThemeData(color: Colors.white, size: 35.0),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Hello Teacher',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 90.0,
                width: 150.0,
                child: MaterialButton(
                  child: OpenSans(
                    text: "Upload Videos",
                    size: 20.0,
                  ),
                  splashColor: Colors.grey,
                  color: Color(0xfff162451),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    UploadVideoDialog(context);
                  },
                ),
              ),
              SizedBox(
                height: 90.0,
                width: 150.0,
                child: MaterialButton(
                  child: OpenSans(
                    text: "Upload Assignments",
                    size: 20.0,
                  ),
                  splashColor: Colors.grey,
                  color: Color(0xfff162451),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    UploadAssignmentDialog(context);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// Upload Assignment Form
TextEditingController _title = TextEditingController();
TextEditingController _question = TextEditingController();
TextEditingController _dateInputController = TextEditingController();

final formkey = GlobalKey<FormState>();

UploadAssignmentDialog(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: width / 3.5,
        child: AlertDialog(
          title: const Text('Enter Assignment Details'),
          content: Form(
            key: formkey,
            child: Column(
              children: [
                TextForm(
                  text: "",
                  containerWidhth: width / 1,
                  hinttext: "Assignment Title",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 3) {
                      return "Please Enter Title";
                    }
                  },
                  controller: _title,
                ),
                TextForm(
                  text: "",
                  containerWidhth: width / 1,
                  hinttext: "Enter Question",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 3) {
                      return "Please Enter Valid Input";
                    }
                  },
                  controller: _question,
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Due Date',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff102C57), width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff102C57), width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff102C57), width: 1)),
                  ),
                  controller: _dateInputController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2050));

                    if (pickedDate != null) {
                      _dateInputController.text = pickedDate.toString();
                    }
                  },
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
                  if (await addData.addResponse(
                      _title.text, _question.text, _dateInputController.text)) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TeacherHomePage(),
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
      FirebaseFirestore.instance.collection('assignments');

  Future addResponse(
    final title,
    final question,
    final duedate,
  ) async {
    return respose
        .add({
          'title': title,
          'question': question,
          'duedate': duedate,
        })
        .then((value) => true)
        .catchError(
          (error) {
            return false;
          },
        );
  }
}

// upload video link
TextEditingController _videoTitle = TextEditingController();
TextEditingController _link = TextEditingController();

final formkeey = GlobalKey<FormState>();

UploadVideoDialog(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: width / 3.5,
        child: AlertDialog(
          title: const Text('Enter Assignment Details'),
          content: Form(
            key: formkey,
            child: Column(
              children: [
                TextForm(
                  text: "",
                  containerWidhth: width / 1,
                  hinttext: "Video Title",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 3) {
                      return "Please Enter Title";
                    }
                  },
                  controller: _videoTitle,
                ),
                TextForm(
                  text: "",
                  containerWidhth: width / 1,
                  hinttext: "Video Link",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 3) {
                      return "Please Enter Valid Input";
                    }
                  },
                  controller: _link,
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
                final addData = UploadDataFireStore();
                if (formkey.currentState!.validate()) {
                  if (await addData.addResponse(_videoTitle.text, _link.text)) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TeacherHomePage(),
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

class UploadDataFireStore {
  CollectionReference respose = FirebaseFirestore.instance.collection('video');

  Future addResponse(
    final videoTitle,
    final link,
  ) async {
    return respose
        .add({
          'title': videoTitle,
          'link': link,
        })
        .then((value) => true)
        .catchError(
          (error) {
            return false;
          },
        );
  }
}
