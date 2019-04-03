import 'package:wallet_app/view_model/state_lib.dart';

class BackupMnemonicPhrase extends Model{

  List<WordInfo> wordList=null;

  List<WordInfo> createNewWords(){
    if(this.wordList!=null){
      this.wordList.clear();
    }
    this.wordList = [
      WordInfo(content: 'word1word1' ),WordInfo(content: 'word2word1' ),WordInfo(content: 'wordword13' ),WordInfo(content: 'word4' ),
      WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),
      WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),
      WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' )
    ];
    return this.wordList;
  }

  List<WordInfo> get mnemonicPhrases{
    if(this.wordList==null){
      createNewWords();
    }
    return this.wordList;
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