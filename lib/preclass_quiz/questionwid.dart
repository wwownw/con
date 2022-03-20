import 'package:con/notice/addnotice.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quiz',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                '${indexAction + 1}/$totalQuestions',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              )
            ],
          ),
          Row(
            children: [
              Text(
                '$question',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
