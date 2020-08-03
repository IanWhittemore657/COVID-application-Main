
import 'package:covidapplicationtest/ImageShow.dart';
import 'package:covidapplicationtest/Map.dart';
import 'package:covidapplicationtest/MapSpecific.dart';
import 'package:covidapplicationtest/ReportPage.dart';
import 'package:covidapplicationtest/ReportSpecificPage.dart';
import 'package:covidapplicationtest/auth.dart';
import 'package:covidapplicationtest/loginPage.dart';
import 'package:covidapplicationtest/maptesting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "dart:async";
import 'package:flutter/services.dart';

import 'package:geolocator/geolocator.dart';

import 'package:string_validator/string_validator.dart';



class HomePage extends StatefulWidget {
  final String email;

  HomePage({Key key,this.email }) : super(key:key);

  @override

  _HomeStateS createState() => _HomeStateS();
}

class _HomeStateS extends State<HomePage>
{
  var input;
  var qrinput;
  var trapR;

  String emailSend;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;


  int counter = 0;

  var qr;
  String result = "";
  String a;
  String b;
  String p;
  String errorM = " ";


  void inputData() async
  {
    final FirebaseUser users = await FirebaseAuth.instance.currentUser();
    final String uid = users.uid.toString();
    print(uid);
  }

  Future<bool> _canLeave(BuildContext context)
  {
    return SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {


    setState(() {
      emailSend = widget.email;
    });

    print("ACCOUNT IS: ${AuthService().isAuthenticated}");

    if(AuthService().isAuthenticated)
    {
      return new WillPopScope(onWillPop:() => _canLeave(context),
        //  SystemNavigator.pop();

        child: Scaffold(

          appBar:
          AppBar

            (
            automaticallyImplyLeading: false,
            title:Text("COVID REPORT"),
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign Out'),
                  onPressed: () => {
                    AuthService().signOut(),
                    Navigator.push(
                        context, new MaterialPageRoute(builder: (
                        context) => LoginPage())),
                  }
              ),
            ],
            centerTitle: false,
            backgroundColor: Colors.lightBlue,

          ),

          body: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Container(
                      width: 270,
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 1, 18,0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          ),

                          onPressed: () async {
                            Navigator.push(
                                context, new MaterialPageRoute(builder: (
                                context) => MapSpecific()));
                          },
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Column( // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              //Icon(Icons,size: 35,),
                              SizedBox(height: 1,),
                              Text("SPECIFIC REPORT MAP", style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 25,),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Container(
                      width: 270,
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 1, 18,0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          ),

                          onPressed: () async {
                            Navigator.push(
                                context, new MaterialPageRoute(builder: (
                                context) => MapTest()));
                          },
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Column( // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              //Icon(Icons,size: 35,),
                              SizedBox(height: 1,),
                              Text("IMAGE REPORTS MAP", style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 25,),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Container(
                      width: 270,
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 1, 18,0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          ),

                          onPressed: () async {
                            Navigator.push(
                                context, new MaterialPageRoute(builder: (
                                context) => ReportPage()));
                          },
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Column( // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              //Icon(Icons,size: 35,),
                              SizedBox(height: 1,),
                              Text("IMAGE REPORTS", style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25,),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Container(
                      width: 270,
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 1, 18,0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          ),

                          onPressed: () async {
                            Navigator.push(
                                context, new MaterialPageRoute(builder: (
                                context) => ReportSpecificPage()));
                          },
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Column( // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              //Icon(Icons,size: 35,),
                              SizedBox(height: 1,),
                              Text("SPECIFIC REPORTS", style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              )
            ),
          ),

          backgroundColor: Color.fromRGBO(174, 201, 218, 1),
        ),
      );
    }
    else {
      Navigator.push(
          context, new MaterialPageRoute(builder: (
          context) => LoginPage()));

    }
  }


  _getCurrentLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;

      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality},\n ${place.postalCode},\n ${place.country}";

      });
    } catch (e) {
      print(e);
    }
  }





}


