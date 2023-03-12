import 'package:flutter/material.dart';

import 'constant/constants.dart';
import 'database/database.dart';

Text myText(String txt, Color? color, double size){
  return Text(
    txt,
    style: TextStyle(
        fontSize: size,
        fontFamily: "Magic4",
        color: color
    ),
  );
}

ElevatedButton gameButton(VoidCallback? onPress, String txt, Color color){
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(backgroundColor: color),
    child: myText(txt,Colors.white,20),
  );
}

void init() {
  if(read("score") != null){
    topScore = read("score");
  }else{
    write("score", topScore);
  }
}