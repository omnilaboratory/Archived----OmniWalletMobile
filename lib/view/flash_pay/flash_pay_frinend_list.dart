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
//    friends.add(FPUserInfo());
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
      ),
      body: this.body(context),
    );
  }

  body(BuildContext context) {
    if(friends==null&&friends.length==0){
      return Center(child: Text("no friends"));
    }
    return ListView.builder(
        itemCount:friends.length,
        itemBuilder: (BuildContext context, int index){
          return detailTile(context,index,friends);
        });
  }

  detailTile(BuildContext context, int index, List<FPUserInfo> friends) {

  }


}
