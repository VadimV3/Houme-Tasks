import 'dart:io';

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

//DATA
Map<int, String> dishData = {
  1: '«Борщ»',
  2: '«Солянка»',
  3: '«Розсольник»',
  4: '«Грибний суп»',
  5: '«Том Ям»',
  6: '«Курячий бульйон»',
  7: '«Суп-пюре з гарбуза»',
};

Map<String, String> adsDishTexts = {
  '«Борщ»': 'Смак, що передається з покоління в покоління!',
  '«Солянка»': 'Яскравий вибух смаку в кожній ложці!',
  '«Розсольник»': 'Кисло, смачно, по-домашньому!',
  '«Грибний суп»': 'Лісова ніжність у кожній краплі!',
  '«Том Ям»': 'Гарячий тайський характер у тарілці!',
  '«Курячий бульйон»': 'Класика, що зігріває душу!',
  '«Суп-пюре з гарбуза»': 'Оксамитовий смак осені!',
};

//Stat
Map<int, List<String>> convertIdToNameOfDish(
  Map<String, Map<int, List<int>>> data,
  String key,
  Map<int, String> dishData,
) {
  Map<int, List<String>> translatedData = {};
  List<String> dishMenuList = [];
  if (data.containsKey(key)) {
    Map<int, List<int>>? userMenu = data[key];
    if (userMenu != null) {
      int daysCount = userMenu.keys.length;
      for (int i = 1; i <= daysCount; i++) {
        print('${userMenu[i]}\n');
        List<int> menuList = userMenu[i]!;
        for (int k = 0; k <= menuList.length - 1; k++) {
          int dishID = menuList[k];
          String dishName = dishData[dishID]!;
          dishMenuList.insert(k, dishName);
        }
        translatedData.putIfAbsent(i, () => []);
        translatedData[i]!.addAll(dishMenuList);
      }
    }
  } else {
    print('Такого користувача нема');
  }
  return translatedData;
}

void countDishAndShowStats(Map<int, List<String>> data) {
  Map<String, int> result = {};
  for (int i = 1; i <= data.keys.length; i++) {
    if (data[i] != null) {
      List<String> dishList = data[i]!;
      for (int k = 0; k <= dishList.length - 1; k++) {
        String key = dishList[k];
        if (result.containsKey(key)) {
          result[key] = result[key]! + 1;
        } else {
          result[key] = 1;
        }
      }
    }
  }
  print('Статистика вибору супів:\n');
  int maxValue = 0;
  String maxKey = '';
  result.forEach((k, v) {
    print('$k - $v разів');
    if (maxValue < v) {
      maxValue = v;
      maxKey = k;
    }
  });
  print('+----------------------------------+');
  print('|    НАЙПОПУЛЯРНІШИЙ СУП ДНЯ       |');
  print('|Назва: $maxKey');
  print('|Выбрано разів: $maxValue');
  print('|Опис:${adsDishTexts[maxKey]}');
  print('+----------------------------------+');
}
