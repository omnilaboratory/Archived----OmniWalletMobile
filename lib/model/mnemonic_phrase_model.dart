import 'dart:async';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:wallet_app/model/global_model.dart';

class MnemonicPhrase{

  static MnemonicPhrase _instance = null;

   static MnemonicPhrase getInstance(){
    if(_instance==null){
      _instance = MnemonicPhrase();
    }
    return _instance;
  }

  String createPhrases(){
    return bip39.generateMnemonic();
  }
  String initSeed(String phrases){
     Future((){
       if(GlobalInfo.bip39Seed==null){
         GlobalInfo.bip39Seed = bip39.mnemonicToSeed(phrases);
       }
     });
  }

  HDWallet createAddress(String phrases,{int index=0}){
    if(GlobalInfo.bip39Seed==null){
      GlobalInfo.bip39Seed = bip39.mnemonicToSeed(phrases);
    }
    var hdWallet = HDWallet.fromSeed(GlobalInfo.bip39Seed);
    return hdWallet.derivePath("m/44'/0'/0'/0/"+index.toString());
  }
}