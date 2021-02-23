import 'package:CalculaterApp/theme/theme.dart';
import 'package:CalculaterApp/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQution = "";
  var userAwnser = "";

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBGColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userQution,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAwnser,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return CalcButton(
                      buttonText: buttons[index],
                      buttonTap: () {
                        setState(() {
                          userQution = "";
                          userAwnser = "";
                        });
                      },
                      color: ThemeColors.clearButtonColor,
                      textColor: ThemeColors.oprationButtonTextColor,
                    );
                  } else if (index == 1) {
                    return CalcButton(
                      buttonText: buttons[index],
                      buttonTap: () {
                        setState(() {
                          userQution =
                              userQution.substring(0, userQution.length - 1);
                        });
                      },
                      color: ThemeColors.deleteButtonColor,
                      textColor: ThemeColors.oprationButtonTextColor,
                    );
                  } else if (index == buttons.length - 1) {
                    return CalcButton(
                      buttonText: buttons[index],
                      buttonTap: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      color: ThemeColors.oprationButtonColor,
                      textColor: ThemeColors.oprationButtonTextColor,
                    );
                  } else {
                    return CalcButton(
                      buttonText: buttons[index],
                      buttonTap: () {
                        setState(() {
                          userQution += buttons[index];
                        });
                      },
                      color: isOperator(buttons[index])
                          ? ThemeColors.oprationButtonColor
                          : ThemeColors.numButtonColor,
                      textColor: isOperator(buttons[index])
                          ? ThemeColors.oprationButtonTextColor
                          : ThemeColors.numButtonTextColor,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    for (var i = 0; i <= 9; i++) {
      if (x.toString() == i.toString()) return false;
    }
    if (x == "." || x == "ANS") {
      return false;
    }
    return true;
  }

  void equalPressed() {
    String finalQution = userQution;
    finalQution = finalQution.replaceAll("x", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalQution);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAwnser = eval.toString();
  }
}
