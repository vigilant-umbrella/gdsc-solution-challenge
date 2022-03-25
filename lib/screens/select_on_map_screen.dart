// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_solution_challenge/models/location_model.dart'
    // ignore: library_prefixes
    as LocationModel;
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:location/location.dart';

class SelectOnMapScreen extends StatefulWidget {
  final LocationModel.Location? initialLocation;
  // route
  static const routeName = '/select-on-map';

  const SelectOnMapScreen({Key? key, this.initialLocation}) : super(key: key);

  @override
  State<SelectOnMapScreen> createState() => _SelectOnMapScreenState();
}

class _SelectOnMapScreenState extends State<SelectOnMapScreen> {
  LatLng? _initialCameraPosition = const LatLng(28.6139, 77.2090);

  // variables
  late String _mapStyle;
  LatLng? _pickedLocation;

  void _panToCurrentLocation(controller) {
    Location().getLocation().then((location) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
                location.latitude ?? 28.6139, location.longitude ?? 77.2090),
            zoom: 15,
          ),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    // set map style
    controller.setMapStyle(_mapStyle);

    // pan to current location
    if (widget.initialLocation == null) {
      _panToCurrentLocation(controller);
    }
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  Future<String?> getPlaceAddress(double lat, double lng) async {
    try {
      return 'Waiting for ashok to make the api';
    } catch (e) {
      return null;
    }
  }

  void _onConfirm() async {
    if (_pickedLocation != null) {
      final address = await getPlaceAddress(
          _pickedLocation!.latitude, _pickedLocation!.longitude);
      Navigator.of(context).pop(
        LocationModel.Location(
          lat: _pickedLocation!.latitude,
          lng: _pickedLocation!.longitude,
          address: address,
        ),
      );
    }
  }

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
    });

    if (widget.initialLocation != null) {
      _pickedLocation =
          LatLng(widget.initialLocation!.lat, widget.initialLocation!.lng);
      _initialCameraPosition =
          LatLng(widget.initialLocation!.lat, widget.initialLocation!.lng);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Location'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _onConfirm,
            ),
          ],
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _initialCameraPosition!,
            zoom: 15,
          ),
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          onTap: _selectLocation,
          markers: _pickedLocation == null
              ? {}
              : {
                  Marker(
                    markerId: const MarkerId('m1'),
                    position: LatLng(
                      _pickedLocation!.latitude,
                      _pickedLocation!.longitude,
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                },
        ),
      ),
    );
  }
}
