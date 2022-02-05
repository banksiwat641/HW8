import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guess_game08/needRandom.dart';

import 'game2.dart';

void main() {
  runApp(const MyApp());
}
//โค้ตนี้ นาย ศิวัช รัตน์วิทยากรณ์ รหัส 07610641 เป็นคนทำ//
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var r = ran();
  var count = 0;
  String _numinput = '';
  String _status='ทายเลข 1 ถึง 100';

  @override
  Widget build(BuildContext context) {
    // answer = random.nextInt(100) + 1;
    var game = game2(r.answers);
    var rrr = r.answers.toString();
    print('เฉลย: ' + rrr.toString());

    return Scaffold(
      appBar: AppBar(title: Text('GUESS THE NUMBER')),
      body: Container(
        margin: EdgeInsets.all(30.0),
        //padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            border: Border.all(
              width: 10,
              color: Color(0xF5A0AFDC),
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xF57FA0FA).withOpacity(1.0),
                offset: const Offset(8.0, 5.0),
                blurRadius: 7.0,
                spreadRadius: 3.0,
              ),
            ]),
        child: Container(
          color: Color(0xF5A0AFDC),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/guess_logo.png',
                        width: 150.0,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'GUESS',
                                style: TextStyle(
                                    fontSize: 60.0, color: Colors.deepPurple),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'THE NUMBER',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.deepPurpleAccent),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_numinput',
                    style: TextStyle(fontSize: 50.0, color: Colors.deepPurple),
                  ),
                ),
                //บอกสถานะ//
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(

                    '$_status',
                    style: TextStyle(fontSize: 25.0, color: Colors.black45),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 1; i <= 3; i++) buildButton(num: i),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 4; i <= 6; i++) buildButton(num: i),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 7; i <= 9; i++) buildButton(num: i),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                            onPressed: () {
                              print('close');
                              setState(() {
                                _numinput = _numinput.substring(0, 0);
                              });
                            },
                            child: Icon(
                              Icons.close, // รูปไอคอน
                              size: 25.0,
                            )),
                      ),
                      buildButton(num: 0),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: OutlinedButton(
                            onPressed: () {
                              print('backspace');
                              setState(() {
                                _numinput = _numinput.substring(
                                    0, _numinput.length - 1);
                              });
                            },
                            child: Icon(
                              Icons.backspace_outlined,
                              // รูปไอคอน
                              size: 25.0,
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        ///////
                        var guess = int.tryParse(_numinput);
                        if (guess == null) {
                          setState(() {
                            _status =
                                'กรุณาใส่ตัวเลข!';
                            _numinput = _numinput.substring(0, 0);
                          });
                          print(
                              "กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น");
                        } else {
                          var result = game.doGuess(guess);
                          if (result == 1) {
                            setState(() {
                              _status = '$guess : มากเกินไป กรุณาลองใหม่!';
                              _numinput = _numinput.substring(0, 0);
                            });
                            print('$guess มากเกินไป กรุณาลองใหม่!');
                            count++;
                          } else if (result == -1) {
                            setState(() {
                              _status = '$guess : น้อยเกินไป กรุณาลองใหม่!';
                              _numinput = _numinput.substring(0, 0);
                            });
                            print('$guess น้อยเกินไป กรุณาลองใหม่!');
                            count++;
                          } else if (result == 0) {
                            setState(() {
                              count++;
                              _status =
                                  'ถูกต้องแล้วครับ🎉 คุณทายทั้งหมด $count ครั้ง';
                            });
                            print(
                                '$guess ถูกต้องแล้วครับ \n คุยทายทั้งหมด $count ครั้ง');
                          }
                        }
                      },
                      child: Text('GUESS')),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton({int? num}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OutlinedButton(
          onPressed: () {
            setState(() {
              _numinput = ' $_numinput$num';
            });
          },
          child: Text('$num', style: TextStyle(fontSize: 25.0))),
    );
  }
}
