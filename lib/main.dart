import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MaterialApp(
  home: new HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  final String url="https://swapi.co/api/people/";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"}

    );

    print(response.body);

    setState(() {
      var toJsonData = json.decode(response.body);
      data = toJsonData['results'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("GET API"),
        ),
        body: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Card(
                              child: new Container(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title:Text(data[index]['name']) ,
                                      subtitle: Text(data[index]['eye_color']),
                                      leading: CircleAvatar(radius: 50.0,
                                        child: Text(data[index]['height']),
                                      ),
                                      
                                    ),

                                  ],
                                ),
                                padding: const EdgeInsets.all(20),
                              ))
                        ],
                      )));
            }));
  }
}