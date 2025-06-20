import 'dart:math';

import 'package:phone_factory/classes/bay_item.dart';

class Ship {
  Ship() {
    _fillSpaceShipBays();
    //TODO remove print
    print(_baysData);
  }

  int countOfBays = 10;
  int countOfAntidots = 2;
  int mutantCountBay = 1;
  int counfOfHintsBay = 3;
  int countMutantBay = 1;
  int countGoalMissionBay = 1;
  int countEmptyBays = 2;
  BayItem item = BayItem.empty;

  final Map<int, BayItem> _baysData = {};

  Map<int, BayItem> get baysData => _baysData;

  void removeBayByNumber(int bayNumber) {
    _baysData.remove(bayNumber);
  }

  BayItem? _getRandomBay() {
    final random = Random();
    List<BayItem> availableItems = List.from(BayItem.values);

    if (mutantCountBay == 0) {
      availableItems.remove(BayItem.infected);
    }
    if (counfOfHintsBay == 0) {
      availableItems.remove(BayItem.hint);
    }
    if (countOfAntidots == 0) {
      availableItems.remove(BayItem.antidote);
    }
    if (countGoalMissionBay == 0) {
      availableItems.remove(BayItem.goal);
    }
    if (countMutantBay == 0) {
      availableItems.remove(BayItem.mutant);
    }
    if (countEmptyBays == 0) {
      availableItems.remove(BayItem.empty);
    }

    if (availableItems.isEmpty) {
      return null;
    }
    BayItem item = availableItems[random.nextInt(availableItems.length)];

    switch (item) {
      case BayItem.infected:
        mutantCountBay -= 1;
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
        _baysData[i] = item;
      } else {
        print('Error with items');
      }
    }
  }
}
