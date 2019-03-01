import 'package:flutter/material.dart';
import 'welcome_page_3.dart';

class WelcomePageTwo extends StatelessWidget {

  // Assets
  final String img_1 = 'assets/LunarX_Logo.jpg';
  final String txt_1 = 'You use your wallet anonymously, meaning your account is not connected to an email account or any other identifying data.';
  final String txt_2 = 'Your password protects your account when working on a certain device or browser. It is needed in order to ensure that your secret phrase is not saved in storage.';
  final String txt_3 = 'If you forget your password, you can easily create a new one by using the account recovery form via your secret phrase. If you lose your secret phrase, however, you will have no way to access your account.';
  final String txt_4 = 'You cannot change your secret phrase. If you accidentally sent it to someone or suspect that scammers have taken it over, then create a new Waves wallet immediately and transfer your funds to it.';

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
          'What you need to know \nabout your SEED',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Introduction content.
        SizedBox(height: 40),
        Text(
          'When registering your account, you will be asked to save your secret phrase (SEED) and to protect your account with a password. \n\nOn normal centralized servers, special attention is paid to the password, which can be changed and reset via email, if the need arises. \n\nHowever, on decentralized platforms such as Waves, everything is arranged differently:',
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
          child: Text('Protect Yourself'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            // Show the welcome page three.
            // print('Current page: $context');
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new WelcomePageThree()));
          },
        ),
      ],
    );
  }
}