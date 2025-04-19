import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

main() {
  runApp(const SignUp());
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  TextEditingController eye = TextEditingController();
  bool obscureTextPassword = true;
  @override
  Widget build(BuildContext context) {
    GlobalKey keyVioletSignUp = GlobalKey();
    return Scaffold(
      body: ListView(
        children: [
          Form(
            key: keyVioletSignUp,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/main_top.png",
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Center(
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: SvgPicture.asset(
                    "assets/icons/signup.svg",
                    width: 255,
                    height: 250,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: SizedBox(
                  width: 280,
                  height: 50,
                  child: TextFormField(
                    // cursorColor: const Color.fromARGB(255, 91, 0, 218),
                    decoration: const InputDecoration(
                        prefix: Icon(
                          Icons.person,
                          color: Color(0xff6F35A5),
                        ),
                        hintText: "Enter Email",
                        filled: true,
                        fillColor: Color.fromARGB(255, 230, 215, 251),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(70)))),
                  ),
                )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: SizedBox(
                  width: 280,
                  height: 50,
                  child: TextFormField(
                    controller: eye,
                    obscureText: obscureTextPassword,
                    decoration: InputDecoration(
                        prefix: const Icon(
                          Icons.lock,
                          color: Color(0xff6F35A5),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureTextPassword = !obscureTextPassword;
                              });
                            },
                            icon: Icon(
                              obscureTextPassword
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                              color: const Color(0xff6F35A5),
                            )),
                        hintText: "Enter Password",
                        filled: true,
                        fillColor: const Color.fromARGB(255, 230, 215, 251),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(70)))),
                  ),
                )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: MaterialButton(
                  minWidth: 280,
                  height: 50,
                  textColor: Colors.white,
                  onPressed: () {},
                  color: const Color(0xff6F35A5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70)),
                  child: const Text("SignUp"),
                )),
                Image.asset("assets/images/main_bottom.png")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
