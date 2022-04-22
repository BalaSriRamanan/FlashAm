// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:dsn/view/widgets/map_screen.dart';
import 'package:dsn/view/screen/menu_screen.dart';
import 'package:dsn/view/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:dsn/presenter/source/constants.dart';

class HomeScreen extends StatefulWidget {
  final double lat, long;
  final bool ispatientin;
  const HomeScreen(
      {Key? key,
      required this.lat,
      required this.long,
      required this.ispatientin})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool IsEmergency;
  late String Username;
  late bool isfullscreen;
  late bool ispatientin = widget.ispatientin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsEmergency = ispatientin;
    Username = "testUsername";
    isfullscreen = false;
    //todo: get the username from the firebase
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
              alignment: Alignment.topLeft,
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
            Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    child: !isfullscreen
                        ? Container(
                            margin: EdgeInsets.only(top: height * 0.2),
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: GestureDetector(
                              onDoubleTap: () {
                                setState(() {
                                  isfullscreen
                                      ? isfullscreen = false
                                      : isfullscreen = true;
                                });
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  heightFactor: 0.3,
                                  widthFactor: 2.5,
                                  child: MapSample(
                                    lat: widget.lat,
                                    long: widget.long,
                                    ispatientin: ispatientin,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: GestureDetector(
                                onDoubleTap: () {
                                  setState(() {
                                    isfullscreen
                                        ? isfullscreen = false
                                        : isfullscreen = true;
                                  });
                                },
                                child: MapSample(
                                  lat: widget.lat,
                                  long: widget.long,
                                  ispatientin: ispatientin,
                                )),
                          ),
                  ),
                ),
                !isfullscreen
                    ? Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Nearbyhospitals(
                                                ispatientin: ispatientin,
                                              )));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/pharmacy.png",
                                        height: 35,
                                        width: 35,
                                      ),
                                      const Text(
                                        nearbyhospital,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color.fromARGB(255, 207, 207, 207),
                                            Color.fromARGB(255, 202, 202, 202)
                                          ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    IsEmergency
                                        ? IsEmergency = false
                                        : IsEmergency = true;
                                    ispatientin = IsEmergency;
                                  });
                                },
                                child: Container(
                                  child: IsEmergency
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/patient.png",
                                              height: 35,
                                              width: 35,
                                            ),
                                            const Text(
                                              patientstatus_in,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/ambulance.png",
                                              height: 35,
                                              width: 35,
                                            ),
                                            const Text(
                                              patientstatus_out,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  decoration: BoxDecoration(
                                      gradient: !IsEmergency
                                          ? const LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                  Color.fromARGB(
                                                      255, 165, 4, 4),
                                                  Color.fromARGB(255, 184, 0, 0)
                                                ])
                                          : const LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                  Color.fromARGB(
                                                      255, 14, 167, 103),
                                                  Color.fromARGB(
                                                      255, 2, 156, 92)
                                                ]),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
            !isfullscreen
                ? Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.07,
                        left: MediaQuery.of(context).size.width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              homescreenhi,
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              Username,
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 25),
                            child: TextButton(
                              child: Container(
                                child: Image.asset(
                                  "assets/images/sandwidge.png",
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MenuScreen(
                                              lat: widget.lat,
                                              long: widget.long,
                                              ispatientin: ispatientin,
                                            )));
                              },
                            ))
                      ],
                    ),
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }
}
