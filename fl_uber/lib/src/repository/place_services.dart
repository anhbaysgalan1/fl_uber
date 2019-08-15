import 'dart:async';
import 'package:fl_uber/src/model/StepInfoResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_uber/src/model/PlaceItemResponse.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class PlaceService {

  static Future<List<PlaceItemResponse>> searchPlace(String key) async{
    String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyAdNl_MUli228TXFN7rWQQ-FkF8Nn0E8gc&language=vi&region=VN&query="+
    Uri.encodeComponent(key);
    print(url);
    var res = await http.get(url);
    if(res.statusCode == 200) {
      return PlaceItemResponse.fromJson(json.decode(res.body));
    } else {
      return new List();
    }
  }

  static Future<List<StepInfoResponse>> getStepDirection(double fromLat, double fromLng, double toLat, double toLng) async{
    var str_origin = fromLat.toString() + "," + fromLng.toString();
    var str_destination = toLat.toString() + "," + toLng.toString();
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + str_origin + "&destination=" + str_destination + "&mode=driving&key="+
        Uri.encodeComponent("AIzaSyAdNl_MUli228TXFN7rWQQ-FkF8Nn0E8gc");
    print(url);
    var res = await http.get(url);
    if(res.statusCode == 200) {
      return StepInfoResponse.fromJson(json.decode(res.body));
    } else {
      return new List();
    }
  }

  static Future<List<PointLatLng>> getPolyline(double fromLat, double fromLng, double toLat, double toLng) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyAdNl_MUli228TXFN7rWQQ-FkF8Nn0E8gc",
        fromLat, fromLng, toLat, toLng);

    if(result.isNotEmpty){
      return result;
    }
  }
}