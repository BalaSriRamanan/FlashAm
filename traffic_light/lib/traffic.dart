import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Traffic extends StatefulWidget {
  const Traffic({Key? key}) : super(key: key);

  @override
  State<Traffic> createState() => _TrafficState();
}

class _TrafficState extends State<Traffic> {
  bool redActive = true, yellowActive = false, greenActive = false;

  late int trafficlat = 0, trafficlong = 0;
  late var currentPosition;
  late bool iscurrentgot = false;
  late bool isOverrideDefault = false;

  var defaultPosition = const LatLng(0, 0);

  late LocationData _locationData;
  late LocationData destination;

  void getUserLocation() async {
    Location location = Location();

    PermissionStatus _permissionGranted;

    _permissionGranted = await location.requestPermission();

    _locationData = await location.getLocation();

    setState(() {
      currentPosition =
          LatLng(_locationData.latitude!, _locationData.longitude!);

      iscurrentgot = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        DatabaseReference referenceData =
            FirebaseDatabase.instance.ref().child("TrafficLight").child("1");
        referenceData.child("Coordinates").update(
            {"lat": _locationData.latitude, "long": _locationData.longitude});
        referenceData.child("isAmbulance").once().then((value) {
          setState(() {
            var isoverride = value.snapshot.value.toString();
            isoverride == "true"
                ? isOverrideDefault = true
                : isOverrideDefault = false;
          });
        });
        log(isOverrideDefault.toString());
        if (isOverrideDefault) {
          greenActive = true;
          redActive = false;
        } else if (redActive && !isOverrideDefault) {
          redActive = false;
          greenActive = true;
        } else if (greenActive && !isOverrideDefault) {
          redActive = true;
          greenActive = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [
                // ignore: unnecessary_const
                Color.fromARGB(156, 0, 0, 0),
                // ignore: unnecessary_const
                Color.fromARGB(156, 0, 0, 0),
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              redActive
                  ? Container(
                      margin: EdgeInsets.only(top: 25),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 255, 17, 0),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 25),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 119, 32, 26),
                      ),
                    ),
              yellowActive
                  ? Container(
                      margin: EdgeInsets.only(top: 25),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.yellow,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 25),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 103, 95, 17),
                      ),
                    ),
              greenActive
                  ? Container(
                      margin: EdgeInsets.only(top: 25),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 2, 255, 11),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 25),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 31, 71, 33),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
