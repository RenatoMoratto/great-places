import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../utils/location_util.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;

  const LocationInput(this.onSelectPosition, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _setMapImage(double latitude, longitude) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    widget.onSelectPosition(LatLng(latitude, longitude));
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();

    _setMapImage(locData.latitude!, locData.longitude!);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapScreen(),
      ),
    );

    if (selectedPosition.toString().isEmpty) return;

    _setMapImage(selectedPosition.latitude, selectedPosition.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text('Localização não informada!')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Localização Atual'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Selecione no Mapa'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
