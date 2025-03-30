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
//List<String> gameElements = ['Rock', 'Scissor', 'Paper'];
enum GameElements { rock, paper, scissor }

late String userName;
late GameElements? userChoice;
late GameElements compChoice;

var userScore = 0;
var compScore = 0;
//Map<int, String> gameItems = {1: 'Scissor', 2: 'Paper', 3: 'Rock'};

//Flow
void gameFlow() {
  while (userChooseHandler()) {
    //Comp pick item
    getRandomGameElement();
    winConditions(userChoice, compChoice);
  }
  print('Game Over!');
}

void getRandomGameElement() {
  Random rand = Random();
  int rndNumber = rand.nextInt(GameElements.values.length);
  compChoice = GameElements.values[rndNumber];
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
  for (var i = 0; i < GameElements.values.length; i++) {
    print('${i + 1} - ${GameElements.values[i].name}');
  }
  String? userPick = stdin.readLineSync();
  int? choosenNumber = int.tryParse(userPick ?? '');

  switch (choosenNumber) {
    case 1:
      userChoice = GameElements.rock;
      break;
    case 2:
      userChoice = GameElements.paper;
      break;
    case 3:
      userChoice = GameElements.scissor;
      break;
    case 9:
      return false;
    default:
      print('Input Error try Again');
      userChoice = null;
      return true;
  }
  return true;
}

void winConditions(GameElements? userInput, GameElements compChoice) {
  if (userInput != null) {
    userChoice = userInput;
    //Draw Win Check
    if (userChoice == compChoice) {
      print('A draw win');
      return;
    }
    //USer Win
    if ((userChoice == GameElements.rock && compChoice == GameElements.scissor) ||
        (userChoice == GameElements.paper && compChoice == GameElements.rock) ||
        (userChoice == GameElements.scissor && compChoice == GameElements.paper)) {
      print('$userName Win!');
      userScore++;
      //Comp Win
    } else {
      print('Computer Win!');
      compScore++;
    }
    results();
  } else {
    print('Check input');
  }
}

void results() {
  String userPick = userChoice.toString().split('.').last;
  String compPick = compChoice.toString().split('.').last;

  print('-----------Result----------');
  print('$userName pick $userPick');
  print('Comp pick $compPick');
  print('$userName has $userScore scores');
  print('Computer has $compScore scores');
  print('----------------------------');
}
