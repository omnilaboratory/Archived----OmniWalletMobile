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
  static String apiHost='http://172.21.100.248:8080/api/';
  static String imageHost='http://127.0.0.1:8080';
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
        userMD5Id = prefs.get(KeyConfig.user_mnemonic_md5);
        print(userMD5Id);
        if(userMD5Id==null){
          showToast('user have not login');
          return null;
        }
      }
      header['authorization']='Bearer '+userMD5Id;
    }

    url = apiHost + url;
    showToast('begin get data from server ',toastLength:Toast.LENGTH_LONG);
    Response response = null;
    if(reqType=="get"){
      response = await http.get(url,headers: header);
    }else{
      response =  await http.post(url,headers: header, body: data);
    }
    Fluttertoast.cancel();

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