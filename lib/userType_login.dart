import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studentinstructor_app/login_handler.dart';
import 'package:studentinstructor_app/main.dart';
import 'package:studentinstructor_app/view_model.dart';
// import 'package:studentinstructor_app/view_model.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserTypeLoginScreen extends HookConsumerWidget {
  //final _authState = ref.watch(authStateProvider);
  const UserTypeLoginScreen({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final viewModelProvider = ref.watch(viewModel);
    useEffect(() {
      viewModelProvider.logout();
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffFFDDCC),
        appBar: AppBar(
          title: Text('Tata Neu'),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20.0,
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff102C57),
          leading: IconButton(
            onPressed: () {},
            //icon: Icon(Icons.home),
            icon: Image.network(
                'https://neuskills.tatadigital.com/productCompareSection/neuskill_logo.png'),
          ),
        ),
        // title: Text('Tata Neu'),
        // titleTextStyle: GoogleFonts.poppins(
        //   color: Colors.white,
        //   fontSize: 20.0,
        // ),
        // centerTitle: true,
        // backgroundColor: const Color(0xff102C57),
        // iconTheme: IconThemeData(color: Colors.white, size: 35.0),
        body: SafeArea(
          child: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://cdn.iste.org/www-root/560x315-Online-Learning-Landing-Page-Main-Image.gif',
                    height: 400.0,
                    width: 300.0,
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      role = "student";
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginHandler(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login As Student',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(30.0),
                      elevation: 12.0,
                      primary: Color(0xff102C57),
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        role = "teacher";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginHandler(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login As Instructor',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(30.0),
                        elevation: 12.0,
                        primary: Color(0xff102C57),
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
