/// Displayed Assets page.
/// [author] Kevin Zhang
/// [time] 2019-4-25

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/view_model/state_lib.dart';

class DisplayedAssets extends StatefulWidget {
  static String tag = "DisplayedAssets";

  @override
  _DisplayedAssetsState createState() => _DisplayedAssetsState();
}

class _DisplayedAssetsState extends State<DisplayedAssets> {

  List<String> _assetList = List();
  List<bool> _isPopularAssetDisplay = List();
  List<bool> _isOtherAssetDisplay   = List();

  @override
  void initState() {
    super.initState();
    _gePopularAsset();
  }

  /// 
  void _gePopularAsset() {

    Future data = NetConfig.get(context,NetConfig.getPopularAssetList);

    data.then((data) {
      if (data != null) {
        List response = data;
        for (var i = 0; i < response.length; i++) {
          var node = response[i];
          print('==> assetName = ${node['assetName']}');
          _assetList.add(node['assetName']);

          _isPopularAssetDisplay.add(true);
          _isOtherAssetDisplay.add(true);
        }
        setState(() { });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(WalletLocalizations.of(context).displayedAssetsPageAppBarTitle),
        ),

        body: SafeArea(
          child: Column(
            children: <Widget>[
              _tabBar(),
              _tabBarView(),
            ],
          ),
        ),
      ),
    );
  }

  /// Two tabs
  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: TabBar(
        labelColor: Colors.blue,
        labelPadding: EdgeInsets.only(bottom: 4),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Text(WalletLocalizations.of(context).displayedAssetsPageTitle_1),
          Text(WalletLocalizations.of(context).displayedAssetsPageTitle_2),
        ]
      ),
    );
  }

  /// Two tabBarView
  Widget _tabBarView() {
    return Expanded(
      child: TabBarView(
        children: <Widget>[
          _popularAsset(),
          Text(''),
        ],
      ),
    );
  }

  ///
  Widget _popularAsset() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 10),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: _popularAssetList(),
      ),
    );
  }

  /// popular asset list
  List<Widget> _popularAssetList() {

    // list tile
    List<Widget> _list = List();

    for (int i = 0; i < _assetList.length; i++) {
      _list.add(_popularAssetItem(_assetList[i], i));
      _list.add(Divider(height: 0, indent: 15));
    }

    return _list;
  }

  /// every popular asset
  Widget _popularAssetItem(String assetName, int index) {
    // print('==> asset icon = ${assetData.iconUrl}');
    return Container(
      color: AppCustomColor.themeBackgroudColor,
      child: ListTile(
        // leading: Image.asset(assetData.iconUrl),
        title: Text(assetName),
        trailing: Switch(
          value: _isPopularAssetDisplay[index], 
          onChanged: (bool value) {
            setState(() {
              _isPopularAssetDisplay[index] = !_isPopularAssetDisplay[index];
            });
          },
        ),
      ),
    );
  }

}