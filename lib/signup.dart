

import 'package:covidapplicationtest/auth.dart';
import 'package:covidapplicationtest/loginPage.dart';
import 'package:flutter/material.dart';
class SignUp extends StatefulWidget
{
  final Function toggleView;
  SignUp({ this.toggleView });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, password;
  String passwordCheck;
  final AuthService _auth = AuthService();
  String error = '';
  final formKey = new GlobalKey<FormState>();

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
          title: new Text("Sign In Instead"),
          content: new Text("Would you rather sign in?"),
          actions: <Widget>[
            new FlatButton(onPressed: ()=>
                Navigator.push(
                    context, new MaterialPageRoute(builder: (
                    context) =>LoginPage())),
              child: new Text("YES"),
            ),
            new FlatButton(onPressed:() =>
                Navigator.push(
                    context, new MaterialPageRoute(builder: (
                    context) => SignUp())),
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
            preferredSize: Size.fromHeight(80.0), // here the desired height
            child: AppBar(
              //automaticallyImplyLeading: false,
              backgroundColor: Colors.lightBlue,
              flexibleSpace:Row
                (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Text("SIGN UP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36,),),
                    ),
                  ),
                ],

              ),
            ),
          ),

          backgroundColor: Color.fromRGBO(174, 201, 218, 1),
          body: Center(
              child: SingleChildScrollView(
                child: Container(
                    height: 500.0,
                    width: 600.0,
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              SizedBox(height: 5,),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 2, 25, 2),
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
                                          //    child: const Icon(Icons.verified_user,size: 35,),
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
                                padding: const EdgeInsets.fromLTRB(25, 2, 25, 2),
                                child: TextFormField(
                                  decoration: InputDecoration(

                                    icon: const Padding(
                                        padding: const EdgeInsets.only(top: 15.0),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0,5,0,20),
                                          //    child: const Icon(Icons.lock,size: 35,),
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
                                    print(password);
                                    this.password = value;
                                  },
                                  obscureText: _obscureText,
                                ),
                              ),

                              SizedBox(height: 30,),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 2, 25, 2),
                                child: TextFormField(
                                  decoration: InputDecoration(

                                    icon: const Padding(
                                        padding: const EdgeInsets.only(top: 15.0),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0,5,0,20),
                                          //    child: const Icon(Icons.lock,size: 35,),
                                        )),

                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                    ),
                                    labelText: 'Re-enter your password',
                                    hintText: "Re-enter your password",
                                  ),

                                  onSaved: (value) => passwordCheck = value.trim(),
                                  validator: (value) => value.isEmpty
                                      ? 'Re-enter password is required'
                                      : null,
                                  onChanged: (value) {
                                    this.passwordCheck = value;
                                    print(passwordCheck);
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

                              SizedBox(height: 30,),

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
                                          onPressed: () async{
                                            if (checkFields()) {
                                              if(password == passwordCheck) {
                                                try {
                                                  dynamic result = _auth
                                                      .registerWithEmailAndPassword(
                                                      email, password);
                                                  Navigator.push(context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginPage()));
                                                  print(result);
                                                  print("User created SIGNUP PAGE");
                                                  if (result == null) {
                                                    setState(() {
                                                      error =
                                                      "An error has occured";
                                                    });
                                                  }
                                                }
                                                catch (e) {
                                                  setState(() {
                                                    error = e.toString();
                                                  });
                                                }
                                              }
                                              else
                                              {
                                                print(passwordCheck);
                                                print(password);
                                                print("Not the same");
                                                error = "Please make sure passwords are the same";
                                              }
                                            }
                                          },
                                          color: Colors.white,
                                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                          child: Container(
                                            width: 200,
                                            child: Column( // Replace with a Row for horizontal icon + text
                                              children: <Widget>[
                                                SizedBox(height: 1,),
                                                Text("SIGN UP", style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                              ],
                                            ),
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

                        Center(
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 16.0,fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                ),
              )
          )

      ),
    );
  }
}
