import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({Key? key}) : super(key: key);

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

const googleMapsApiKey = "AIzaSyC_s2zNUWs7BXpFFf1ImzArtJpJXd-Dv9Q";

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  var currentLocation = const LatLng(23.7932, 90.2713);
  var destinationLocation = const LatLng(23.8479, 90.2576);

  void addCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 3.5),
      "images/truckIconNew.png",
    ).then((icon) {
      setState(() {
        this.markerIcon = icon;
      });
    });
  }

  @override
  void initState() {
    addCustomMarkerIcon();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("images/tIcon.png"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Google Maps",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 12.5,
        ),
        markers: {
          Marker(
              markerId: MarkerId("Current Postion"),
              position: currentLocation,
              draggable: true,
              onDragEnd: (value) {},
              icon: markerIcon),
          Marker(
            markerId: MarkerId("Destination"),
            position: destinationLocation,
          ),
        },
      ),
    );
  }
}
