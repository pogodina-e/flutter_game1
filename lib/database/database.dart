import 'package:hive_flutter/hive_flutter.dart';

void write(String id, dynamic value) async{
  final myBox = Hive.box('user');
  switch(id) {
    case "score":
      myBox.put("score", value);
      break;
  }
}
dynamic read(String id) {
  final myBox = Hive.box('user');
  dynamic value;
  switch (id) {
    case "score":
      value = myBox.get("score");
      break;
  }
}