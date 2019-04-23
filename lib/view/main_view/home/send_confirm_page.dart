import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/model/global_model.dart';
import 'package:wallet_app/model/mnemonic_phrase_model.dart';
import 'package:wallet_app/model/wallet_info.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/tools/net_config.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/main_model.dart';
import 'package:simple_rsa/simple_rsa.dart';

class SendConfirm extends StatelessWidget {
  static String tag = "Send Confirm";
  MainStateModel stateModel = null;
  AccountInfo accountInfo = null;
  WalletInfo walletInfo = null;
  SendInfo _sendInfo ;
  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);
    this._sendInfo = stateModel.sendInfo;
    walletInfo =  stateModel.currWalletInfo;
    accountInfo = stateModel.currAccountInfo;

    return Scaffold(
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        title: Text(SendConfirm.tag),
      ),
      body: this.body(context),
    );
  }
  Widget body(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 10,left: 20,right: 20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: <Widget>[
                AutoSizeText(
                  WalletLocalizations.of(context).wallet_send_page_to,
                  style: TextStyle(color: Colors.grey),
                  minFontSize: 9,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(child: Container()),
                Text('${_sendInfo.toAddress==null?'':_sendInfo.toAddress}',style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Text(
                  WalletLocalizations.of(context).wallet_send_page_title_amount,
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(child: Container()),
                Text("${_sendInfo.amount==null?0:_sendInfo.amount} BTC",style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Text(
                  WalletLocalizations.of(context).wallet_send_page_title_minerFee_input_title,
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(child: Container()),
                Text("${_sendInfo.minerFee==null?0:_sendInfo.minerFee} BTC",style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Text(
                  WalletLocalizations.of(context).wallet_send_page_title_note,
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(child: Container()),
                Text("${_sendInfo.note==null?'':_sendInfo.note}",style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CustomRaiseButton(
              hasRow: false,
              context: context,
              callback: (){
                this.transfer(context);
              },
              title: WalletLocalizations.of(context).common_btn_confirm,
              titleColor: Colors.white,
              color: AppCustomColor.btnConfirm,
            ),
          ),
        ],
      ),
    );
  }
  transfer(BuildContext context){
    print(accountInfo.propertyId);
    //btc send
    if(accountInfo.propertyId==0){
      Future futureRSA = NetConfig.get(NetConfig.getUserRSAEncrypt);
      futureRSA.then((publicKey){
        HDWallet wallet = MnemonicPhrase.getInstance().createAddress(GlobalInfo.userInfo.mnemonic,index: walletInfo.addressIndex);
//        var encryptedFuture = encryptString(wallet.wif, publicKey);
//        encryptedFuture.then((encryptedString){
          Future future = NetConfig.post(NetConfig.btcSend, {
            'fromBitCoinAddress':accountInfo.jsonData['address'],
            'privkey':wallet.wif,
            'toBitCoinAddress':_sendInfo.toAddress,
            'amount':_sendInfo.amount.toString(),
            'minerFee':_sendInfo.minerFee.toString(),
          });
          future.then((data){
            if(data!=null){
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          });
        });
//      });
    }else{


    }
  }
}
