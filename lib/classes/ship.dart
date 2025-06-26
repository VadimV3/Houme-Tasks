import 'dart:math';

import 'package:phone_factory/classes/bay_item.dart';

class Ship {
  Ship() {
    _fillSpaceShipBays();
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

  void placeMutantInBay() {
    if (baysData.containsValue(BayItem.empty)) {
      for (int bayKey in baysData.keys) {
        if (baysData[bayKey] == BayItem.empty) {
          baysData[bayKey] = BayItem.mutant;
          break;
        }
      }
    } else {
      for (int bayKey in baysData.keys) {
        if (baysData[bayKey] != BayItem.goal) {
          baysData[bayKey] = BayItem.mutant;
          break;
        }
      }
    }
  }

  BayItem? _getRandomBay() {
    List<BayItem> availableItems = _getAvailableBayItems();
    if (availableItems.isEmpty) {
      return null;
    }
    final random = Random();
    BayItem item = availableItems[random.nextInt(availableItems.length)];

    switch (item) {
      case BayItem.infected:
        mutantCountBay--;
        break;
      case BayItem.hint:
        counfOfHintsBay--;
        break;
      case BayItem.empty:
        countEmptyBays--;
        break;
      case BayItem.antidote:
        countOfAntidots--;
        break;
      case BayItem.goal:
        countGoalMissionBay--;
      case BayItem.mutant:
        countMutantBay--;
        break;
    }
    return item;
  }

  List<BayItem> _getAvailableBayItems() {
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
    return availableItems;
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
