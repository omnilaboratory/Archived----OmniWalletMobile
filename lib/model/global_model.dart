import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/model/user_info.dart';
import 'package:wallet_app/tools/Tools.dart';
import 'package:wallet_app/tools/key_config.dart';
import 'package:bip39/bip39.dart' as bip39;

/**
 * Global data
 */
class  GlobalInfo{

  static Uint8List bip39Seed;

  static initBipSeed(String _mnemonic) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((share) {
      var seed = share.get(KeyConfig.user_mnemonicSeed);
      if(seed!=null){
        var seedStr = seed.toString();
        seedStr = seedStr.substring(1,seedStr.length-1);
        List<String> seedStrArr = seedStr.split(',');
        List<int> seedArr = [];
        for(int i=0;i<seedStrArr.length;i++){
          seedArr.add(int.parse(seedStrArr[i]));
        }
        GlobalInfo.bip39Seed = Uint8List.fromList(seedArr);
      }
      if(GlobalInfo.bip39Seed == null){
        Tools.showToast('data is initing,please wait',toastLength: Toast.LENGTH_LONG);
        Future future = getSedd(_mnemonic);
        future.then((data){
          GlobalInfo.bip39Seed = data;
          share.setString(KeyConfig.user_mnemonicSeed,data.toString());
        });
      }
    });
  }

  static getSedd(String mnemonic) async{
    return await bip39.mnemonicToSeed(mnemonic);
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