/// FlashPayMain app.
/// [author] Kevin Zhang
/// [time] 2019-6-10

import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/view/flash_pay/flash_pay_deposit.dart';
import 'package:wallet_app/view/flash_pay/flash_pay_receive.dart';
import 'package:wallet_app/view/flash_pay/flash_pay_user_register.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/state_lib.dart';

import 'flash_pay_lib.dart';

class FlashPayMain extends StatefulWidget {
  static String tag = "FlashPayMain";

  @override
  _FlashPayMainState createState() => _FlashPayMainState();
}

class _FlashPayMainState extends State<FlashPayMain> {

  MainStateModel stateModel = null;

  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);

    print("FlashPayMain begin");
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model)
    {
      if(GlobalInfo.userInfo.fpUserInfo==null){
        return FPUserRegister();
      }
      print("FlashPayMain go next page");

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
              Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'USDT',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  )
              ),
              _balanceOfUSDT(),
              _frozenOfUSDT(),
              _scanAndFriends(),
              _depositAndWithdrawal(),
              _collectAndTransfer(),
            ],
          ),
        ),
      );
    });

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
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  /// USDT Frozen
  Widget _frozenOfUSDT() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
        ],
      ),
    );
  }

  /// Buttons
  Widget _scanAndFriends() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 60, bottom: 30),
      child: Row(
        children: <Widget>[
          CustomRaiseButton( // Scan button.
            context: context,
            title: WalletLocalizations.of(context).flashPayMainPageScan,
            titleColor: Colors.white,
            leftIconName: 'icon_back',
            color: AppCustomColor.btnConfirm,
            callback: () {
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => FlashPayReceive()));
            },
          ),
          SizedBox(width: 30),
          CustomRaiseButton( // Friends button.
            context: context,
            title: WalletLocalizations.of(context).flashPayMainPageFriends,
            titleColor: Colors.white,
            rightIconName: 'icon_next',
            color: AppCustomColor.btnConfirm,
            callback: () {
              Navigator.pushNamed(context, FPFrinedList.tag);
            },
          ),
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
                MaterialPageRoute(builder: (context) => FlashPayDeposit()));
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
  Widget _collectAndTransfer() {
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
