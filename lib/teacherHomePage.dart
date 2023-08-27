import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studentinstructor_app/all_courses_grid.dart';
import 'package:studentinstructor_app/components.dart';
import 'package:studentinstructor_app/course_details_screen.dart';
import 'package:studentinstructor_app/teacher_selected_course.dart';
import 'package:studentinstructor_app/view_model.dart';

String selectedCourseName = '';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 72.0,
              backgroundColor: Color(0xfff162451),
              child: CircleAvatar(
                radius: 70.0,
                backgroundColor: Color(0xfff162451),
                backgroundImage: AssetImage('assets/dummy.jpg'),
              ),
            ),
            SizedBox(height: 15.0),
            Text('Hello Teacher'),
            SizedBox(height: 15.0),
            SelectedCourseButton(),
            SizedBox(height: 30.0),
            LogoutButton(),
          ],
        ),
      ),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('courses').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: ((BuildContext context, index) {
                final courseDetails = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => CourseDetailsScreen(
                                name: courseDetails['courseName'],
                                duration: courseDetails['duration'],
                                description: courseDetails['description'],
                                image: courseDetails['image'],
                                price: courseDetails['price'],
                              )),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Hero(
                            tag: courseDetails['courseName'],
                            child: Image.network(courseDetails['image']),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          courseDetails['courseName'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(courseDetails['duration'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0)),
                            TextButton(
                              onPressed: () {
                                ShowDialog(context);
                              },
                              child: Text(
                                'Select',
                                style: TextStyle(color: Colors.pinkAccent),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          ;
        },
      ),
    );
  }
}

TextEditingController _name = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _phone = TextEditingController();
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
                  text: "Full Name",
                  containerWidhth: width / 3,
                  hinttext: "Full Name",
                  onChanged: (text) => null,
                  validator: (text) {
                    if (text.toString().isEmpty || text.toString().length < 3) {
                      return "Please Enter Valid Name";
                    }
                  },
                  controller: _name,
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
                  controller: _phone,
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
                  if (await addData.addResponse(
                      _name.text, _email.text, _phone.text, _courseName.text)) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TeacherCourseSelected(),
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
      FirebaseFirestore.instance.collection('teacherSlectedCourse');

  Future addResponse(
    final name,
    final email,
    final phone,
    final courseName,
  ) async {
    return respose
        .add({
          'name': name,
          'email': email,
          'phone': phone,
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

class SelectedCourseButton extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    return Center(
      child: SizedBox(
        height: 50.0,
        width: 150.0,
        child: MaterialButton(
          child: OpenSans(
            text: "Your Course",
            size: 20.0,
          ),
          splashColor: Colors.grey,
          color: Color(0xfff162451),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TeacherCourseSelected(),
            ));
          },
        ),
      ),
    );
  }
}
