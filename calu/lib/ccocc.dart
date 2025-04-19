
import 'package:flutter/material.dart';

class Calcu extends StatefulWidget {
  const Calcu({super.key});
  @override
  State<Calcu> createState() => _Calcu();
}

class ButtonCalulit extends StatelessWidget {
  final int color, flex_1;
  final String nomNum;
  final int colorWb;
  final Function onPressed;

  const ButtonCalulit({
    super.key,
    required this.color,
    required this.colorWb,
    required this.nomNum,
    required this.onPressed,
    required this.flex_1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex_1,
        child: Ink(
          decoration: ShapeDecoration(
            color: Color(color),
            shape: const CircleBorder(),
          ),
          child: IconButton(
            icon: Text(
              nomNum,
              style: TextStyle(color: Color(colorWb), fontSize: 40),
            ),
            onPressed: () => onPressed(nomNum),
          ),
        ));
  }
}

class _Calcu extends State<Calcu> {
  String displayText = "0";
  String operand = "", valu = "0";
  double firstOperand = 0;
  double secondOperand = 0;
  String operation = "", ac = "AC";
  String changeColor = "";

  void _onButtonPressed(String value) {
    ac = "C";
    if (value == "+" || value == "-" || value == "x" || value == "÷") {
      if (valu != "") {
        firstOperand = double.parse(valu);
        valu = "";
        operation = value;
        setState(() {
          changeColor = value;
        });
      }
    } else {
      changeColor = "";
      if (value == "=") {
        secondOperand = double.parse(valu);
        switch (operation) {
          case "-":
            valu = (firstOperand - secondOperand).toString();
            value = "";

          case "+":
            valu = (firstOperand + secondOperand).toString();
            value = "";

          case "x":
            valu = (firstOperand * secondOperand).toString();
            value = "";
          case "÷":
            valu = (firstOperand / secondOperand).toString();
            value = "";
        }
      }
      if (value != "+/-") {
        if (valu == "0" && value != ".") valu = "";
        if ((!valu.contains(".")) || value != ".") valu += value;
      } else {
        if (valu == "0" && value != ".") valu = "";
        if (!valu.contains("-")) {
          valu = "-$valu";
        } else {
          valu = valu.replaceFirst("-", "");
        }
      }
      if (value == "C" || value == "AC") {
        valu = "0";
        ac = "AC";
      }
      setState(() {
        changeColor;
        ac;
        displayText = valu;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),
                child: Text(
                  displayText,
                  style: const TextStyle(
                    fontSize: 50,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color:null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(children: [
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xffA5A5A5,
                        colorWb: 0xff000000,
                        nomNum: ac,
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xffA5A5A5,
                        colorWb: 0xff000000,
                        nomNum: "+/-",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xffA5A5A5,
                        colorWb: 0xff000000,
                        nomNum: "%",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: changeColor == '÷' ? 0xffFFFFFF : 0xffFDA102,
                        colorWb: changeColor == '÷' ? 0xffFDA102 : 0xffFFFFFF,
                        //                         color: 0xffFDA102,
                        // colorWb: 0xffFFFFFF,
                        nomNum: '÷',
                        onPressed: _onButtonPressed,
                      ),
                    ]),
                    Row(children: [
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: "7",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: "8",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: "9",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: changeColor == "x" ? 0xffFFFFFF : 0xffFDA102,
                        colorWb: changeColor == "x" ? 0xffFDA102 : 0xffFFFFFF,
                        nomNum: "x",
                        onPressed: _onButtonPressed,
                      ),
                    ]),
                    Row(children: [
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: "4",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: "5",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: "6",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: changeColor == "-" ? 0xffFFFFFF : 0xffFDA102,
                        colorWb: changeColor == "-" ? 0xffFDA102 : 0xffFFFFFF,
                        nomNum: "-",
                        onPressed: _onButtonPressed,
                      ),
                    ]),
                    Row(children: [
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: "1",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: "2",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: "3",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: changeColor == '+' ? 0xffFFFFFF : 0xffFDA102,
                        colorWb: changeColor == '+' ? 0xffFDA102 : 0xffFFFFFF,
                        nomNum: "+",
                        onPressed: _onButtonPressed,
                      ),
                    ]),
                    Row(children: [
                      ElevatedButton(
                        onPressed: () {
                          _onButtonPressed("0");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(34, 20, 128, 5),
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.grey[850],
                        ),
                        child: const Text(
                          '0',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xff363636,
                        colorWb: 0xffFFFFFF,
                        nomNum: ".",
                        onPressed: _onButtonPressed,
                      ),
                      ButtonCalulit(
                        flex_1: 1,
                        color: 0xffFDA102,
                        colorWb: 0xffFFFFFF,
                        nomNum: "=",
                        onPressed: _onButtonPressed,
                      )
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    ;
  }
}

