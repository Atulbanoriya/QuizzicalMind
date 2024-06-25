import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quizapp/auth_screen/Login.dart';
import 'package:quizapp/custom/dailog.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<UserCredential?> signUp({required String email, required String password}) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.message}')));
      return null;
    }
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      UserCredential? userCredential = await signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (userCredential != null) {
        // Show custom success dialog
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              title: "Sign Up Successful",
              description: "Your account has been created successfully.",
              onConfirm: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
              }, onCancel: () {
              Navigator.of(context).pop();
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
        leading: IconButton(
          color: Colors.white, onPressed: () { Get.back(); }, icon: Icon(Icons.keyboard_backspace,),
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              "Sign - Up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xff40E0D0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "image/logowhite.png",
              height: 130.0,
              width: 130.0,
            ),
            SizedBox(
              height: 520,
              width: 400,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    left: 16,
                    child: Container(
                      height: 480,
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
                              height: 15,
                            ),
                            Text(
                              "Create New Account",
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
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      label: Text("First & Last Name"),
                                      prefixIcon: Icon(Icons.person_2_outlined),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
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
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      label: Text("Enter Password"),
                                      prefixIcon: Icon(Icons.key_rounded),
                                    ),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters long';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: confirmPasswordController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.key_off_outlined),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      label: Text("Confirm Password"),
                                    ),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      }
                                      if (value != passwordController.text) {
                                        return 'Passwords do not match';
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
                                        "SignUp",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    onPressed: _signUp,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 15,
                                    color: Color(0xff40E0D0),
                                    indent: 100.0,
                                    endIndent: 100.0,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "If You Have already Account? ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                                  },
                                  child: Text(
                                    "Click Here",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff40E0D0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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