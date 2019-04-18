import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tools{

  static SharedPreferences sharedPreferences = null;

  static getSharedPreferences() async{
    if(sharedPreferences==null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      sharedPreferences = prefs;
    }
    return sharedPreferences;

  }

  /** 返回当前时间戳 */
  static bool getCurrRunningMode() {
    return bool.fromEnvironment("dart.vm.product");
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

  /// get image path
  static String imagePath(final String text,{String scaleType="@2x",String suffix="png"}) {
    scaleType = scaleType==null?'':scaleType;
    suffix = suffix==null?'png':suffix;
    return 'assets/' + text + scaleType+'.'+suffix;
  }



}