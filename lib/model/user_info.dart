import 'dart:async';

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




  void init() async{
    if(GlobalInfo.bip39Seed==null){
      GlobalInfo.initBipSeed(this._mnemonic);
    }
    print('init fun begin gggg ${DateTime.now()}');
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