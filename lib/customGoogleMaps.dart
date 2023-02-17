import 'package:flutter/material.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({Key? key}) : super(key: key);

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Google Maps"),
      ),
    );
  }
}
