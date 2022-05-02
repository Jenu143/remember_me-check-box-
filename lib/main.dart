import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remember_me/Auth/auth.dart';
import 'package:remember_me/constant/comman_dialog.dart';
import 'package:remember_me/home.dart';
import 'package:remember_me/screens/login.dart';
import 'package:remember_me/provider/get_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance().then(
    (prefs) {
      preferences = prefs;
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final res = preferences.getString("uid");
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetProvider()),
      ],
      child: MaterialApp(
        home: preferences.getString("uid") == null
            ? const LoginScreen()
            : Home(uid: res.toString()),
      ),
    );
  }
}
