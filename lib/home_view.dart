import 'dart:html';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:studentinstructor_app/all_courses_grid.dart';
import 'package:studentinstructor_app/components.dart';
import 'package:studentinstructor_app/view_model.dart';

class HomeView extends HookConsumerWidget {
  int _page = 0;
  List<Widget> screen = [const AllCoursesGrid(), Text('Enrolled Course(s)')];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            Text('UserName'),
            SizedBox(height: 15.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SocialMediaUrls(
            //         imagepath: "assets/instagram-2-1-logo-svgrepo-com.svg",
            //         url: 'https://instagram.com'),
            //     SocialMediaUrls(
            //         imagepath: "assets/linkedin-icon-2-logo-svgrepo-com.svg",
            //         url: 'https://linkedin.com'),
            //     SocialMediaUrls(
            //         imagepath: "assets/brand-github-svgrepo-com.svg",
            //         url: 'https://github.com'),
            //   ],
            // ),
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
        backgroundColor: const Color(0xfff162451),
        iconTheme: IconThemeData(color: Colors.white, size: 35.0),
      ),
      body: screen[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: (index) {
          // setState((){
          _page = index;
          // });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, color: Colors.white), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_sharp, color: Colors.white), label: ''),
        ],
        backgroundColor: Color(0xfff162451),
      ),
    );
  }
}

class LogoutButton extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    return GridView.count(
      crossAxisCount: 2,
      children: [
        Center(
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
        ),
      ],
    );
  }
}
