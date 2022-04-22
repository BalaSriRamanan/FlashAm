import 'package:dsn/presenter/source/constants.dart';
import 'package:dsn/view/screen/login_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(156, 111, 189, 253),
              Color.fromARGB(156, 9, 43, 146),
            ])),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(
              top: 0,
              left: 0,
            ),
            child: Image.asset("assets/images/cross1.png"),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 0,
              left: 0,
            ),
            alignment: Alignment.centerRight,
            child: Image.asset("assets/images/cross2.png"),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 0,
              left: 0,
            ),
            alignment: Alignment.bottomLeft,
            child: Image.asset("assets/images/cross3.png"),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      welcome,
                      style: TextStyle(fontSize: 30),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      child: const Text(
                        quotes,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()));
                      },
                      child: Image.asset("assets/images/next.png"),
                      style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor:
                              const Color.fromRGBO(87, 202, 67, 100),
                          padding: const EdgeInsets.all(25))),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
