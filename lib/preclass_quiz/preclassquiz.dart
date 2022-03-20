import 'package:con/constants.dart';
import 'package:con/model/preclassmodel.dart';
import 'package:con/optioncard.dart';
import 'package:con/widget/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:con/nextbutton.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PreclassPage extends StatefulWidget {
  const PreclassPage({Key? key}) : super(key: key);

  @override
  State<PreclassPage> createState() => _PreclassPageState();
}

class _PreclassPageState extends State<PreclassPage> {
  //
  List<Question> _questions = [
    Question(
      id: '1',
      title: 'three 는 영어로 뭐게',
      options: {'1': false, '2': false, '3': true, '4': false},
    ),
    Question(
      id: '2',
      title: 'two 는 영어로 뭐게',
      options: {'1': false, '2': true, '3': false, '4': false},
    ),
  ];
  int index = 0;

  bool isPressed = false;
  //
  void nextQuestion() {
    if (index == _questions.length - 1) {
      return;
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
        });
      } else {
        Fluttertoast.showToast(
            gravity: ToastGravity.CENTER,
            msg: '퀴즈의 답을 골라주세요.',
            backgroundColor: Colors.grey.shade800);
      }
    }
  }

  void changeColor() {
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          '퀴즈타임',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: double.infinity,
        child: Column(
          children: [
            QuestionWidget(
                question: _questions[index].title,
                indexAction: index,
                totalQuestions: _questions.length),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < _questions[index].options.length; i++)
              OptionCard(
                option: _questions[index].options.keys.toList()[i],
                color: isPressed
                    ? _questions[index].options.values.toList()[i] == true
                        ? correct
                        : incorrect
                    : neutral,
                onTap: changeColor,
              )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
