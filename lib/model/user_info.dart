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

  void set mnemonic(String val){
    this._mnemonic=val;
    this.initBipSeed();
  }

  void initBipSeed() async{
    if(GlobalInfo.bip39Seed==null){
      await (GlobalInfo.bip39Seed = bip39.mnemonicToSeed(this._mnemonic));
      Future future = NetConfig.get(NetConfig.btcAndUsdtExchangeRate);
      future.then((data){
        if(data!=null){
          AssetToUSDRateInfo info = AssetToUSDRateInfo();
          info.btcs[0] = double.parse(data[0]['rate']);
          info.btcs[1] = double.parse(data[1]['rate']);
          GlobalInfo.usdRateInfo = info;
        }
      });
    }
  }
}