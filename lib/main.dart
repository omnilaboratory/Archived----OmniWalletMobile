import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wallet_app/l10n/WalletLocalizationsDelegate.dart';
import 'package:wallet_app/view/backupwallet/backup_wallet_index.dart';
import 'package:wallet_app/view/main_view/about.dart';
import 'package:wallet_app/view/main_view/help.dart';
import 'package:wallet_app/view/main_view/feedback.dart';
import 'package:wallet_app/view/main_view/home/send_confirm_page.dart';
import 'package:wallet_app/view/main_view/home/send_page.dart';
import 'package:wallet_app/view/main_view/service_terms.dart';
import 'package:wallet_app/view/main_view/user_info.dart';
import 'package:wallet_app/view/main_view/wallet_address_book.dart';
import 'package:wallet_app/view/welcome/welcome_page_1.dart';
import 'package:wallet_app/view/main_view/settings.dart';
import 'package:wallet_app/view_model/state_lib.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

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

  // Create the model.
  MainStateModel mainStateModel = MainStateModel();

  Locale locale;

  final routes = <String, WidgetBuilder> {
    SendConfirm.tag: (context)         => SendConfirm(),
    WalletSend.tag: (context)          => WalletSend(),
    Settings.tag: (context)            => Settings(),
    Help.tag: (context)                => Help(),
    SubmitFeedback.tag: (context)      => SubmitFeedback(),
    AddressBook.tag: (context)         => AddressBook(),
    ServiceTerms.tag: (context)        => ServiceTerms(),
    BackupWalletIndex.tag: (context)   => BackupWalletIndex(),
    About.tag: (context)               => About(),
    UserInfo.tag: (context)            => UserInfo(),
  };

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainStateModel>(
      model: mainStateModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
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
        routes: routes,
        // home: BackupWalletIndex(),
        home: WelcomePageOne(),
      ),
    );
  }
}
