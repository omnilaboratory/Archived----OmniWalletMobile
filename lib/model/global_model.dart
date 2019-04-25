import 'dart:typed_data';

import 'package:wallet_app/model/user_info.dart';
import 'package:wallet_app/tools/key_config.dart';

/**
 * Global data
 */
class  GlobalInfo{

  static Uint8List bip39Seed;

  static AssetToUSDRateInfo usdRateInfo = AssetToUSDRateInfo();

  static String currLanguage = KeyConfig.languageEn;
  /// userInfo
  static UserInfo userInfo = UserInfo();


  static clear(){
    userInfo = UserInfo();
  }
}

class AssetToUSDRateInfo {
  List<double> btcs = [1,1];
  AssetToUSDRateInfo();
}