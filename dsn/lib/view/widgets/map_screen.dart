import 'dart:async';
import 'dart:developer' as dev;

import 'dart:math';

import 'package:dsn/presenter/source/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final double lat, long;
  final bool ispatientin;
  const MapSample(
      {Key? key,
      required this.lat,
      required this.long,
      required this.ispatientin})
      : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  late double trafficlat, trafficlong;
  late var currentPosition;
  late bool iscurrentgot = false;
  late CameraPosition kGooglePlex =
      CameraPosition(target: currentPosition, zoom: 15);
  var defaultPosition = const LatLng(0, 0);
  late CameraPosition unknown =
      CameraPosition(target: defaultPosition, zoom: 15);
  late LocationData _locationData;
  late LatLng destination;
  late Set<Polyline> _polylines = Set<Polyline>();
  late List<LatLng> polylinecoordinates = [];
  late PolylinePoints polylinePoints;

  void getUserLocation() async {
    Location location = Location();

    PermissionStatus _permissionGranted;

    _permissionGranted = await location.requestPermission();

    _locationData = await location.getLocation();

    setState(() {
      currentPosition =
          LatLng(_locationData.latitude!, _locationData.longitude!);

      iscurrentgot = true;
      dev.log(currentPosition.toString());
      dev.log(kGooglePlex.toString());

      polylinePoints = PolylinePoints();
      if ((widget.lat == 0) && (widget.long == 0)) {
        destination = LatLng(_locationData.latitude!, _locationData.longitude!);
        dev.log(destination.toString());
      }
      destination = LatLng(widget.lat, widget.long);
      setpolylines();
    });

    if (widget.lat != 0 && widget.long != 0) {
      setState(() {
        var hospitalPosition = LatLng(widget.lat, widget.long);
        kGooglePlex = CameraPosition(target: hospitalPosition, zoom: 15);
      });
    }
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        DatabaseReference referenceData =
            FirebaseDatabase.instance.ref().child("TrafficLight").child("1");
        referenceData.child("Coordinates").child("lat").once().then((value) {
          trafficlat = double.parse(value.snapshot.value.toString());
          dev.log(trafficlat.toString());
        });
        referenceData.child("Coordinates").child("long").once().then((value) {
          trafficlong = double.parse(value.snapshot.value.toString());
          dev.log(trafficlong.toString());
        });
      });
      getUserLocation();
      GetDistance();
    });

    super.initState();
  }

  void GetDistance() {
    var tl = Point(trafficlat, trafficlong);
    dev.log(tl.toString());
    var curl = Point(_locationData.latitude!, _locationData.longitude!);
    double distanceBetweenTwoPoints = sqrt((tl.x - curl.x) * (tl.x - curl.x)) +
        sqrt((tl.y - curl.y) * (tl.y - curl.y));
    print(distanceBetweenTwoPoints);
    if (distanceBetweenTwoPoints < 0.0001 && widget.ispatientin) {
      DatabaseReference referenceData =
          FirebaseDatabase.instance.ref().child("TrafficLight").child("1");
      referenceData.update({
        "isAmbulance": "true",
      });
    } else {
      DatabaseReference referenceData =
          FirebaseDatabase.instance.ref().child("TrafficLight").child("1");
      referenceData.update({"isAmbulance": "false"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: iscurrentgot
          ? GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  void setpolylines() async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        "AIzaSyA7LwR7Ch2km0O5L_d67GMbxfoich7RgGM",
        PointLatLng(currentPosition.latitude, currentPosition.longitude),
        PointLatLng(destination.latitude, destination.longitude));
    if (result.status == 'OK') {
      for (var point in result.points) {
        polylinecoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: const PolylineId('polyLine'),
            color: const Color.fromARGB(255, 68, 255, 81),
            points: polylinecoordinates));
        dev.log(_polylines.toString());
      });
    } else {
      dev.log(result.errorMessage.toString());
    }
  }
}
