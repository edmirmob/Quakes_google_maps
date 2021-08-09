import 'dart:convert';
import 'package:http/http.dart';
import 'package:quakes_google_maps/model/quake.dart';

class Network{

  Future<Quake> getAllQuakes()async{
    var url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson';
    
    final response = await get(Uri.parse(Uri.encodeFull(url)));

    if(response.statusCode == 200){
      // print('Quakes data: ${response.body}');
       return Quake.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error getting quakes');
    }

  }
}