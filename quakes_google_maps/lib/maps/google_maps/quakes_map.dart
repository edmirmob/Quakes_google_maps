import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  double _zoomVal = 5.0;

  @override
  void initState() {
    super.initState();
    _quakeData = Network().getAllQuakes();
    // _quakeData.then((value) =>
    //     {print('Place: ${value.features.elementAt(0).properties.place}')});
  }
 Widget _plusZoom(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Align(
      alignment: Alignment.topRight,
      child: IconButton(onPressed: (){
       _zoomVal++;
       _plus(_zoomVal);
      },
       icon: Icon(FontAwesomeIcons.searchPlus)),
      ),
    );
  }
  Widget _minusZoom(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Align(
      alignment: Alignment.topLeft,
      child: IconButton(onPressed: (){
       _zoomVal--;
       _minus(_zoomVal);
      },
       icon: Icon(FontAwesomeIcons.searchMinus)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(context),
          _minusZoom(),
          _plusZoom()
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
        markers: Set<Marker>.of(_markerList),
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

 Future<void> _minus(double zoomVal)async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(40.712776, -74.005974),zoom: zoomVal)
    ));
  }

  Future<void> _plus(double zoomVal)async {
      final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(40.712776, -74.005974),zoom: zoomVal)
    ));
  }
}
