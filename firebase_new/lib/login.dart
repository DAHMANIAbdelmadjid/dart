import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_new/tool.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> keyTextFildLogin = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed("homepage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 450,
          height: 450,
          child: Form(
            key: keyTextFildLogin,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              children: [
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 176, 174, 174),
                        ),
                        width: 90,
                        height: 90,
                        child: Image.asset("images/dent-cassee.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    const Text("Login To Continue Using The App"),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextFormFieldUse(
                      myController: email,
                      obscureTextbool: false,
                      hintTextField: "Enter Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextFormFieldUse(
                      myController: password,
                      obscureTextbool: true,
                      hintTextField: "Enter Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const Text(
                            " Forget Password",
                            style: TextStyle(
                                color: Color(0xffDB4B86),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () async {
                            if (kDebugMode) {
                              debugPrint("object");
                            }
                            // Navigator.of(context).pushReplacementNamed("signup");
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email.text);
                          },
                        )),
                  ],
                ),
                MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(70))),
                  onPressed: () async {
                    // Check if form is valid
                    if (keyTextFildLogin.currentState!.validate()) {
                      try {
                        final credential =
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        Navigator.of(context).pushReplacementNamed("homepage");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          if (kDebugMode) {
                            debugPrint('No user found for that email.');
                          }
                        } else if (e.code == 'wrong-password') {
                          if (kDebugMode) {
                            debugPrint('Wrong password provided for that user.');
                          }
                        }
                      }
                    }
                  },
                  color: const Color(0xffFD7DA0),
                  child: const Text("Login"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Or Log With",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70))),
                            onPressed: () {},
                            child: Image.asset(
                              "images/facebook.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70))),
                            onPressed: () {},
                            child: Image.asset(
                              "images/apple-logo.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70))),
                            onPressed: () {
                              signInWithGoogle();
                              // Navigator.of(context)
                              //     .pushReplacementNamed("homepage");
                            },
                            child: Image.asset(
                              "images/google.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Don't Have An Account?"),
                  InkWell(
                    child: const Text(
                      " SignUp",
                      style: TextStyle(
                          color: Color(0xffDB4B86), fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      if (kDebugMode) {
                        debugPrint("object");
                      }
                      Navigator.of(context).pushReplacementNamed("signup");
                    },
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
