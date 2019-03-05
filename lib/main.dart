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
  Locale locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (this.locale == null) {
          this.locale = deviceLocale;
        }
        return this.locale;
      },

      locale: this.locale,

      // onGenerateTitle: (context){
      //   return WalletLocalizations.of(context).main_index_title;
      // },

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        WalletLocalizationsDelegate.delegate,
      ],

      supportedLocales: [
        const Locale('zh','CH'),
        const Locale('en','US'),
      ],

      home: WelcomePageOne(),
      // home: BackupWalletIndex(),
    );
  }
}
