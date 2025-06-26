import 'dart:io';
import 'dart:math';

import 'package:phone_factory/classes/Ship.dart';
import 'package:phone_factory/classes/bay_item.dart';
import 'package:phone_factory/classes/hint_generator/hint_generator.dart';
import 'package:phone_factory/classes/squad.dart';
import 'package:phone_factory/classes/squad_members/captain.dart';
import 'package:phone_factory/classes/squad_members/squad_member.dart';

import 'game_constants.dart';

class Game {
  Ship ship = Ship();
  Captain captain = Captain();

  Squad squad = Squad();
  BayItem bayType = BayItem.mutant;
  int gameMove = 0;
  Map<int, int> infectedSquads = {};
  bool isGoal = false;

  int _showGameMenuAndUserChoiceHandler() {
    print('----------------------Ігрове меню---------------');
    print('Щоб вибрати відсік натисніть 1');
    print('Використати Антидот натисніть 2');
    print('Статус Команди 3');
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
    for (int bayNumber in ship.baysData.keys) {
      bays.add(bayNumber);
    }
    print('Ваші відсіки: $bays');
  }

  int _chooseBayHandler() {
    int bayNumber = 0;
    while (true) {
      print('Введіть номер відсіка: ');

      bayNumber = _userIputHandler();
      if (ship.baysData.containsKey(bayNumber)) {
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
    BayItem? choosenBay = ship.baysData[numberOfBay]!;
    switch (choosenBay) {
      case BayItem.mutant:
        _handleMutantBay();
        break;
      case BayItem.empty:
        _handleEmptyBay();
        break;
      case BayItem.hint:
        _handleHintBay();
        break;
      case BayItem.infected:
        _handleInfectedBay();
        break;
      case BayItem.goal:
        _handleGoalBay();
        break;
      case BayItem.antidote:
        _handleAntidotBay();
        break;
    }
    ship.removeBayByNumber(numberOfBay);
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
        squad.useAntidot();
        break;
      case 3:
        squad.showCondition();
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
    int winScore = 0;
    int squadWinScore = (squad.members.length * 17);
    if (captain.isLive) {
      winScore = captain.winScore + squadWinScore;
    }
    int chance = (random.nextDouble() * 100).toInt();

    if (chance > winScore) {
      squad.infectMember();
      print('Ви програли бій з мутантом');
    } else {
      print('Ви виграли бій з мутантом');
      _searchBay();
    }
  }

  void _handleHintBay() {
    print('Ви отримали підказку!');
    HintGenerator hintGenerator = HintGenerator();
    print(hintGenerator.getHint(ship.baysData));
  }

  void _handleInfectedBay() {
    print('Ви зайшли в інфікований відсік!!');
    squad.infectMember();
  }

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
    if (squad.capatin == 0 && squad.members.isEmpty) {
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

  void _searchBay() {
    final rnd = Random();
    double chance = rnd.nextDouble();
    if (chance >= chanceToFindAntidot) {
      squad.addAntidot();
      print('Ви знайшли Антідот.');
    } else {
      print('Ви нічого не знайшли');
    }
  }

  void endMove() {
    _processMembersInfection();
    gameMove++;
  }

  void _processMembersInfection() {
    for (SquadMember member in squad.members) {
      if (member.isInfected) {
        if (member.countDaysInfected < daysToMutant) {
          member.countDaysInfected++;
        } else {
          _createMutantFromMember(member);
        }
      }
    }
  }

  void _createMutantFromMember(SquadMember member) {
    squad.members.remove(member);
    print('Увага!! Один з членів єкіпажу перетворився на мутанта!!!');
    ship.placeMutantInBay();
  }
}
