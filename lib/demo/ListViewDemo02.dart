import 'package:flutter/material.dart';

class Demo02 extends StatefulWidget {
  @override
  _Demo02State createState() => _Demo02State();
}

class _Demo02State extends State<Demo02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body:  this.content(),
    );
  }
  Widget content(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(height: 200,color: Colors.black,),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index){
                return ListTile(title: Text('title${index}'),);
              }
          ),
        ],
      ),
    );
  }

  Widget content1(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
          ListTile(title: Text('title'),),
        ],
      ),
    );
  }


  Widget content2(){
    return Column(
      children: <Widget>[
        Container(height: 200,color: Colors.black,),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index){
                return ListTile(title: Text('title${index}'),);
              }
          ),
        ),
      ],
    );
  }
}
