import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/model/global_model.dart';
import 'package:wallet_app/tools/net_config.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Tools{

  /** 返回当前时间戳 */
  static bool getCurrRunningMode() {
    return bool.fromEnvironment("dart.vm.product");
  }

  ///生成md5
  static String convertMD5Str(String data){
    return md5.convert(Utf8Encoder().convert(md5.convert(Utf8Encoder().convert(data)).toString())).toString();
  }

  /** 返回当前时间戳 */
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  /** 复制到剪粘板 */
  static copyToClipboard(final String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
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

  /// get image path
  static String imagePath(final String text,{String scaleType="@2x",String suffix="png"}) {
    scaleType = scaleType==null?'':scaleType;
    suffix = suffix==null?'png':suffix;
    return 'assets/' + text + scaleType+'.'+suffix;
  }

  ///
  static void saveStringKeyValue(String key, String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  ///
  static Future<String> getStringKeyValue(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// loading Animation
  static void loadingAnimation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,  // user must tap button to dismiss dialog.
      builder: (BuildContext context) {
        return Container(
          // color: Colors.white,
          child: SpinKitFadingCircle(
            itemBuilder: (context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ),
        );
      }
    );
  }


  static Widget networkImage(BuildContext context, String url,{String defaultImage='assets/omni-logo.png',double width =90,double height = 90} ) {
    if (url == null) {
      return Image.asset(defaultImage, width: width,height: height);
    } else {
      return CachedNetworkImage(
          placeholder: (BuildContext context, String url){
            new CircularProgressIndicator();
          },
          imageUrl:NetConfig.imageHost + url,width: width,height: height,
      );
    }
  }
}