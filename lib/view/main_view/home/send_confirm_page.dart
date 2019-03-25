import 'package:flutter/material.dart';
import 'package:wallet_app/model/wallet_info.dart';
import 'package:wallet_app/view_model/main_model.dart';

class SendConfirm extends StatelessWidget {
  static String tag = "Send Confirm";
  MainStateModel stateModel = null;
  SendInfo _sendInfo ;
  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);
    this._sendInfo = stateModel.sendInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text(SendConfirm.tag),
      ),
      body: this.body(context),
    );
  }
  Widget body(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 30,left: 20,right: 20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: <Widget>[
                Text(
                  'To',
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(child: Container()),
                Text(_sendInfo.toAddress,style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Text(
                  'Amount',
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(child: Container()),
                Text("${_sendInfo.amount} BTC",style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Text(
                  'Miner Fee',
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(child: Container()),
                Text("${_sendInfo.minerFee} BTC",style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Text(
                  'Memo',
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(child: Container()),
                Text("${_sendInfo.note}",style: TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RaisedButton(
              color: Colors.lightBlue[300],
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.35,vertical: 20),
                onPressed: (){
             },
              child: Text('Confirm',style: TextStyle(color: Colors.white,fontSize: 20),),
            ),
          )
        ],
      ),
    );
  }
}
