import 'package:flutter/material.dart';
import 'package:remember_me/constant/comman_dialog.dart';

import 'package:remember_me/provider/get_provider.dart';
import 'package:remember_me/screens/login.dart';

class Home extends StatelessWidget {
  Home({Key? key, this.uid = ""}) : super(key: key);
  final String uid;

  GetProvider getProvider = GetProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to home screen...!",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 50),
            Text(uid),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                final email = preferences.getString("email");
                final password = preferences.getString("pass");
                final checkBoxValue = preferences.getBool("btn");

                await preferences.clear().then((value) {
                  if (checkBoxValue == true) {
                    preferences.setString("email", email.toString());
                    preferences.setString("pass", password.toString());
                    preferences.setBool("btn", checkBoxValue!);
                  }
                });

                await getProvider.logOut();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
