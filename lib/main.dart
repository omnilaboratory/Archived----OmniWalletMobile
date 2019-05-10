import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/l10n/chinese_local.dart';

import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/backupwallet/backup_wallet_index.dart';
import 'package:wallet_app/view/backupwallet/backup_wallet_words.dart';
import 'package:wallet_app/view/main_view/about.dart';
import 'package:wallet_app/view/main_view/address_manage.dart';
import 'package:wallet_app/view/main_view/displayed_assets.dart';
import 'package:wallet_app/view/main_view/feedback.dart';
import 'package:wallet_app/view/main_view/help.dart';
import 'package:wallet_app/view/main_view/home/send_confirm_page.dart';
import 'package:wallet_app/view/main_view/home/send_page.dart';
import 'package:wallet_app/view/main_view/main_page.dart';
import 'package:wallet_app/view/main_view/service_terms.dart';
import 'package:wallet_app/view/main_view/settings.dart';
import 'package:wallet_app/view/main_view/splash.dart';
import 'package:wallet_app/view/main_view/unlock.dart';
import 'package:wallet_app/view/main_view/update_nick_name.dart';
import 'package:wallet_app/view/main_view/update_pin.dart';
import 'package:wallet_app/view/main_view/user_info_page.dart';
import 'package:wallet_app/view/main_view/wallet_address.dart';
import 'package:wallet_app/view/main_view/wallet_address_book.dart';
import 'package:wallet_app/view/welcome/create_account.dart';
import 'package:wallet_app/view/welcome/select_language.dart';
import 'package:wallet_app/view_model/main_model.dart';
import 'package:wallet_app/view_model/state_lib.dart';


final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
//   debugPaintSizeEnabled = true;
  runApp(MyApp());

  //set status bar color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:Colors.transparent
  ));
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

  static void setThemeColor(BuildContext context, Brightness brightness) {
    _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
    state.setState(() {
      state.brightness = brightness;
      AppCustomColor.setColors(brightness);
    });
  }

  /// Restart app when unlock.
  static void restartApp(BuildContext context) {
    _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
    state.setState(() {});
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

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
    UserInfoPage.tag: (context)        => UserInfoPage(),
    BackupWalletWords.tag: (context)   => BackupWalletWords(),
    MainPage.tag: (context)            => MainPage(),
    RestoreAccount.tag: (context)      => RestoreAccount(),
    UpdatePIN.tag: (context)           => UpdatePIN(),
    CreateAccount.tag: (context)       => CreateAccount(),
    SelectLanguage.tag: (context)      => SelectLanguage(),
    WalletAddress.tag: (context)       => WalletAddress(),
    AddressManage.tag: (context)       => AddressManage(data: null),
    DisplayedAssets.tag: (context)     => DisplayedAssets(),
    UpdateNickName.tag: (context)      => UpdateNickName(),
    SelectCurrency.tag: (context)      => SelectCurrency(),
    SelectTheme.tag: (context)         => SelectTheme(),
  };

  Brightness brightness = Brightness.light;

  ///----------------------
  /// App Lifecycle coding for lock and unlock app.
  
  Timer _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("==> lifeChanged = $state");


    // Enter background.
    if (state == AppLifecycleState.paused) {
      print("==> paused -> loginToken = ${GlobalInfo.userInfo.loginToken}");

      if (GlobalInfo.userInfo.loginToken != null) { // User has logged in.
        _timer = Timer(
          Duration(seconds: 3),
          () {
            GlobalInfo.isInputPIN = true;
            _timer.cancel();
          }
        );
      }
    }

    // Back from background.
    if (state == AppLifecycleState.resumed) {
      _timer.cancel();
      
      print("==> resumed -> loginToken = ${GlobalInfo.userInfo.loginToken}");

      if (GlobalInfo.userInfo.loginToken != null) { // User has logged in.
        print("==> _isInputPIN = ${GlobalInfo.isInputPIN}");

        if (GlobalInfo.isInputPIN) { // Will be locked.
//          GlobalInfo.fromWhere = 1; // from background.
          routeObserver.navigator.push(
            MaterialPageRoute(
                builder: (BuildContext context) {
                  return Unlock();
                }
            ),
          );


        }

//        routeObserver.navigator.push(route)

//        _timer.cancel();
//        setState(() {});
      }
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  ///----------------------
  

  @override
  Widget build(BuildContext context) {

    print("==> _isInputPIN At BULID = ${GlobalInfo.isInputPIN}");

    // Unclock app by input pin code.
    if (GlobalInfo.isInputPIN) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          brightness:brightness,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: brightness==Brightness.dark? Colors.black:Colors.white,
            brightness: brightness,
            textTheme: brightness==Brightness.dark?
                TextTheme(title: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal))
                :TextTheme(title: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal)),
            iconTheme: brightness==Brightness.dark?IconThemeData(color: Colors.white):IconThemeData(color: Colors.black)
          )
        ),

        localeResolutionCallback: (deviceLocale, supportedLocales) {
          if (this.locale == null) {
            this.locale = deviceLocale;
          }
          return this.locale;
        },

        // set app language
        locale: this.locale,

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          WalletLocalizationsDelegate.delegate,
          ChineseCupertinoLocalizations.delegate,  // Fix for Flutter Bug
        ],
        supportedLocales: [
          const Locale('zh','CH'),
          const Locale('en','US'),
          const Locale('zh',''),  // Fix for Flutter Bug
        ],

        home: Unlock(),
      );

    } else {  // No need unclock.
      return _backFromBackground();
    }
  }

  ///
  Widget _backFromBackground() {

    AppCustomColor.setColors(brightness);

    return ScopedModel<MainStateModel>(
      model: mainStateModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness:brightness,
          appBarTheme: AppBarTheme(
            elevation:   0,
            color: brightness==Brightness.dark? Colors.black:Colors.white,
            brightness: brightness,
            textTheme: brightness==Brightness.dark?
                TextTheme(title: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal))
                :TextTheme(title: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal)),
            iconTheme: brightness==Brightness.dark?IconThemeData(color: Colors.white):IconThemeData(color: Colors.black)
          )
        ),

        //
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          if (this.locale == null) {
            this.locale = deviceLocale;
          }
          return this.locale;
        },

        // set app language
        locale: this.locale,

        // onGenerateTitle: (context){
        //   return WalletLocalizations.of(context).main_index_title;
        // },

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          WalletLocalizationsDelegate.delegate,
          ChineseCupertinoLocalizations.delegate,  // Fix for Flutter Bug
        ],
        supportedLocales: [
          const Locale('zh','CH'),
          const Locale('en','US'),
          const Locale('zh',''),  // Fix for Flutter Bug
        ],
        routes: routes,
        // home: BackupWalletIndex(),
        navigatorObservers: [routeObserver],
        home: Splash(),
      ),
    );
  }
}
