import 'dart:typed_data';

import 'package:wallet_app/model/user_info.dart';

/**
 * Global data
 */
class  GlobalInfo{

  static Uint8List bip39Seed;
  /// userInfo
  static UserInfo userInfo = UserInfo();


  static clear(){
    userInfo = UserInfo();
  }
}