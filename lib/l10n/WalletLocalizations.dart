import 'package:flutter/material.dart';

class WalletLocalizations{
  
  final Locale locale;
  WalletLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {

    'zh': {
      'main_index_title': 'LunarX Omniwallet',
      'backup_index_prompt_btn': '知道了',
      'backup_index_title': '备份钱包',
      'backup_index_laterbackup': '稍后备份',
      'backup_index_btn': '备份钱包助记词',
      'backup_index_tips_title': '请立即备份您的钱包!',
      'backup_index_tips': '注意：请备份你的钱包账户，Omniwallet 不会访问你的账户、不能恢复私钥、重置密码。你自己控制自己的钱包和资产安全。',
      'backup_index_prompt_tips': '任何人得到你的助记词将能获得你的资产。\n请抄写在纸上妥善保管。',
      'backup_index_prompt_title': '不要截屏',
      'backup_words_title': '备份助记词',
      'backup_words_next': '下一步',
      'backup_words_content': '请仔细抄写下方助记词，我们将在\n下一步验证。',
      'backup_words_order_title': '确认助记词',
      'backup_words_order_content': '请按顺序点击助记词，以确认您\n正确备份。',
      'backup_words_order_finish': '完成',

      'welcomePageOneTitle' : '欢迎加入 Omni 平台！',
      'welcomePageOneContent' : "为了您的安全，请您抽时间来了解一些重要信息。\n\n"
          "如果您访问了钓鱼网站或丢失备份短语（SEED短语），我们无法恢复您的资金或冻结您的帐户。\n\n"
          "如您愿意继续使用我们的平台，您同意接受与您SEED损失相关的所有风险。如果您丢失了SEED，"
          "您同意并承认 Omni 平台不会对此造成的负面后果承担责任。",
      'welcomePageOneButton' : '您需要知道的关于您的SEED信息',
      
      'welcomePageTwoTitle' : '您需要知道关于您的SEED的信息',
      'welcomePageTwoContentOne' : "注册您的账户时，您要保存您的密码（SEED）并使用密码来保护您的账户。"
          "用普通的中央服务器上，您特别注意密码, 而且您可以通过电子邮件更改和重置密码。然而，Omni 与众不同 — "
          "该钱包安全地储存在您使用的设备上 ：",
      'welcomePageTwoContentTwo' : "您匿名地使用您的钱包，指的是您的账户未连接到电子邮件账户或任何其他识别数据。",
      'welcomePageTwoContentThree' : "用某个设备或浏览器时，您的密码可以保护您的账户，"
          "为了确保您的密码短语不被保存在存储器中。",
      'welcomePageTwoContentFour' : "如果您忘记了密码，您可以通过您的密码短语使用账户恢复表单并轻松创建"
          "一个新密码。但是，如果您遗失了密码，您将无法访问您的帐户。",
      'welcomePageTwoContentFive' : "你不能改变你的秘密短语。如果您不小心将其发送给某人或怀疑诈骗者已将"
          "其移交给他人，请立即创建一个新的 Omni 钱包并将资金转入其中。",
      'welcomePageTwoButtonBack' : '    返回    ',
      'welcomePageTwoButtonNext' : '    保护自己    ',

      'welcomePageThreeTitle' : '如何防止网络钓鱼攻击',
      'welcomePageThreeContentOne' : "诈骗最常见的攻击方式之一是网络钓鱼，一般钓鱼者在Facebook或其他类"
          "似于真实的网站上创建假社群。",
      'welcomePageThreeContentTwo' : "请总是检查URL: https://www.lunarx_omni.com",
      'welcomePageThreeContentThree' : "访问您的账户时请不要使用具有扩展程序或插件的浏览器。",
      'welcomePageThreeContentFour' : "请不要打开来自未知发件人的电子邮件或链接。",
      'welcomePageThreeContentFive' : "请您定期更新您的浏览器和操作系统。",
      'welcomePageThreeContentSix' : "请您使用官方安全软件。请不要安装会被黑客攻击的未知软件。",
      'welcomePageThreeContentSeven' : "使用公共Wi-Fi或其他人的设备时请勿访问您的钱包。",
      'welcomePageThreeButtonBack' : '    返回    ',
      'welcomePageThreeButtonNext' : '    我了解    ',

      'startPageAppBarTitle' : 'LunarX Omniwallet',
      'startPageButtonFirst' : '      开始使用      ',
      'startPageButtonSecond' : '      恢复钱包      ',
      'startPageLanguageBarTitle' : '多语言',

      'main_page_title' : '钱包',
      'common_btn_skip' : '跳过',

      'marketPageAppBarTitle' : '行情',
      'marketPageFav' : '自选',
      'marketPageAll' : '全部',
      'marketPagePrice' : '价格',
      'marketPageChange' : '涨跌幅',

      'myProfilePageMenu1' : '设置',
      'myProfilePageMenu2' : '钱包地址本',
      'myProfilePageMenu3' : '帮助和反馈',
      'myProfilePageMenu4' : '服务条款',
      'myProfilePageMenu5' : '备份钱包',
      'myProfilePageMenu6' : '关于',

      'settingsPageTitle' : '设置',
      'settingsPageItem_1_Title' : '多语言',
      'settingsPageItem_2_Title' : '货币',
      'settingsPageItem_3_Title' : '主题颜色',

      'helpPageTitle' : '帮助',
      'helpPageItemTitle' : '常见问题',
      'helpPageFeedback' : '提交反馈',

      'feedbackPageTitle' : '提交反馈',
      'feedbackPageInputTitleTooltip' : '标题',
      'feedbackPageContentTooltip' : '内容',
      'feedbackPageEmailTooltip' : '电子邮件',
      'feedbackPageUploadPicTitle' : '上传图片',
      'feedbackPageSubmitButton' : '提交',

      "createNewAddress_title":"创建新的地址",
      "createNewAddress_hint1":"地址名称",
      "createNewAddress_Add":"添加",
      "createNewAddress_Cancel":"取消",
      "createNewAddress_WrongAddress":"请输入地址名称",

      'serviceTermsPageAppBarTitle' : '服务条款',

      'aboutPageAppBarTitle' : '关于',
      'aboutPageAppName' : 'Omni 钱包',
      'aboutPageItem_1' : '版本日志',
      'aboutPageItem_2' : '官方网站',
      'aboutPageItem_3' : '推特',
      'aboutPageItem_4' : '微信',
      'aboutPageItem_5' : '电报群',
      'aboutPageButton' : '版本更新',

      'userInfoPageAppBarTitle' : '用户信息',
      'userInfoPageItem_1_Title' : '头像',
      'userInfoPageItem_2_Title' : '用户名',
      'userInfoPageButton' : '删除当前钱包',

      'buttom_tab1_name' : '钱包',
      'buttom_tab2_name' : '市场',
      'buttom_tab3_name' : 'Omni',
      'buttom_tab4_name' : '我的',
    },

    'en': {
      'main_index_title': 'LunarX Omniwallet',
      'backup_index_prompt_btn': 'I got it',
      'backup_index_title': 'Backup wallet',
      'backup_index_laterbackup': 'later',
      'backup_index_btn': 'Backup Mnemonic Phrase',
      'backup_index_tips_title': 'Backup your wallet now!',
      'backup_index_tips': 'Notice: please backup your wallet, Omni will never visit your account, can not restore your private key or reset your password. You will manage your wallet on your own, and make sure the safety of your asset.',
      'backup_index_prompt_tips': 'Anyone who gets access to your mnemonic will have access to your assets. Please copy it onto paper and store securely for safekeeping.',
      'backup_index_prompt_title': "Do Not Use Screenshots!",
      'backup_words_title': 'Backup Mnemonic Phrase',
      'backup_words_next': 'next',
      'backup_words_content': "Please copy the mnemonic words carefully,\nwe will verify them in the next step.",
      'backup_words_order_title': 'Confirm mnemonic words',
      'backup_words_order_content': 'Please click mnemonic words in order to \nmake sure that you backup correctly',
      'backup_words_order_finish': 'Finish',

      'welcomePageOneTitle' : 'Welcome to the Omni Platform!',
      'welcomePageOneContent' : "Please take some time to understand some "
          "important things for your own safety. \n\nWe cannot recover your "
          "funds or freeze your account if you visit a phishing site or lose "
          "your backup phrase (aka SEED phrase).  \n\nBy continuing to use our "
          "platform, you agree to accept all risks associated with the loss of "
          "your SEED, including but not limited to the inability to obtain your "
          "funds and dispose of them. In case you lose your SEED, you agree and "
          "acknowledge that the Omni Platform would not be responsible for the "
          "negative consequences of this.",
      'welcomePageOneButton' : 'What you need to know about your SEED',

      'welcomePageTwoTitle' : 'What you need to know \nabout your SEED',
      'welcomePageTwoContentOne' : "When registering your account, you will be asked "
          "to save your secret phrase (SEED) and to protect your account with a password. "
          "On normal centralized servers, special attention is paid to the password, which "
          "can be changed and reset via email, if the need arises. However, on decentralized "
          "platforms such as Omni, everything is arranged differently:",
      'welcomePageTwoContentTwo' : "You use your wallet anonymously, meaning your account "
          "is not connected to an email account or any other identifying data.",
      'welcomePageTwoContentThree' : "Your password protects your account when working on "
          "a certain device or browser. It is needed in order to ensure that your secret "
          "phrase is not saved in storage.",
      'welcomePageTwoContentFour' : "If you forget your password, you can easily create a "
          "new one by using the account recovery form via your secret phrase. If you lose "
          "your secret phrase, however, you will have no way to access your account.",
      'welcomePageTwoContentFive' : "You cannot change your secret phrase. If you "
          "accidentally sent it to someone or suspect that scammers have taken it over, "
          "then create a new Omniwallet immediately and transfer your funds to it.",
      'welcomePageTwoButtonBack' : 'Go Back',
      'welcomePageTwoButtonNext' : 'Protect Yourself',

      'welcomePageThreeTitle' : 'How To Protect Yourself from Phishers',
      'welcomePageThreeContentOne' : "One of the most common forms of scamming is "
          "phishing, which is when scammers create fake communities on Facebook or "
          "other websites that look similar to the authentic ones.",
      'welcomePageThreeContentTwo' : "Always check the URL: https://www.lunarx_omni.com",
      'welcomePageThreeContentThree' : "Do not use browsers that have extensions or "
          "plugins to access your account.",
      'welcomePageThreeContentFour' : "Do not open emails or links from unknown senders.",
      'welcomePageThreeContentFive' : "Regularly update your browser and operating system.",
      'welcomePageThreeContentSix' : "Use official security software. Do not install "
          "unknown software which could be hacked.",
      'welcomePageThreeContentSeven' : "Do not access your wallet when using public "
          "Wi-Fi or someone else’s device.",
      'welcomePageThreeButtonBack' : 'Go Back',
      'welcomePageThreeButtonNext' : 'I Understand',

      'startPageAppBarTitle' : 'LunarX Omniwallet',
      'startPageButtonFirst' : '     Get Started     ',
      'startPageButtonSecond' : '   Restore wallet   ',
      'startPageLanguageBarTitle' : 'Language',

      'main_page_title' : 'My Wallet',
      'common_btn_skip' : 'Skip',

      'marketPageAppBarTitle' : 'Quotation',
      'marketPageFav' : 'Favorites',
      'marketPageAll' : 'All',
      'marketPagePrice' : 'Price',
      'marketPageChange' : 'Change',

      'myProfilePageMenu1' : 'Settings',
      'myProfilePageMenu2' : 'Address Book',
      'myProfilePageMenu3' : 'Help and Feedback',
      'myProfilePageMenu4' : 'Service Terms',
      'myProfilePageMenu5' : 'Backup Wallet',
      'myProfilePageMenu6' : 'About',

      'settingsPageTitle' : 'Settings',
      'settingsPageItem_1_Title' : 'Language',
      'settingsPageItem_2_Title' : 'Currency',
      'settingsPageItem_3_Title' : 'Theme',

      'helpPageTitle' : 'Help',
      'helpPageItemTitle' : 'FAQ',
      'helpPageFeedback' : 'Feedback',

      'feedbackPageTitle' : 'Submit Feedback',
      'feedbackPageInputTitleTooltip' : 'Title',
      'feedbackPageContentTooltip' : 'Content',
      'feedbackPageEmailTooltip' : 'E-mail',
      'feedbackPageUploadPicTitle' : 'Upload Picture',
      'feedbackPageSubmitButton' : 'Submit',

      "createNewAddress_title":"Create New Address",
      "createNewAddress_hint1":"Address Name",
      "createNewAddress_Add":"Add",
      "createNewAddress_Cancel":"Cancel",
      "createNewAddress_WrongAddress":"Please input address name",

      'serviceTermsPageAppBarTitle' : 'Service Terms',

      'aboutPageAppBarTitle' : 'About',
      'aboutPageAppName' : 'Omni Wallet',
      'aboutPageItem_1' : 'Version History',
      'aboutPageItem_2' : 'Website',
      'aboutPageItem_3' : 'Twitter',
      'aboutPageItem_4' : 'Wechat',
      'aboutPageItem_5' : 'Telegram',
      'aboutPageButton' : 'Version Update',

      'userInfoPageAppBarTitle' : 'User Information',
      'userInfoPageItem_1_Title' : 'Avatar',
      'userInfoPageItem_2_Title' : 'User Name',
      'userInfoPageButton' : 'Delete Current Wallet',


      'buttom_tab1_name' : 'Wallet',
      'buttom_tab2_name' : 'Market',
      'buttom_tab3_name' : 'Omni',
      'buttom_tab4_name' : 'My',
    }
  };

  get buttom_tab1_name => _localizedValues[locale.languageCode]['buttom_tab1_name'];
  get buttom_tab2_name => _localizedValues[locale.languageCode]['buttom_tab2_name'];
  get buttom_tab3_name => _localizedValues[locale.languageCode]['buttom_tab3_name'];
  get buttom_tab4_name => _localizedValues[locale.languageCode]['buttom_tab4_name'];

  // User Information page
  get userInfoPageAppBarTitle => _localizedValues[locale.languageCode]['userInfoPageAppBarTitle'];
  get userInfoPageItem_1_Title => _localizedValues[locale.languageCode]['userInfoPageItem_1_Title'];
  get userInfoPageItem_2_Title => _localizedValues[locale.languageCode]['userInfoPageItem_2_Title'];
  get userInfoPageButton => _localizedValues[locale.languageCode]['userInfoPageButton'];

  // Service Terms page
  get serviceTermsPageAppBarTitle => _localizedValues[locale.languageCode]['serviceTermsPageAppBarTitle'];

  // About page
  get aboutPageAppBarTitle => _localizedValues[locale.languageCode]['aboutPageAppBarTitle'];
  get aboutPageAppName => _localizedValues[locale.languageCode]['aboutPageAppName'];
  get aboutPageItem_1 => _localizedValues[locale.languageCode]['aboutPageItem_1'];
  get aboutPageItem_2 => _localizedValues[locale.languageCode]['aboutPageItem_2'];
  get aboutPageItem_3 => _localizedValues[locale.languageCode]['aboutPageItem_3'];
  get aboutPageItem_4 => _localizedValues[locale.languageCode]['aboutPageItem_4'];
  get aboutPageItem_5 => _localizedValues[locale.languageCode]['aboutPageItem_5'];
  get aboutPageButton => _localizedValues[locale.languageCode]['aboutPageButton'];

  //wallet page createNewAddress dialog
  get createNewAddress_title => _localizedValues[locale.languageCode]['createNewAddress_title'];
  get createNewAddress_hint1 => _localizedValues[locale.languageCode]['createNewAddress_hint1'];
  get createNewAddress_Add => _localizedValues[locale.languageCode]['createNewAddress_Add'];
  get createNewAddress_Cancel => _localizedValues[locale.languageCode]['createNewAddress_Cancel'];
  get createNewAddress_WrongAddress => _localizedValues[locale.languageCode]['createNewAddress_WrongAddress'];

  // Submit Feedback page
  get feedbackPageTitle => _localizedValues[locale.languageCode]['feedbackPageTitle'];
  get feedbackPageInputTitleTooltip => _localizedValues[locale.languageCode]['feedbackPageInputTitleTooltip'];
  get feedbackPageContentTooltip => _localizedValues[locale.languageCode]['feedbackPageContentTooltip'];
  get feedbackPageEmailTooltip => _localizedValues[locale.languageCode]['feedbackPageEmailTooltip'];
  get feedbackPageUploadPicTitle => _localizedValues[locale.languageCode]['feedbackPageUploadPicTitle'];
  get feedbackPageSubmitButton => _localizedValues[locale.languageCode]['feedbackPageSubmitButton'];

  // Help and Feedback page
  get helpPageTitle => _localizedValues[locale.languageCode]['helpPageTitle'];
  get helpPageItemTitle => _localizedValues[locale.languageCode]['helpPageItemTitle'];
  get helpPageFeedback => _localizedValues[locale.languageCode]['helpPageFeedback'];

  // Setting page
  get settingsPageTitle => _localizedValues[locale.languageCode]['settingsPageTitle'];
  get settingsPageItem_1_Title => _localizedValues[locale.languageCode]['settingsPageItem_1_Title'];
  get settingsPageItem_2_Title => _localizedValues[locale.languageCode]['settingsPageItem_2_Title'];
  get settingsPageItem_3_Title => _localizedValues[locale.languageCode]['settingsPageItem_3_Title'];

  // My profile page
  get myProfilePageMenu1 => _localizedValues[locale.languageCode]['myProfilePageMenu1'];
  get myProfilePageMenu2 => _localizedValues[locale.languageCode]['myProfilePageMenu2'];
  get myProfilePageMenu3 => _localizedValues[locale.languageCode]['myProfilePageMenu3'];
  get myProfilePageMenu4 => _localizedValues[locale.languageCode]['myProfilePageMenu4'];
  get myProfilePageMenu5 => _localizedValues[locale.languageCode]['myProfilePageMenu5'];
  get myProfilePageMenu6 => _localizedValues[locale.languageCode]['myProfilePageMenu6'];

  // Market Page
  get marketPageAppBarTitle => _localizedValues[locale.languageCode]['marketPageAppBarTitle'];
  get marketPageFav => _localizedValues[locale.languageCode]['marketPageFav'];
  get marketPageAll => _localizedValues[locale.languageCode]['marketPageAll'];
  get marketPagePrice => _localizedValues[locale.languageCode]['marketPagePrice'];
  get marketPageChange => _localizedValues[locale.languageCode]['marketPageChange'];

  // Start Page.
  get startPageAppBarTitle => _localizedValues[locale.languageCode]['startPageAppBarTitle'];
  get startPageButtonFirst => _localizedValues[locale.languageCode]['startPageButtonFirst'];
  get startPageButtonSecond => _localizedValues[locale.languageCode]['startPageButtonSecond'];
  get startPageLanguageBarTitle => _localizedValues[locale.languageCode]['startPageLanguageBarTitle'];

  // Welcome Page One.
  get welcomePageOneTitle => _localizedValues[locale.languageCode]['welcomePageOneTitle'];
  get welcomePageOneContent => _localizedValues[locale.languageCode]['welcomePageOneContent'];
  get welcomePageOneButton => _localizedValues[locale.languageCode]['welcomePageOneButton'];

  // Welcome Page Two.
  get welcomePageTwoTitle => _localizedValues[locale.languageCode]['welcomePageTwoTitle'];
  get welcomePageTwoContentOne => _localizedValues[locale.languageCode]['welcomePageTwoContentOne'];
  get welcomePageTwoContentTwo => _localizedValues[locale.languageCode]['welcomePageTwoContentTwo'];
  get welcomePageTwoContentThree => _localizedValues[locale.languageCode]['welcomePageTwoContentThree'];
  get welcomePageTwoContentFour => _localizedValues[locale.languageCode]['welcomePageTwoContentFour'];
  get welcomePageTwoContentFive => _localizedValues[locale.languageCode]['welcomePageTwoContentFive'];
  get welcomePageTwoButtonBack => _localizedValues[locale.languageCode]['welcomePageTwoButtonBack'];
  get welcomePageTwoButtonNext => _localizedValues[locale.languageCode]['welcomePageTwoButtonNext'];

  // Welcome Page Three.
  get welcomePageThreeTitle => _localizedValues[locale.languageCode]['welcomePageThreeTitle'];
  get welcomePageThreeContentOne => _localizedValues[locale.languageCode]['welcomePageThreeContentOne'];
  get welcomePageThreeContentTwo => _localizedValues[locale.languageCode]['welcomePageThreeContentTwo'];
  get welcomePageThreeContentThree => _localizedValues[locale.languageCode]['welcomePageThreeContentThree'];
  get welcomePageThreeContentFour => _localizedValues[locale.languageCode]['welcomePageThreeContentFour'];
  get welcomePageThreeContentFive => _localizedValues[locale.languageCode]['welcomePageThreeContentFive'];
  get welcomePageThreeContentSix => _localizedValues[locale.languageCode]['welcomePageThreeContentSix'];
  get welcomePageThreeContentSeven => _localizedValues[locale.languageCode]['welcomePageThreeContentSeven'];
  get welcomePageThreeButtonBack => _localizedValues[locale.languageCode]['welcomePageThreeButtonBack'];
  get welcomePageThreeButtonNext => _localizedValues[locale.languageCode]['welcomePageThreeButtonNext'];

  get main_index_title => _localizedValues[locale.languageCode]['main_index_title'];

  get backup_index_title => _localizedValues[locale.languageCode]['backup_index_title'];
  get backup_index_laterbackup => _localizedValues[locale.languageCode]['backup_index_laterbackup'];
  get backup_index_tips_title => _localizedValues[locale.languageCode]['backup_index_tips_title'];
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

  String get main_page_title => _localizedValues[locale.languageCode]['main_page_title'];

  String get common_btn_skip => _localizedValues[locale.languageCode]['common_btn_skip'];


  static WalletLocalizations of (BuildContext context){
    return Localizations.of(context, WalletLocalizations);
  }
}