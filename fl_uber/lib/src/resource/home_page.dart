import 'dart:async';

import 'package:fl_uber/src/resource/widgets/ride_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fl_uber/src/resource/widgets/home_menu.dart';
import 'package:fl_uber/src/model/PlaceItemResponse.dart';
import 'package:fl_uber/src/repository/place_services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  GoogleMapController _mapController;
   Map<String, Marker> _markers = {};
  Set<Polyline> _polylines = {};
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(10.7915178, 106.7271422), zoom: 14.4746),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              markers: _markers.values.toSet(),
              polylines: _polylines,
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text("Taxi App", style: TextStyle(color: Colors.black),),
                    leading: FlatButton(onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    }, child: Image.asset("assets/ic_menu.png")),
                    actions: <Widget>[Image.asset("assets/ic_notify.png")],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: RidePicker(onPlaceSelected),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }

  void onPlaceSelected(PlaceItemResponse placeItemResponse, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
    _createMarker(mkId, placeItemResponse.lat, placeItemResponse.lng);
    if (_markers.length > 1) {
       Marker fromMarker = _markers["from_address"];
       Marker toMarker = _markers["to_address"];

//      PlaceService.getStepDirection(fromMarker.position.latitude, fromMarker.position.longitude, toMarker.position.latitude, toMarker.position.longitude)
//       .then((rs) {
//         print(rs);
//         List<LatLng> stepLatLngs = List();
//
//
//         rs.forEach((item) {
//           stepLatLngs.add(item.from);
//           stepLatLngs.add(item.to);
//           List<PointLatLng> result = decodePolyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@");
//         });

//      });

      PlaceService.getPolyline(fromMarker.position.latitude, fromMarker.position.longitude, toMarker.position.latitude, toMarker.position.longitude)
      .then((res) {
        List<LatLng> stepLatLngs = List();
        res.forEach((point) {
          stepLatLngs.add(LatLng(point.latitude, point.longitude));
        });
        _drawPolylines("pId", stepLatLngs);
        _moveCamera();
      });
    }

  }

  void _moveCamera() {

    if (_markers.values.length > 1) {
      var fromLatLng = _markers["from_address"].position;
      var toLatLng = _markers["to_address"].position;

      var sLat, sLng, nLat, nLng;
      if(fromLatLng.latitude <= toLatLng.latitude) {
        sLat = fromLatLng.latitude;
        nLat = toLatLng.latitude;
      } else {
        sLat = toLatLng.latitude;
        nLat = fromLatLng.latitude;
      }

      if(fromLatLng.longitude <= toLatLng.longitude) {
        sLng = fromLatLng.longitude;
        nLng = toLatLng.longitude;
      } else {
        sLng = toLatLng.longitude;
        nLng = fromLatLng.longitude;
      }

      LatLngBounds bounds = LatLngBounds(northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      _mapController.animateCamera(CameraUpdate.newLatLng(
          _markers.values.elementAt(0).position));
    }
  }

  void _createMarker(String mkId, double lat, double lng) {
    _markers.remove(mkId);
    setState(() {
      _markers[mkId] = Marker(
        markerId: MarkerId(mkId),
        position: LatLng(lat, lng),
      );
    });
  }
  
  void _drawPolylines(String pId, List<LatLng> steps) {
    _polylines.clear();
    setState(() {
      _polylines.add(Polyline(polylineId: PolylineId(pId), points: steps, width: 10));
    });
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}