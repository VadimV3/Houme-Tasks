import 'dart:math';

import 'package:phone_factory/classes/bay_item.dart';
import 'package:phone_factory/classes/hint_generator/hint.dart';

class HintGenerator {
  Hint getHint(Map<int, BayItem> baysData) {
    List<int> baysKeysList = List.from(baysData.keys);
    Random random = Random();
    int randomKeyIndex = random.nextInt(baysKeysList.length);
    int hintKey = baysKeysList[randomKeyIndex];
    final bayItem = baysData[hintKey];
    if (bayItem == null) {
      throw Exception('Bay item can`t be null, must have BayItem value');
    }
    return Hint(bayNumber: hintKey, bayItem: bayItem);
  }
}
