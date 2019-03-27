import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableItemDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('title'),),
      body: new Slidable(
        delegate: new SlidableDrawerDelegate(),
        actionExtentRatio: 0.25,
        child: new Container(
          color: Colors.white,
          child: new ListTile(
            onTap: (){
              debugPrint('a');
            },
            leading: new CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: new Text('3'),
              foregroundColor: Colors.white,
            ),
            title: new Text('Tile n°'),
            subtitle: new Text('SlidableDrawerDelegate'),
          ),
        ),
//        actions: <Widget>[
//          new IconSlideAction(
//            caption: 'Archive',
//            color: Colors.blue,
//            icon: Icons.archive,
//            onTap: () => debugPrint('Archive'),
//          ),
//          new IconSlideAction(
//            caption: 'Share',
//            color: Colors.indigo,
//            icon: Icons.share,
//            onTap: () => debugPrint('Share'),
//          ),
//        ],
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: 'More',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () => debugPrint('More'),
          ),
          new IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => debugPrint('Delete'),
          ),
        ],
      ),
    );
  }
}
