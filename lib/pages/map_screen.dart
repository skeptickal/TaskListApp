import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/resource/bottom_nav.dart';

class MapScreen extends StatelessWidget {
  final LatLng _center = const LatLng(37.422131, -122.084801);

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    GoogleMapController? mapController;

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    mapController?.dispose();

    Future<dynamic> serviceEnabled() async {
      Location location = Location();
      bool _serviceEnabled = await location.serviceEnabled();
      PermissionStatus _permissionGranted = await location.hasPermission();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }
      // LocationData _locationData = await location.getLocation();
      // return LatLng(_locationData.latitude!, _locationData.longitude!);
      return await location.getLocation();
    }

    serviceEnabled();

    return Scaffold(
      bottomNavigationBar: const BottomNav(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Map',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
      ),
      backgroundColor: bgColor,
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 13.0),
      ),
    );
  }
}
