import 'dart:math';

import 'package:phone_factory/classes/Ship.dart';
import 'package:phone_factory/classes/bay_item.dart';

class Hint {
  int _currentBayNumber;
  Ship ship = Ship();

  Hint({required int currentBayNumber}) : _currentBayNumber = currentBayNumber;

  void getHint() {
    Map<int, dynamic> baysData = ship.getSpaceShipBays();
    List<int> alloweBaysList = List.from(baysData.keys);
    alloweBaysList.remove(_currentBayNumber);
    Random random = Random();
    int randomBayIndex = random.nextInt(alloweBaysList.length);
    int randomAllowedBay = alloweBaysList[randomBayIndex];
    BayItem randomBay = baysData[randomAllowedBay];

    switch (randomBay) {
      case BayItem.hint:
        print('В відсіку номер $randomAllowedBay є підказка');
        break;
      case BayItem.infected:
        print('В відсіку номер $randomAllowedBay сидить чужий');
        break;
      case BayItem.antidote:
        print('В відсіку номер $randomAllowedBay антидот');
        break;
      case BayItem.empty:
        print('Відсік номер $randomAllowedBay порожній');
        break;
      case BayItem.goal:
        print('Відсік номер $randomAllowedBay з "головною метою"');
        break;
      default:
        break;
    }
  }
}
