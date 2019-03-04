import 'package:flutter/material.dart';
import 'start.dart';

class WelcomePageThree extends StatelessWidget {

  // Assets
  final String img_1 = 'assets/LunarX_Logo.jpg';
  final String txt_1 = 'Always check the URL: https://www.lunarx_omni.com';
  final String txt_2 = 'Do not use browsers that have extensions or plugins to access your account.';
  final String txt_3 = 'Do not open emails or links from unknown senders.';
  final String txt_4 = 'Regularly update your browser and operating system.';
  final String txt_5 = 'Use official security software. Do not install unknown software which could be hacked.';
  final String txt_6 = 'Do not access your wallet when using public Wi-Fi or someone else’s device.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            children: <Widget>[
              _childColumn(context),
            ],
          ),
        )
    );
  }

  // Child content.
  Widget _childColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        // Title
        Text(
          'How To Protect Yourself \nfrom Phishers',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Introduction content.
        SizedBox(height: 40),
        Text(
          'One of the most common forms of scamming is phishing, which is when scammers create fake communities on Facebook or other websites that look similar to the authentic ones.',
          style: TextStyle(color: Colors.grey[700]),
        ),

        // List content.
        SizedBox(height: 40),
        _listContent(img_1, txt_1),

        SizedBox(height: 20),
        _listContent(img_1, txt_2),

        SizedBox(height: 20),
        _listContent(img_1, txt_3),

        SizedBox(height: 20),
        _listContent(img_1, txt_4),

        SizedBox(height: 20),
        _listContent(img_1, txt_5),

        SizedBox(height: 20),
        _listContent(img_1, txt_6),

        SizedBox(height: 40),
        _bottomButton(context),
      ],
    );
  }

  //
  Widget _listContent(String img, String txt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(img, width: 50, height: 50),
        SizedBox(width: 30),
        Expanded(
          child: Text(
            txt,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  // Buttons
  Widget _bottomButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Back button.
        RaisedButton(
          child: Text('Go Back'),
          onPressed: () { Navigator.pop(context); },
        ),

        // Next button.
        RaisedButton(
          child: Text('I Understand'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => StartPage()), 
              (route) => route == null
            );
          },
        ),
      ],
    );
  }
}