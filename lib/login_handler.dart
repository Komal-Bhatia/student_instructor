import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studentinstructor_app/all_courses_grid.dart';
import 'package:studentinstructor_app/login_view.dart';
import 'package:studentinstructor_app/main.dart';
import 'package:studentinstructor_app/teacherHomePage.dart';
import 'package:studentinstructor_app/teacherLoginView.dart';
import 'package:studentinstructor_app/userType_login.dart';
import 'package:studentinstructor_app/view_model.dart';

class LoginHandler extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);

    return _authState.when(
      data: (data) {
        if (data != null) {
          if (role == "student") {
            return AllCoursesGrid();
          } else if (role == "teacher") {
            return TeacherHomePage();
            //return TutorHomeScreen();
          } else {
            return UserTypeLoginScreen();
          }
        } else {
          if (role == "student") {
            return LoginView();
          } else if (role == "teacher") {
            return TeacherLoginView();
          } else {
            return UserTypeLoginScreen();
          }
        }
      },
      error: (error, stackTrace) {
        return UserTypeLoginScreen();
      },
      loading: () => CircularProgressIndicator(),
    );
  }
}
