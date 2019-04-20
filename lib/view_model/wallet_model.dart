import 'package:scoped_model/scoped_model.dart';
import 'package:wallet_app/model/wallet_info.dart';
import 'dart:math';

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

  num _currWalletIndex=0;
  set currWalletIndex(num value){
    this._currWalletIndex = value;
  }
  num get currWalletIndex{
    return _currWalletIndex;
  }

  AccountInfo _currAccountInfo;
  set currAccountInfo(AccountInfo info){
    this._currAccountInfo = info;
    notifyListeners();
  }
  AccountInfo get currAccountInfo{
    return _currAccountInfo;
  }

  num _currAccountIndex=0;
  set currAccountIndex(num value){
    this._currAccountIndex = value;
  }
  num get currAccountIndex{
    return _currAccountIndex;
  }


  TradeInfo _currTradeInfo;
  set currTradeInfo(TradeInfo info){
    this._currTradeInfo = info;
    notifyListeners();
  }
  TradeInfo get currTradeInfo{
    return _currTradeInfo;
  }

  List<WalletInfo> get  walletInfoes {
    if(this._walletInfoes==null){
      this._walletInfoes = [];
      Future future = NetConfig.get(NetConfig.addressList);
      future.then((data){
        if(data!=null){
          List list = data['data'] ;
          for(int i=0;i<list.length;i++){
            var node = list[i];
            WalletInfo info = WalletInfo(name: node['addressName'],address:node['address'],totalLegalTender: 0,note: '',accountInfoes: []);
            _walletInfoes.add(info);
          }
        }
      });
    }
    notifyListeners();
    return this._walletInfoes;
  }
//      int walletCount = 1+Random().nextInt(10);
//      for(int i=0;i<walletCount;i++){
//        List<AccountInfo> accountInfo = [];
//        int accountCount = 1+Random().nextInt(10);
//        num totalMoney = 0;
//        for(int j=0;j<accountCount;j++){
//          num money = Random().nextDouble();
//          accountInfo.add(AccountInfo(name: 'Asset ${j+1}',amount:Random().nextDouble(),legalTender:money ));
//          totalMoney+=money;
//        }
//        WalletInfo info = WalletInfo(name: 'Wallet Address ${i+1}',address: "18TbfsFjWpi6Ad14UXS4YQ3Wume4xh5ySt",totalLegalTender: totalMoney,note: "note${i+1}",accountInfoes: accountInfo);
//        _walletInfoes.add(info);
//      }

  addWalletInfo(WalletInfo info) {
    _walletInfoes.add(info);
    notifyListeners();
  }


  List<TradeInfo> get tradeInfoes{
    List<TradeInfo> infoes = [];
    int count = 6;
    for(int i=0;i<count;i++){
      infoes.add(
          TradeInfo(
            amount: Random().nextDouble(),
            note: "note${i}",
            objAddress: "18TbfsFjWpi6Ad14UXS4YQ3Wume4xh5ySt",
            tradeDate: DateTime.now(),
            state: Random().nextInt(2),
            confirmAmount: Random().nextInt(100),
            txId: "txidtxidtxidtxidtxid${i}",
            blockId: Random().nextInt(60000)
          )
      );
    }
    return infoes;
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