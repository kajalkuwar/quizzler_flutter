import 'package:flutter/material.dart';
import 'package:quizzler_flutter/brain_quiz.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];
  BrainQuiz brainQuiz = BrainQuiz();
  int questNo = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                brainQuiz.getQuestText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPressed: () {
                setState(() {
                  if (brainQuiz.getCorrectAns() == true) {
                    scorekeeper.add(
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    );
                  } else {
                    scorekeeper.add(
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    );
                  }
                  if (brainQuiz.isFinished() == true) {
                    Alert(
                      context: context,
                      title: 'Finished!',
                      desc: 'You\'ve reached the end of the quiz.',
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            setState(() {
                              brainQuiz.reset();
                              scorekeeper = [];
                              Navigator.pop(context);
                            });
                          },
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.black]),
                          child: const Text(
                            "Restart Quiz",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ).show();

                    // if (questNo >= brainQuiz.quest.length) {
                    // questNo = 0;
                    // }
                  } else {
                    brainQuiz.NextQues();
                  }
                });
                //The user picked true.
              },
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              onPressed: () {
                setState(() {
                  if (brainQuiz.getCorrectAns() == false) {
                    scorekeeper.add(
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    );
                  } else {
                    scorekeeper.add(
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    );
                  }
                  if (brainQuiz.isFinished()) {
                    Alert(
                      context: context,
                      title: 'Finished!',
                      desc: 'You\'ve reached the end of the quiz.',
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            setState(() {
                              brainQuiz.reset();
                              scorekeeper = [];
                              Navigator.pop(context);
                            });
                          },
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.black]),
                          child: const Text(
                            "Restart Quiz",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ).show();
                  } else {
                    brainQuiz.NextQues();
                  }
                });
                //The user picked false.
              },
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: scorekeeper,
        ),
      ],
    );
  }
}
