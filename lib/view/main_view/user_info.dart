/// User Info page.
/// [author] Kevin Zhang
/// [time] 2019-3-29

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/main_view/update_pin.dart';
import 'package:wallet_app/view/welcome/welcome_page_1.dart';

class UserInfo extends StatefulWidget {
  static String tag = "UserInfo";
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  var _imgAvatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).userInfoPageAppBarTitle),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),

            Ink( // Avatar
              color: AppCustomColor.themeBackgroudColor,
              child: ListTile(
                title: Text(WalletLocalizations.of(context).userInfoPageItem_1_Title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _avatar(_imgAvatar),
                    SizedBox(width: 15),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),

                onTap: () {
                  _bottomSheet();
                },
              ),
            ),
            
            Divider(height: 0, indent: 15),

            Ink( // user name
              color: AppCustomColor.themeBackgroudColor,
              child: ListTile(
                title: Text(WalletLocalizations.of(context).userInfoPageItem_2_Title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'user name',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 15),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),

                onTap: () {
                  // TODO: show next page.
                  // Navigator.of(context).pushNamed(route);
                },
              ),
            ),
            
            Ink( /// Update PIN Code
              color: AppCustomColor.themeBackgroudColor,
              child: ListTile(
                title: Text(WalletLocalizations.of(context).userInfoPageItem_3_Title),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // TODO: show next page.
                   Navigator.of(context).pushNamed(UpdatePIN.tag);
                },
              ),
            ),

            SizedBox(height: 10),
            
            Ink( // delete account button
              color: AppCustomColor.themeBackgroudColor,
              child: ListTile(
                title: Text(
                  WalletLocalizations.of(context).userInfoPageButton,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),

                onTap: () { _deleteUser(); },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteUser() {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((share) {
      share.clear();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => WelcomePageOne()), 
        (route) => route == null,
      );
    });
  }
  
  //
  void _bottomSheet() {
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context) {

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text(WalletLocalizations.of(context).imagePickerBottomSheet_1),
              onTap: () {
                _openGallery();
              },
            ),

            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text(WalletLocalizations.of(context).imagePickerBottomSheet_2),
              onTap: () {
                _takePhoto();
              },
            ),
          ],
        );
      }
    );
  }
  
  //
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imgAvatar = image;
    });
    Navigator.pop(context);
  }

  //
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgAvatar = image;
    });
    Navigator.pop(context);
  }

  // 
  Widget _avatar(image) {
    if (image == null) {
      // return Image.asset('assets/logo-png.png', width: 35, height: 35);
      return CircleAvatar(
        child: Image.asset('assets/omni-logo.png', width: 35, height: 35),
        backgroundColor: Colors.transparent,
      );
    } else {
      return CircleAvatar(
        backgroundImage: FileImage(image),
      );
    }
  }
}