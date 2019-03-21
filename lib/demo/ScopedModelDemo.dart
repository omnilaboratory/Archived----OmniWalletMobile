import 'package:scoped_model/scoped_model.dart';

class CounterModel extends Model{
  int _counter=0;
  int get counter{
    return this._counter;
  }

  void increment(){
    this._counter++;
    notifyListeners();
  }
}