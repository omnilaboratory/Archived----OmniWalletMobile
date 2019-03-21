/// My profile page.
/// [author] Kevin Zhang
/// [time] 2019-3-21

import 'package:flutter/material.dart';

class UserCenter extends StatefulWidget {
  @override
  _UserCenterState createState() => _UserCenterState();
}

class _UserCenterState extends State<UserCenter> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   title: _appBarTitle(),
      // ),
      
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _bannerArea(),
            _menuList(),
          ],
        ),
      )
    );
  }

  // AppBar Title
  Widget _bannerArea() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      height: 200,
      decoration: BoxDecoration(
        // color: Colors.blue[200],
        image: DecorationImage(
          image: AssetImage('assets/img1.jpg'),
          fit: BoxFit.cover,
        )
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // user avatar.
          Image.asset('assets/logo-png.png', width: 70, height: 70),
          SizedBox(height: 20),
          // user nick name
          Text(
            'Nick Name',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  //
  Widget _menuList() {
    return ListTile(
      leading: Icon(Icons.chevron_right),
      title: Text('test'),
      trailing: Icon(Icons.chevron_right),
      onTap: () { 
        // TODO: show next page.
      },
    );
  }

}
