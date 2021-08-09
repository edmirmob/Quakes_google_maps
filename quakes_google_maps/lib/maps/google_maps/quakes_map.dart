import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quakes_google_maps/model/quake.dart';
import 'package:quakes_google_maps/network/network.dart';

class QuakesMap extends StatefulWidget {
  const QuakesMap({Key key}) : super(key: key);

  @override
  _QuakesMapState createState() => _QuakesMapState();
}

class _QuakesMapState extends State<QuakesMap> {
  Future<Quake> _quakeData;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markerList = <Marker>[];

  @override
  void initState() {
    super.initState();
    _quakeData = Network().getAllQuakes();
    // _quakeData.then((value) =>
    //     {print('Place: ${value.features.elementAt(0).properties.place}')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            findQuakes();
          },
          label: Text('Find Quakes')),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(36.108000, -117.8608333), zoom: 3),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  void findQuakes() {
    setState(() {
      _markerList.clear();
      _handleResponse();
    });
  }

  void _handleResponse() {
    setState(() {
      _quakeData.then((quakes) => {
            quakes.features.forEach((quake) {
              _markerList.add(
                Marker(
                  markerId: MarkerId(quake.id),
                  position: LatLng(quake.geometry.coordinates[1],
                      quake.geometry.coordinates[0]),
                      infoWindow: InfoWindow(title: quake.properties.title, snippet: quake.properties.place),
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
                      onTap: (){}
                ),
              );
            })
          });
    });
  }
}
