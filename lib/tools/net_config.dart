import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class NetConfig{
  static String apiHost='http://172.21.100.248:8080/api/';
  static String imageHost='http://127.0.0.1:8080';
  static String userMD5Id = null;
  static setUserID(String data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userMD5Id',data);
    userMD5Id = prefs.get('userMD5Id');
  }

  /// 创建新用户
  static String createUser='common/createUser';
  /// 根据助记词恢复用户
  static String restoreUser= 'common/restoreUser';
  /// testKafka common/countries
  static String testKafka='common/testKafka';
  /// 获取用户信息
  static String getUserInfo='user/getUserInfo';



  static post(String url,Map<String, String> data) async{
    return _sendData("post", url, data);
  }

  static get(String url) async{
    return _sendData("get", url,null);
  }

  static _sendData(String reqType, String url,Map<String, String> data) async{

    Map<String, String> header = new Map();
    print(url);
    if(url.startsWith('common')==false){
      if(userMD5Id==null){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userMD5Id = prefs.get('user.mnemonic_md5');

        if(userMD5Id==null){
          showToast('user have not login');
        }
        return null;
      }
      header['authorization']='Bearer '+userMD5Id;
    }

    url = apiHost + url;
    Response response = null;
    if(reqType=="get"){
      response = await http.get(url,headers: header);
    }else{
      response =  await http.post(url,headers: header, body: data);
    }

    if(response.statusCode==200){
      var result = json.decode(response.body);
      int status = result['status'];
      if(status==1){
        var data = result['data'];
        print(data);
        return data;
      }
      if(status==0){
        showToast(result['msg']);
      }
      if(status==403){
        setUserID(null);
        showToast(result['msg']);
      }
    }else{
      showToast('server is sleep, please wait');
    }
  }



  static showToast(String msg){
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
    );
  }
}