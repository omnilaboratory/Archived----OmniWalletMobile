import 'package:flutter/material.dart';

// 参看 https://www.jianshu.com/p/8356a3bc8f6c

class WalletLocalizations{
  final Locale locale;

  WalletLocalizations(this.locale);

  static Map<String,Map<String,String>> _localizedValues={
    'zh': {
      'main_index_title': 'LunarX_Omni钱包',
      'backup_index_title': 'Flutter 示例',
      'backup_index_tips': '注意：请备份你的钱包账户，Omni Wallet 不会访问你的账户、不能恢复私钥、重置密码。你自己控制自己的钱包和资产安全。',
    },
    'en': {
      'main_index_title': 'LunarX_Omni Wallet',
      'backup_index_title': 'Flutter Demo',
      'backup_index_tips': 'Note：safe。',
    }
  };

  get backup_index_title{
    return _localizedValues[locale.languageCode]['backup_index_title'];
  }
  get main_index_title{
    return _localizedValues[locale.languageCode]['main_index_title'];
  }
  get backup_index_tips{
    return _localizedValues[locale.languageCode]['backup_index_tips'];
  }

  static WalletLocalizations of (BuildContext context){
    return Localizations.of(context, WalletLocalizations);
  }
}