import 'package:flutter/material.dart';


class WordInfo{
  String content;
  bool visible;
  WordInfo({@required this.content,this.visible=false});
}


class BackupWalletWordsOrder extends StatefulWidget {
  @override
  _BackupWalletWordsOrderState createState() => _BackupWalletWordsOrderState();
}

class _BackupWalletWordsOrderState extends State<BackupWalletWordsOrder> {

  List<WordInfo> words=[
    WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),
    WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),
    WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),
    WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' ),WordInfo(content: 'word' )
  ];

  Widget wordBulid(BuildContext context){
    return GridView.builder(
      physics: new NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left:20,right: 20,top: 24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 6.0,
        childAspectRatio: 2
      ),
      itemCount: 16,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Offstage(
              offstage: words[index].visible,
              child: Text(words[index].content)
          ),
          onTap: (){
              print(index);
              setState(() {
                words[index].visible=true;
              });
          },
        );
      },
    );
  }


  Widget pageCentent(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Container(),flex: 3,),
          Text('请按顺序点击助记词，以确认您\n正确备份。'),
          Expanded(child: Container(),flex: 1),
          Container(
            decoration: BoxDecoration(
              color: Color(0xECE0E0FF),
              borderRadius: BorderRadius.circular(5)
            ),
            width: MediaQuery.of(context).size.width*0.9,
            height: 90,
            child:wordBulid(context),
          ),
          Expanded(child: Container(),flex: 2,),
          RaisedButton(
            onPressed: (){

            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
              child: Text('完成',style: TextStyle(fontSize: 16),),
            ),
          ),
          Expanded(child: Container(),flex: 3,),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('确认助记词'),
//        leading: Icon(Icons.arrow_back_ios),
      ),
      body: pageCentent(context),
    );
  }
}
