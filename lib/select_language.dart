import 'package:flutter/material.dart';

class SelectLanguage extends StatefulWidget {

  // App current language.
  final String currentLanguage;
  SelectLanguage(this.currentLanguage);

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  
  // List content.
  List<Widget> _list = List();
  List<String> items = <String> [
    'English', '简体中文',
  ];

  // Build list tile.
  Widget _buildListData(BuildContext context, String item) {

    if (item == widget.currentLanguage) {
      print(widget.currentLanguage);
      return ListTile(
        title: Text(item),
        trailing: Icon(Icons.check),
        onTap: () {
          print('click tile.');
        },
      );

    } else {
      return ListTile(
        title: Text(item),
        onTap: () {
          print('click tile.');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    for (int i = 0; i < items.length; i++) {
      _list.add(_buildListData(context, items[i]));
    }

    var divideList = ListTile.divideTiles(context: context, tiles: _list).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          children: divideList,
        ),
      )
    );
  }
}