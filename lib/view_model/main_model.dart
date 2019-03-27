import 'package:scoped_model/scoped_model.dart';
import 'package:wallet_app/view_model/select_language_model.dart';
import 'package:wallet_app/view_model/user_usual_address_model.dart';
import 'package:wallet_app/view_model/wallet_model.dart';
class MainStateModel extends Model with SelectLanguageModel,WalletModel,UserUsualAddressModel
{
  MainStateModel of(context) =>
      ScopedModel.of<MainStateModel>(context, rebuildOnChange: false);
}
