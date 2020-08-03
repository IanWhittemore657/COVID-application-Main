import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapplicationtest/FullImageView.dart';
import 'package:covidapplicationtest/Home.dart';
import 'package:covidapplicationtest/auth.dart';
import 'package:covidapplicationtest/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}


class _ReportPageState extends State<ReportPage>  {
//  with AutomaticKeepAliveClientMixin<ReportPage>
//  @override
//  bool get wantKeepAlive => true;


  String useridd;

  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      useridd = user.uid;
    });
    print(useridd);
    return user.uid;
  }

  @override
  void initState()
  {
    super.initState();
    currentUser();
    print(useridd);

  }
  Future<bool> _canLeave(BuildContext context)
  {
    return  Navigator.push(
        context, new MaterialPageRoute(
        builder: (context) => HomePage()));
  }


  @override
  Widget build(BuildContext context) {

    print("ACCOUNT IS: ${AuthService().isAuthenticated}");


    if(AuthService().isAuthenticated) {
      return new WillPopScope(onWillPop: ()  => _canLeave(context),
        child: Scaffold(
          appBar: AppBar
            (
            automaticallyImplyLeading: true,
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
                      AuthService().signOut(),
                      Navigator.push(
                          context, new MaterialPageRoute(builder: (
                          context) => LoginPage())),
                    }
                ),
              ),
            ],
            centerTitle: false,
            backgroundColor: Colors.lightBlue,

          ),


          backgroundColor: Color.fromRGBO(174, 201, 218, 1),

          body:Padding(
            padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//todo get images
                Padding(
                  //padding: const EdgeInsets.fromLTRB(50, 15, 10, 15),
                  padding: const EdgeInsets.fromLTRB(10, 15, 20, 15),
                  child: Text("Location Reports",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),

                Expanded(
                  child: Container(
                    child: StreamBuilder(
                        stream: Firestore.instance.collection("User Input").document("xnTEUIQWbAUGEldxH8aXvE5UDUq2").collection("Photos").orderBy('Date', descending: true).snapshots(),
                        builder:(BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData)

                            //return Center(child: new Text("Loading.."));
                            return Column
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
                                Text("Please ensure there is data"),
                              ],
                            );

                          return new ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,

                            children: snapshot.data.documents.map((document)
                            {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                child: new Card(
                                  elevation: 10.0,
                                  margin: EdgeInsets.all(5),
                                  child:new Container(
                                    padding: new EdgeInsets.all(0),

                                    child: ListTile(
                                      title:Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                                        child: Center(child: new Text("${document["Locality"] ?? "No Data"}",style: TextStyle(decoration: TextDecoration.underline,fontSize: 22),)
                                        ),
                                      ),

                                      subtitle: new Column
                                        (
                                        children: <Widget>[
                                          Text("${document["Date"] ?? "No Data"} : ${document["Time"]?? "No Data"}",style: TextStyle(color: Colors.black,fontSize: 16),),
                                          SizedBox(height: 10,),

//
//                                          CachedNetworkImage(
//                                            imageUrl:  document["ImageReference"] ?? "no data" ,fit:BoxFit.contain ,
//                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
//                                                CircularProgressIndicator(value: downloadProgress.progress),
//                                            errorWidget: (context, url, error) => Icon(Icons.error),
//                                          ),
                                          GestureDetector(


                                            child: new FadeInImage(

                                              placeholder:
                                              new AssetImage("assets/loadingimage.png"),
                                              image: new CachedNetworkImageProvider(document["ImageReference"] ?? "no data"),
                                              // image: new CachedNetworkImageProvider(document["ImageReference"] ? document["ImageReference"] : "https://us.123rf.com/450wm/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-stock-vector-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg?ver=6"),
                                            ),

                                            onTap: ()
                                            {
                                              Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                return FullScreen(text: document["ImageReference"],);
                                              }),
                                              );
                                            },
                                          ),

//                                           GestureDetector(
//                                               child: Image.network(document["ImageReference"] ?? "no data" ,fit:BoxFit.contain),
//                                             onTap: ()
//                                             {
//
//                                             Navigator.push(context, MaterialPageRoute(builder: (_) {
//                                               //todo send data of imagereference to this
//                                               return FullScreen();
//                                             }
//                                             ),
//                                             );
//
//                                             },
//
//                                           ),



                                          SizedBox(height: 15,),

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[

                                                    Text("Postcode: ${document["PostCode"] ?? "No Data"}",
                                                      style: TextStyle(fontSize: 16,color: Colors.grey[600]),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 15,),

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
//                                              Row(
//                                                mainAxisAlignment: MainAxisAlignment.center,
//                                                children: <Widget>[
//                                                  Text("Country: ${document["Country"] ?? "No Data"}",
//                                                    style: TextStyle(fontSize: 14,color: Colors.grey[600]),
//                                                  ),
//                                                ],
//                                              ),
//
//                                              SizedBox(height: 15,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                    child: Text("${document['Latitude'] ?? "No Data"} : ${document['Longitude'] ?? "No Data"}",
                                                      style: TextStyle(fontSize: 16,color: Colors.grey[600]),
                                                    ),
                                                  ),

//                                                  Text("${document['location'].latitude ?? "No Data"} : ${document['location'].latitude ?? "No Data"}",
//                                                    style: TextStyle(fontSize: 16,color: Colors.grey[600]),),
                                                ],
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 15,),

                                        ],
                                      ),



                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      );

    }
  }


}
