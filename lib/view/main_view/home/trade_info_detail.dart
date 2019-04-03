import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/model/wallet_info.dart';
import 'package:wallet_app/view/main_view/home/omni_website.dart';
import 'package:wallet_app/view/main_view/home/send_confirm_page.dart';
import 'package:wallet_app/view_model/main_model.dart';

class TradeInfoDetail extends StatelessWidget {
  MainStateModel stateModel = null;
  TradeInfo tradeInfo = null;

  var textStyleTitle = TextStyle(
    color: Colors.grey,
  );
  var textStyleBody = TextStyle(
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);
    tradeInfo = stateModel.currTradeInfo;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('交易记录详情'),
      ),
      body:this.body(context)
    );
  }

  Widget body(BuildContext context){
    var line1 = Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text('Sent BTC',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87
                    ),
                  ),
                ),
                Text(
                  '${tradeInfo.amount.toStringAsFixed(8)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    tradeInfo.state==0?'Confirming':'Finish',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                    ),
                  ),
                ),
              ],
            );
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20,left: 20,right: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 40),
                  width: double.infinity, child: line1
              ),
              line("To",tradeInfo.objAddress),
              line("Memo",tradeInfo.note),
              line("Date",DateFormat('yyyy.MM.dd hh:mm').format(tradeInfo.tradeDate)),
              line("交易Id",tradeInfo.txId),
              line("确认Block",tradeInfo.blockId.toString()),
              line("确认数量",tradeInfo.confirmAmount.toString()),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                        return WebViewPage();
                      }));
                    },
                    child: Text('浏览Omni网站'),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
  Widget line(String title,String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: textStyleTitle,
                  ),
                ),
                Text(content,style: textStyleBody,)
              ],
            ),
    );
  }
}
