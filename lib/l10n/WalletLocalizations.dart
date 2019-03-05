import 'package:flutter/material.dart';

class WalletLocalizations{
  
  final Locale locale;
  WalletLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {

    'zh': {
      'main_index_title': 'LunarX_Omni钱包',
      'backup_index_prompt_btn': '知道了',
      'backup_index_title': '备份钱包',
      'backup_index_btn': '备份钱包助记词',
      'backup_index_tips': '注意：请备份你的钱包账户，Omni Wallet 不会访问你的账户、不能恢复私钥、重置密码。你自己控制自己的钱包和资产安全。',
      'backup_index_prompt_tips': '任何人得到你的助记词将能获得你的资产。\n请抄写在纸上妥善保管。',
      'backup_index_prompt_title': '不要截屏',
      'backup_words_title': '备份助记词',
      'backup_words_next': '下一步',
      'backup_words_content': '请仔细抄写下方助记词，我们将在\n下一步验证。',
      'backup_words_order_title': '确认助记词',
      'backup_words_order_content': '请按顺序点击助记词，以确认您\n正确备份。',
      'backup_words_order_finish': '完成',
      'welcomePageOneTitle' : '欢迎加入 Omni 平台！',
      // 'welcome_1_title' : '',
    },

    'en': {
      'main_index_title': 'LunarX_Omni Wallet',
      'backup_index_prompt_btn': 'I got it',
      'backup_index_title': 'Backup the wallet',
      'backup_index_btn': 'Backup wallet mnemonic',
      'backup_index_tips': 'Note: please back up your Wallet account, Omni Wallet does not access your account, cannot restore private key, reset password. You are in control of your own wallet and asset security.',
      'backup_index_prompt_tips': 'Anyone who gets your mnemonic will get your assets. Please copy on the paper for safekeeping.',
      'backup_index_prompt_title': "Don't screenshots",
      'backup_words_title': 'Back up your mnemonic',
      'backup_words_next': 'next',
      'backup_words_content': "Please copy the mnemonic word carefully,\nwe will verify it in the next step.",
      'backup_words_order_title': 'Confirm mnemonic words',
      'backup_words_order_content': 'Please click mnemonic word in order to \nmake sure that you backup correctly',
      'backup_words_order_finish': 'Finish',
      'welcomePageOneTitle' : 'Welcome to the Omni Platform!',
    }
  };
  get welcomePageOneTitle =>_localizedValues[locale.languageCode]['welcomePageOneTitle'];

  get main_index_title => _localizedValues[locale.languageCode]['main_index_title'];

  get backup_index_title => _localizedValues[locale.languageCode]['backup_index_title'];
  get backup_index_tips => _localizedValues[locale.languageCode]['backup_index_tips'];
  get backup_index_btn => _localizedValues[locale.languageCode]['backup_index_btn'];
  get backup_index_prompt_title => _localizedValues[locale.languageCode]['backup_index_prompt_title'];
  get backup_index_prompt_tips => _localizedValues[locale.languageCode]['backup_index_prompt_tips'];
  get backup_index_prompt_btn => _localizedValues[locale.languageCode]['backup_index_prompt_btn'];

  get backup_words_title => _localizedValues[locale.languageCode]['backup_words_title'];
  get backup_words_content => _localizedValues[locale.languageCode]['backup_words_content'];
  get backup_words_next => _localizedValues[locale.languageCode]['backup_words_next'];

  get backup_words_order_title => _localizedValues[locale.languageCode]['backup_words_order_title'];
  get backup_words_order_content => _localizedValues[locale.languageCode]['backup_words_order_content'];
  get backup_words_order_finish => _localizedValues[locale.languageCode]['backup_words_order_finish'];


  static WalletLocalizations of (BuildContext context){
    return Localizations.of(context, WalletLocalizations);
  }
}