import 'package:firebase_auth/firebase_auth.dart';
import 'package:remember_me/model/custom_model.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //login
  Future<CustomModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return CustomModel(user: res.user);
    } on FirebaseAuthException catch (e) {
      return CustomModel(msg: e.message);
    }
  }

  //register
  Future<CustomModel> register({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return CustomModel(user: res.user);
    } on FirebaseAuthException catch (e) {
      return CustomModel(msg: e.message);
    }
  }

  //log out
  Future logOut() async {
    await _auth.signOut();
    print("sing out");
  }
}
