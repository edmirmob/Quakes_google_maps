import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({Key key}) : super(key: key);

  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  GoogleMapController mapController;
  static final LatLng _center = LatLng(43.85328125938318, 18.374909033640293);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 11),
          mapType: MapType.terrain,
          markers: {sarajevoMarker},
          ),
          
    );
  }

  Marker sarajevoMarker = Marker(
    markerId: MarkerId('Sarajevo'),
    position: _center,
    infoWindow: InfoWindow(title: 'Sarajevo', snippet: 'This is a great town!'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
  );
}