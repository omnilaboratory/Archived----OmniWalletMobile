import 'package:flutter/material.dart';

class ColumnDemo extends StatefulWidget {
  @override
  _ColumnDemoState createState() => _ColumnDemoState();
}

class _ColumnDemoState extends State<ColumnDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
          ListTile(title: Text('item'),),
        ],
      ),
    );
  }
}
