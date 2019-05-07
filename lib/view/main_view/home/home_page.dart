import 'dart:async';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(WalletLocalizations.of(context).main_page_title),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                buildShowDialog(context);
//                showDialog(
//                    context: context,
//                    barrierDismissible: true,
//                    builder: (BuildContext context){
//                      return CreateNewAddressDialog(callback: onClickAddButton,showSnackBar: showSnackBar,);
//                    });
              },
              icon: Icon(
                Icons.add,
                size: 30,
                color: AppCustomColor.themeFrontColor,
              ))
        ],
      ),
      body: new BodyContentWidget(),
    );
  }

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  buildShowDialog(BuildContext context) {
    canTouchAdd =true;
    String _addressName;
    return showDialog(
      context: context,
      builder:(BuildContext context){
        return Form(
          key: _formKey,
          child: SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            titlePadding: EdgeInsets.only(top: 12,bottom: 12),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Container(
              child: Column(
                  children: <Widget>[
                    Text(WalletLocalizations.of(context).createNewAddress_title,style: TextStyle(fontSize: 20),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric (vertical: 8),
                child: TextFormField(
                  validator: (val){
                    if(val==null||val.length==0){
                      return WalletLocalizations.of(context).createNewAddress_WrongAddress;
                    }
                  },
                  onSaved: (val){
                    _addressName = val;
                  },
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: WalletLocalizations.of(context).createNewAddress_hint1
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6,bottom: 6),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        elevation: 0,
                        highlightElevation: 0,
                        onPressed:  () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                            WalletLocalizations.of(context).createNewAddress_Cancel,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              color:Colors.blue,
                            )
                        ),
                        color: AppCustomColor.btnCancel,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: RaisedButton(
                        elevation: 0,
                        highlightElevation: 0,
                        onPressed:  () {
                          var _form = _formKey.currentState;
                          if (_form.validate()) {
                            _form.save();
                            this.onClickAddButton(_addressName);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                            WalletLocalizations.of(context).createNewAddress_Add,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              color:Colors.white,
                            )
                        ),
                        color: AppCustomColor.btnConfirm,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool canTouchAdd =true;
  Function onClickAddButton(String addressName){
    if(canTouchAdd==false) return null;

    canTouchAdd =false;
    Future future = NetConfig.get(NetConfig.getNewestAddressIndex);
    future.then((data){
      if(data!=null){
        int addressIndex = data;
        this.createAddressAgain(addressName, ++addressIndex);
      }
    });
  }

  createAddressAgain(String addressName ,int addressIndex){
    HDWallet wallet = MnemonicPhrase.getInstance().createAddress(GlobalInfo.userInfo.mnemonic,index: addressIndex);
    WalletInfo info = WalletInfo(name: addressName,visible: true,address: wallet.address,addressIndex: addressIndex, totalLegalTender: 0,note: '',accountInfoes: []);
    Future result = NetConfig.post(
        NetConfig.createAddress,
        {'address':wallet.address,'addressName':addressName,'addressIndex':addressIndex.toString()},
        errorCallback: (msg){
          if(msg.toString().contains('address is exist')){
            this.createAddressAgain(addressName, ++addressIndex);
          }
          canTouchAdd = true;
        });

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

