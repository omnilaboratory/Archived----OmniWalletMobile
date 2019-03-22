import 'package:flutter/material.dart';

class RadioDemo extends StatefulWidget {
  @override
  _RadioDemoState createState() => _RadioDemoState();
}

class _RadioDemoState extends State<RadioDemo> {

  int _value1 = 0;
  int _value2 = 0;

  void _setvalue2(int value) => setState(() => _value2 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('title'),),
      body: ExpansionTile(
        title: Text('abc'),
          children: [
            this.makeRadioTiles()
          ],
      ),
    );
  }


  Widget makeRadioTiles() {
    List<Widget> list = new List<Widget>();

    for(int i = 0; i < 3; i++){
      list.add(new RadioListTile(
        value: i,
        groupValue: _value2,
        onChanged: _setvalue2,
        activeColor: Colors.green,
        controlAffinity: ListTileControlAffinity.trailing,
        title: new Text('Item: ${i}'),
        subtitle: new Text('sub title'),
      ));
    }

    Column column = new Column(children: list,);
    return column;
  }
}
