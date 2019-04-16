import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/model/wallet_info.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/main_view/home/send_page.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/main_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

//收款页面
class ReceivePage extends StatefulWidget {
  @override
  _ReceivePageState createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  MainStateModel stateModel = null;
  WalletInfo walletInfo;
  AccountInfo accountInfo;

  final key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);
    walletInfo = stateModel.currWalletInfo;
    accountInfo = stateModel.currAccountInfo;
    return Scaffold(
      key: this.key,
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(title: Text(accountInfo.name+' '+WalletLocalizations.of(context).wallet_detail_content_receive),),
      body: this.body()
    );
  }

  copyAddress(){
    Clipboard.setData(new ClipboardData(text: walletInfo.address));
    this.showTips(WalletLocalizations.of(context).wallet_receive_page_tips_copy);
  }

  Widget body(){
    return Column(
      children: <Widget>[
        Container(height: 100,),
        GestureDetector(
          onLongPress: (){
            copyAddress();
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Tools.imagePath('icon_code_bg')))
            ),
            child: QrImage(
              data: walletInfo.address,
              size: 188.0,
              foregroundColor: Colors.blue[800],
              padding: EdgeInsets.all(20),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 10,bottom: 60),
            child: Text(walletInfo.address)
        ),
        Container(
          margin: EdgeInsets.only(top: 30,bottom: 20,left: 16,right: 16),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRaiseButton(
                context: context,
                callback: (){
                  copyAddress();
                },
                title: WalletLocalizations.of(context).wallet_receive_page_copy,
                titleColor: Colors.blue,
                leftIconName: 'icon_copy',
                color: AppCustomColor.btnCancel,
              ),
              SizedBox(width: 30,),
              CustomRaiseButton(
                context: context,
                callback: (){
                  this.showTips(WalletLocalizations.of(context).wallet_receive_page_tips_share);
                },
                title: WalletLocalizations.of(context).wallet_receive_page_share,
                titleColor: Colors.white,
                leftIconName: 'icon_share',
                color: AppCustomColor.btnConfirm,
              ),
            ],
          ),
        )
      ],
    );
  }

  showTips(String content){
    this.key.currentState.hideCurrentSnackBar();
    this.key.currentState.showSnackBar(
        SnackBar(
          content: Text(content),
          duration: Duration(seconds: 1,milliseconds: 200),
        ),
    );
  }
}