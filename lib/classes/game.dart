import 'dart:io';
import 'dart:math';

import 'package:phone_factory/classes/Ship.dart';
import 'package:phone_factory/classes/bay_item.dart';
import 'package:phone_factory/classes/squad.dart';

class Game {
  Ship ship = Ship();
  Squad squad = Squad();
  BayItem bayType = BayItem.mutant;
  int gameMove = 0;
  Map<int, int> infectedSquads = {};
  double _chanseToFindAntidot = 0.5;

  int showGameMenuAndUserChoiceHandler() {
    print('----------------------Ігрове меню---------------');
    print('Щоб вибрати відсік натисніть 1');
    print('Використати Антидот натисніть 2');
    print('Завершити хід натисніть 3');
    print('-------------------------------------------------');

    String? choice = stdin.readLineSync();
    if (choice != null) {
      return int.parse(choice);
    } else {
      return 0;
    }
  }

  void _showNumberBays() {
    List<int> bays = [];
    for (int bayNumber in ship.getSpaceShipBays().keys) {
      bays.add(bayNumber);
    }
    print('Ваші відсіки: $bays');
  }

  int _chooseBayHandler() {
    int bayNumber = 0;
    while (true) {
      print('Введіть номер відсіка: ');
      String? choice = stdin.readLineSync();
      if (choice != null) {
        bayNumber = int.parse(choice);
        if (ship.getSpaceShipBays().containsKey(bayNumber)) {
          return bayNumber;
        } else {
          print('Невірний номер відсіка');
        }
      }
    }
  }

  void _checkTypeOfBay(int numberOfBay) {
    //TODO check type of bay and return result add fucntions to handlle this
  }

  void playTurn() {
    int choice = showGameMenuAndUserChoiceHandler();
    switch (choice) {
      case 0:
        print('Помилка вводу меню');
        break;
      case 1:
        _showNumberBays();
        int userBayNumber = _chooseBayHandler();
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        print('Помилка вводу меню');
    }
  }

  void _handleEmptyBay() {
    print('Цей видсік порожній');
  }

  void _handleMutantBay() {
    print('Відсік з мутантом');
    final random = Random();

    int captWinScoore = 0;
    int squadWinScore = (squad.getSquadMemmbersCount() * 17);
    if (squad.getCaptein() < 0) {
      captWinScoore = 40;
    }
    int winScore = captWinScoore + squadWinScore;
    int chance = (random.nextDouble() * 100).toInt();

    if (chance > winScore) {
      _wasInfected();
    } else {
      _searchBay();
    }
  }

  void _handleHintBay() {}
  void _handleInfectedBay() {}
  void _handleGoalBay() {}

  bool checkEndGame() {
    return false;
  }

  void _wasInfected() {
    int? existOneKey = infectedSquads.keys.first;
    if (squad.getSquadMemmbersCount() > 0) {
      if (existOneKey != 0) {
        infectedSquads[existOneKey + 1] = 0;
        squad.setSquadMembers(1);
      } else {
        infectedSquads[1] = 0;
      }
    }
  }

  void _searchBay() {
    final rnd = Random();
    double chance = rnd.nextDouble();
    if (chance >= _chanseToFindAntidot) {
      squad.addAntidot();
      print('Ви знайшли Антідот.');
    } else {
      print('Ви нічого не знайшли');
    }
  }

  void endMove() {
    _checkAndCountInfectedToMutant();
  }

  void _checkAndCountInfectedToMutant() {
    if (infectedSquads.isNotEmpty) {
      for (int moveCount in infectedSquads.values) {
        moveCount += 1;
        if (moveCount == 2) {
          Map<int, dynamic> bays = ship.getSpaceShipBays();
          for (BayItem bay in bays.values) {
            if (bay == BayItem.empty) {
              bay = BayItem.mutant;
            }
          }
        }
      }
    }
  }
}
