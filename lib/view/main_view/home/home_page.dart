import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/main_view/home/main_page_content.dart';
import 'package:wallet_app/view/widgets/dialog_widget.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<WalletInfo> walletInfoes;
  MainStateModel stateModel = null;

  @override void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);
    walletInfoes = stateModel.walletInfoes;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(WalletLocalizations.of(context).main_page_title),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return CreateNewAddressDialog(callback: onClickAddButton,showSnackBar: showSnackBar,);
                    });
              },
              icon: Icon(
                Icons.add_circle_outline,
                size: 30,
                color: AppCustomColor.themeFrontColor,
              ))
        ],
      ),
      body: new BodyContentWidget(),
    );
  }

  Function onClickAddButton(String addressName){
    int addressIndex = walletInfoes.length;
    HDWallet wallet = MnemonicPhrase.getInstance().createAddress(GlobalInfo.userInfo.mnemonic,index: addressIndex);
    WalletInfo info = WalletInfo(name: addressName,address: wallet.address,addressIndex: addressIndex, totalLegalTender: 0,note: '',accountInfoes: []);
    Future result = NetConfig.post(NetConfig.createAddress, {'address':wallet.address,'addressName':addressName,'addressIndex':addressIndex.toString()});
    result.then((data){
      if(data!=null){
        stateModel.addWalletInfo(info);
      }
    });
  }
  Function showSnackBar(String content){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(content)));
  }
}

