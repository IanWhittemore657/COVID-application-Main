import 'package:covidapplicationtest/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MapSpecific extends StatefulWidget {
  @override
  _MapStateSpecific createState() => _MapStateSpecific();
}

class _MapStateSpecific extends State<MapSpecific> {
  bool mapToggle = false;
  bool clientsToggle = false;
  bool resetToggle = false;

  var currentLocation;

  var clients = [];

  var currentClient;
  var currentBearing;

  GoogleMapController mapController;

  String useridd = "Testing";



  void initState() {
    super.initState();

    //print(useridd);
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
        populateClients();
      });
    });
  }

  populateClients() {
    clients = [];
    Firestore.instance.collection("User Input").document("xnTEUIQWbAUGEldxH8aXvE5UDUq2").collection("Specific Report").orderBy('Date', descending: true).getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          clientsToggle = true;
        });
        for (int i = 0; i < docs.documents.length; ++i) {
          clients.add(docs.documents[i].data);
          initMarker(docs.documents[i].data);
        }
      }
    });
  }
  List<Marker> allMakers = [];


  initMarker(client) {

    setState(() {
      allMakers.add(Marker(
        markerId: MarkerId(client["Time"] ?? "No Data"),
        draggable: false,
        infoWindow:
        InfoWindow(title: "${client["Address"] ?? "No Data"}", snippet: "  ${client["PostCode"] ?? "No Data"}"),
        position: LatLng(client['location'].latitude ?? "52.0369849", client['location'].longitude ?? "-0.7108528"),));
    });

  }

  Widget clientCard(client) {
    return Padding(
        padding:EdgeInsets.fromLTRB(2, 10, 10, 0),
        child: InkWell(
            onTap: () {
              setState(() {
                currentClient = client;
                currentBearing = 90.0;
              });
              zoomInMarker(client);
            },
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                height: 180.0,
                width: 280.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5,),
                    Center(child: Text(client['PostCode'] ?? "No Data",style: TextStyle(fontSize: 16),),),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("Address           :",style: TextStyle(fontSize: 12,color: Colors.black),),

                            SizedBox(height: 4,),

                            Text("Date                  :",style: TextStyle(fontSize: 12,color: Colors.black),),


                            SizedBox(height: 4,),
                            Text("Post Code        :",style: TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 4,),

                            Text("Locality            :",style: TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 4,),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text("Time                 :",style: TextStyle(fontSize: 12,color: Colors.black),),
                            ),

                            SizedBox(height: 4,),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text("Location          :",style: TextStyle(fontSize: 12,color: Colors.black),),
                            ),

                            SizedBox(height: 4,),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text("Country            :",style: TextStyle(fontSize: 12,color: Colors.black),),
                            ),

                          ],
                        ),
                        SizedBox(width:6,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(client["Address"] ?? "No Data",style: TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 4,),
                            Text(client["Date"] ?? "No Data",style: TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 4,),
                            Text(client["PostCode"] ?? "No DaTA",style: TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 4,),
                            Text(client["Locality"] ?? "No Data",style: TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 4,),
                            Text(client["Time"].toString() ?? "No Data",style: TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 4,),
                            Text(" ${client["Latitude"] ?? "52"} : ${client["Longitude"] ??"-0.7108528" }",style: TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 4,),
                            Text(" ${client["Country"] ?? "No data"}",style: TextStyle(fontSize: 12,color: Colors.black),),

                          ],
                        )



                      ],
                    ),

                  ],
                ),

              ),
            )));
  }

  zoomInMarker(client) {
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            client['location'].latitude, client['location'].longitude),
        zoom: 17.0,
        bearing: 90.0,
        tilt: 45.0)))
        .then((val) {
      setState(() {
        resetToggle = true;
      });
    });
  }

  resetCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 17.0))).then((val) {
      setState(() {
        resetToggle = false;
      });
    });
  }

  addBearing() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentClient['location'].latitude,
                currentClient['location'].longitude
            ),
            bearing: currentBearing == 360.0 ? currentBearing : currentBearing + 90.0,
            zoom: 17.0,
            tilt: 45.0
        )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 360.0) {}
        else {
          currentBearing = currentBearing + 90.0;
        }
      });
    });
  }

  removeBearing() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentClient['location'].latitude,
                currentClient['location'].longitude
            ),
            bearing: currentBearing == 0.0 ? currentBearing : currentBearing - 90.0,
            zoom: 17.0,
            tilt: 45.0
        )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 0.0) {}
        else {
          currentBearing = currentBearing - 90.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar
          (
          automaticallyImplyLeading: false,
          title:                 Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0,0 ),
            child: FlatButton.icon(
                icon: Icon(Icons.home,size: 35,),
                label: Text('',style: TextStyle(fontSize: 1),),
                onPressed: () =>
                {
                  Navigator.push(
                      context, new MaterialPageRoute(
                      builder: (context) => HomePage())),
                }
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign Out'),
                  onPressed: () => {
//                    AuthService().signOut(),
//                    Navigator.push(
//                        context, new MaterialPageRoute(builder: (
//                        context) => LoginPage())),
                  }
              ),
            ),
          ],
          centerTitle: false,
          backgroundColor: Colors.lightBlue,

        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 80.0,
                  width: double.infinity,
                  child: mapToggle
                      ?
                  GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(target: LatLng(currentLocation.latitude,currentLocation.longitude),
                      zoom: 17,
                    ),

                    onMapCreated: onMapCreated,
                    markers: Set.from(allMakers),
                  )

                      :  Column
                    (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 8.0,
                          valueColor : AlwaysStoppedAnimation(Colors.black),

                        ),
                      ),
                      SizedBox(height: 15,),
                      Text("Please ensure your location is on"),
                    ],
                  ),
                ),

                Positioned(
                    top: MediaQuery.of(context).size.height - 300.0,
                    left: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                      child: Container(
                          height: 220.0,
                          width: MediaQuery.of(context).size.width,
                          child: clientsToggle
                              ? ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(8.0),
                            children: clients.map((element) {
                              return clientCard(element);
                            }).toList(),
                          )
                              : Container(height: 1.0, width: 1.0)),
                    )),

                resetToggle
                    ? Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height -
                            30.0),
                    right: 23.0,
                    child: FloatingActionButton(
                      onPressed: resetCamera,
                      mini: true,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.refresh,size: 35,),
                    ))
                    : Container(),

                resetToggle
                    ? Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height -
                            30.0),
                    right: 80.0,
                    child: FloatingActionButton(
                        onPressed: addBearing,
                        mini: true,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.rotate_left,size: 35,
                        ))
                )
                    : Container(),

                resetToggle
                    ? Positioned(
                    top: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height -
                            30.0),
                    right: 140.0,
                    child: FloatingActionButton(
                        onPressed: removeBearing,
                        mini: true,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.rotate_right,size: 35,)
                    ))
                    : Container()
              ],
            )
          ],
        ));
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}