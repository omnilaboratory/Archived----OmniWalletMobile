import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wallet_app/tools/app_data_setting.dart';
import 'package:wallet_app/view/backupwallet/backup_wallet_index.dart';
import 'package:wallet_app/view/backupwallet/backup_wallet_words.dart';
import 'package:wallet_app/view/main_view/about.dart';
import 'package:wallet_app/view/main_view/feedback.dart';
import 'package:wallet_app/view/main_view/help.dart';
import 'package:wallet_app/view/main_view/home/send_confirm_page.dart';
import 'package:wallet_app/view/main_view/home/send_page.dart';
import 'package:wallet_app/view/main_view/main_page.dart';
import 'package:wallet_app/view/main_view/service_terms.dart';
import 'package:wallet_app/view/main_view/settings.dart';
import 'package:wallet_app/view/main_view/splash.dart';
import 'package:wallet_app/view/main_view/update_pin.dart';
import 'package:wallet_app/view/main_view/user_info.dart';
import 'package:wallet_app/view/main_view/wallet_address_book.dart';
import 'package:wallet_app/view/welcome/create_account.dart';
import 'package:wallet_app/view/welcome/select_language.dart';
import 'package:wallet_app/view_model/main_model.dart';
import 'package:wallet_app/view_model/state_lib.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import "package:bitcoin_bip44/bitcoin_bip44.dart";

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
    BackupWalletWords.tag: (context)   => BackupWalletWords(),
    MainPage.tag: (context)            => MainPage(),
    RestoreAccount.tag: (context)      => RestoreAccount(),
    UpdatePIN.tag: (context)           => UpdatePIN(),
    CreateAccount.tag: (context)       => CreateAccount(),
    SelectLanguage.tag: (context)      => SelectLanguage(),
  };

  Brightness brightness = Brightness.light;



  @override
  Widget build(BuildContext context) {
//    Future data = NetConfig.post(NetConfig.createUser,{'userId':'c4ca4238a0b923820dcc509a6f758494','nickname':'user4'});
//    Future data = NetConfig.get(NetConfig.getUserInfo);
//    print(data.then((data){
//      if(data!=null){
////        NetConfig.setUserID(data['userId']);
//      }
//    }));
    // this.test();
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
        ],
        supportedLocales: [
          const Locale('zh','CH'),
          const Locale('en','US'),
        ],
        routes: routes,
        // home: BackupWalletIndex(),
        home: Splash(),
      ),
    );
  }


  test(){

//    String randomMnemonic = bip39.generateMnemonic();
    String randomMnemonic = 'quote flag wise digital travel garlic film vibrant width evoke device biology';
    print(randomMnemonic);
    String seed = bip39.mnemonicToSeedHex(randomMnemonic);
    print(seed);
//    print(bip39.mnemonicToSeed(randomMnemonic));


    var seed1 = bip39.mnemonicToSeed(randomMnemonic);
    var hdWallet = new HDWallet.fromSeed(seed1);
    hdWallet = hdWallet.derivePath("m/44'/0'/0'/0/0");
    print(hdWallet.address);
    print(hdWallet.wif);

    hdWallet = new HDWallet.fromSeed(seed1);
    hdWallet = hdWallet.derivePath("m/44'/0'/0'/0/1");
    print(hdWallet.address);
    print(hdWallet.wif);

    hdWallet = new HDWallet.fromSeed(seed1);
    hdWallet = hdWallet.derivePath("m/44'/0'/0'/0/2");
    print(hdWallet.address);
    print(hdWallet.wif);
    print('---------------------------------------------------');
    hdWallet = new HDWallet.fromSeed(seed1);
    hdWallet = hdWallet.derivePath("m/0/0");
    print(hdWallet.address);
    print(hdWallet.wif);

    Bip44 bip44 = Bip44(seed);
    Coin bitcoin = bip44.coins[0];
    Account account = Account(bitcoin, 0, changeExternal);
    print(account.chain.root);
  }
}
