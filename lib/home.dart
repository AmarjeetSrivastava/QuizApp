// ignore_for_file: prefer_const_constructors

/*
import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Icon> _scoreTracker = [];

  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  void _questionAnswered(bool answerScore) {
    setState(() {
      answerWasSelected = true;
      if (answerScore) {
        _totalScore++;
      }
      _scoreTracker.add(answerScore
          ? Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          : Icon(
              Icons.clear,
              color: Colors.red,
            ));

      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz App",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.isEmpty)
                  SizedBox(
                    height: 25,
                  ),
                if (_scoreTracker.isNotEmpty) ..._scoreTracker
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "${_questions[_questionIndex]['question']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map(
              (answer) => Answer(
                answerText: "${answer['answerText']}",
                answerColor: answerWasSelected
                    ? answer['score'] != null
                        ? Colors.green
                        : Colors.red
                    : null,
                answerTap: () {
                  _questionAnswered(answer['score'] as bool);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _nextQuestion();
              },
              child: Text(endOfQuiz ? 'Restart Quiz' : 'Next Question'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40)),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: Text(
                "${_totalScore.toString()}/${_questions.length}",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

final _questions = const [
  {
    'question': 'How long is New Zealand’s NinetyBeach?',
    'answers': [
      {'answerText': '88km, so 55 miles long.', 'score': true},
      {'answerText': '55km, so 34 miles long.', 'score': false},
      {'answerText': '90km, so 56 miles long.', 'score': false},
    ],
  },
  {
    'question': 'How long is New Zealand’s  Mile Beach?',
    'answers': [
      {'answerText': '88km, so 55 miles long.', 'score': true},
      {'answerText': '55km, so 34 miles long.', 'score': false},
      {'answerText': '90km, so 56 miles long.', 'score': false},
    ],
  },
  {
    'question': 'How long is NewNinety Mile Beach?',
    'answers': [
      {'answerText': '88km, so 55 miles long.', 'score': true},
      {'answerText': '55km, so 34 miles long.', 'score': false},
      {'answerText': '90km, so 56 miles long.', 'score': false},
    ],
  },
];
*/

import 'package:flutter/material.dart';
import 'answer.dart';

List<Icon> _trackScore = [];
int _questionNo = 0;
int _totalScore = 0;
bool answerSelected = false;
bool endQuiz = false;
bool correctAnswer = false;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswer = true;
      }
      // adding to the score tracker on top
      _trackScore.add(
        answerScore
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.clear,
                color: Colors.red,
              ),
      );
      //when the quiz ends
      if (_questionNo + 1 == _questions.length) {
        endQuiz = true;
      }
    });
  }

  final sb = const SnackBar(
    content: Text('Please select an answer before going to the next question'),
    duration: Duration(seconds: 1),
  );
  void _nextQuestion() {
    setState(() {
      _questionNo++;
      answerSelected = false;
      correctAnswer = false;
    });
    // what happens at the end of the quiz
    if (_questionNo >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionNo = 0;
      _totalScore = 0;
      _trackScore = [];
      endQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        elevation: 6,
        shadowColor: Colors.teal,
        title: const Text(
          'Quiz App',
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.teal.shade500,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Score: ${_totalScore.toString()}',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.teal,
                thickness: 2,
              ),
            ),
            /*Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    bottom: 10.0, left: 30.0, right: 30.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                child: 
              ),
              ),*/
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Q.No.${_questionNo + 1}: ${_questions[_questionNo]['question']}",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.teal.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ...(_questions[_questionNo]['answers'] as List<Map<String, Object>>)
                .map(
              (answer) => Answer(
                answerText: "${answer['answerText']}",
                answerColor: answerSelected
                    ? correctAnswer
                        ? Colors.green.shade200
                        : Colors.red.shade200
                    : null,
                tapAnswer: () {
                  // if answer was already selected then nothing happens onTap
                  if (answerSelected) {
                    return;
                  }
                  //answer is being selected
                  _questionAnswered(answer['score'] as bool);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 15, top: 25),
              child: Material(
                color: Colors.teal.shade600,
                borderRadius: BorderRadius.circular(15),
                shadowColor: Colors.teal.shade900,
                elevation: 12,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (!answerSelected) {
                      ScaffoldMessenger.of(context).showSnackBar(sb);
                      return;
                    }

                    if (answerSelected && !endQuiz) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.white,
                        content: Container(
                          alignment: Alignment.bottomCenter,
                          height: 40,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              correctAnswer
                                  ? 'Well done, you got it right!'
                                  : 'Wrong',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color:
                                    correctAnswer ? Colors.green : Colors.red,
                              ),
                            ),
                          ),
                        ),
                        duration: const Duration(seconds: 1),
                      ));
                    }
                    if (endQuiz) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Results(
                                  totalScore: _totalScore,
                                )),
                      );
                    }
                    _nextQuestion();
                  },
                  child: Text(
                    endQuiz ? 'Result' : 'Next Question',
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '${_questionNo + 1}/${_questions.length}',
                style: const TextStyle(
                    fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // if (answerSelected && !endQuiz)
          ],
        ),
      ),
    );
  }
}

class Results extends StatelessWidget {
  final int totalScore;
  const Results({
    Key? key,
    required this.totalScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        elevation: 6,
        shadowColor: Colors.teal,
        title: const Text(
          'Results',
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.teal.shade500,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  totalScore > 4
                      ? 'Congratulations! Your final score is: $totalScore'
                      : 'Your final score is: $totalScore. Better luck next time!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.teal.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Colors.teal.shade600,
                borderRadius: BorderRadius.circular(15),
                shadowColor: Colors.teal.shade900,
                elevation: 12,
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Restart Quiz",
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    )),
              ),
            ]),
      ),
    );
  }
}

final _questions = [
  {
    'question': 'Flutter is a:',
    'answers': [
      {'answerText': 'Framework', 'score': true},
      {'answerText': 'Programming Language', 'score': false},
      {'answerText': 'Operating System', 'score': false},
    ],
  },
  {
    'question': 'A __________ is a sequence of asynchronus events',
    'answers': [
      {'answerText': 'Current', 'score': false},
      {'answerText': 'Flow', 'score': false},
      {'answerText': 'Stream', 'score': true},
    ],
  },
  {
    'question': 'Flutter is a Framework of:',
    'answers': [
      {'answerText': 'JavaScript', 'score': false},
      {'answerText': 'Java', 'score': false},
      {'answerText': 'Dart', 'score': true},
    ],
  },
  {
    'question': 'Dart and Flutter are products of:',
    'answers': [
      {'answerText': 'Apple', 'score': false},
      {'answerText': 'Google', 'score': true},
      {'answerText': 'BMW', 'score': false},
    ],
  },
  {
    'question': 'Which one is a deprecated element in flutter',
    'answers': [
      {'answerText': 'RaisedButton', 'score': true},
      {'answerText': 'SingleChildScrollView', 'score': false},
      {'answerText': 'Container', 'score': false},
    ],
  },
  {
    'question': 'When was Flutter Created',
    'answers': [
      {'answerText': 'May, 2017', 'score': true},
      {'answerText': 'January, 2016', 'score': false},
      {'answerText': 'April, 2018', 'score': false},
    ],
  },
  {
    'question': 'Official Website of Flutter is:',
    'answers': [
      {'answerText': 'flutter.com', 'score': false},
      {'answerText': 'flutter.dev', 'score': true},
      {'answerText': 'flutter.net', 'score': false},
    ],
  },
  {
    'question': 'Command to build apk in flutter',
    'answers': [
      {'answerText': 'flutter apk build', 'score': false},
      {'answerText': 'flutter create apk', 'score': false},
      {'answerText': 'flutter build apk', 'score': true},
    ],
  },
  {
    'question': 'Command to delete build in Flutter:',
    'answers': [
      {'answerText': 'flutter clean build', 'score': false},
      {'answerText': 'flutter delete build', 'score': false},
      {'answerText': 'flutter clean', 'score': true},
    ],
  },
];
