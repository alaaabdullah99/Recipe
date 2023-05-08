import 'package:flutter/cupertino.dart';

class instruction {
  final int stepNum;
  final String text;

  instruction({ required this.text,required this.stepNum});

  factory instruction.fromJson(Map<String, dynamic> json) {
    return instruction(
      text: json['display_text'],
      stepNum: json['position'],
    );
  }
}
