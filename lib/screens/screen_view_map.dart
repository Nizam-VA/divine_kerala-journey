import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScreenViewMap extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String place;

  const ScreenViewMap(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.place});

  @override
  State<ScreenViewMap> createState() => _ScreenViewMapState();
}

class _ScreenViewMapState extends State<ScreenViewMap> {
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};
  LatLng current = LatLng(0, 0);

  @override
  void initState() {
    final currentLocation =
        LatLng(double.parse(widget.latitude), double.parse(widget.longitude));
    current = currentLocation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          mapType: MapType.normal,
          markers: _markers.values.toSet(),
          onMapCreated: (controller) {
            addMarker('place', current);
            _mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: current,
            zoom: 14.4746,
          )),
    );
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(title: widget.place));
    _markers[id] = marker;
  }
}
