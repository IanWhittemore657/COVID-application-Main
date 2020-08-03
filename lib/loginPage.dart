
import 'package:covidapplicationtest/Home.dart';
import 'package:covidapplicationtest/auth.dart';
import 'package:covidapplicationtest/signup.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final AuthService _auth = AuthService();
  String error = '';

  final formKey = new GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }


  Future<bool> _canLeave(BuildContext context)
  {
    return showDialog(context: context,
        child: new AlertDialog(
          title: new Text("Sign Up Instead"),
          content: new Text("Would you rather sign up?"),
          actions: <Widget>[
            new FlatButton(onPressed: ()=>
                Navigator.push(
                    context, new MaterialPageRoute(builder: (
                    context) => SignUp())),
              child: new Text("YES"),
            ),
            new FlatButton(onPressed:() =>
                Navigator.push(
                    context, new MaterialPageRoute(builder: (
                    context) => LoginPage())),
              child: new Text("NO"),),
          ],
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(onWillPop:() => _canLeave(context),

      child: Scaffold(
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
                      Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36,),),
                      SizedBox(height: 25,),
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 2, 50, 2),
                              child: TextFormField(
                                validator: (value) => value.isEmpty
                                    ? 'Email is required'
                                    : validateEmail(value.trim()),
                                onChanged: (value) {
                                  this.email = value;
                                },
                                decoration: InputDecoration(
                                  icon: const Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0,5,0,20),
                                      )),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                  ),
                                  labelText: 'Enter your email',
                                  hintText: "Enter your email",
                                ),
                              ),
                            ),

                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 2, 50, 2),
                              child: TextFormField(
                                decoration: InputDecoration(

                                  icon: const Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0,5,0,20),
                                      )),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                  ),
                                  labelText: 'Enter your password',
                                  hintText: "Enter your password",
                                ),

                                onSaved: (value) => password = value.trim(),
                                validator: (value) => value.isEmpty
                                    ? 'Password is required'
                                    : null,
                                onChanged: (value) {
                                  this.password = value;
                                },
                                obscureText: _obscureText,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: new RaisedButton(
                                  color: Colors.grey[100],

                                  onPressed: _toggle,
                                  child: new Text(_obscureText ? "Show" : "Hide")),
                            ),

                            SizedBox(height: 45,),


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
                                          side: BorderSide(color: Colors.black),
                                        ),

                                        onPressed: () async {
                                          if (checkFields()) {
                                            try {
                                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                                              if (result == null) {
                                                setState(() {
                                                  error = "Could Not Sign In";
                                                });
                                              }
                                              else{
                                                var route = new MaterialPageRoute(builder: (BuildContext context) => new HomePage(email: email,),);
                                                Navigator.of(context).push(route);
                                                //  Navigator.push(context,new MaterialPageRoute(builder: (context)=> Home()));
                                              }
                                            }

                                            catch (e) {
                                              setState(() {
                                                error = e.toString();
                                              });
                                            }
                                          }
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

      ),
    );
  }
}
