import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nimu_todos/pages/homepage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          decoration: PageDecoration(),
          title: "Your daily activities manager",
          body: "Manage your daily activities whith Nimu TODOS.",
          image: Image(
            image: AssetImage('images/img2.jpg'),
          ),
        ),
        PageViewModel(
          title: "Second",
          body: "This is my second home page",
          image: Image.asset("images/img.png"),
        ),
        PageViewModel(
          title: "Third",
          body: "This is my third home page",
          image: Image.asset("images/img2.jpg"),
        ),
      ],
      onDone: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      showNextButton: true,
      next: Icon(Icons.arrow_right_alt_rounded),
      done: Icon(Icons.done),
      showSkipButton: true,
      // onSkip: () {

      // },
      skip: Text(""),
    );
  }
}
