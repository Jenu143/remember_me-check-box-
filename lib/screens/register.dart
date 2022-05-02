import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remember_me/constant/comman_dialog.dart';
import 'package:remember_me/home.dart';
import 'package:remember_me/provider/get_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GetProvider getProvider = GetProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
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
            // chekBox(),
            // const SizedBox(height: 20),

            //loinBtn
            register(),
            const SizedBox(height: 20),

            //textBtn
            textBtn(context),
          ],
        ),
      ),
    );
  }

  Widget textBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        "Have an Account?",
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget register() {
    return Consumer<GetProvider>(
      builder: (context, value, child) => ElevatedButton(
        onPressed: () async {
          final res = await getProvider.register(
            email: emailController.text,
            password: passwordController.text,
          );

          if (res.user?.uid == null) {
            commanDialog(
                context: context,
                error:
                    "this is email already has been used \ntry onther email or password");
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          }

          print("UID :: ${res.user?.uid}");
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 70, vertical: 14),
          ),
        ),
        child: const Text("Register"),
      ),
    );
  }

  // Widget chekBox() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 30),
  //     child: Consumer<GetProvider>(
  //       builder: (context, value, child) {
  //         return Row(
  //           children: [
  //             Checkbox(
  //               value: value.btnCheck,
  //               onChanged: (c) {
  //                 value.checkValue();
  //               },
  //             ),
  //             const Text("remember email and password"),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

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
