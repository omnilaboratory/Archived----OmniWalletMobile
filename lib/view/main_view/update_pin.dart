import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class UpdatePIN extends StatefulWidget {
  static String tag = 'UpdatePIN';
  @override
  _UpdatePINState createState() => _UpdatePINState();
}

class _UpdatePINState extends State<UpdatePIN> {
  FocusNode _nodeText1 = FocusNode();
  FocusNode _nodeText2 = FocusNode();
  TextEditingController controller1;
  TextEditingController controller2;

  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppCustomColor.themeBackgroudColor,
      appBar: AppBar(title: Text(WalletLocalizations.of(context).userInfoPageItem_3_Title),),
      body: this.buildBody(),
    );
  }
  Widget buildBody(){
    ///input pin
    var inputPin = TextField( // content
      controller: controller1,
      decoration: InputDecoration(
        labelText: WalletLocalizations.of(context).restore_account_tip_pin,
        border: InputBorder.none,
        fillColor: AppCustomColor.themeBackgroudColor,
        filled: true,
      ),
      maxLines: 1,
      obscureText:true,
      focusNode: _nodeText1,
    );
    /**
     * PIN confirm
     */
    var inputConfirmPin = TextField( // content
      controller: controller2,
      decoration: InputDecoration(
        labelText: WalletLocalizations.of(context).restore_account_tip_confirmPin,
        border: InputBorder.none,
        fillColor: AppCustomColor.themeBackgroudColor,
        filled: true,
      ),
      maxLines: 1,
      obscureText:true,
      focusNode: _nodeText2,
    );

    return FormKeyboardActions(
      actions: _keyboardActions(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: <Widget>[
            inputPin,
            Divider(height: 0,),
            inputConfirmPin,
            Divider(height: 0,),
            SizedBox(height: 30,),
            CustomRaiseButton( // Next button.
              context: context,
              hasRow: false,
              title: WalletLocalizations.of(context).userInfoPageItem_3_Title,
              titleColor: Colors.white,
              color: AppCustomColor.btnConfirm,
              callback: (){
                this.clickBtn();
              },
            ),
          ],
        ),
      ),
    );
  }
  clickBtn() {
    String pin = this.controller1.text;
    String pin2 = this.controller2.text;
    if (pin.isNotEmpty&&pin2.isNotEmpty) {
      if(pin == pin2){
        Navigator.of(context).pop();
        return;
      }
    }
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: "Wrong PIN",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
    );
    return ;
  }

  List<KeyboardAction> _keyboardActions() {
    List<KeyboardAction> actions = <KeyboardAction> [
      KeyboardAction(
          focusNode: _nodeText1,
          closeWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          )
      ),

      KeyboardAction(
          focusNode: _nodeText2,
          closeWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          )
      ),
    ];
    return actions;
  }
}
