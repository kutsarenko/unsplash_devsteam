import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/homepage.dart';
import 'homepage.dart';

class FullScreen extends StatefulWidget {
  final dynamic imgPath;
 

  const FullScreen({Key key, @required this.imgPath}) : super(key: key);
  

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Unsplash Devsteam',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(children: <Widget>[
          Hero(
            tag: "widget.imgPath",
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                    Image.network(widget.imgPath, fit: BoxFit.cover)),
          ),
        ]));
  }
}
