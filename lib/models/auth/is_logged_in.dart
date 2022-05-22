import 'package:hive/hive.dart';

part 'is_logged_in.g.dart';

@HiveType(typeId: 3)
class IsLoggedIn extends HiveObject{

  @HiveField(0)
  bool isLoggedIn = false;

  IsLoggedIn(this.isLoggedIn);
}
