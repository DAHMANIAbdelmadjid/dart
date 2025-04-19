import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_new/tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SinUp extends StatefulWidget {
  const SinUp({super.key});
  @override
  State<SinUp> createState() => _SinUp();
}

class _SinUp extends State<SinUp> {
  TextEditingController user = TextEditingController();

  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey keyTextFild = GlobalKey();
  void onButtonTapped(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: keyTextFild,
      child:
          ListView(padding: const EdgeInsets.fromLTRB(25, 0, 25, 0), children: [
        const SizedBox(
          height: 50,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
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
              height: 30,
            ),
            const Text(
              "SinUp",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const Text("SinUp To Contiune Using The App"),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "username",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormFieldUse(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              myController: user,
              obscureTextbool: false,
              hintTextField: "Enter Username",
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Email",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormFieldUse(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              myController: emailAddress,
              obscureTextbool: false,
              hintTextField: "Enter Email",
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormFieldUse(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              myController: password,
              obscureTextbool: true,
              hintTextField: "Enter Password",
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        MaterialButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(70))),
          onPressed: () async {
            try {
              if (kDebugMode) {
                debugPrint("${emailAddress.text}==${password.text}");
              }
              final credential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailAddress.text,
                password: password.text,
              );
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed("homepage");
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                if (kDebugMode) {
                  debugPrint('The password provided is too weak.');
                }
              } else if (e.code == 'email-already-in-use') {
                if (kDebugMode) {
                  debugPrint('The account already exists for that email.');
                }
              }
            } catch (e) {
              print(e);
            }
          },
          color: const Color(0xffFD7DA0),
          child: const Text("SinUp"),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Or Sin With",
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
                        borderRadius: BorderRadius.all(Radius.circular(70))),
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
                        borderRadius: BorderRadius.all(Radius.circular(70))),
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
                        borderRadius: BorderRadius.all(Radius.circular(70))),
                    onPressed: () {},
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
          const Text("Are You Have An Account ?"),
          InkWell(
            child: const Text(
              " Login",
              style: TextStyle(
                  color: Color(0xffDB4B86), fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("login");
            },
          )
        ]),
      ]),
    ));
  }
}
