import 'package:fl_uber/blocs/place_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fl_uber/src/model/PlaceItemResponse.dart';

class RidePickerPage extends StatefulWidget {
  String selectedAddress;
  Function(PlaceItemResponse, bool) onSelected;
  bool _isFromAddress;

  RidePickerPage(this.selectedAddress, this.onSelected, this._isFromAddress);

  @override
  State<StatefulWidget> createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  var placeBloc = PlaceBloc();
  var _addressController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressController = TextEditingController(text: widget.selectedAddress);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    placeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xfff8f8f8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 60,
                        child: Center(
                          child: Image.asset("assets/ic_location_black.png"),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        width: 40,
                        height: 60,
                        child: Center(
                          child: FlatButton(
                              onPressed: () {
                                _addressController.text = "";
                              },
                              child: Image.asset("assets/ic_remove_x.png")),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 50),
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          onSubmitted: (str) {
                            placeBloc.searchPlace(str);
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                              hintText: "Search", border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == "start") {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<PlaceItemResponse> places = snapshot.data;
                      print(snapshot.data.toString());
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: places.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(places.elementAt(index).name),
                              subtitle: Text(places.elementAt(index).address),
                              onTap: () {
                                Navigator.of(context).pop();
                                widget.onSelected(places.elementAt(index), widget._isFromAddress);
                              },
                            );
                          });
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
