import 'dart:io';

import 'package:soups/data/soup_data.dart';
import 'package:soups/statistics.dart';

void main() {
  var mainData = addUserMenu();
  String userName = mainData.keys.first;
  var data = convertIdToNameOfDish(mainData, userName, dishData);
  programMenu(data);
}

const int daysCount = 5;

List<int> pickDish() {
  List<int> userPick = [];
  dishData.forEach((key, value) {
    print('Номер в меню $key, назва страви $value');
  });
  print(
    'Введіть супи, які ви обрали на день 1 (числа від 1 до ${dishData.length} через пробіл) \n',
  );
  String userInput = stdin.readLineSync() ?? '';
  List<String> menuParts = userInput.split(' ');
  for (String part in menuParts) {
    int numberDish = int.tryParse(part.trim()) ?? 0;
    if (numberDish != 0) {
      if (numberDish >= 1 && numberDish <= dishData.length) {
        userPick.add(numberDish);
      } else {
        print('Ви ввели непраильне значення спробуйте ще раз');
      }
    }
  }
  return userPick;
}

Map<int, List<int>> createMenuByDay(int daysCount) {
  int counter = 1;
  Map<int, List<int>> menu = {};
  while (counter <= daysCount) {
    List<int> userChoice = pickDish();
    if (userChoice.isNotEmpty) {
      menu[counter] = userChoice;
      counter++;
    }
  }
  return menu;
}

Map<String, Map<int, List<int>>> addUserMenu() {
  Map<String, Map<int, List<int>>> userData = {};
  print('Введіть своє ім`я');
  String userName = stdin.readLineSync() ?? '';
  while (userName.isEmpty) {
    print('Поле не може бути пустим');
    userName = stdin.readLineSync() ?? '';
  }
  Map<int, List<int>> menu = createMenuByDay(daysCount);
  userData[userName] = menu;

  return userData;
}

void programMenu(Map<int, List<String>> data) {
  print('Меню програми!');
  print(
    '1 - Показати статистику по вибору користувачів\n'
    '2 - Показати рекламу напуполярнішої страви\n'
    '3 - Показати меню\n',
  );

  String userInput = stdin.readLineSync() ?? ' ';
  int? userChoice = int.tryParse(userInput);
  if (userChoice != null) {
    switch (userChoice) {
      case 1:
        break;
      case 2:
        countDishAndShowStats(data);
        break;
      case 3:
        break;
      default:
        break;
    }
  }
}
