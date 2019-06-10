/// FlashPayMain app.
/// [author] Kevin Zhang
/// [time] 2019-6-10

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/view/flash_pay/flash_pay_receive.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class FlashPayMain extends StatefulWidget {
  static String tag = "FlashPayMain";

  @override
  _FlashPayMainState createState() => _FlashPayMainState();
}

class _FlashPayMainState extends State<FlashPayMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).flashPayMainPageAppBarTitle),
        actions: <Widget>[
          FlatButton(
            child: Text(WalletLocalizations.of(context).flashPayMainPageAppBarAction),
            onPressed: () {
              // Navigator.of(context).pop();
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            _balanceOfUSDT(),
            _frozenOfUSDT(),
            _depositAndWithdrawal(),
            _receieveAndPay(),
          ],
        ),
      ),
    );
  }

  /// USDT Balance
  Widget _balanceOfUSDT() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: <Widget>[
          Text(WalletLocalizations.of(context).flashPayMainPageBalance),
          Expanded(child: Container()),
          Text(
            '0.00000000',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          SizedBox(width: 20),
          Text('USDT'),
        ],
      ),
    );
  }

  /// USDT Frozen
  Widget _frozenOfUSDT() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: <Widget>[
          Text(WalletLocalizations.of(context).flashPayMainPageFrozen),
          Expanded(child: Container()),
          Text(
            '0.00000000',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(width: 20),
          Text('USDT'),
        ],
      ),
    );
  }

  /// Buttons
  Widget _depositAndWithdrawal() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: <Widget>[
          CustomRaiseButton( // Deposit button.
            context: context,
            title: WalletLocalizations.of(context).flashPayMainPageDeposit,
            titleColor: Colors.white,
            leftIconName: 'icon_back',
            color: AppCustomColor.btnConfirm,
            callback: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => FlashPayReceive()));
            },
          ),

          SizedBox(width: 30),
          CustomRaiseButton( // Withdrawal button.
            context: context,
            title: WalletLocalizations.of(context).flashPayMainPageWithdrawal,
            titleColor: Colors.white,
            rightIconName: 'icon_next',
            color: AppCustomColor.btnConfirm,
            callback: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => WelcomePageThree()));
            },
          ),
        ],
      ),
    );
  }

  /// Buttons
  Widget _receieveAndPay() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: <Widget>[
          CustomRaiseButton( // Deposit button.
            context: context,
            // flex: 2,
            title: WalletLocalizations.of(context).flashPayMainPageFlashReceive,
            titleColor: Colors.white,
            leftIconName: 'icon_back',
            color: AppCustomColor.btnConfirm,
            callback: () {
              // Navigator.pop(context);
            },
          ),

          SizedBox(width: 30),
          CustomRaiseButton( // Withdrawal button.
            context: context,
            // flex: 3,
            title: WalletLocalizations.of(context).flashPayMainPageFlashPay,
            titleColor: Colors.white,
            rightIconName: 'icon_next',
            color: AppCustomColor.btnConfirm,
            callback: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => WelcomePageThree()));
            },
          ),
        ],
      ),
    );
  }
}