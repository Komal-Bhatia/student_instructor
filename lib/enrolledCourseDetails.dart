import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentinstructor_app/all_courses_grid.dart';
import 'package:studentinstructor_app/course_assignments.dart';
import 'package:studentinstructor_app/course_videos_list.dart';

import 'components.dart';

class EnrolledCourseMaterial extends StatefulWidget {
  const EnrolledCourseMaterial({super.key});
  _EnrolledCourseMaterialState createState() => _EnrolledCourseMaterialState();
}

String courseName = '';

class _EnrolledCourseMaterialState extends State<EnrolledCourseMaterial> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color(0xffFFDDCC),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.0),
                // LogoutButton(),
                Container(
                  height: 200.0,
                  width: 200.0,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Hope! you had a great learning today.',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
                SizedBox(height: 30.0),
                // LogoutButton(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Back'))
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Selected Course'),
            titleTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20.0,
            ),
            centerTitle: true,
            backgroundColor: const Color(0xff102C57),
            iconTheme: IconThemeData(color: Colors.white, size: 35.0),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('studentsInfoAfterEnrolled')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return SelectedCourses(
                        enrolledCourseList: documentSnapshot['course'],
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
          )),
    );
  }
}

class SelectedCourses extends StatefulWidget {
  final enrolledCourseList;
  final isweb;
  const SelectedCourses(
      {super.key, required this.enrolledCourseList, this.isweb});
  _SelectedCoursesState createState() => _SelectedCoursesState();
}

class _SelectedCoursesState extends State<SelectedCourses> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isweb
          ? EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0)
          : EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: Border.all(
          style: BorderStyle.solid,
          width: 2.0,
          color: Colors.black,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(3.0)),
                  child: Text(
                    widget.enrolledCourseList.toString(),
                    style: GoogleFonts.abel(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 30.0,
                  width: 100.0,
                  child: MaterialButton(
                      child: OpenSans(
                        text: "Videos",
                        size: 14.0,
                      ),
                      splashColor: Colors.grey,
                      color: Color(0xfff162451),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CourseVideosList()),
                        );
                      }),
                ),
                SizedBox(
                  height: 30.0,
                  width: 100.0,
                  child: MaterialButton(
                      child: OpenSans(
                        text: "Assignments",
                        size: 14.0,
                      ),
                      splashColor: Colors.grey,
                      color: Color(0xfff162451),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CourseAssignments()),
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
