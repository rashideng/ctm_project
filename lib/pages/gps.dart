import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

import 'package:ctm_project/pages/Divider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Gps extends StatefulWidget {
  static const String idScreen = "Gps";
  @override
  _GpsState createState() => _GpsState();
}

class _GpsState extends State<Gps> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Position currentPossition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePossition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPossition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition camaraPosition =
        new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(camaraPosition));
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 265;
              });
              locatePossition();
            },
          ),

          //HamburgerButton for Drawer
          //
          Positioned(
            top: 45,
            left: 22,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 3,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  radius: 20,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0),
                    Text("Hey there,", style: TextStyle(fontSize: 12.0)),
                    Text("Where to,",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey[500],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Destination",
                              style: TextStyle(fontWeight: FontWeight.w200),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Row(
                      children: [
                        Icon(
                          Icons.business_outlined,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add your destinantion"),
                            SizedBox(height: 2),
                            Text(
                              "Destination",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12.0),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    DividerWidget(),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Icon(
                          Icons.business_center_rounded,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add your Office address"),
                            SizedBox(height: 2),
                            Text(
                              "Office",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
