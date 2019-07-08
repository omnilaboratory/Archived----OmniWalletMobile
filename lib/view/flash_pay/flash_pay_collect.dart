/// FlashPayCollect app.
/// [author] Kevin Zhang
/// [time] 2019-6-10

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';

class FlashPayCollect extends StatefulWidget {

  /// 1:Deposit 2:Flash Receive
  // final int parentID;
  // FlashPayReceive({Key key, @required this.parentID}) : super(key: key);

  @override
  _FlashPayCollectState createState() => _FlashPayCollectState();
}

class _FlashPayCollectState extends State<FlashPayCollect> {
  // WalletInfo walletInfo;

  // final key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // walletInfo = widget.walletInfo;
    return Scaffold(
      // key: this.key,
      backgroundColor: AppCustomColor.themeBackgroudColor,
      // appBar: AppBar(title: Text(WalletLocalizations.of(context).flashPayMainPageDeposit),),
      appBar: AppBar(title: Text('Collect')),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _title(),
            _showQR(),
            _omniAddress(),
            _copyAndShare(),
          ],
        ),
      ),
    );
  }

  ///
  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 40),
      child: Text(
        // WalletLocalizations.of(context).flashPayPaymentMethodPageMethod_1,
        'Use OmniWallet Scan to pay me',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  ///
  Widget _showQR() {
    return GestureDetector(
      onLongPress: () {
        _copyAddress();
      },

      child: Container(
        margin: EdgeInsets.only(top: 50, bottom: 40),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Tools.imagePath('icon_code_bg')))
        ),

        child: QrImage(
          data: 'address for Flash Pay User',  // To be done.
          size: 188.0,
          foregroundColor: Colors.blue[800],
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  ///
  Widget _omniAddress() {
    return AutoSizeText(
      'address for Flash Pay User',  // To be done.
      maxLines: 1,
      minFontSize: 9,
      overflow: TextOverflow.fade,
    );
  }

  ///
  Widget _copyAndShare() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: <Widget>[
          CustomRaiseButton(
            context: context,
            callback: () {
              _copyAddress();
            },
            title: WalletLocalizations.of(context).wallet_receive_page_copy,
            titleColor: Colors.blue,
            leftIconName: 'icon_copy',
            color: AppCustomColor.btnCancel,
          ),
          SizedBox(width: 30,),
          CustomRaiseButton(
            context: context,
//                callback: (){
//                  this.showTips(WalletLocalizations.of(context).wallet_receive_page_tips_share);
//                },
            title: WalletLocalizations.of(context).wallet_receive_page_share,
            titleColor: Colors.white,
            leftIconName: 'icon_share',
            color: AppCustomColor.btnConfirm,
          ),
        ],
      ),
    );
  }

  ///
  void _copyAddress() {
    Tools.copyToClipboard('address for Flash Pay User');  // To be done.
    Tools.showToast(WalletLocalizations.of(context).wallet_receive_page_tips_copy);
  }
}