

import 'package:covidapplicationtest/Home.dart';
import 'package:covidapplicationtest/authenticate.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print("THIS IS THE WRAPPER");
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return HomePage();
    }

  }
}