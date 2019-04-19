import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';

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

  HDWallet createAddress(String phrases,{int index=0}){
    var seed = bip39.mnemonicToSeed(phrases);
    var hdWallet = HDWallet.fromSeed(seed);
    return hdWallet.derivePath("m/44'/0'/0'/0/"+index.toString());
  }
}