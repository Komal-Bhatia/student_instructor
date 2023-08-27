import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studentinstructor_app/firebase_options.dart';
//import 'package:studentinstructor_app/login_handler.dart';
import 'package:studentinstructor_app/userType_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

String role = "";
String selectedCourse = '';
String userEmail = '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Student-Instructor-App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            backgroundColor: Colors.pinkAccent,
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xffFFDDCC)),
        //scaffoldBackgroundColor: const Color(0xfffbe4e8)),
        home: UserTypeLoginScreen());
  }
}
