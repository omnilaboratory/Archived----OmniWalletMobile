import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';

class DialogDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('title'),),
      body: Center(child: RaisedButton(onPressed: (){
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context){
              return CreateNewAddressDialog();
            });
      },child: Text('click me'),),),
    );
  }
}

/**
 * 创建新的钱包地址 钱包页面的右上角的点击事件
 */
class CreateNewAddressDialog extends StatefulWidget {
  final Function callback;
  final Function showSnackBar;
  CreateNewAddressDialog({Key key, this.callback,this.showSnackBar}) : super(key: key);

  @override
  _CreateNewAddressDialogState createState() => _CreateNewAddressDialogState();
}

class _CreateNewAddressDialogState extends State<CreateNewAddressDialog> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _addressName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Material(
            type: MaterialType.transparency,
            child: GestureDetector(
              onTap: () {
                debugPrint('blue');
              },
              child: Align(
                alignment: Alignment(0, -0.05),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.37,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 70,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFF78A9FA),
                                      Color(0xFF6690F9),
                                    ]),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 0, top: 8),
                                  child: Icon(
                                    Icons.fiber_new,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                    width: double.infinity,
                                    child: Center(
                                        child: Text(
                                          WalletLocalizations.of(context).createNewAddress_title,
                                          style: TextStyle(
                                              color: Colors.white70, fontSize: 20),
                                        )))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 20),
                            child: TextFormField(
                              validator: (val){
                                if(val==null||val.trim().length==0){
                                  return WalletLocalizations.of(context).createNewAddress_WrongAddress;
                                }
                              },
                              onSaved: (val){
                                this._addressName = val;
                              },
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 2,top: 8),
                                  hintText: WalletLocalizations.of(context).createNewAddress_hint1,
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 14)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 8),
                            child: Divider(
                              height: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 36),
                            child: Row(
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    WalletLocalizations.of(context).createNewAddress_Cancel,
                                    style: TextStyle(color: Color(0xFF6B93F9)),
                                  ),
                                  color: Color(0xFFE4ECFF),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 14),
                                ),
                                Expanded(child: Container()),
                                RaisedButton(
                                  onPressed: () {
                                    var _form = _formKey.currentState;
                                    if(_form.validate()){
                                      _form.save();
                                      widget.callback(_addressName);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(WalletLocalizations.of(context).createNewAddress_Add,
                                      style: TextStyle(color: Colors.white)),
                                  color: Color(0xFF6690F9),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 14),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
class MessageDialog1 extends Dialog{
  String text;
  MessageDialog1({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
        },
        child: Material(
          type: MaterialType.transparency,
            child:GestureDetector(
              onTap: (){
                debugPrint('blue');
              },
              child: Center(
                child:
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Container(color: Colors.red,),
                ),),
//              child: Container(
//                decoration: BoxDecoration(
//                  color: Colors.grey,
//                  borderRadius: BorderRadius.all(Radius.circular(5)),
//                ),
//                margin: EdgeInsets.symmetric(horizontal: 30,vertical: 100),
//                child: Center(child: Text(text)),
//              ),
            )
        )
    );
  }
}

// ignore: must_be_immutable
class MessageDialog extends Dialog{
  String text;
  MessageDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency,
        child: Center( //保证控件居中效果
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    text,
                    style: new TextStyle(fontSize: 12.0,color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
