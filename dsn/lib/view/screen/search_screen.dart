import 'dart:convert';
import 'dart:developer';

import 'package:dsn/view/widgets/searchvalue.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:dsn/presenter/source/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart' as places;

import 'package:location/location.dart';

import 'home_screen.dart';

class Nearbyhospitals extends StatefulWidget {
  final bool ispatientin;
  const Nearbyhospitals({Key? key, required this.ispatientin})
      : super(key: key);

  @override
  _NearbyhospitalsState createState() => _NearbyhospitalsState();
}

class _NearbyhospitalsState extends State<Nearbyhospitals> {
  late final dref = FirebaseDatabase.instance.ref().child("Hospital");
  late DatabaseReference databaseReference;

  late bool isSearchenable;
  late String searchText;
  late List results = [];
  late LatLng currentPosition;
  late bool iscurrentgot = false;
  late CameraPosition kGooglePlex =
      CameraPosition(target: currentPosition, zoom: 15);
  late List HospitalList;

  List searchinList() {
    List searchResult = [];
    for (var i = 0; i < ListHospitals.length; i++) {
      String hospital = ListHospitals[i][0];
      hospital = hospital.toLowerCase();
      String Hospital = hospital.toUpperCase();
      if (hospital.contains(searchText) || Hospital.contains(searchText)) {
        searchResult.add(ListHospitals[i]);
      }
    }
    return searchResult;
  }

  void getUserLocation() async {
    Location location = Location();

    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _permissionGranted = await location.requestPermission();

    _locationData = await location.getLocation();

    setState(() {
      currentPosition =
          LatLng(_locationData.latitude!, _locationData.longitude!);
      kGooglePlex = CameraPosition(target: currentPosition, zoom: 15);
      iscurrentgot = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserLocation();
    super.initState();
    searchText = "";
    isSearchenable = false;
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
                    margin: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        !isSearchenable
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    isSearchenable
                                        ? isSearchenable = false
                                        : isSearchenable = true;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 25),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Text(
                                    "NearbyHospitals",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 25,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.73,
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        hintText: usernameHint,
                                      ),
                                      onChanged: (searchtext) {
                                        setState(() {
                                          searchText = searchtext;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isSearchenable
                                              ? isSearchenable = false
                                              : isSearchenable = true;
                                        });
                                      },
                                      child: Image.asset(
                                        "assets/images/search.png",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  searchText != ""
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 25),
                            itemBuilder: (BuildContext context, int index) {
                              return SearchValueWidget(
                                  hospitalname: ListHospitals[index][0],
                                  hospitaladdress: ListHospitals[index][1],
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomeScreen(
                                                  lat: ListHospitals[index][2],
                                                  long: ListHospitals[index][3],
                                                  ispatientin:
                                                      widget.ispatientin,
                                                )));
                                  });
                            },
                            itemCount: searchinList().length,
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 25),
                            itemBuilder: (BuildContext context, int index) {
                              return SearchValueWidget(
                                  hospitalname: ListHospitals[index][0],
                                  hospitaladdress: ListHospitals[index][1],
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomeScreen(
                                                  lat: ListHospitals[index][2],
                                                  long: ListHospitals[index][3],
                                                  ispatientin:
                                                      widget.ispatientin,
                                                )));
                                  });
                            },
                            itemCount: ListHospitals.length,
                          ),
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
