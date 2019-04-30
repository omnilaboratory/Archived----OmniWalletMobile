import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel =
    const MethodChannel('juanito21.com/simple_rsa');

Future<String> encryptString(String txt, String publicKey) async {
  try {
    publicKey = publicKey.replaceAll("-----BEGIN PUBLIC KEY-----", "").replaceAll("-----END PUBLIC KEY-----", "");
    final String result = await _channel
        .invokeMethod('encrypt', {"txt": txt, "publicKey": publicKey});
    return result;
  } on PlatformException catch (e) {
    throw "Failed to get string encoded: '${e.message}'.";
  }
}

Future<String> decryptString(String txt, String privateKey) async {
  try {
    privateKey = privateKey.replaceAll("-----BEGIN PRIVATE KEY-----", "").replaceAll("-----END PRIVATE KEY-----", "");
    privateKey = privateKey.replaceAll("-----BEGIN RSA PRIVATE KEY-----", "").replaceAll("-----END RSA PRIVATE KEY-----", "");
    final String result = await _channel
        .invokeMethod('decrypt', {"txt": txt, "privateKey": privateKey});
    return result;
  } on PlatformException catch (e) {
    throw "Failed decoded string: '${e.message}'.";
  }
}

Future<String> signString(String plainText, String privateKey) async {
  try {
    privateKey = privateKey.replaceAll("-----BEGIN PRIVATE KEY-----", "").replaceAll("-----END PRIVATE KEY-----", "");
    privateKey = privateKey.replaceAll("-----BEGIN RSA PRIVATE KEY-----", "").replaceAll("-----END RSA PRIVATE KEY-----", "");
    final String result = await _channel
        .invokeMethod('sign', {"plainText": plainText, "privateKey": privateKey});
    return result;
  } on PlatformException catch (e) {
    throw "Failed decoded string: '${e.message}'.";
  }
}

Future<bool> verifyString(String plainText, String signature, String publicKey) async {
  try {
    publicKey = publicKey.replaceAll("-----BEGIN PUBLIC KEY-----", "").replaceAll("-----END PUBLIC KEY-----", "");
    final bool result = await _channel
        .invokeMethod('verify', {"plainText": plainText, "signature": signature, "publicKey": publicKey});
    return result;
  } on PlatformException catch (e) {
    throw "Failed decoded string: '${e.message}'.";
  }
}

Future<String> decryptStringWithPublicKey(String plainText, String signature, String publicKey) async {
  try {
    publicKey = publicKey.replaceAll("-----BEGIN PUBLIC KEY-----", "").replaceAll("-----END PUBLIC KEY-----", "");
    final String result = await _channel
        .invokeMethod('decryptWithPublicKey', {"plainText": plainText, "publicKey": publicKey});
    return result;
  } on PlatformException catch (e) {
    throw "Failed decoded string: '${e.message}'.";
  }
}
