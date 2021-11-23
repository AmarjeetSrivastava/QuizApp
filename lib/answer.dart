import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color? answerColor;
  final Function tapAnswer;

  const Answer(
      {Key? key,
      required this.answerText,
      required this.answerColor,
      required this.tapAnswer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => tapAnswer(),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: answerColor,
          border: Border.all(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          answerText,
          style: TextStyle(fontSize: 20.0, color: Colors.teal.shade700),
        ),
      ),
    );
  }
}
