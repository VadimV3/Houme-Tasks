import 'dart:math';

import 'package:phone_factory/classes/bay_item.dart';

class Ship {
  static final Ship _instance = Ship._internal();

  factory Ship() {
    return _instance;
  }
  Ship._internal() {
    _fillSpaceShipBays();
  }

  int countOfBays = 10;
  int countOfAntidots = 3;
  int aliensCountBay = 3;
  int counfOfHintsBay = 3;
  int countMutantBay = 1;
  int countGoalMissionBay = 1;
  int countEmptyBays = 2;
  BayItem item = BayItem.empty;

  final Map<int, BayItem> _spaceShipBays = {};

  Map<int, dynamic> getSpaceShipBays() {
    return _spaceShipBays;
  }

  BayItem? _getRandomBay() {
    final random = Random();
    List<BayItem> availableItems = List.from(BayItem.values);

    if (aliensCountBay <= 0) {
      availableItems.remove(BayItem.infected);
    }
    if (counfOfHintsBay <= 0) {
      availableItems.remove(BayItem.hint);
    }
    if (countOfAntidots <= 0) {
      availableItems.remove(BayItem.antidote);
    }
    if (countGoalMissionBay <= 0) {
      availableItems.remove(BayItem.goal);
    }
    if (countMutantBay <= 0) {
      availableItems.remove(BayItem.mutant);
    }

    if (availableItems.isEmpty) {
      return null;
    }
    BayItem item = availableItems[random.nextInt(availableItems.length)];

    switch (item) {
      case BayItem.infected:
        aliensCountBay -= 1;
        break;
      case BayItem.hint:
        counfOfHintsBay -= 1;
        break;
      case BayItem.empty:
        countEmptyBays -= 1;
        break;
      case BayItem.antidote:
        countOfAntidots -= 1;
        break;
      case BayItem.goal:
        countGoalMissionBay -= 1;
      case BayItem.mutant:
        countMutantBay -= 1;
        break;
    }
    return item;
  }

  void _fillSpaceShipBays() {
    for (var i = 1; i <= countOfBays; i++) {
      BayItem? item = _getRandomBay();
      if (item != null) {
        _spaceShipBays[i] = item;
      } else {
        print('Error with items');
      }
    }
  }
}
