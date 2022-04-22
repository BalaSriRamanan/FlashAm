import 'package:dsn/presenter/source/constants.dart';
import 'package:dsn/view/screen/home_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  final double lat, long;
  final bool ispatientin;
  const MenuScreen(
      {Key? key,
      required this.lat,
      required this.long,
      required this.ispatientin})
      : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String nickName;
  late String userName;
  late String personalInformation;
  late String vehicleInformation;
  late String licenseInformation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nickName = "UserNickName";
    userName = "Username";
    personalInformation = """
1/33, unknown st,
unknown place,
unknown city,
unknown XXX-XXX
     """;
    vehicleInformation = """
    Ambulance 
    id: 125
    license Plate: Ambulance-911""";
    licenseInformation = """
    License Number: XZY253615646,
    Owner Name: Mr. Someone""";
    // get the informantion from the firebase
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
              ]),
        ),
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
          Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            child: Image.asset(
              "assets/images/female.png",
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, left: 5),
            child: TextButton(
                onPressed: () {
                  //redirect to home
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HomeScreen(
                                lat: widget.lat,
                                long: widget.long,
                                ispatientin: widget.ispatientin,
                              )));
                },
                child: Image.asset(
                  "assets/images/back.png",
                  height: 25,
                  width: 25,
                )),
          ),
          Container(
            width: width,
            height: height * 0.6,
            margin: EdgeInsets.only(top: height * 0.4),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Color.fromARGB(226, 255, 255, 255)),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Text(
                    nickName,
                    style: const TextStyle(fontSize: 40, color: Colors.black),
                  ),
                ),
                Text(
                  userName,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: width * 0.9,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        color: Colors.white),
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      personalInformation,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: width * 0.9,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        color: Colors.white),
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      vehicleInformation,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: width * 0.9,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        color: Colors.white),
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      licenseInformation,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 25),
                    width: width * 0.9,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        color: Colors.white),
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      personalInformation,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
              ]),
            ),
          )
        ]),
      )),
    );
  }
}
