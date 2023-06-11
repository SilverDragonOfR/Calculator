import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;
import 'package:calculator/history.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>
{
  String equation = "0";
  String result = "0";
  String expression = "0";

  double equationFontSize = 20.0;
  double resultFontSize = 35.0;
  var isInverse = false;
  var isDegrees = false;
  var isDarkMode = false;
  var isInverseButtonDisabled = false;
  var isDegreesButtonDisabled = false;

  List history = [];

  // Color Scheme Light
  Color c1 = const Color(0xff310131);
  Color c2 = const Color(0x13420039);
  Color c3 = const Color(0xfff24cb3);
  Color c4 = const Color(0xff9adb28);
  Color c5 = const Color(0xffb5cdf1);
  Color c6 = const Color(0xfffbf5f3);

  Color c1Disabled = const Color(0x77310131);

  void goToHistory() async
  {
    history = await Navigator.push( context , MaterialPageRoute(builder: (context) => History(history: history,c1: c1, c2: c2, c3: c3, c4: c4,c5: c5,c6:c6)));

    setState((){});
  }

  void themeChange()
  {
    setState(()
    {
      if(isDarkMode)
      {
        c1 = const Color(0xff310131);
        c2 = const Color(0x13420039);
        c3 = const Color(0xfff24cb3);
        c4 = const Color(0xff9adb28);
        c5 = const Color(0xffb5cdf1);
        c6 = const Color(0xfffbf5f3);

        c1Disabled = const Color(0x77310131);
        isDarkMode = !isDarkMode;
      }
      else
      {
        c1 = const Color(0xffffddff);
        c2 = const Color(0x13420039);
        c3 = const Color(0xff810250);
        c4 = const Color(0xff274b13);
        c5 = const Color(0xff0d1c33);
        c6 = const Color(0xff140703);

        c1Disabled = const Color(0x77ffddff);
        isDarkMode = !isDarkMode;
      }
    });
  }

  void buttonPressed(String buttonText)
  {
    setState(()
    {
      if(buttonText == "C")
      {
        equation = "0";
        result = "0";
        equationFontSize = 20.0;
        resultFontSize = 35.0;
      }
      else if(buttonText == "CE")
      {
        equation = equation.substring(0,equation.length-1);
        if(equation == "")
        {
          equation = "0";
        }
        result = "0";
        equationFontSize = 35.0;
        resultFontSize = 20.0;
      }
      else if(buttonText == "=")
      {
        equationFontSize = 20.0;
        resultFontSize = 35.0;
        expression = equation;


        expression = expression.replaceAll("deg", "(π/180)*");
        expression = expression.replaceAll("e", "(e^1)");
        expression = expression.replaceAll("log(", "log(10,");
        expression = expression.replaceAll("π", "${math.pi}");

        try
        {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL,cm).toStringAsPrecision(10)}";
          bool isPoint = false;
          for(int i=0;i<result.length;i++)
          {
            if(result[i] == ".")
            {
              isPoint = true;
              break;
            }
          }
          if(isPoint)
          {
            int i=result.length-1;
            while(result[i] == "0")
            {
              result = result.substring(0,result.length-1);
              i=result.length-1;
            }
            if(result[result.length-1] == ".")
            {
              result = result.substring(0,result.length-1);
            }
          }
        }
        catch(e)
        {
          result = "Error";

        }
        history.add([equation,result]);

      }
      else if(buttonText == "1st" || buttonText == "2nd")
      {
        isInverse = !isInverse;
        if(buttonText == "1st")
        {
          isDegreesButtonDisabled = true;
        }
        else
        {
          isDegreesButtonDisabled = false;
        }
      }
      else if(buttonText == "rad" || buttonText == "deg")
      {
        isDegrees = !isDegrees;
        if(buttonText == "rad")
        {
          isInverseButtonDisabled = true;
        }
        else
        {
          isInverseButtonDisabled = false;
        }
      }
      else if(buttonText == "asin")
      {
        equationFontSize = 35.0;
        resultFontSize = 20.0;
        if(equation == "0")
        {
          equation = "arcsin(";
        }
        else
        {
          equation = equation + "arcsin(";
        }
      }
      else if(buttonText == "acos" || buttonText == "atan")
      {
        equationFontSize = 35.0;
        resultFontSize = 20.0;
        if(equation == "0")
        {
          (buttonText=="acos") ? equation = "arccos(" : equation = "arctan(";
        }
        else
        {
          (buttonText=="acos") ? equation = equation + "arccos(" : equation = equation + "arctan(";
        }
      }
      else if(buttonText == "ln" || buttonText == "log" || buttonText == "sin" || buttonText == "cos" || buttonText == "tan")
      {
        equationFontSize = 35.0;
        resultFontSize = 20.0;
        if(equation == "0")
        {
          equation = buttonText + "(";
          if((buttonText=="sin" || buttonText=="cos" || buttonText=="tan") && isDegrees)
          {
            equation = equation + "deg(";
          }
        }
        else
        {
          equation = equation + buttonText + "(";
          if((buttonText=="sin" || buttonText=="cos" || buttonText=="tan") && isDegrees)
          {
            equation = equation + "deg(";
          }
        }
      }
      else if(buttonText == "x^")
      {
        equationFontSize = 35.0;
        resultFontSize = 20.0;
        if(equation == "0")
        {
          equation = buttonText;
        }
        else
        {
          equation = equation + "^";
        }
      }
      else
      {
        equationFontSize = 35.0;
        resultFontSize = 20.0;
        if(equation == "0")
        {
          equation = buttonText;
        }
        else
        {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor)
  {
    return Container
    (
      height: MediaQuery.of(context).size.height*0.07*buttonHeight,
      color: buttonColor,
      child: TextButton
      (
        style:
        ButtonStyle
        (
          shape: MaterialStateProperty.all<RoundedRectangleBorder>
          (
            RoundedRectangleBorder
            (
              borderRadius: BorderRadius.circular(0.0),
              side:
              BorderSide
              (
                color: c2,
                width: 1,
                style: BorderStyle.solid
              )
            )
          ),
          padding: MaterialStateProperty.all(const EdgeInsets.all(15.0))
        ),
        onPressed: ((buttonText=="1st" && isInverseButtonDisabled) || (buttonText=="rad" && isDegreesButtonDisabled) )? null :()
        {
          buttonPressed(buttonText);
        },
        child:
        FittedBox
        (
          fit: BoxFit.fitWidth, 
          child:
          Text
          (
            buttonText,
            style:
            TextStyle
            (
              fontSize: MediaQuery.of(context).size.shortestSide*0.10,
              fontWeight: FontWeight.normal,
              color: ((buttonText=="1st" && isInverseButtonDisabled) || (buttonText=="rad" && isDegreesButtonDisabled)) ? c1Disabled : c1
            ),
          )
        ),

        
      )
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
        appBar: AppBar
        (
          title:
          Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              const Text("Calculator",style: TextStyle(fontSize: 30)),
              ElevatedButton
              (
                onPressed: ()
                {
                  themeChange();
                },
                child:
                Text
                (
                  (isDarkMode? "Light" : "Dark"),
                  style: TextStyle(color: c6),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: c1)
              ),
              ElevatedButton
              (
                onPressed: ()
                {
                  goToHistory();
                },
                child: Text("History", style: TextStyle(color: c1)),
                style: ElevatedButton.styleFrom(backgroundColor: c4)
              ),

            ],
          
          ),


          backgroundColor: c3,
          foregroundColor: c1,
        ),

        body:
        Container
        (
          child:
          Column
          (
            children:
            [
              Container
              (
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  equation,
                  style: TextStyle(fontSize: equationFontSize, color: c1),
                ),
              ),

              Container
              (
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Text
                (
                  result,
                  style: TextStyle(fontSize: resultFontSize, color: c1),
                ),
              ),

              const Expanded(child: Divider(color: Colors.transparent),),

              SingleChildScrollView
              (
                child:
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Container
                    (
                      width: MediaQuery.of(context).size.width*0.20,
                      child:
                      Table
                      (
                        children:
                        [
                          TableRow
                          (
                            children:
                            [
                              isInverse ? buildButton("2nd",1, c3) : buildButton("1st",1, c3)
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("C",1, c3),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("ln",1, c4),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("log",1, c4),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("x^",1, c4),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("π",1, c4),
                            ]
                          ),
                        ],
                      ),
                    ),

                    SizedBox
                    (
                      width: MediaQuery.of(context).size.width*0.60,
                      child: Table
                      (
                        children:
                        [
                          TableRow
                          (
                            children:
                            [
                              isDegrees ? buildButton("deg", 1, c3) : buildButton("rad", 1, c3),
                              isInverse ? buildButton("asin", 1, c4) : buildButton("sin", 1, c4),
                              isInverse ? buildButton("acos", 1, c4) : buildButton("cos", 1, c4),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("CE", 1, c3),
                              buildButton("(", 1, c5),
                              buildButton(")", 1, c5),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("7", 1, c6),
                              buildButton("8", 1, c6),
                              buildButton("9", 1, c6),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("4", 1, c6),
                              buildButton("5", 1, c6),
                              buildButton("6", 1, c6),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("1", 1, c6),
                              buildButton("2", 1, c6),
                              buildButton("3", 1, c6),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("e", 1, c4),
                              buildButton("0", 1, c6),
                              buildButton(".", 1, c6),
                            ]
                          ),
                          
                        ]
                      )
                    ),

                    Container
                    (
                      width: MediaQuery.of(context).size.width*0.20,
                      child:
                      Table
                      (
                        children:
                        [
                          TableRow
                          (
                            children:
                            [
                              isInverse ? buildButton("atan", 1, c4) : buildButton("tan", 1, c4),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("/",1, c5),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("*",1, c5),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("-",1, c5),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("+",1, c5),
                            ]
                          ),
                          TableRow
                          (
                            children:
                            [
                              buildButton("=",1, c3),
                            ]
                          ),
                        ],
                      ),
                    )

                  ],
                )
                ,
              )
              
            ],
          ),
          color: c6,
        )
        
        );
  }
}
