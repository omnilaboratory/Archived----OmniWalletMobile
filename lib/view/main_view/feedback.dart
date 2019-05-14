/// Submit Feedback page.
/// [author] Kevin Zhang
/// [time] 2019-3-25

// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/model/global_model.dart';
import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class SubmitFeedback extends StatefulWidget {
  static String tag = "SubmitFeedback";

  @override
  _SubmitFeedbackState createState() => _SubmitFeedbackState();
}

class FeedBackInfo{
  String title;
  String content;
  String urls;
  String email;
}

class _SubmitFeedbackState extends State<SubmitFeedback> {

  //
  FocusNode _nodeText1 = FocusNode();
  FocusNode _nodeText2 = FocusNode();
  FocusNode _nodeText3 = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FeedBackInfo _feedBackInfo = FeedBackInfo();


  @override
  void initState() {
    GlobalInfo.isLocked = false;
    GlobalInfo.isNeedLock =  false;
    submitFinish =false;
    super.initState();
  }

  @override
  void dispose() {
    GlobalInfo.isNeedLock =  true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).feedbackPageTitle),
      ),

      body: FormKeyboardActions(
        actions: _keyboardActions(),
        child: SafeArea(
          child: _content(),
        ),
      ),
    );
  }

  // Keyboard Actions
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

      KeyboardAction(
          focusNode: _nodeText3,
          closeWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          )
      ),
    ];

    return actions;
  }

  //
  Widget _content() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField( // title
              decoration: InputDecoration(
                labelText: WalletLocalizations.of(context).feedbackPageInputTitleTooltip,
                labelStyle: TextStyle(
                  // color: Colors.blue,
                ),
                border: InputBorder.none,
                fillColor: AppCustomColor.themeBackgroudColor,
                filled: true,
              ),
              validator: (val){
                if(val.isEmpty){
                  return WalletLocalizations.of(context).common_tips_input+WalletLocalizations.of(context).feedbackPageInputTitleTooltip;
                }
              },
              onSaved: (val){
                _feedBackInfo.title = val;
              },
              focusNode: _nodeText1,
            ),

            SizedBox(height: 20),

            TextFormField( // content
              decoration: InputDecoration(
                labelText: WalletLocalizations.of(context).feedbackPageContentTooltip,
                labelStyle: TextStyle(
                  // color: Colors.blue,
                ),
                border: InputBorder.none,
                fillColor: AppCustomColor.themeBackgroudColor,
                filled: true,
              ),
              validator: (val){
                if(val.isEmpty){
                  return WalletLocalizations.of(context).common_tips_input+WalletLocalizations.of(context).feedbackPageContentTooltip;
                }
              },
              onSaved: (val){
                _feedBackInfo.content = val;
              },
              maxLines: null,
              focusNode: _nodeText2,
            ),

            // Upload Picture Title
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                WalletLocalizations.of(context).feedbackPageUploadPicTitle,
              ),
            ),

            Container(  // Upload Picture Button
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                // elevation: 4.0,
                shape: CircleBorder(),
                color: Colors.transparent,
                child: Ink.image(
                  image: AssetImage('assets/upload_picture.png'),
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  child: InkWell(
                    onTap: () {
                      _bottomSheet();
                    },
                    child: null,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            TextFormField( // Email
              decoration: InputDecoration(
                labelText: WalletLocalizations.of(context).feedbackPageEmailTooltip,
                labelStyle: TextStyle(
                  // color: Colors.blue,
                ),
                border: InputBorder.none,
                fillColor: AppCustomColor.themeBackgroudColor,
                filled: true,
              ),
              validator: (val){
                if(val.isEmpty){
                  return WalletLocalizations.of(context).common_tips_input+WalletLocalizations.of(context).feedbackPageEmailTooltip;
                }
              },
              onSaved: (val){
                _feedBackInfo.email = val;
              },
              focusNode: _nodeText3,
              keyboardType: TextInputType.emailAddress,
            ),

            Container(  // submit button
              padding: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        WalletLocalizations.of(context).feedbackPageSubmitButton,
                        style: TextStyle(color: Colors.white),
                      ),

                      color: AppCustomColor.btnConfirm,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      onPressed: submitFinish==false? postDataToServer:null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //

  bool submitFinish =false;
  Function postDataToServer(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      Future future = NetConfig.post(context, NetConfig.feedback, {
          'title':_feedBackInfo.title,
          'content':_feedBackInfo.content,
          'imageUrls':_feedBackInfo.urls==null?'':_feedBackInfo.urls,
          'email':_feedBackInfo.email,
        });
      future.then((data){
        if(data!=null){
          Tools.showToast(WalletLocalizations.of(context).common_tips_finish);
          submitFinish = true;
          setState(() {
            
          });
        }
      });
    }
  }
  void _bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_album),
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

  }

  //
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  }
}