import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/main_view/home/wallet_detail.dart';
import 'package:wallet_app/view/widgets/custom_expansion_tile.dart';
import 'package:wallet_app/view_model/state_lib.dart';

/**
 * asset list view
 */
class BodyContentWidget extends StatefulWidget {
  BodyContentWidget({Key key, }) : super(key: key);
  @override
  _BodyContentWidgetState createState() => _BodyContentWidgetState();
}

class _BodyContentWidgetState extends State<BodyContentWidget> {

  List<WalletInfo> walletInfoes;
  List<WalletInfo> _walletInfoes;
  MainStateModel stateModel = null;

  @override
  Widget build(BuildContext context) {
    if(stateModel==null){
      stateModel = MainStateModel().of(context);
      stateModel.walletInfoes = null;
    }
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
          walletInfoes = model.getWalletInfoes(context);
          _walletInfoes=[];
          for(var node in walletInfoes){
            if(node.visible){
              _walletInfoes.add(node);
            }
          }
          return ListView.builder(
              itemCount: _walletInfoes.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: AppCustomColor.themeBackgroudColor,
                  ),
                  child: CustemExpansionTile(
                    title: buildFirstLevelHeader(index),
                    children: buildItemes(context,index),
                  ),
                );
              });
          }
        );
  }

  Widget buildFirstLevelHeader(int index) {
    WalletInfo dataInfo = _walletInfoes[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10,bottom: 20,top: 20),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.lightBlue[50],
            child: Image.asset(Tools.imagePath('icon_wallet'),width: 20,height: 20,),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: AutoSizeText(
                      dataInfo.name,
                      style: TextStyle(fontSize: 18),
                      minFontSize: 10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      '\$'+dataInfo.totalLegalTender.toStringAsFixed(2),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),
                      minFontSize: 11,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              AutoSizeText(
                dataInfo.address.replaceRange(6, dataInfo.address.length-6, '...'),
                minFontSize: 9,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildItemes(BuildContext context, int index) {
    WalletInfo dataInfo = _walletInfoes[index];
    List<Widget> list = List();
    for (int i = 0; i < dataInfo.accountInfoes.length; i++) {
      AccountInfo accountInfo = dataInfo.accountInfoes[i];
      if(accountInfo.visible==false) continue;
      list.add(
        Container(
          margin: EdgeInsets.only(left: 50,bottom: 12,top: 6),
          child: InkWell(
            onTap: (){ this.onClickItem(index,i);},
            child: Container(
              margin: EdgeInsets.all(6),
              child: Row(
                children: <Widget>[
                  Image.asset(Tools.imagePath(accountInfo.iconUrl),width: 25,height: 25,),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                      child: AutoSizeText('${accountInfo.name}',style: TextStyle(fontSize: 18),minFontSize: 16,)
                  ),
                  Expanded(child: Container(),),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: AutoSizeText(
                            '${accountInfo.amount.toString()}',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16),
                            minFontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: AutoSizeText(
                            '\$'+accountInfo.legalTender.toStringAsFixed(2),
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16,color: Colors.grey),
                            minFontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      );
    }
    return list;
  }
  //点击item
  void onClickItem(int mainIndex,int subIndex){
    print('clickItem '+mainIndex.toString()+" "+ subIndex.toString());
    stateModel.currWalletInfo = _walletInfoes[mainIndex];
    stateModel.currAccountInfo = stateModel.currWalletInfo.accountInfoes[subIndex];
//    stateModel.currWalletIndex = mainIndex;
//    stateModel.currAccountIndex = subIndex;
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>WalletDetail()));
  }
}