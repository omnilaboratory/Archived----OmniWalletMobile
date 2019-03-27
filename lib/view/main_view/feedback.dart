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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WalletLocalizations.of(context).feedbackPageTitle),
      ),

      body: FormKeyboardActions(
        actions: _keyboardActions(),
        
        child: SafeArea(
          child: Column(
            children: <Widget>[
              TextField( // title
                decoration: InputDecoration(
                  filled: true, 
                  labelText: WalletLocalizations.of(context).feedbackPageInputTitleTooltip,
                ),

                // keyboardType: TextInputType.number,
                focusNode: _nodeText1,
              ),

              TextField( // content
                decoration: InputDecoration(
                  filled: true, 
                  labelText: WalletLocalizations.of(context).feedbackPageContentTooltip,
                ),

                maxLines: 2,
                focusNode: _nodeText2,
              ),
            ],
          ),
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
    ];

    return actions;
  }
  
  // Build FAQ list
  List<Widget> _buildFAQList() {
    // list tile
    List<Widget> _list = List();

    // FAQ list
    List<String> faqList = <String> [
      'Q-1','Q-2','Q-3',
    ];

    for (int i = 0; i < faqList.length; i++) {
      _list.add(_faqItem(faqList[i]));
    }

    var divideList = ListTile.divideTiles(context: context, tiles: _list).toList();

    return divideList;
  }

  //
  Widget _faqItem(String item) {
    return ListTile(
      title: Text(item),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () { 
        // TODO: show next page.
        print('menu list');
        Navigator.of(context).pushNamed('routeName');
      },
    );
  }
}