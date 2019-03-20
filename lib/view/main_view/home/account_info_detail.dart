import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_app/model/wallet_info.dart';
import 'package:wallet_app/view_model/main_model.dart';

class AccountInfoDetail extends StatelessWidget {
  MainStateModel stateModel = null;
  TradeInfo tradeInfo = null;

  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);
    tradeInfo = stateModel.currTradeInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body:this.body()
    );
  }

  Widget body(){
    return Container(
      margin: EdgeInsets.only(top: 20,left: 20),
      child: ListView.builder(
          itemCount: 7,
          itemBuilder: (BuildContext context, int index){
              return this.buildItem(context,index);
          }),
    );
  }
  Widget buildItem(BuildContext context, int index){
    if(index == 0)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(tradeInfo.tradeDate.toString()),
          Text('转出 ${tradeInfo.amount.toStringAsFixed(8)}'),
          Text('到        ${tradeInfo.objAddress}'),
        ],
      );
  }
}
