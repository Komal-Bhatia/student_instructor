import 'package:flutter/material.dart';
import 'package:studentinstructor_app/components.dart';

class CourseDetailsScreen extends StatelessWidget {
  final name;
  final duration;
  final description;
  final image;
  final price;
  CourseDetailsScreen(
      {super.key,
      this.name,
      this.duration,
      this.description,
      this.image,
      this.price});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xffcbafbd),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.0,
              width: 50.0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_left,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Hero(
              tag: name,
              child: Center(
                  child: CircleAvatar(
                radius: 92.0,
                backgroundColor: Color(0xfff162451),
                child: CircleAvatar(
                  radius: 52.0,
                  child: Image.network(
                    image,
                    height: deviceSize.height * 0.4,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              )),
            ),
            const SizedBox(height: 20.0),
            Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
            ),
            const SizedBox(height: 10.0),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Duration: $duration ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Price : Rs. $price only',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
                onPressed: () {
                  ShowDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffa6263e),
                ),
                child: Text(
                  'Enroll Now',
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
