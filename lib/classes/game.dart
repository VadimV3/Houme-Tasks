import 'dart:io';
import 'dart:math';

import 'package:phone_factory/classes/Ship.dart';
import 'package:phone_factory/classes/bay_item.dart';
import 'package:phone_factory/classes/hint.dart';
import 'package:phone_factory/classes/squad.dart';

import 'game_constants.dart';

//todo 1 fix big create bays, need check exacly count type of bbays, 2 fix hints, some time get empry hint

class Game {
  Ship ship = Ship();
  late Map<int, BayItem> baysData;

  Squad squad = Squad();
  BayItem bayType = BayItem.mutant;
  int gameMove = 0;
  Map<int, int> infectedSquads = {};
  int _currentBayNumber = 0;
  bool isGoal = false;

  Game() {
    baysData = ship.getSpaceShipBays();
  }

  int _showGameMenuAndUserChoiceHandler() {
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

      bayNumber = _userIputHandler();
      if (ship.getSpaceShipBays().containsKey(bayNumber)) {
        _currentBayNumber = bayNumber;
        return bayNumber;
      } else {
        print('Невірний номер відсіка');
      }
    }
  }

  int _userIputHandler() {
    String? input = stdin.readLineSync();
    int userInput = 0;
    if (input != null) {
      userInput = int.parse(input);
    }
    return userInput;
  }

  void _checkTypeOfBay(int numberOfBay) {
    //TODO check type of bay and return result add fucntions to handlle this
    BayItem? choosenBay = baysData[numberOfBay]!;
    switch (choosenBay) {
      case BayItem.mutant:
        _handleMutantBay();
        print('Mutant bay');
        break;
      case BayItem.empty:
        _handleEmptyBay();
        print('Empty bay');
        break;
      case BayItem.hint:
        _handleHintBay();
        print('Hint bay');
        break;
      case BayItem.infected:
        _handleInfectedBay();
        print('infected bay');
        break;
      case BayItem.goal:
        _handleGoalBay();
        print('Goal bay');
        break;
      case BayItem.antidote:
        _handleAntidotBay();
        print('Antidot bay');
        break;
    }
    baysData.remove(numberOfBay);
  }

  void playTurn() {
    int choice = _showGameMenuAndUserChoiceHandler();
    switch (choice) {
      case 0:
        print('Помилка вводу меню');
        break;
      case 1:
        _showNumberBays();
        int userBayNumber = _chooseBayHandler();
        _checkTypeOfBay(userBayNumber);
        endMove();
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
    print('Цей видсік порожній!');
    print('Хочете його обшукаты?');
    print('1 - так \n 2 - Ні');
    int userChoice = _userIputHandler();
    if (userChoice == 1) {
      _searchBay();
    }
  }

  void _handleMutantBay() {
    print('+++++++++++Відсік з мутантом++++++++++++++++');
    final random = Random();
    int captWinScore = 0;
    int squadWinScore = (squad.squadMembersCount * 17);
    if (squad.capatin < 0) {
      captWinScore = 40;
    }
    int winScore = captWinScore + squadWinScore;
    int chance = (random.nextDouble() * 100).toInt();

    if (chance > winScore) {
      _wasInfected();
      print('Ви програли бій з мутантом');
    } else {
      print('Ви виграли бій з мутантом');
      _searchBay();
    }
  }

  void _handleHintBay() {
    print('Ви отримали підказку!');
    HintGenerator hint = HintGenerator(currentBayNumber: _currentBayNumber);
    hint.getHint();
  }

  void _handleInfectedBay() {}

  void _handleGoalBay() {
    isGoal = true;
  }

  void _handleAntidotBay() {
    print('Вы знайшли відсік з антідотом!');
    print('Вам додано 1 антидот!');
    squad.addAntidot();
    print('Кількість антидотів: ${squad.antidotCount}');
  }

  bool checkEndGame() {
    if (squad.capatin == 0 && squad.squadMembersCount == 0) {
      print('Вы програли. Всі члени ікіпажу мертві!');
      return false;
    }
    if (isGoal == true) {
      print('---------Перемога!!!-----------');
      print('Ви знайшли євукаційний відсік!');
      return false;
    }
    return true;
  }

  void _wasInfected() {
    if (squad.squadMembersCount > 0) {
      if (infectedSquads.isNotEmpty) {
        int existOneKey = infectedSquads.keys.first;
        if (existOneKey != 0) {
          infectedSquads[existOneKey + 1] = 0;
          squad.squadMembers = 1;
        }
      } else {
        infectedSquads[1] = 0;
      }
    }
  }

  void _searchBay() {
    final rnd = Random();
    double chance = rnd.nextDouble();
    if (chance >= chanseToFindAntidot) {
      squad.addAntidot();
      print('Ви знайшли Антідот.');
    } else {
      print('Ви нічого не знайшли');
    }
  }

  void endMove() {
    _checkAndCountInfectedToMutant();
    gameMove++;
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
