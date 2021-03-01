import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_app/data.dart';
import 'package:http/http.dart' as http;

import 'fullscreen.dart';

class GalleryPage extends StatefulWidget {
  final String imgPath;

  GalleryPage({Key key, this.imgPath}) : super(key: key);

  

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List data = [];
  List<String> imgUrls = [];
  List<String> description = [];
  List<String> author = [];
  bool showImg = false;

  getPhotos() async {
    http.Response response = await http.get(
        'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');
    data = json.decode(response.body);
    print(response.body);
    _assign();
    setState(() {
      showImg = true;
    });
  }

  _assign() {
    for (var i = 0; i < data.length; i++) {
      imgUrls.add(data.elementAt(i)["urls"]["raw"]);
      description.add(data.elementAt(i)["alt_description"]);
      author.add(data.elementAt(i)["user"]["username"]);
    }
  }


  @override
  Widget build(BuildContext context) {
    
    getPhotos();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unsplash Devsteam',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.separated(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(imgPath: imgUrls.elementAt(index))));
            },
            child: Container(
              height: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Hero(
                        tag: "widget.imgPath",
                         child: Container(
                           child: !showImg
                           ? CircularProgressIndicator()
                           : Image.network(imgUrls.elementAt(index), fit: BoxFit.cover,)))),
                      // !showImg
                      //     ? CircularProgressIndicator()
                      //     : Image(
                      //         image: NetworkImage(imgUrls.elementAt(index)),
                              //fit: BoxFit.cover),
                    ),
                 
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      '"${description.elementAt(index)}"',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                      child: Text(
                    '@${author.elementAt(index)}',
                    style: TextStyle(color: Colors.black38),
                  ),
                  ),
                ]
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
