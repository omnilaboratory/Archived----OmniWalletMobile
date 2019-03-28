/// Submit Feedback page.
/// [author] Kevin Zhang
/// [time] 2019-3-25

import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class SubmitFeedback extends StatefulWidget {
  static String tag = "SubmitFeedback";

  @override
  _SubmitFeedbackState createState() => _SubmitFeedbackState();
}

class _SubmitFeedbackState extends State<SubmitFeedback> {

  //
  FocusNode _nodeText1 = FocusNode();
  FocusNode _nodeText2 = FocusNode();
  FocusNode _nodeText3 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(WalletLocalizations.of(context).feedbackPageTitle),
        elevation: 0,
      ),

      body: FormKeyboardActions(
        actions: _keyboardActions(),
        child: SafeArea(
          child: _content(),
        ),
      ),
    );
  }

  // Keyboard Actions
  List<KeyboardAction> _keyboardActions() {

    List<KeyboardAction> actions = <KeyboardAction> [
      KeyboardAction(
        focusNode: _nodeText1,
        closeWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        )
      ),

      KeyboardAction(
        focusNode: _nodeText2,
        closeWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        )
      ),

      KeyboardAction(
        focusNode: _nodeText3,
        closeWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        )
      ),
    ];

    return actions;
  }
  
  //
  Widget _content() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField( // title
            decoration: InputDecoration(
              labelText: WalletLocalizations.of(context).feedbackPageInputTitleTooltip,
              labelStyle: TextStyle(
                color: Colors.blue,
              ),
              border: InputBorder.none,
              fillColor: Colors.white,
              filled: true, 
            ),

            focusNode: _nodeText1,
          ),

          SizedBox(height: 20),

          TextField( // content
            decoration: InputDecoration(
              labelText: WalletLocalizations.of(context).feedbackPageContentTooltip,
              labelStyle: TextStyle(
                color: Colors.blue,
              ),
              border: InputBorder.none,
              fillColor: Colors.white,
              filled: true, 
            ),

            maxLines: null,
            focusNode: _nodeText2,
          ),

          // Upload Picture Title
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              WalletLocalizations.of(context).feedbackPageUploadPicTitle,
            ),
          ),
          
          Container(  // Upload Picture Button
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              // elevation: 4.0,
              shape: CircleBorder(),
              color: Colors.transparent,
              child: Ink.image(
                image: AssetImage('assets/upload_picture.png'),
                fit: BoxFit.cover,
                width: 80,
                height: 80,
                child: InkWell(
                  onTap: () {},
                  child: null,
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          TextField( // Email
            decoration: InputDecoration(
              labelText: WalletLocalizations.of(context).feedbackPageEmailTooltip,
              labelStyle: TextStyle(
                color: Colors.blue,
              ),
              border: InputBorder.none,
              fillColor: Colors.white,
              filled: true, 
            ),

            focusNode: _nodeText3,
            keyboardType: TextInputType.emailAddress,
          ),

        ],
      ),
    );
  }
}