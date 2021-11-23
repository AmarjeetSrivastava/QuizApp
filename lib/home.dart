import 'package:flutter/material.dart';
import 'answer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _trackScore = [];
  int _questionNo = 0;
  int _totalScore = 0;
  bool answerSelected = false;
  bool endQuiz = false;
  bool correctAnswer = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
  
      answerSelected = true;
    
      if (answerScore) {
        _totalScore++;
        correctAnswer = true;
      }
 
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
                  
                  if (answerSelected) {
                    return;
                  }
                
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
                                  : 'Wrong :/',
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
                    _nextQuestion();
                  },
                  child: Text(
                    endQuiz ? 'Restart Quiz' : 'Next Question',
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
       

            if (endQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    _totalScore > 4
                        ? 'Congratulations! Your final score is: $_totalScore'
                        : 'Your final score is: $_totalScore. Better luck next time!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _totalScore > 4 ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final _questions = [
  {
    'question':
        'Flutter is a:',
    'answers': [
      {'answerText': 'Framework', 'score': true},
      {'answerText': 'Programming Language', 'score': false},
      {'answerText': 'Operating System', 'score': false},
    ],
  },
  {
    'question': 'A __________ is a sequence of asynchronus events',
    'answers': [
      {'answerText': 'Chennai', 'score': false},
      {'answerText': 'Mumbai', 'score': false},
      {'answerText': 'Stream', 'score': true},
    ],
  },
  {
    'question': 'Flutter is a Framework of:',
    'answers': [
      {'answerText': 'Current', 'score': false},
      {'answerText': 'Flow', 'score': false},
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
     
      {'answerText': 'flutter.com', 'score': false}, {'answerText': 'flutter.dev', 'score': true},
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
