

import 'package:covidapplicationtest/loginPage.dart';
import 'package:covidapplicationtest/signup.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  String error = '';

  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.lightBlue,
            flexibleSpace:Row
              (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Image.asset("assets/logocovid.png",fit: BoxFit.contain,height: 125,width: 200,),
                ),
              ],

            ),
          ),
        ),

        //CAN USE THIS OR USE SINGLechildscrollview
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color.fromRGBO(174, 201, 218, 1),

        body: Center(

            child: Container(
                height: 500.0,
                width: 600.0,
                child: Column(
                  children: <Widget>[
                    Text("WELCOME",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36,),),
                    SizedBox(height: 40,),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 60,),


                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column
                              (
                              children: <Widget>[
                                Container(
                                  width: 220,
                                  height: 65,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 1, 18,0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.black)
                                      ),
                                      onPressed: ()  {
                                        Navigator.push(context,new MaterialPageRoute(builder: (context)=> LoginPage()));
                                      },
                                      color: Colors.white,
                                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                      child: Column( // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          //Icon(Icons,size: 35,),
                                          SizedBox(height: 1,),
                                          Text("SIGN IN", style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 60,),
                                Container(
                                  width: 220,
                                  height: 65,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 1, 18,0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.black)
                                      ),
                                      onPressed: () => {
                                        Navigator.push(context,new MaterialPageRoute(builder: (context)=> SignUp()))
                                      },
                                      color: Colors.white,
                                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                      child: Column( // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          //Icon(Icons,size: 35,),
                                          SizedBox(height: 1,),
                                          Text("SIGN UP", style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],

                      ),
                    ),
                    SizedBox(height: 30,),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )

                  ],
                )
            )
        )

    );
  }
}
