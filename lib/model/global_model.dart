import 'dart:typed_data';

import 'package:wallet_app/model/user_info.dart';
import 'package:wallet_app/tools/key_config.dart';
import 'package:bip39/bip39.dart' as bip39;

/**
 * Global data
 */
class  GlobalInfo{

  static Uint8List bip39Seed;

  static initBipSeed(String _mnemonic) async {
    if(GlobalInfo.bip39Seed == null){
       GlobalInfo.bip39Seed = await bip39.mnemonicToSeed(_mnemonic);
    }
  }

  static AssetToUSDRateInfo usdRateInfo = AssetToUSDRateInfo();

  static String currLanguage = KeyConfig.languageEn;
  /// userInfo
  static UserInfo userInfo = UserInfo();


  static clear(){
    userInfo = UserInfo();
  }
}

class AssetToUSDRateInfo {
  List<double> btcs = [5000,35000];
  AssetToUSDRateInfo();
}