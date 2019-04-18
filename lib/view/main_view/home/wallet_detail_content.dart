import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/model/wallet_info.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/main_view/home/send_page.dart';
import 'package:wallet_app/view/main_view/home/trade_info_detail.dart';
import 'package:wallet_app/view/main_view/home/receive_page.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/main_model.dart';

class WalletDetailContent extends StatefulWidget {
  @override
  _WalletDetailContentState createState() => _WalletDetailContentState();
}

class _WalletDetailContentState extends State<WalletDetailContent> with SingleTickerProviderStateMixin{

  MainStateModel stateModel = null;
  WalletInfo walletInfo;
  AccountInfo accountInfo;
  List<TradeInfo> tradeInfoes ;

  TabController mController;

  @override void initState() {
    super.initState();
    mController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);
    tradeInfoes = stateModel.tradeInfoes;
    walletInfo = stateModel.currWalletInfo;
    accountInfo = stateModel.currAccountInfo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildHeader(),
        Padding(
          padding: const EdgeInsets.only(top: 20,bottom: 10),
          child: TabBar(
              controller: mController,
              labelColor: Colors.blue,
              labelPadding: EdgeInsets.only(bottom: 4),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Text('All'),
                Text('Out'),
                Text('In'),
                Text('Failed'),
              ]),
        ),
        Expanded(
          child: TabBarView(
            controller: mController,
            children: <Widget>[
              ListView.builder(
                  itemCount:tradeInfoes.length,
                  itemBuilder: (BuildContext context, int index){
                    return detailTile(context,index);
                  }),
              ListView.builder(
                  itemCount:tradeInfoes.length,
                  itemBuilder: (BuildContext context, int index){
                    return detailTile(context,index);
                  }),
              ListView.builder(
                  itemCount:tradeInfoes.length,
                  itemBuilder: (BuildContext context, int index){
                    return detailTile(context,index);
                  }),
              ListView.builder(
                  itemCount:tradeInfoes.length,
                  itemBuilder: (BuildContext context, int index){
                    return detailTile(context,index);
                  }),
            ],
          ),
        ),
        buildFooter()
      ],
    );
  }

  Widget detailTile(BuildContext context, int index){
    TradeInfo tradeInfo = tradeInfoes[index];
    return InkWell(
      onTap: (){
        stateModel.currTradeInfo = tradeInfo;
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          return TradeInfoDetail();
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(child: Icon(Icons.arrow_upward),backgroundColor:Colors.green[100]),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('${accountInfo.name} '+('${tradeInfo.amount>0?'In':'Out'}'),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                            child: Text(
                              tradeInfo.state==0?
                                  WalletLocalizations.of(context).wallet_trade_info_detail_finish_state1
                                : WalletLocalizations.of(context).wallet_trade_info_detail_finish_state2,
                              style: TextStyle(color:Colors.grey[500],fontSize: 12),),
                          )
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: AutoSizeText(
                        '${tradeInfo.objAddress}',
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                        maxLines: 1,
                        minFontSize: 9,
                        overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>
              [
                Text((tradeInfo.amount>0?'+':'-')+'${tradeInfo.amount.toStringAsFixed(8)}',style: TextStyle( fontSize:16,color:tradeInfo.amount>0?Colors.green:Colors.red,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(DateFormat('yyyy.MM.dd').format(tradeInfo.tradeDate)),
                )
            ],),
          ],
        ),
      ),
    );
  }

  //头部
  Container buildHeader() {
    return Container(
        height: 160,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                  accountInfo.amount.toStringAsFixed(8),
                  style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                  "=\$ "+accountInfo.legalTender.toStringAsFixed(2),
                  style: TextStyle(fontSize: 20,color: Colors.white54),
              ),
            ),
          ],
        ),
      );
  }
  Widget buildFooter() {
    return Container(
        margin: EdgeInsets.only(top: 2,bottom: 6,left: 10,right: 10),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CustomRaiseButton(
              context: context,
              callback: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return WalletSend();
                }));
              },
              title: WalletLocalizations.of(context).wallet_detail_content_send,
              titleColor: Colors.blue,
              leftIconName: 'icon_send',
              color: AppCustomColor.btnCancel,
            ),
            SizedBox(width: 30,),
            CustomRaiseButton(
              context: context,
              callback: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return ReceivePage();
                }));
              },
              title: WalletLocalizations.of(context).wallet_detail_content_receive,
              titleColor: Colors.white,
              leftIconName: 'icon_receive',
              color: AppCustomColor.btnConfirm,
            ),
          ],
        ),
      );
  }
}
