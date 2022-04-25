import 'package:hive/hive.dart';
import 'package:trakk/screens/repository/hive_interface.dart';
// import 'package:vpay_merchant_mobile/repository/hive_interface.dart';
import 'package:trakk/screens/repository/hive_repository.dart';

class HiveRepository implements IRepository {
  HiveRepository();

  static openHives(List<String> boxNames) async {
    var boxHives = boxNames.map((name) => Hive.openBox(name));
    print("trying to open hive boxes");
    await Future.wait(boxHives);
    print("Hive boxes opened");
  }

  @override
  add<T>({required T item, required String key, required String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    box.put(key, item);
  }

  @override
  T get<T>({required String key, required String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    return box.get(key);
  }

  @override
  remove<T>({required String key, required String name}) {
    var box = Hive.box(name);
    checkBoxState(box);
    return box.delete(key);
  }

  checkBoxState(box) {
    if (box == null) throw Exception('Box has not been set');
  }

  @override
  clear<T>({required String name}) async {
    var box = Hive.box(name);
    checkBoxState(box);
    await box.clear();
  }
}
