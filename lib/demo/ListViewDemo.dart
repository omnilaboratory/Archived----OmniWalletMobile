
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StarWarsData extends StatefulWidget {
  @override
  _StarWarsDataState createState() => _StarWarsDataState();
}

class _StarWarsDataState extends State<StarWarsData> {

  final String url = "https://swapi.co/api/starships";
  List data;

  @override void initState() {
    super.initState();
    this.getSWData();
  }

  Future<String> getSWData() async{
     var res = await http.get(url);
     setState(() {
       var resBody = json.decode(res.body);
       data = resBody['results'];
     });
     return "ok";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars Starships'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
          itemCount: data==null?0:data.length,
          itemBuilder:(BuildContext context,int index){
            return Container(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Text('Name:'),
                          Text(data[index]['name'])
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Text('model:'),
                          Text(data[index]['model'])
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 30,)
                ],
              ),
            );
          }
      ),

    );
  }
}
