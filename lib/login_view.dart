import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studentinstructor_app/components.dart';
import 'package:studentinstructor_app/view_model.dart';
import 'package:sign_button/sign_button.dart';

class LoginView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: deviceHeight / 5.5,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/app_logo.jpg"),
                  radius: 70,
                ),
              ),
              // Image.asset(),
              SizedBox(height: 30.0),
              EmailandPasswordfeilds(),

              SizedBox(height: 15.0),
              RegisterAndLogin(),

              SizedBox(
                height: 15.0,
              ),
              SignInButton(
                buttonType: ButtonType.google,
                btnColor: Colors.black,
                btnTextColor: Colors.white,
                buttonSize: ButtonSize.medium,
                onPressed: () async {
                  viewModelProvide.signInWithGoogleWeb(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextEditingController _emailFeild = TextEditingController();
TextEditingController _passwordFeild = TextEditingController();

class EmailandPasswordfeilds extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    return Column(
      children: [
        //Email
        SizedBox(
          width: 350.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            controller: _emailFeild,
            onChanged: (value) {
              userEmail:
              _emailFeild.text;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              prefixIcon: Icon(Icons.email, color: Colors.black, size: 30.0),
              hintText: "Email",
              hintStyle: GoogleFonts.openSans(),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        //Password
        SizedBox(
          width: 350.0,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: _passwordFeild,
            obscureText: viewModelProvider.isObscure,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              prefixIcon: IconButton(
                onPressed: () {
                  viewModelProvider.toggelObscure();
                },
                icon: Icon(
                  viewModelProvider.isObscure
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
              hintText: "Password",
              hintStyle: GoogleFonts.openSans(),
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterAndLogin extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 50.0,
          width: 150.0,
          child: MaterialButton(
            child: OpenSans(
              text: "Register",
              size: 20.0,
            ),
            splashColor: Colors.grey,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () async {
              await viewModelProvide.createUserWithEmailAndPassword(
                  context, _emailFeild.text, _passwordFeild.text);
            },
          ),
        ),
        SizedBox(
          width: 7.0,
        ),
        Text(
          "OR",
          style: GoogleFonts.pacifico(fontSize: 14.0),
        ),
        SizedBox(
          width: 7.0,
        ),
        SizedBox(
          height: 50.0,
          width: 150.0,
          child: MaterialButton(
            child: OpenSans(
              text: "LOGIN",
              size: 20.0,
            ),
            splashColor: Colors.grey,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () async {
              viewModelProvide.signInWithEmailAndPassword(
                  context, _emailFeild.text, _passwordFeild.text);
            },
          ),
        ),
      ],
    );
  }
}
