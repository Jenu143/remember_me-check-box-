import 'package:flutter/cupertino.dart';
import 'package:remember_me/Auth/auth.dart';
import 'package:remember_me/constant/comman_dialog.dart';
import 'package:remember_me/model/custom_model.dart';

class GetProvider extends ChangeNotifier {
  Auth auth = Auth();
  bool btnCheck = preferences.getBool("btn") == true ? true : false;
  String? gUU;
  // for chek box
  void checkValue() {
    btnCheck = !btnCheck;
    notifyListeners();
  }

  // login
  Future<CustomModel> login(
      {required String email, required String password}) async {
    final res = auth.logIn(email: email, password: password);

    notifyListeners();
    return res;
  }

  // register
  Future<CustomModel> register(
      {required String email, required String password}) async {
    final reg = auth.register(email: email, password: password);

    notifyListeners();
    return reg;
  }

  Future logOut() async {
    final out = auth.logOut();

    notifyListeners();
    return out;
  }
}
