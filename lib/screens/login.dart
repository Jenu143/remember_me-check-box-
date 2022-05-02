import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remember_me/constant/comman_dialog.dart';
import 'package:remember_me/home.dart';
import 'package:remember_me/model/custom_model.dart';
import 'package:remember_me/provider/get_provider.dart';
import 'package:remember_me/screens/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GetProvider getProvider = GetProvider();

  @override
  void initState() {
    super.initState();
    if (preferences.getBool("btn") == true) {
      emailController.text = preferences.getString("email").toString();
      passwordController.text = preferences.getString("pass").toString();

      getProvider.btnCheck = preferences.getBool("btn")!;
      print("getBtn Value :: ${getProvider.btnCheck}");
    }
  }

//!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 100),
            textFields("Email", emailController),
            const SizedBox(height: 20),

            textFields("password", passwordController),
            const SizedBox(height: 20),

            //^ consumer

            chekBox(),
            const SizedBox(height: 20),

            //loinBtn
            loginBtn(),
            const SizedBox(height: 20),

            //textBtn
            textBtn(context)
          ],
        ),
      ),
    );
  }

  Widget textBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
      },
      child: Text(
        "Create Account?",
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget loginBtn() {
    return Consumer<GetProvider>(
      builder: (context, value, child) => ElevatedButton(
        onPressed: () async {
          final res = await getProvider.login(
            email: emailController.text,
            password: passwordController.text,
          );

          if (res.user?.uid == null) {
            commanDialog(
                context: context,
                error: "no record found...! \ncreate account first :)");
          } else {
            print("set value :: ${value.btnCheck}");
            preferences.setString("uid", "${res.user?.uid}");
            preferences.setString("email", emailController.text);
            preferences.setString("pass", passwordController.text);
            preferences.setBool("btn", value.btnCheck);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          }
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 70, vertical: 14),
          ),
        ),
        child: const Text("Login"),
      ),
    );
  }

  Widget chekBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Consumer<GetProvider>(
        builder: (context, value, child) {
          return Row(
            children: [
              Checkbox(
                value: value.btnCheck,
                onChanged: (c) {
                  value.checkValue();
                },
              ),
              const Text("remember email and password"),
            ],
          );
        },
      ),
    );
  }

  Widget textFields(String name, TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: name,

          //focus border
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(25),
          ),

          //border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
