import 'package:flutter/material.dart';

// 参看 https://www.jianshu.com/p/8356a3bc8f6c

class WalletLocalizations{
  
  final Locale locale;
  WalletLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {

    'zh': {
      'main_index_title': 'LunarX_Omni钱包',
      'backup_index_title': 'Flutter 示例',
      'backup_index_tips': '注意：请备份你的钱包账户，Omni Wallet 不会访问你的账户、不能恢复私钥、重置密码。你自己控制自己的钱包和资产安全。',
      'backup_words_next': '下一步',
      'welcome_1_title' : '欢迎加入 Omni 平台！',
      // 'welcome_1_title' : '',
    },

    'en': {
      'main_index_title': 'LunarX_Omni Wallet',
      'backup_index_title': 'Flutter Demo',
      'backup_index_tips': 'Note：safe。',
      'backup_words_next': 'next',
      'welcome_1_title' : 'Welcome to the Omni Platform!',
    }
  };

  get welcome_1_title{
    return _localizedValues[locale.languageCode]['welcome_1_title'];
  }

  get backup_index_title{
    return _localizedValues[locale.languageCode]['backup_index_title'];
  }
  get main_index_title{
    return _localizedValues[locale.languageCode]['main_index_title'];
  }
  get backup_index_tips{
    return _localizedValues[locale.languageCode]['backup_index_tips'];
  }
  get backup_words_next{
    return _localizedValues[locale.languageCode]['backup_words_next'];
  }

  static WalletLocalizations of (BuildContext context){
    return Localizations.of(context, WalletLocalizations);
  }
}