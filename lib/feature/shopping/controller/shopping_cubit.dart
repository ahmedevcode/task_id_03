import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

class ShoppingCubit extends Cubit<List<String>> {
  final Box<String> _shoppingBox;

  ShoppingCubit(this._shoppingBox) : super(_shoppingBox.values.toList());

  void addItem(String item) {
    _shoppingBox.add(item);
    emit(_shoppingBox.values.toList());
  }

  void removeItem(int index) {
    _shoppingBox.deleteAt(index);
    emit(_shoppingBox.values.toList());
  }
}
