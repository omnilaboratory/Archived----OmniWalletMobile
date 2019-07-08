import 'package:scoped_model/scoped_model.dart';
import 'package:wallet_app/model/global_model.dart';
import 'package:wallet_app/model/user_info.dart';

class FPUserModel extends Model{

  void setFPUserInfo() {
    GlobalInfo.userInfo.fpUserInfo = FPUserInfo();
    notifyListeners();
  }
}