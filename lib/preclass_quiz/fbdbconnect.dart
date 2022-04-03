import 'dart:convert';
import 'package:con/preclass_quiz/preclassmodel.dart';
import 'package:http/http.dart' as http;

class DBconnect {
  final url = Uri.parse(
      'https://conf-2561d-default-rtdb.firebaseio.com/questions.json');

  Future<List<Question>> fetchQuestions() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
          id: key,
          title: value['title'],
          options: Map.castFrom(value['options']),
        );
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }
}
