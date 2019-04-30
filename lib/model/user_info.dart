import 'dart:async';

import 'package:bip39/bip39.dart' as bip39;
import 'package:wallet_app/model/global_model.dart';
import 'package:wallet_app/tools/net_config.dart';

class UserInfo{
  String userId;
  String _mnemonic;
  String pinCode;
  String faceUrl;
  String nickname;
  UserInfo({
    this.userId,
    this.faceUrl,
    this.nickname
  });

  String get mnemonic{
    return this._mnemonic;
  }

  void set mnemonic(String val) {
    this._mnemonic=val;
    this.init();
  }


  void initBipSeed() async{
    if(GlobalInfo.bip39Seed==null){
      print('begin ${DateTime.now()}');
      await (GlobalInfo.bip39Seed = bip39.mnemonicToSeed(this._mnemonic));
      print('end ${DateTime.now()}');
      print(GlobalInfo.bip39Seed);
    }
  }

  void init() async{
    print('begin init ${DateTime.now()}  ${GlobalInfo.bip39Seed}');
    this.initBipSeed();
    print('get rate ${DateTime.now()}');
    Future future = NetConfig.get(NetConfig.btcAndUsdtExchangeRate);
    future.then((data){
      if(data!=null){
        AssetToUSDRateInfo info = AssetToUSDRateInfo();
        info.btcs[0] = data[0]['rate'];
        info.btcs[1] = data[1]['rate'];
        GlobalInfo.usdRateInfo = info;
      }
    });
  }
}