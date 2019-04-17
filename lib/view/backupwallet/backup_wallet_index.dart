import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/backupwallet/backup_wallet_words.dart';
import 'package:wallet_app/view/main_view/main_page.dart';
import 'package:wallet_app/view/widgets/custom_raise_button_widget.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class BackupWalletIndex extends StatelessWidget  {
  static String tag = "BackupWallet";
  BackupWalletIndex({Key key,this.param}):super(key:key);
  final Object param;

 void initData(){
   Future<SharedPreferences> prefs = SharedPreferences.getInstance();
   prefs.then((share){
     share.setInt('backParentId', this.param);
   });
 }

  @override
  Widget build(BuildContext context) {
    this.initData();
    return Scaffold(
      backgroundColor: AppCustomColor.themeBackgroudColor,

      appBar: AppBar(
        title: Text(WalletLocalizations.of(context).backup_index_title),
        actions: _getActions(context),
      ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: _pageContent(context),
        ),
      )
    );
  }

  //
  Widget _pageContent(BuildContext context) {
    return Column(
      children: <Widget>[
        // title image
        Expanded(child: Container()),
        Image.asset(Tools.imagePath('image_backup'), width: 280, height: 200),

        // Title
        Expanded(child: Container()),
        Text(
          WalletLocalizations.of(context).backup_index_tips_title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        // content text
        SizedBox(height: 20),
        Text(
          WalletLocalizations.of(context).backup_index_tips,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppCustomColor.fontGreyColor,
            height: 1.3,
          ),
        ),

        // backup button
        Expanded(child: Container()),
        Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
          child: CustomRaiseButton(
            context: context,
            hasRow: false,
            title: WalletLocalizations.of(context).backup_index_btn,
            titleColor: Colors.white,
            color: AppCustomColor.btnConfirm,
            callback: () {
              Navigator.pushNamed(context, BackupWalletWords.tag);
            },
          ),
        ),
      ],
    );
  }

  //
  List<Widget> _getActions(BuildContext context){

    if (this.param != null && this.param == 1) {
      List<Widget> list = [];
      list.add(FlatButton(
        child: Text(WalletLocalizations.of(context).backup_index_laterbackup),
        textColor: AppCustomColor.btnConfirm,
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            MainPage.tag,
            (route) => route == null,
          );
        },
      ));
      return list;
    }

    return null;
  }
}
