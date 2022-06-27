import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int min = 0;
  int max = 100;
  int x = 0;
  String y = '';
  var selectedRange = RangeValues(0, 100);
  TextEditingController input = TextEditingController();

  int compare(int guess) {
    Random random = Random();
    int randomNumber = min + random.nextInt(max - min);
    print(randomNumber);

    //-----------------------
    int result = 1;
    if (randomNumber == guess) {
      print('correct! ' + guess.toString() + " || " + randomNumber.toString());
      result = 1;
    } else {
      print(
          'incorrect! ' + guess.toString() + " || " + randomNumber.toString());
      result = 0;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          actions: [],
          leading: Icon(Icons.gamepad_outlined),
          title: Text('guessing game'),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text('enter the range of numbers to guess: '),
              RangeSlider(
                activeColor: Colors.green,
                values: selectedRange,
                min: 0,
                max: 100,
                divisions: 100,
                labels: RangeLabels(
                  selectedRange.start.round().toString(),
                  selectedRange.end.round().toString(),
                ),
                onChanged: (RangeValues newRange) {
                  setState(() {
                    selectedRange = newRange;
                    min = selectedRange.start.round();
                    max = selectedRange.end.round();
                  });
                },
              ),
              TextFormField(
                controller: input,
                decoration: InputDecoration(
                    hintText: 'enter your guessed number between  ' +
                        selectedRange.start.round().toString() +
                        '  and  ' +
                        selectedRange.end.round().toString()),
              ),
              ElevatedButton(
                onPressed: () {
                  x = compare(int.parse(input.text));
                  if (x == 1) {
                    y = 'you won!';
                  } else {
                    y = 'you lost!';
                  }
                  setState(() {});
                },
                child: Text('guess'),
              ),
              Text(
                'result : ' + y,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
