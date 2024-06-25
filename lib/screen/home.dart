import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/screen/Complepage.dart';
import 'package:quizapp/screen/optionpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List responseData = [];
  int number = 0;

  int questionCount = 1;
  List<String> shuffledOptions = [];
  String selectedOption = '';

  int correctAnswers = 0;
  int wrongAnswers = 0;

  late Timer _timer;
  int _secondRemaining = 30;

  @override
  void initState() {
    super.initState();
    api();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer in dispose
    super.dispose();
  }

  Future<void> api() async {
    final response =
    await http.get(Uri.parse('https://opentdb.com/api.php?amount=1000'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["results"];
      if (mounted) {
        setState(() {
          responseData = data;
          updateShuffledOption();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 421,
              width: 400,
              child: Stack(
                children: [
                  Container(
                    height: 240,
                    width: 390,
                    decoration: BoxDecoration(
                      color: const Color(0xff40E0D0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 10,
                    child: Container(
                      height: 170,
                      width: 325,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            spreadRadius: 3,
                            color: const Color(0xff40E0D0).withOpacity(.4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Text(
                                "Question $questionCount/10",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(responseData.isNotEmpty
                                ? responseData[number]['question']
                                : ''),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 210,
                    left: 115,
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.purple,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.lightGreen,
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.white,
                          child: Text(
                            _secondRemaining.toString(),
                            style: const TextStyle(
                              color: Color(0xff40E0D0),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: (responseData.isNotEmpty &&
                  responseData[number]['incorrect_answers'] != null)
                  ? shuffledOptions.map((option) {
                return OptionPage(
                  option: option,
                  selectedOption: selectedOption,
                  onSelected: (selectedOption) {
                    setState(() {
                      this.selectedOption = selectedOption;
                    });
                    handleAnswerSelection(selectedOption);
                  },
                );
              }).toList()
                  : [],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff40E0D0),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                onPressed: () {
                  nextQuestion();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleAnswerSelection(String selectedOption) {
    String correctAnswer = responseData[number]['correct_answer'];

    if (selectedOption == correctAnswer) {
      correctAnswers++;
    } else {
      wrongAnswers++;
    }
  }

  void nextQuestion() {
    if (number == 9) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Complepage(
        correctAnswers: correctAnswers,
        wrongAnswers: wrongAnswers,
      )));
    } else {
      setState(() {
        questionCount++;
        number++;
        updateShuffledOption();
        selectedOption = ''; // Reset selected option
        _secondRemaining = 30;
      });
    }
  }

  void updateShuffledOption() {
    if (responseData.isNotEmpty) {
      setState(() {
        shuffledOptions = shuffleOption(
          [
            responseData[number]['correct_answer'],
            ...(responseData[number]['incorrect_answers'] as List),
          ],
        );
      });
    }
  }

  List<String> shuffleOption(List<String> options) {
    List<String> shuffledOptions = List.from(options);
    shuffledOptions.shuffle();
    return shuffledOptions;
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_secondRemaining > 0) {
            _secondRemaining--;
          } else {
            nextQuestion();
            _secondRemaining = 30;
          }
        });
      }
    });
  }
}
