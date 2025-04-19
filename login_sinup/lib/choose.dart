import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Choose extends StatelessWidget {
  const Choose({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
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
                    width: 35,
                  ),
                  const Center(
                    child: Text(
                      "WELCOME TO EDU",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Center(
                child: SvgPicture.asset(
                  "assets/icons/chat.svg",
                  width: 350,
                  height: 350,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                  child: MaterialButton(
                minWidth: 250,
                height: 50,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("login");
                },
                color: const Color(0xff6F35A5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70)),
                child: const Text("LOGIN"),
              )),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: MaterialButton(
                minWidth: 250,
                height: 50,
                onPressed: () {},
                color: const Color.fromARGB(255, 230, 215, 251),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70)),
                child: const Text("SINGUP"),
              )),
              Image.asset("assets/images/main_bottom.png")
            ],
          ),
        ],
      ),
    );
  }
}
