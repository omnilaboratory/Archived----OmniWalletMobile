import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  /// get image path
  static String imagePath(final String text,{String scaleType="@2x",String suffix="png"}) {
    scaleType = scaleType==null?'':scaleType;
    suffix = suffix==null?'png':suffix;
    return 'assets/' + text + scaleType+'.'+suffix;
  }
}