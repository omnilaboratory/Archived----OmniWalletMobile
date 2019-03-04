import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wallet_app/backupwallet/backup_wallet_index.dart';
import 'package:wallet_app/backupwallet/backup_wallet_words.dart';
import 'package:wallet_app/l10n/WalletLocalizations.dart';
import 'package:wallet_app/l10n/WalletLocalizationsDelegate.dart';

import 'start.dart';
import 'welcome_page_1.dart';

void main() => runApp(MyApp());

GlobalKey<_FreeLocalizations> freeLocalizationStateKey = new GlobalKey<_FreeLocalizations>();


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
    state.setState(() {
      state.locale = newLocale;
    });
  }
}

class _MyAppState extends State<MyApp> {

  Locale locale=Locale('zh','CH');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: this.locale,
      onGenerateTitle: (context){
        return WalletLocalizations.of(context).main_index_title;
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        WalletLocalizationsDelegate.delegate,
      ],
      supportedLocales: [
        const Locale('zh','CH'),
        const Locale('en','US'),
      ],
      home: new Builder(builder: (context){
        return new FreeLocalizations(
          key: freeLocalizationStateKey,
          child: BackupWalletIndex(),
        );
      }),
    );
  }
}

class FreeLocalizations extends StatefulWidget{

  final Widget child;
  FreeLocalizations({Key key,this.child}):super(key:key);

  @override
  State<FreeLocalizations> createState() {
    return new _FreeLocalizations();
  }
}

class _FreeLocalizations extends State<FreeLocalizations>{

  Locale _locale = const Locale('zh','CH');

  changeLocale(Locale locale){
    setState((){
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}