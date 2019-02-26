import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Create New Account'),
      ),

      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 50.0), // spacer - 空位符

            Column(
              children: <Widget>[
                // TextField - Account Name
                TextField(
                  decoration:
                      InputDecoration(filled: true, labelText: 'Account Name'),
                ),

                // TextField - Password
                SizedBox(height: 30.0),
                TextField(
                  decoration:
                      InputDecoration(filled: true, labelText: 'Password'),
                ),

                // TextField - Repeat Password
                SizedBox(height: 30.0),
                TextField(
                  decoration: InputDecoration(
                      filled: true, labelText: 'Repeat Password'),
                ),

                // Button - Create wallet
                SizedBox(height: 100.0),
                RaisedButton(
                  child: Text('Create'),
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  onPressed: () {
                    // TODO: next page.
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}