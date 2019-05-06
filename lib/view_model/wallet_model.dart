import 'dart:async';

import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wallet_app/model/wallet_info.dart';

import 'package:wallet_app/view_model/state_lib.dart';

class WalletModel extends Model{

  List<WalletInfo> _walletInfoes;

  WalletInfo _currWalletInfo;
  set currWalletInfo(WalletInfo info){
    this._currWalletInfo = info;
  }
  WalletInfo get currWalletInfo{
    return _currWalletInfo;
  }

//  num _currWalletIndex=0;
//  set currWalletIndex(num value){
//    this._currWalletIndex = value;
//  }
//  num get currWalletIndex{
//    return _currWalletIndex;
//  }

  AccountInfo _currAccountInfo;
  set currAccountInfo(AccountInfo info){
    this._currAccountInfo = info;
    notifyListeners();
  }
  AccountInfo get currAccountInfo{
    return _currAccountInfo;
  }

//  num _currAccountIndex=0;
//  set currAccountIndex(num value){
//    this._currAccountIndex = value;
//  }
//  num get currAccountIndex{
//    return _currAccountIndex;
//  }


  TradeInfo _currTradeInfo;
  set currTradeInfo(TradeInfo info){
    this._currTradeInfo = info;
    notifyListeners();
  }
  TradeInfo get currTradeInfo{
    return _currTradeInfo;
  }

  set walletInfoes(List<WalletInfo> info){
    if(info==null&&_loadLastTime!=null){
      var now = DateTime.now();
      var duration = now.difference(_loadLastTime);
      if(duration.inSeconds>20){
        this._walletInfoes = null;
      }
    }else{
      this._walletInfoes = info;
    }
  }

  DateTime _loadLastTime  = null;
  List<WalletInfo> get walletInfoes {
    if(this._walletInfoes==null){
      this._walletInfoes = [];
      Future future = NetConfig.get(NetConfig.addressList);
      future.then((data){
        if(data!=null){

          _loadLastTime = DateTime.now();

          double btcRate = GlobalInfo.usdRateInfo.btcs[0];
          if(GlobalInfo.currLanguage==KeyConfig.languageEn){
            btcRate = GlobalInfo.usdRateInfo.btcs[0];
          }else{
            btcRate = GlobalInfo.usdRateInfo.btcs[1];
          }
          this._walletInfoes = [];
          List list = data['data'] ;
          for(int i=0;i<list.length;i++){
            var node = list[i];
            List assets = node['assets'];
            num totalMoney = 0;
            List<AccountInfo> accountInfo = [];
            for(int j=0;j<assets.length;j++){
              var asset = assets[j];
              double amount = double.parse(asset['balance'].toString());

              double money = amount* btcRate;
              var  propertyId = asset['propertyid'];
              if(propertyId>0){
                money = 0;
              }
              accountInfo.add(AccountInfo(
                  name: asset['name'],
                  amount:amount,
                  iconUrl: propertyId==0||propertyId==1||propertyId==361?'coin_logo_'+asset['name'].toString().toUpperCase():'coin_logo_OMNI',
                  legalTender:money,
                  jsonData: asset,
                  visible: asset['visible'],
                  propertyId: asset['propertyid']
              ));
              totalMoney+=money;
            }
            totalMoney = totalMoney;
            WalletInfo info = WalletInfo(
                name: node['addressName'],
                address:node['address'],
                addressIndex: node['addressIndex'],
                visible: node['visible'],
                totalLegalTender: totalMoney,
                note: '',
                accountInfoes: accountInfo);
            _walletInfoes.add(info);
          }
          if(_walletInfoes.length==0){
            int addressIndex = walletInfoes.length;
            String defaultName = 'name0';
            HDWallet wallet = MnemonicPhrase.getInstance().createAddress(GlobalInfo.userInfo.mnemonic,index: addressIndex);
            WalletInfo info = WalletInfo(
                name: defaultName,
                address: wallet.address,
                addressIndex: addressIndex,
                visible: true,
                totalLegalTender: 0,
                note: '',
                accountInfoes: []
            );
            Future result = NetConfig.post(NetConfig.createAddress, {'address':wallet.address,'addressName':defaultName,'addressIndex':addressIndex.toString()});
            result.then((data){
              this.addWalletInfo(info);
            });
              notifyListeners();
          }else{
            notifyListeners();
          }
        }
      });
    }
    return this._walletInfoes;
  }

  addWalletInfo(WalletInfo info) {
    List<AccountInfo> accountInfo = [];
    accountInfo.add(AccountInfo(
        name: 'BTC',
        amount:0,
        iconUrl: 'coin_logo_BTC',
        legalTender:0,
        visible: true,
        propertyId: 0
    ));
    accountInfo.add(AccountInfo(
        name: 'OMNI',
        amount:0,
        iconUrl: 'coin_logo_OMNI',
        legalTender:0,
        visible: true,
        propertyId: 1
    ));
    accountInfo.add(AccountInfo(
        name: 'LunarX',
        amount:0,
        iconUrl: 'coin_logo_LUNARX',
        legalTender:0,
        visible: true,
        propertyId: 361
    ));
    info.accountInfoes = accountInfo;
    _walletInfoes.insert(0,info);
    notifyListeners();
  }

  List<TradeInfo> tradeInfoes = null;
  List<TradeInfo> getTradeInfoes(String address,{int propertyId=0}){
    print('getTradeInfoes');
    if(tradeInfoes==null){
      String url  = NetConfig.getTransactionsByAddress+'?address='+address;
      if(propertyId>0){
        url  = NetConfig.getOmniTransactionsByAddress+'?address='+address+'&assetId='+propertyId.toString();
      }
      Future future = NetConfig.get(url);
      future.then((data){
        if(data!=null){
          tradeInfoes = [];
          List dataList = data['list'];
          for(int i=0;i<dataList.length;i++){
            var currData = dataList[i];
            bool isSend = currData['isSend'];
            double txValue = 0;
            if(propertyId==0){
               txValue = currData['txValue'];
            }else{
                txValue = double.parse(currData['txValue']);
             }

            int time = currData['time']*1000;
            int confirmAmount = currData['confirmAmount'];
            if(isSend){
              txValue = 0-txValue;
            }
            tradeInfoes.add(
                TradeInfo(
                    amount: txValue,
                    note: '',
                    tradeType: isSend,
                    objAddress: currData['targetAddress'],
                    tradeDate:DateTime.fromMillisecondsSinceEpoch(time),
                    state: confirmAmount>0?1:0,
                    confirmAmount: confirmAmount,
                    txId: currData['txId'],
                    blockId: currData['blockHeight']
                )
            );
          }
          notifyListeners();
          return tradeInfoes;
        }
      });
    }

    if(tradeInfoes==null) tradeInfoes=[];
    return tradeInfoes;
  }

  /**
   * 转账信息
   */
  SendInfo _sendInfo = null ;
  set sendInfo(SendInfo info){
    this._sendInfo = info;
  }
  SendInfo get sendInfo{
    if(this._sendInfo==null){
      this._sendInfo = SendInfo();
    }
    return _sendInfo;
  }
}