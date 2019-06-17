import 'package:flutter/material.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class FPUserRegister extends StatelessWidget {

  MainStateModel stateModel = null;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _nodeEmail = FocusNode();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    stateModel = MainStateModel().of(context);

    var inputPin = TextFormField( // content
      controller: _emailController,
      decoration: InputDecoration(
        labelText: WalletLocalizations.of(context).flashPayUserRegisterInputTitle1,
//        border: InputBorder.none,
        fillColor: AppCustomColor.themeBackgroudColor,
        filled: true,
      ),
      validator: (val){
        if(val.isEmpty||val.length!=6){
          return WalletLocalizations.of(context).common_tips_input+WalletLocalizations.of(context).flashPayUserRegisterInputTitle1;
        }
      },
      maxLines: 1,
      obscureText:true,
      maxLength: 30,
      keyboardType: TextInputType.number,
      focusNode: _nodeEmail,
    );

    return Scaffold(
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).flashPayUserRegisterTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: ClipRRect( // user avatar.
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Tools.networkImage(GlobalInfo.userInfo.faceUrl),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12,bottom: 10),
                child: Container( // user nick name
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    GlobalInfo.userInfo.nickname,
                    style: TextStyle(color: AppCustomColor.themeFrontColor),
                  ),
                ),
              ),
              inputPin,
              Padding(
                padding: const EdgeInsets.only(left: 50,right: 50,top: 100),
                child: CustomRaiseButton(
                  hasRow: false,// Scan button.
                  context: context,
                  title: WalletLocalizations.of(context).flashPayUserRegisterBtnName1,
                  titleColor: Colors.white,
                  color: AppCustomColor.btnConfirm,
                  callback: () {
                    stateModel.setFPUserInfo();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}