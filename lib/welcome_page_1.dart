import 'package:flutter/material.dart';
import 'welcome_page_2.dart';

class WelcomePageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: _childColumn(context),
        ),
      )
    );
  }

  // Child content.
  Widget _childColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Title
        Text(
          'Welcome to the Omni Platform!',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Image for welcome.
        Image.asset('assets/LunarX_Logo.jpg'),

        // Introduction content.
        Text(
          'Please take some time to understand some important things for your own safety. \n\nWe cannot recover your funds or freeze your account if you visit a phishing site or lose your backup phrase (aka SEED phrase).  \n\nBy continuing to use our platform, you agree to accept all risks associated with the loss of your SEED, including but not limited to the inability to obtain your funds and dispose of them. In case you lose your SEED, you agree and acknowledge that the Waves Platform would not be responsible for the negative consequences of this.',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.grey[700]),
        ),

        // Next button.
        RaisedButton(
          child: Text('What you need to know about your SEED'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            // Show the welcome page two.
            // print('Current page: $context');
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new WelcomePageTwo()));
          },
        ),
      ],
    );
  }
}
