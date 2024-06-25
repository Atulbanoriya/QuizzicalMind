import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/auth_screen/signup.dart';
import 'package:quizapp/custom/dailog.dart';
import 'package:quizapp/screen/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Future<UserCredential?> signIn({required String email, required String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.message}')));
      return null;
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      UserCredential? userCredential = await signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (userCredential != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: "Login Successful",
              description: "You have successfully logged in.",
              onConfirm: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
              },
              onCancel: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff40E0D0),
        leading: Icon(
          Icons.keyboard_backspace,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xff40E0D0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "image/logowhite.png",
              height: 160.0,
              width: 160.0,
            ),
            SizedBox(
              height: 480,
              width: 400,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    left: 16,
                    child: Container(
                      height: 450,
                      width: 325,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Login Into Your Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            Divider(
                              thickness: 5,
                              height: 15,
                              color: Color(0xff40E0D0),
                              indent: 120.0,
                              endIndent: 120.0,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      label: Text("Enter your email"),
                                      prefixIcon: Icon(Icons.mail_outline_outlined),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.key_off_outlined),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      label: Text("Enter Password"),
                                    ),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff40E0D0),
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 5,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    onPressed: _login,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Implement forget password functionality here
                                    },
                                    child: Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 15,
                                    color: Color(0xff40E0D0),
                                    indent: 100.0,
                                    endIndent: 100.0,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Create New Account? ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage()));
                                  },
                                  child: Text(
                                    "Click Here",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff40E0D0),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
