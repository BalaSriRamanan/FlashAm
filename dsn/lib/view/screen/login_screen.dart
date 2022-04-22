import 'package:dsn/presenter/source/constants.dart';
import 'package:dsn/view/screen/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late String Username, Password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Username = "";
    Password = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              alignment: Alignment.topRight,
              child: Image.asset("assets/images/cross4.png"),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 0,
                left: 0,
              ),
              alignment: Alignment.centerLeft,
              child: Image.asset("assets/images/cross5.png"),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 0,
                left: 0,
              ),
              alignment: Alignment.bottomRight,
              child: Image.asset("assets/images/cross6.png"),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
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
                        loginscreen,
                        style: TextStyle(fontSize: 30),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: const EdgeInsets.only(top: 30),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            hintText: usernameHint,
                          ),
                          onChanged: (username) {
                            setState(() {
                              Username = username;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: const EdgeInsets.only(top: 30),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            hintText: passwordHint,
                          ),
                          onChanged: (username) {
                            setState(() {
                              Username = username;
                            });
                          },
                          obscureText: true,
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
                                  builder: (_) => const HomeScreen(
                                        lat: 0,
                                        long: 0,
                                        ispatientin: false,
                                      )));
                        },
                        child: Image.asset("assets/images/next.png"),
                        style: TextButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Color.fromARGB(156, 38, 255, 0),
                            padding: const EdgeInsets.all(25))),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
