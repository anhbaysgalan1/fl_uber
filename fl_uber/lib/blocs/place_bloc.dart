import 'dart:async';
import 'package:fl_uber/src/repository/place_services.dart';

class PlaceBloc{

  var _placeController = StreamController();

  Stream get placeStream => _placeController.stream;

  void searchPlace(String key) {
    _placeController.sink.add('start');
    PlaceService.searchPlace(key).then((rs) {
      _placeController.sink.add(rs);
    }).catchError(() {

    });
  }

  void dispose() {
    _placeController.close();
  }
}