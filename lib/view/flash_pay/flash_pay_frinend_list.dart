import 'package:flutter/material.dart';
import 'package:wallet_app/model/user_info.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class FPFrinedList extends StatefulWidget {
  static String tag = "FPFrinedList";
  @override
  _FPFrinedListState createState() => _FPFrinedListState();
}

class _FPFrinedListState extends State<FPFrinedList> {

  List<FPUserInfo> friends = new List();
  @override
  void initState() {
    friends.add(FPUserInfo(hyperUsername: "email1"));
    friends.add(FPUserInfo(hyperUsername: "email2"));
    friends.add(FPUserInfo(hyperUsername: "email3"));
    friends.add(FPUserInfo(hyperUsername: "email4"));
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCustomColor.themeBackgroudColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(WalletLocalizations.of(context).flashPayMainPageFriends),
        actions: <Widget>[
          IconButton(
              onPressed: (){
//                buildShowDialog(context);
              },
              icon: Icon(
                Icons.add,
                size: 30,
                color: AppCustomColor.themeFrontColor,
              ))
        ],
      ),
      body: this.body(context),
    );
  }

  body(BuildContext context) {
    if(friends==null||friends.length==0){
      return Center(child: Text("no friends"));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
          itemCount:friends.length,
          itemBuilder: (BuildContext context, int index){
            return detailTile(context,index,friends);
          }),
    );
  }

  detailTile(BuildContext context, int index, List<FPUserInfo> friends) {
      FPUserInfo info = friends[index];
      return Column(
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Tools.networkImage(
                  GlobalInfo.userInfo.faceUrl, width: 35, height: 35),
            ),
            title: Text(info.hyperUsername),
            subtitle: Text(info.hyperUsername),
          ),
          Divider(height: 1,)
        ],
      );
  }
}
