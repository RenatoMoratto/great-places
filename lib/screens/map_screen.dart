import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;

  const MapScreen({
    Key? key,
    this.initialLocation = const PlaceLocation(
      latitude: 37.419857,
      longitude: -122.078827,
    ),
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LatLng initialLocation = LatLng(
      widget.initialLocation.latitude,
      widget.initialLocation.longitude,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: {
          Marker(
            markerId: const MarkerId('p1'),
            position: _pickedPosition ?? initialLocation,
          ),
        },
      ),
    );
  }
}
