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
            // if (answerSelected && !endQuiz)

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
        'Select the correct answer?1h giu bugu gui iubm u hbmx yb ljhufh hhhhh jbj uhui ',
    'answers': [
      {'answerText': 'this answer is true', 'score': true},
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is false', 'score': false},
    ],
  },
  {
    'question': 'Select the correct answer?2',
    'answers': [
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is true', 'score': true},
    ],
  },
  {
    'question': 'Select the correct answer?3',
    'answers': [
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is true', 'score': true},
    ],
  },
  {
    'question': 'Select the correct answer?4',
    'answers': [
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is true', 'score': true},
      {'answerText': 'this answer is false', 'score': false},
    ],
  },
  {
    'question': 'Select the correct answer?5',
    'answers': [
      {'answerText': 'this answer is true', 'score': true},
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is false', 'score': false},
    ],
  },
  {
    'question': 'Select the correct answer?6',
    'answers': [
      {'answerText': 'this answer is true', 'score': true},
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is false', 'score': false},
    ],
  },
  {
    'question': 'Select the correct answer?7',
    'answers': [
      {'answerText': 'this answer is true', 'score': true},
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is false', 'score': false},
    ],
  },
  {
    'question': 'Select the correct answer?8',
    'answers': [
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is true', 'score': true},
    ],
  },
  {
    'question': 'Select the correct answer?9',
    'answers': [
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is false', 'score': false},
      {'answerText': 'this answer is true', 'score': true},
    ],
  },
];
