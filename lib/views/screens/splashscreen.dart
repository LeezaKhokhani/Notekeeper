import 'package:flutter/material.dart';
import 'package:notekeeper/views/screens/signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash_screens extends StatefulWidget {
  const splash_screens({Key? key}) : super(key: key);

  @override
  State<splash_screens> createState() => _splash_screensState();
}

class _splash_screensState extends State<splash_screens> {

  logicIntro() async {
    final prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    logicIntro();
    Future.delayed(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const signinpage())),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
            child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
              children: const [
              Image(
             image: AssetImage(
                  "assets/images/images__4_-removebg-preview.png",
               ),
            ),
              SizedBox(
            height: 50,
            ),
            ],
            ),
          ),
    backgroundColor: Colors.black,
    );
  }
}

