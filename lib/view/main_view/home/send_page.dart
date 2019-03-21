import 'package:flutter/material.dart';
import 'package:wallet_app/model/wallet_info.dart';
import 'package:wallet_app/view_model/main_model.dart';

/**
 * 钱包转账
 */
class WalletSend extends StatefulWidget {
  @override
  _WalletSendState createState() => _WalletSendState();
}
class _WalletSendState extends State<WalletSend> {

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
        appBar: AppBar(title: Text(accountInfo.name+"转账"),),
        body: this.body()
    );
  }

  Widget body(){

    var line1 = Padding(
      padding: EdgeInsets.only(left: 30,top: 30,right: 30),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('转账地址',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
              Expanded(child: Container()),
              InkWell(child: Text('常用地址'),onTap: (){

              },)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: TextField(
              scrollPadding: EdgeInsets.only(top: 10),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8,top: 20,bottom:10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    labelText:'请输入地址',
                    labelStyle: TextStyle(fontSize: 14)
                ),
            ),
          ),
        ],
      )
    );

    var line2 = Padding(
        padding: EdgeInsets.only(left: 30,top: 30,right: 30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('转账数量',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                Expanded(child: Container()),
                Text('余额：${accountInfo.amount.toStringAsFixed(8)}')
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextField(
                keyboardType:TextInputType.number ,
                scrollPadding: EdgeInsets.only(top: 0),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8,top: 20,bottom:10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    labelText:'请输入数量',
                    labelStyle: TextStyle(fontSize: 14)
                ),
              ),
            ),
          ],
        )
    );

    var line3 = Padding(
        padding: EdgeInsets.only(left: 30,top: 30,right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[
            Text('备注',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8,top: 20,bottom:10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      labelText:'备注（选填）',
                      labelStyle: TextStyle(fontSize: 14)
                  ),
                ),
              ),
            )
          ],
        )
    );

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          line1,
          line2,
          line3
        ],
      ),
    );
  }
}
