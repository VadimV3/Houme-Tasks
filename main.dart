import 'dart:io';
import 'dart:math';
//Гра "Камінь, ножиці, папір": Користувач грає проти комп’ютера, який випадково вибирає один з варіантів. Визначається переможець.

void main() {
  //Set user name
  addUserToScore();
  //game flow
  gameFlow();
}

//Main data
List<String> gameElements = ['Rock', 'Scissor', 'Paper'];

late String userName;
var userChoice;
var compChoice;
Map<String, int> scores = {'Computer': 0};
Map<int, String> gameItems = {1: 'Scissor', 2: 'Paper', 3: 'Rock'};

//Flow
void gameFlow() {
  while (userChooseHandler()) {
    //Comp pick item
    compChoice = getRandomGameElement();
    winConditions(userChoice, compChoice);
  }
  print('Game Over!');
}

String getRandomGameElement() {
  Random rand = Random();
  return gameElements[rand.nextInt(gameElements.length)];
}

void addUserToScore() {
  print('Welcome to Game "Rock, Paper, Scissor" enter your name ');
  String? name = stdin.readLineSync();
  if (name != null && name != '') {
    userName = name;
    scores.addAll({'$name': 0});
  }
}

bool userChooseHandler() {
  print('$userName write  the number to choose element or input 9 to exit game');
  gameItems.forEach((key, value) {
    print('$key - $value');
  });
  String? userPick = stdin.readLineSync();
  int? choosenNumber = int.tryParse(userPick ?? '');

  if (choosenNumber != null && gameItems.containsKey(choosenNumber)) {
    userChoice = gameItems[choosenNumber];
    return true;
  } else {
    results();
    return false;
  }
}

void winConditions(String userChoice, String compChoice) {
  if ((userChoice == 'Rock' && compChoice == 'Scissor') ||
      (userChoice == 'Paper' && compChoice == 'Rock') ||
      (userChoice == 'Scissor' && compChoice == 'Paper')) {
    print('User Win!');
    if (scores.containsKey(userName)) {
      scores[userName] = scores[userName]! + 1;
    } else if ((userChoice == 'Rock' && compChoice == 'Rock') ||
        (userChoice == 'Paper' && compChoice == 'Paper') ||
        (userChoice == 'Scissor' && compChoice == 'Scissor')) {
      print('A draw win');
    }
  } else {
    scores['Computer'] = scores['Computer']! + 1;
    print('Computer Win!');
  }
  results();
}

void results() {
  print('-----------Result----------');
  print('User pick $userChoice');
  print('Comp pick $compChoice');
  scores.forEach((key, value) {
    print('$key has $value scores');
  });
  print('----------------------------');
  print('Hello');
}
