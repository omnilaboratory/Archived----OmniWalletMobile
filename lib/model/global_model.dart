import 'package:wallet_app/model/user_info.dart';

/**
 * Global data
 */
class  GlobalInfo{

  /// userInfo
  static UserInfo userInfo = UserInfo();


  static clear(){
    userInfo = UserInfo();
  }
}