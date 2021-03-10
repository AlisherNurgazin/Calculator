import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  Widget button(String btntext, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(btntext);
        },
        child: Text(
          '$btntext',
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'Raleway',
            color: txtcolor,
          ),
        ),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),/////////
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('C', const Color(0xff333333), Colors.white),
                button('+/-', const Color(0xff333333), Colors.white),
                button('%', const Color(0xff333333), Colors.white),
                button('/', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('7', const Color(0xFF616161), Colors.white),
                button('8', const Color(0xFF616161), Colors.white),
                button('9', const Color(0xFF616161), Colors.white),
                button('x', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('4', const Color(0xFF616161), Colors.white),
                button('5', const Color(0xFF616161), Colors.white),
                button('6', const Color(0xFF616161), Colors.white),
                button('-', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('1', const Color(0xFF616161), Colors.white),
                button('2', const Color(0xFF616161), Colors.white),
                button('3', const Color(0xFF616161), Colors.white),
                button('+', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(30, 20, 128, 20),
                  onPressed: () {
                    calculation('0');
                  },
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  color: const Color(0xFF616161),
                ),
                button('.', const Color(0xFF616161), Colors.white),
                button('=', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  double firstNum = 0;
  double secondNum = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic Operator = '';
  dynamic preOperator = '';
  void calculation(btnText) {
    if (btnText == 'C') {
      text = '0';
      firstNum = 0;
      secondNum = 0;
      result = '';
      finalResult = '0';
      Operator = '';
      preOperator = '';
    } else if (Operator == '=' && btnText == '=') {
      if (preOperator == '+') {
        finalResult = add();
      } else if (preOperator == '-') {
        finalResult = sub();
      } else if (preOperator == 'x') {
        finalResult = mul();
      } else if (preOperator == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (firstNum == 0) {
        firstNum = double.parse(result);
      } else {
        secondNum = double.parse(result);
      }

      if (Operator == '+') {
        finalResult = add();
      } else if (Operator == '-') {
        finalResult = sub();
      } else if (Operator == 'x') {
        finalResult = mul();
      } else if (Operator == '/') {
        finalResult = div();
      }
      preOperator = Operator;
      Operator = btnText;
      result = '';
    } else if (btnText == '%') {
      result = firstNum * 0.1*secondNum;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (firstNum + secondNum).toString();
    firstNum = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (firstNum - secondNum).toString();
    firstNum = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (firstNum * secondNum).toString();
    firstNum = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (firstNum / secondNum).toString();
    firstNum = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
