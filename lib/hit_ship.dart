// Тобі потрібно реалізувати міні-гру «затопи російський корабель». Гравцеві потрібно вгадати випадкове положення корабля на полі, що складається з 10 клітинок. Програма повинна генерувати випадкову позицію корабля, а гравець - вводити здогадки, намагаючись вгадати точне розташування.
//
// Вимоги до задачі:
//
// Поле гри:
//
// Поле складається з 10 клітинок, які пронумеровані від 1 до 10.
// Рандомна позиція корабля:
//
// Корабель випадково розташовується в одній з 10 клітин.
// Введення від гравця:
//
// Програма має запитувати в користувача введення здогадки - ціле число, яке відповідає клітині, де, на думку гравця, розташований корабель.
// Перевірка введення:
//
// Якщо введення користувача менше ніж 1 або більше ніж 10, програма має повідомити, що введення некоректне, і попросити ввести число в правильному діапазоні.
// Підказки для гравця:
//
// Якщо здогадка користувача менша за позицію корабля, програма має вивести повідомлення: «Занадто низько! Спробуй знову.»
// Якщо здогадка користувача більша за позицію корабля, програма має вивести повідомлення: «Занадто високо! Спробуй знову.»
// Закінчення гри:
//
// Коли користувач вгадає правильну позицію, програма повинна привітати його і вивести повідомлення про точне місцезнаходження корабля: «Вітаю! Ти вгадав, корабель на позиції N!», де N - це випадково згенерована позиція корабля.
// Повторення гри:
//
// Програма має повторювати запит здогадки від користувача доти, доки він не вгадає правильне розташування корабля.
// Завершення роботи програми:
//
// У користувача є всього 4 спроби вгадати корабель. Якщо він використав всі, то програма пише, що спроби вичерпано.

// Після успішного вгадування програма вітає гравця з перемогою над російським кораблем
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
    bool isWin = false;
    if (gameField.containsKey(userInput)) {
      if (gameField[userInput] == true) {
        print('You Win!');
        attempts = 0;
        isWin = true;
      } else {
        bool? newValue = gameField.remove(userInput);
        if (newValue != null) {
          attempts--;
          print('Miss! You have attempts: $attempts');
        }
      }
      if (attempts == 0 && isWin == false) {
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
