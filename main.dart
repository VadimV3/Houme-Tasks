import 'dart:io';
import 'dart:math';
//Гра "Камінь, ножиці, папір": Користувач грає проти комп’ютера, який випадково вибирає один з варіантів. Визначається переможець.

void main() {
  //Set user name
  addUserName();
  //game flow
  gameFlow();
}

//Main data
List<String> gameElements = ['Rock', 'Scissor', 'Paper'];

late String userName;
var userChoice;
var compChoice;

var userScore = 0;
var compScore = 0;
Map<int, String> gameItems = {1: 'Scissor', 2: 'Paper', 3: 'Rock'};

//Flow
void gameFlow() {
  while (userChooseHandler()) {
    //Comp pick item
    if (userChoice != null) {
      compChoice = getRandomGameElement();
      winConditions(userChoice, compChoice);
    } else {
      print('Bad input, try again');
    }
  }
  print('Game Over!');
}

String getRandomGameElement() {
  Random rand = Random();
  return gameElements[rand.nextInt(gameElements.length)];
}

void addUserName() {
  print('Welcome to Game "Rock, Paper, Scissor" enter your name ');
  String? name = stdin.readLineSync();
  if (name != null && name.isNotEmpty) {
    userName = name;
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
  } else if (!gameItems.containsKey(choosenNumber) && choosenNumber != 9) {
    userChoice = null;
    return true;
  } else if (choosenNumber == 9) {
    return false;
  } else {
    results();
  }
  return false;
}

void winConditions(String userChoice, String compChoice) {
  if ((userChoice == 'Rock' && compChoice == 'Scissor') ||
      (userChoice == 'Paper' && compChoice == 'Rock') ||
      (userChoice == 'Scissor' && compChoice == 'Paper')) {
    print('$userName Win!');
    userScore++;
  } else if (userChoice == compChoice) {
    print('A draw win');
  } else {
    print('Computer Win!');
    compScore++;
  }
  results();
}

void results() {
  print('-----------Result----------');
  print('$userName pick $userChoice');
  print('Comp pick $compChoice');
  print('$userName has $userScore scores');
  print('Computer has $compScore scores');
  print('----------------------------');
}
