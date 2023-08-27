import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentinstructor_app/all_courses_grid.dart';
import 'package:studentinstructor_app/components.dart';
import 'package:studentinstructor_app/course_videos_list.dart';
//import 'package:studentinstructor_app/course_videos_list.dart';

class CourseAssignments extends StatelessWidget {
  const CourseAssignments({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFDDCC),
        // drawer: Drawer(
        //   backgroundColor: Colors.white,
        //   child: Column(
        //     children: [
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           SizedBox(height: 30.0),
        //           // LogoutButton(),
        //           Container(
        //             height: 200.0,
        //             width: 200.0,
        //             padding: const EdgeInsets.all(16.0),
        //             // decoration: BoxDecoration(
        //             //   border: Border.all(),
        //             // ),
        //             child: const Text(
        //               'Hope! you had a great learning today.',
        //               style: TextStyle(color: Colors.black, fontSize: 25.0),
        //             ),
        //           ),
        //           SizedBox(height: 30.0),
        //           LogoutButton(),
        //           SizedBox(height: 30.0),
        //           TextButton(
        //               onPressed: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) => CourseVideosList(),
        //                 ));
        //               },
        //               child: Text('Back'))
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          title: Text('Course Assignments List'),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20.0,
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff102C57),
          iconTheme: IconThemeData(color: Colors.white, size: 35.0),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('assignments').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return AssignmemtQuestions(
                      assignmentList: documentSnapshot['title'],
                      assignmentQuest: documentSnapshot['question'],
                      assignmentDuedate: documentSnapshot['duedate'],
                      isweb: true);

                  // Text(documentSnapshot['course']);
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class AssignmemtQuestions extends StatefulWidget {
  final assignmentList;
  final assignmentQuest;
  final assignmentDuedate;
  final isweb;
  const AssignmemtQuestions(
      {super.key,
      this.assignmentList,
      this.isweb,
      this.assignmentQuest,
      this.assignmentDuedate});
  _AssignmemtQuestionsState createState() => _AssignmemtQuestionsState();
}

class _AssignmemtQuestionsState extends State<AssignmemtQuestions> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: widget.isweb
                ? EdgeInsets.only(top: 40.0)
                : EdgeInsets.only(top: 30.0),
            child: Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    border: Border.all(
                  style: BorderStyle.solid,
                  width: 2.0,
                  color: Colors.black,
                )),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Column(
                        children: [
                          Text(
                            'Title - ${widget.assignmentList.toString()}',
                            style: GoogleFonts.abel(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Question - ${widget.assignmentQuest.toString()}',
                            style: GoogleFonts.abel(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Due Date - ${widget.assignmentDuedate.toString()}',
                            style: GoogleFonts.abel(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          MaterialButton(
                            onPressed: () {
                              SubmitAssignment(context);
                            },
                            child: OpenSans(
                              text: "Submit Assignments",
                              size: 14.0,
                            ),
                            splashColor: Colors.grey,
                            color: Color(0xfff162451),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// submit assignment alert box
TextEditingController _fullName = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _courseName = TextEditingController();
TextEditingController _solution = TextEditingController();

final formkey = GlobalKey<FormState>();

SubmitAssignment(BuildContext context) {
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
                  text: "Full Name",
                  containerWidhth: width / 1,
                  hinttext: "Full Name",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 3) {
                      return "Please Enter Valid Name";
                    }
                  },
                  controller: _fullName,
                ),
                TextForm(
                  text: "Email",
                  containerWidhth: width / 1,
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
                  text: "Course Name",
                  containerWidhth: width / 1,
                  onChanged: (text) => null,
                  hinttext: "Selected Course Name",
                  validator: (text) {
                    if (text.toString().isEmpty) {
                      return "Please Enter Valid Name Of Course";
                    }
                  },
                  controller: _courseName,
                ),
                TextForm(
                  text: "Solution",
                  containerWidhth: width / 1,
                  onChanged: (text) => null,
                  hinttext: "Write Code",
                  validator: (text) {
                    if (text.toString().isEmpty) {
                      return "This feild is required";
                    }
                  },
                  controller: _solution,
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
                  if (await addData.addResponse(_fullName.text, _email.text,
                      _courseName.text, _solution.text)) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CourseAssignments(),
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
      FirebaseFirestore.instance.collection('assigmentByStudents');

  Future addResponse(
    final fullName,
    final email,
    final courseName,
    final solution,
  ) async {
    return respose
        .add({
          'full_name': fullName,
          'email': email,
          'course': courseName,
          'solution': solution
        })
        .then((value) => true)
        .catchError(
          (error) {
            return false;
          },
        );
  }
}
