
import 'package:wallet_app/view_model/state_lib.dart';

import 'fp_user_model.dart';

class MainStateModel extends Model with 
    SelectLanguageModel, WalletModel, UserUsualAddressModel,
    BackupMnemonicPhrase, SelectCurrencyModel, SelectThemeModel,
    FPUserModel
{
  MainStateModel of(context) =>
      ScopedModel.of<MainStateModel>(context, rebuildOnChange: false);
}
