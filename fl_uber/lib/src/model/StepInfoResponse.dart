import 'package:google_maps_flutter/google_maps_flutter.dart';
class StepInfoResponse {
  int distance;
  LatLng from;
  LatLng to;
  String points;
  StepInfoResponse(this.distance, this.from, this.to, this.points);


  static List<StepInfoResponse> fromJson(Map<String, dynamic> json) {
    List<StepInfoResponse> rs = new List();
    var stepsRes = json['routes'][0]["legs"][0]["steps"] as List;
    for(var item in stepsRes) {
      var p = StepInfoResponse(0, LatLng(item["start_location"]["lat"], item["start_location"]["lng"]), LatLng(item["end_location"]["lat"], item["start_location"]["lng"]), item["polyline"]["points"]);
      rs.add(p);
    }
    return rs;
  }
}