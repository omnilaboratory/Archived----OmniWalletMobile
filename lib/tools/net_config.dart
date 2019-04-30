import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class NetConfig{
//  static String apiHost='http://192.168.0.106:8080/api/';
//  static String apiHost='http://172.21.100.248:8080/api/';

  static String apiHost='http://62.234.169.68:8080/walletClient/api/';
  static String imageHost='http://62.234.169.68:8080';
  static String userMD5Id = null;
  static setUserID(String data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KeyConfig.user_mnemonic_md5,data);
    userMD5Id = prefs.get(KeyConfig.user_mnemonic_md5);
  }

  /// 创建新用户
  static String createUser='common/createUser';
  /// 根据助记词恢复用户
  static String restoreUser= 'common/restoreUser';
  /// 图片上传
  static String uploadImage='common/uploadImage';
  /// 比特币、Usdt和欧元的对美元的实时汇率
  static String btcAndUsdtExchangeRate='common/btcAndUsdtExchangeRate';


  /// 获取用户信息
  static String getUserInfo='user/getUserInfo';

  /// wallet/address/create  创建新地址
  static String createAddress='wallet/address/create';
  /// wallet/address/list  地址列表
  static String addressList ='wallet/address/list';

  /**
   * wallet/address/getTransactionsByAddress 根据address获取交易记录
   * wallet/address/getTransactionsByAddress?address=1JiSZQDAZ16Qm8BDmNRBWa6AVsJWWeLC2U
  */
  static String getTransactionsByAddress ='wallet/address/getTransactionsByAddress';

  /// wallet/address/getOmniTransactionsByAddress 根据address获取omni交易记录
  static String getOmniTransactionsByAddress ='wallet/address/getOmniTransactionsByAddress';

  /// user/transferAddress/create  创建新的常用转账地址
  static String createTransferAddress='user/transferAddress/edit';
  /// user/transferAddress/list  转账地址列表
  static String transferAddressList ='user/transferAddress/list';
  /// user/transferAddress/delAddress  删除常用转账地址
  static String delAddress ='user/transferAddress/delAddress';

  /// blockChain/sendCmd  发送omni命令
  static String sendCmd ='blockChain/sendCmd';

  /// 获取用户公钥
  static String getUserRSAEncrypt ='user/getUserRSAEncrypt';

  /// Get Popular Asset List
  static String getPopularAssetList ='wallet/asset/getPopularAssetList';

  /// blockChain/btcSend  btc转账
  static String btcSend ='blockChain/btcSend';

  /// blockChain/omniRawTransaction omni原生转账
  static String omniRawTransaction ='blockChain/omniRawTransaction';

  ///
  static String setAddressVisible ='wallet/address/setVisible';

  ///
  static String setAssetVisible ='wallet/asset/setAssetVisible';

  ///
  static String changeAddressName ='wallet/address/changeAddressName';



  static post(String url,Map<String, String> data,{Function errorCallback=null}) async{
    return _sendData("post", url, data,errorCallback: errorCallback);
  }

  static get(String url,{Function errorCallback}) async{
    return _sendData("get", url,null,errorCallback: errorCallback);
  }

  static _sendData(String reqType, String url,Map<String, String> data,{Function errorCallback=null}) async{

    Map<String, String> header = new Map();
    if(url.startsWith('common')==false){
      if(GlobalInfo.userInfo.userId==null){
        showToast('user have not login');
        return null;
      }
      header['authorization']='Bearer '+GlobalInfo.userInfo.userId;
    }

    url = apiHost + url;
    print(url);
//    showToast('begin get data from server ',toastLength:Toast.LENGTH_LONG);
    Response response = null;
    if(reqType=="get"){
      response = await http.get(url,headers: header);
    }else{
      response =  await http.post(url,headers: header, body: data);
    }
//    Fluttertoast.cancel();
    print(response.statusCode);
    bool isError = true;
    if(response.statusCode==200){
      var result = json.decode(response.body);
      int status = result['status'];
      print(result);
      if(status==1){
        var data = result['data'];
        print(data);
        isError = false;
        return data;
      }
      if(status==0){
        showToast(result['msg'],toastLength:Toast.LENGTH_LONG);
      }
      if(status==403){

      }
    }else if(response.statusCode==403){
      GlobalInfo.bip39Seed = null;
      Future<SharedPreferences> prefs = SharedPreferences.getInstance();
      prefs.then((share) {
        share.clear();
      });
      showToast('user not exist');
    } else{
      showToast('server is sleep, please wait');
    }
    if(errorCallback!=null&&isError){
      errorCallback();
    }
  }

  static showToast(String msg,{Toast toastLength = Toast.LENGTH_SHORT}){
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
    );
  }

  static uploadImageFunc(File imageFile) async{
    String url = apiHost + uploadImage;
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,filename: basename(imageFile.path));
    request.files.add(multipartFile);

    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((data) {
      print(data);
    });
  }
}