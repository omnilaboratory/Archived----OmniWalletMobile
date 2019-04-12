import 'package:wallet_app/view_model/state_lib.dart';
import 'dart:math';

class BackupMnemonicPhrase extends Model{

  List<WordInfo> wordList=null;

  List<WordInfo> createNewWords(){
    if(this.wordList!=null){
      this.wordList.clear();
    }else{
      this.wordList = [];
    }

    String randomMnemonic = 'quote flag wise digital travel garlic film vibrant width evoke device biology';
    List<String> list = randomMnemonic.split(' ');
    for(int count=0;count<list.length;count++){
      this.wordList.add(WordInfo(content: list[count],seqNum: count));
    }
    return this.wordList;
  }

  List<WordInfo> get mnemonicPhrases{
    if(this.wordList==null){
      createNewWords();
    }
    return this.wordList;
  }

  List<WordInfo> get randomSortMnemonicPhrases{
    var temp = this.wordList.sublist(0);
    for(var item in temp){
      item.visible=true;
    }
    temp.shuffle();
    return temp;
  }

  String get mnemonicPhraseString{
    if(this.wordList==null){
      createNewWords();
    }
    String result = '';
    for(int i=0;i<this.wordList.length;i++){
      result += '${i+1}:'+this.wordList[i].content+",";
    }
    result = result.substring(0,result.length-1);
    return result;
  }

}