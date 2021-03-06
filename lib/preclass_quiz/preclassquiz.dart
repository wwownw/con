import 'package:con/preclass_quiz/constants.dart';
import 'package:con/preclass_quiz/fbdbconnect.dart';
import 'package:con/preclass_quiz/preclassmodel.dart';
import 'package:con/preclass_quiz/optioncard.dart';
import 'package:con/preclass_quiz/questionwid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'nextbutton.dart';
import 'resultbox.dart';

class PreclassPage extends StatefulWidget {
  const PreclassPage({Key? key}) : super(key: key);

  @override
  State<PreclassPage> createState() => _PreclassPageState();
}

class _PreclassPageState extends State<PreclassPage> {
  var db = DBconnect();

  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  // List<Question> _questions = [
  //   Question(
  //     id: '1',
  //     title: 'three 는 영어로 뭐게',
  //     options: {'1': false, '2': false, '3': true, '4': false},
  //   ),
  //   Question(
  //     id: '2',
  //     title: 'two 는 영어로 뭐게',
  //     options: {'1': false, '2': true, '3': false, '4': false},
  //   ),
  // ];

  int index = 0;

  int score = 0;

  bool isPressed = false;
  bool isAlreadySelected = false;
  //
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: questionLength,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        Fluttertoast.showToast(
            gravity: ToastGravity.CENTER,
            msg: '퀴즈의 답을 골라주세요.',
            backgroundColor: Colors.grey.shade800);
      }
    }
  }

  void checkAndswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
      } else {
        if (value == false) {
          setState(() {
            isPressed = true;
            isAlreadySelected = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _questions as Future<List<Question>>,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              var extractedData = snapshot.data as List<Question>;
              return Scaffold(
                backgroundColor: Colors.grey[100],
                appBar: AppBar(
                  iconTheme: const CupertinoIconThemeData(color: Colors.black),
                  elevation: 0,
                  title: const Text(
                    '',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  backgroundColor: Colors.grey[100],
                ),
                body: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      QuestionWidget(
                          question: extractedData[index].title,
                          indexAction: index,
                          totalQuestions: extractedData.length),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      for (int i = 0;
                          i < extractedData[index].options.length;
                          i++)
                        GestureDetector(
                          onTap: () => checkAndswerAndUpdate(
                              extractedData[index].options.values.toList()[i]),
                          child: OptionCard(
                            option:
                                extractedData[index].options.keys.toList()[i],
                            color: isPressed
                                ? extractedData[index]
                                            .options
                                            .values
                                            .toList()[i] ==
                                        true
                                    ? correct
                                    : incorrect
                                : neutral,
                          ),
                        )
                    ],
                  ),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                      onTap: () => nextQuestion(extractedData.length),
                      child: const NextButton()),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButtonAnimator:
                    FloatingActionButtonAnimator.scaling,
              );
            }
          } else {
            return Scaffold(
              backgroundColor: Colors.grey.shade100,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 25),
                    Text(
                      '퀴즈를 불러오고 있습니다. \n잠시만 기다려주세요.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: const Center(
              child: Text('퀴즈 불러오기에 실패했습니다.'),
            ),
          );
        });
  }
}
