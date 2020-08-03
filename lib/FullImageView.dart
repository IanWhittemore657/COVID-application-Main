import "package:flutter/material.dart";
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
class FullScreen extends StatefulWidget {
  final String text;
  FullScreen({Key key, @required this.text}) : super(key:key);

  @override
  _FullScreenState createState() => _FullScreenState();
}


class _FullScreenState extends State<FullScreen> {

  String image = "";
  String errorimage = "https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101065/112815953-stock-vector-no-image-available-icon-flat-vector.jpg?ver=6";

  @override
  Widget build(BuildContext context) {

    setState(() {
      image = widget.text;
    });
    if(image == "")
      {
        setState(() {
          image = errorimage;
        });
        print("The image is null");
      }
    else
      {
        print(image);
        print("there is an image");
      }

    return Scaffold(
      backgroundColor: Color.fromRGBO(174, 201, 218, 1),
      body: GestureDetector(
        child: Center(
            child: PhotoView(
              imageProvider:
              CachedNetworkImageProvider(image),
//          imageProvider: AssetImage("$image"),
            ),
          ),

        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
