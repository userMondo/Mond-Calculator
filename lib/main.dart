// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculator_logic.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Calculator',
        theme: ThemeData(
          primaryColor: const Color(0xFF22577A),
          scaffoldBackgroundColor: const Color(0xFF22577A),
          textTheme: Typography.whiteMountainView,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xFF38A3A5)),
        ),
        home: const CalculatorHome());
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  final CalculatorLogic _calculatorLogic = CalculatorLogic();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _buttonPressed(String buttonText) {
    setState(() {
      _calculatorLogic.handleInput(buttonText);
    });
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        _buttonPressed('⌫');
      } else if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        _buttonPressed('=');
      } else {
        final String? key = event.character;
        if (key != null) {
          if ('0123456789.+-*/^%'.contains(key)) {
            _buttonPressed(key);
          } else if (key == 'c' || key == 'C') {
            _buttonPressed('C');
          }
        }
      }
    }
  }

  Widget _buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFF57CC99),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.3),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: duplicate_ignore
      // ignore: deprecated_member_use
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF22577A),
                Color(0xFF38A3A5),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    alignment: Alignment.bottomRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _calculatorLogic.output,
                          style: const TextStyle(
                              fontSize: 48.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            reverse: true,
                            itemCount: _calculatorLogic.history.length,
                            itemBuilder: (context, index) {
                              return Text(
                                _calculatorLogic.history[
                                    _calculatorLogic.history.length -
                                        1 -
                                        index],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white.withOpacity(0.7)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildButton('C', color: const Color(0xFF80ED99)),
                            _buildButton('^', color: const Color(0xFFC7F9CC)),
                            _buildButton('√', color: const Color(0xFFC7F9CC)),
                            _buildButton('÷', color: const Color(0xFFC7F9CC)),
                          ],
                        ),
                        Row(
                          children: [
                            _buildButton('7'),
                            _buildButton('8'),
                            _buildButton('9'),
                            _buildButton('×', color: const Color(0xFFC7F9CC)),
                          ],
                        ),
                        Row(
                          children: [
                            _buildButton('4'),
                            _buildButton('5'),
                            _buildButton('6'),
                            _buildButton('-', color: const Color(0xFFC7F9CC)),
                          ],
                        ),
                        Row(
                          children: [
                            _buildButton('1'),
                            _buildButton('2'),
                            _buildButton('3'),
                            _buildButton('+', color: const Color(0xFFC7F9CC)),
                          ],
                        ),
                        Row(
                          children: [
                            _buildButton('%', color: const Color(0xFFC7F9CC)),
                            _buildButton('0'),
                            _buildButton('.'),
                            _buildButton('=', color: const Color(0xFF80ED99)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
