import 'package:bip39/bip39.dart' as bip39;
import 'package:wallet_app/model/global_model.dart';

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
    }
  }
}