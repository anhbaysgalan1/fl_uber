class PlaceItemResponse {
  String name;
  String address;
  double lat;
  double lng;
  PlaceItemResponse(this.name, this.address, this.lat, this.lng);


  static List<PlaceItemResponse> fromJson(Map<String, dynamic> json) {

    List<PlaceItemResponse> rs = new List();
    var results = json['results'] as List;
    for(var item in results) {
      var p = PlaceItemResponse(item["name"], item["formatted_address"], item['geometry']['location']['lat'], item['geometry']['location']['lng']);
      print(p.name);
      rs.add(p);
    }
    return rs;
  }
}