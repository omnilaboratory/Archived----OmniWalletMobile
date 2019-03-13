
import 'package:flutter/material.dart';

import 'package:wallet_app/l10n/WalletLocalizations.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: Text(WalletLocalizations.of(context).marketPageAppBarTitle),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            _showExchange(),
            _showTitle(),
            
          ], 
        ),
      ),
    );
  }

  // Exchanges
  Widget _showExchange() {
    return Row(
      children: <Widget>[
        FlatButton(  // Favorites button
          child: Text(WalletLocalizations.of(context).marketPageFav),
          textColor: Colors.grey,
          onPressed: () {
            // TODO: Show favorite assets quotation.
          },
        ),

        FlatButton( // Binance exchange button
          child: Text('Binance'),
          textColor: Colors.grey,
          onPressed: () {
            // TODO: Show Binance exchange quotation.
          },
        ),
      ],
    );
  }

  // 
  Widget _showTitle() {
    return Row(
      children: <Widget>[
        FlatButton(  // All button
          child: Text(WalletLocalizations.of(context).marketPageAll),
          textColor: Colors.grey,
          onPressed: () {
            // TODO: Show favorite assets quotation.
          },
        ),

        FlatButton( // Binance exchange button
          child: Text(WalletLocalizations.of(context).marketPagePrice),
          textColor: Colors.grey,
          onPressed: () {
            // TODO: Show Binance exchange quotation.
          },
        ),

        FlatButton( // Binance exchange button
          child: Text(WalletLocalizations.of(context).marketPageChange),
          textColor: Colors.grey,
          onPressed: () {
            // TODO: Show Binance exchange quotation.
          },
        ),
      ],
    );
  }
}
