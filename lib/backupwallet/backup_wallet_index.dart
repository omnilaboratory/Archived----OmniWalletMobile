import 'package:flutter/material.dart';

class BackupWalletIndex extends StatelessWidget {

  final String content =  '注意：请备份你的钱包账户，Omni Wallet 不会访问你的账户、不能恢复私钥、重置密码。你自己控制自己的钱包和资产安全。';

  Widget buildDialogWindow(BuildContext context){
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(0.0),
      children: <Widget>[
        Center(
          child:Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.camera_enhance,
                  size: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                    '不要截屏',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                child: Text('任何人得到你的助记词将能获得你的资产。\n请抄写在纸上妥善保管。',textAlign: TextAlign.center,),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Text('知道了',textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ],
          )
        )
      ],
    );
  }
  void onTouchBtn(BuildContext context){
    showDialog(
      context: context,
      builder:buildDialogWindow,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget pageContent(){
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30,left: 20,right: 20),
            child: Image.network(
              'https://imags.geoparker.cn/20170417_58f4acab9fd3c.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment(0, -0.5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[400],
                        letterSpacing: 2,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
              )
          ),
          Container(
            margin: EdgeInsets.only(bottom: 80),
            child: RaisedButton(
              child: Text('备份钱包助记词'),
                onPressed: (){
                  this.onTouchBtn(context);
                }
            ),
          ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('备份钱包'),
      ),
      body: Scaffold(
        body: pageContent(),
      ),
    );
  }
}
