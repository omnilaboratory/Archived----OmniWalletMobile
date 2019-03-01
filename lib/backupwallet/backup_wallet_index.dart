import 'package:flutter/material.dart';

class BackupWalletIndex extends StatelessWidget {

  String content =  '注意：请备份你的钱包账户，Omni Wallet 不会访问你的账户、不能恢复私钥、重置密码。你自己控制自己的钱包和资产安全。';
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
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red[400]
                      ),
                    ),
                  ),
              )
          ),
          Container(
            margin: EdgeInsets.only(bottom: 80),
            child: RaisedButton(
              child: Text('备份钱包助记词'),
                onPressed: (){}
            ),
          )
        ],
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('备份钱包'),
      ),
      body: pageContent(),
    );
  }
}
