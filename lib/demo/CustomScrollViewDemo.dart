
import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('title'),),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Text('header'),
          ),
          SliverGrid.count(
            crossAxisCount: 4,
            children:[
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
              const ListTile(title: Text('Abc'),),
            ]
          ),
          SliverFixedExtentList(
                itemExtent: 100.0,
                delegate: SliverChildListDelegate(
                  [
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                    const ListTile(title: Text('12345'),),
                  ]
                ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
                const ListTile(title: Text('Abc'),),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Text('footer'),
          ),
        ],
      ),
    );
  }
}
