import 'package:flutter/material.dart';

import 'create_account.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            Column(
              children: <Widget>[
                Image.asset('assets/LunarX_Logo.jpg'),
                SizedBox(height: 16.0),
                Text('LunarX_Omni Wallet'),

                // Button - Create new wallet
                SizedBox(height: 100.0),
                RaisedButton(
                  child: Text('Create new wallet'),
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  onPressed: () {
                    // TODO: Show the create new wallet page.
                    // print('Current page: $context');
                    Navigator.push(context, new MaterialPageRoute( 
                      builder: (context) => new CreateAccount()) );
                  },
                ),

                // Button - Restore wallet
                SizedBox(height: 10.0),
                RaisedButton(
                  child: Text('   Restore wallet   '),
                  onPressed: () {
                    // TODO: Show the restore wallet page.
                  },
                ),
              ],
            ),

            // TODO: Select language.

          ],
        ),
      ),
    );
  }
}
