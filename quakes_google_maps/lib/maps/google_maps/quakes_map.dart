import 'package:flutter/material.dart';
import 'package:quakes_google_maps/model/quake.dart';
import 'package:quakes_google_maps/network/network.dart';

class QuakesMap extends StatefulWidget {
  const QuakesMap({ Key key }) : super(key: key);

  @override
  _QuakesMapState createState() => _QuakesMapState();
}

class _QuakesMapState extends State<QuakesMap> {
   Future<Quake> _quakeData;

   @override
  void initState() {
    super.initState();
    _quakeData = Network().getAllQuakes();
    _quakeData.then((value) =>{
    print('Place: ${value.features.elementAt(0).properties.place}')
    } 
    );
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}