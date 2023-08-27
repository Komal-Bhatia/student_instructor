import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studentinstructor_app/components.dart';
import 'package:studentinstructor_app/course_details_screen.dart';
import 'package:studentinstructor_app/enrolledCourseDetails.dart';
import 'package:studentinstructor_app/view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class AllCoursesGrid extends StatelessWidget {
  const AllCoursesGrid({super.key});
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
              Text('Hello Learner'),
              SizedBox(height: 15.0),
              EnrolledCourses(),
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
        body: ScreenTypeLayout(
          mobile: _responsive(2), // 2 items per row on mobile
          tablet: _responsive(4), // 3 items per row on tablet
          desktop: _responsive(6), // 6 items per row on desktop
        ));
  }

  Widget _responsive(int crossAxisCount) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('courses').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount),
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
                                  fontWeight: FontWeight.bold, fontSize: 11.0)),
                          Text('Rs. ${courseDetails["price"]}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11.0)),
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
    );
  }
}

class LogoutButton extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    return Center(
      child: SizedBox(
        height: 50.0,
        width: 150.0,
        child: MaterialButton(
          child: OpenSans(
            text: "Logout",
            size: 20.0,
          ),
          splashColor: Colors.grey,
          color: Color(0xfff162451),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () async {
            await viewModelProvide.logout();
          },
        ),
      ),
    );
  }
}

class Courses extends StatefulWidget {
  final name;
  final duration;
  final description;
  final image;
  final price;
  final isweb;
  const Courses(
      {Key? key,
      required this.name,
      required this.duration,
      required this.image,
      this.description,
      this.price,
      this.isweb})
      : super(key: key);
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isweb ? EdgeInsets.all(10.0) : EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
              style: BorderStyle.solid, width: 5.0, color: Color(0xff976c80)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    // color: Colors.limeAccent,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Column(
                    children: [
                      Image.network(widget.image, height: 50.0, width: 50.0),
                      Text(widget.name.toString(),
                          style: GoogleFonts.abel(
                            fontSize: 15.0,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7.0,
            ),
            Text(
              widget.duration.toString(),
              style: GoogleFonts.openSans(fontSize: 15.0),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              widget.price.toString(),
              style: GoogleFonts.openSans(fontSize: 15.0),
            )
            // Text(
            //   widget.description.toString(),
            //   style: GoogleFonts.openSans(fontSize: 5.0),
            //   maxLines: expand == true ? null : 3,
            //   overflow:
            //       expand == true ? TextOverflow.visible : TextOverflow.ellipsis,
            // )
          ],
        ),
      ),
    );
  }
}

class EnrolledCourses extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    return Center(
      child: SizedBox(
        height: 90.0,
        width: 150.0,
        child: MaterialButton(
          child: OpenSans(
            text: "Enrolled Course",
            size: 20.0,
          ),
          splashColor: Colors.grey,
          color: Color(0xfff162451),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EnrolledCourseMaterial()),
            );
          },
        ),
      ),
    );
  }
}
