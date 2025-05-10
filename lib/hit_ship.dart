import 'dart:io';
import 'dart:math';

void main() {
  //init Gamer and Field
  GameField gameField = GameField(10, 4);
  User user = User();
  //Game process

  gameField._createGameFieldWithShip();

  while (gameField.attempts != 0) {
    gameField.showField();
    user.setUserChoice();
    gameField.gameProcess(user.userChoice);
  }
}

// GameField
class GameField {
  int attempts;
  Map<int, bool> gameField = {};
  int _gameFiledSize;

  GameField(this._gameFiledSize, this.attempts) {
    _createGameFieldWithShip();
  }

  void _createGameFieldWithShip() {
    //Clear field
    gameField.clear();
    //Check rnd number of ship position
    Random random = Random();
    int rndNumber = random.nextInt(_gameFiledSize);
    //Game field with ship position
    for (int i = 1; i <= _gameFiledSize; i++) {
      if (i == rndNumber) {
        gameField[i] = true;
      } else {
        gameField[i] = false;
      }
    }
  }

  void gameProcess(int userInput) {
    if (gameField.containsKey(userInput)) {
      if (gameField[userInput] == true) {
        print('You Win!');
        attempts = 0;
      } else {
        bool? newValue = gameField.remove(userInput);
        if (newValue != null) {
          attempts--;
          print('Miss! You have attempts $attempts');
        }
      }
      if (attempts == 0) {
        print('You Loose');
      }
    } else {
      print('Bad Input');
    }
  }

  void showField() {
    List<int> result = [];

    print('------------Game Field-------------');
    if (gameField.isNotEmpty) {
      for (var key in gameField.keys) {
        result.add(key);
      }
      print(result);
    } else {
      print('Field is empty');
    }
    print('<---------END FIELD-------------->');
  }
}

//User action
class User {
  int userChoice = 0;
  void setUserChoice() {
    print('Enter field number to make a shot ');
    String? userNumber = stdin.readLineSync();
    if (userNumber != null && userNumber.isNotEmpty) {
      int? result = int.tryParse(userNumber);
      if (result != null) {
        userChoice = result;
      } else {
        print('Not valid Number');
      }
    } else {
      print('Input is empty');
    }
  }
}
