/*Task 3

Завдання: Суп дня преміум
Умова:

Користувач вводить кількість днів
𝑛
n (не більше 30), протягом яких він записує свій вибір «супу дня». Кількість днів має бути в межах від 1 до 30. Якщо користувач вводить неприпустиму кількість днів, програма має попросити його ввести правильне значення.

Для кожного дня користувач вводить одне або кілька чисел від 1 до 7 (через пробіл), які відповідають певному супу:

1 - «Борщ»
2 - «Солянка»
3 - «Розсольник»
4 - «Грибний суп»
5 - «Том Ям»
6 - «Курячий бульйон»
7 - «Суп-пюре з гарбуза»

Приклад: «1 3» - означає, що на цей день було обрано “Борщ” і “Розсольник”.

Програма повинна:

- Вивести список супів, обраних користувачем для кожного дня.

- Підрахувати, скільки разів був обраний кожен суп за весь період.

- Показати, який суп був обраний найчастіше.

- Треба прорекламувати найчастіше обраний суп

- Треба створити масів меню на кожен день тижня, де будуть використовуватися найбільш популярні супи.

- Далі треба створити масив відвідувачів, вони люблять або один або інший суп та зробити так, щоб ці відвідувачі приходили кожен день та брали суп з меню та ставили оцінку за обслуговування. від 1 до 10 на рандом, але якщо є улюблений суп, то оцінка завжди має бути не менше 6.

ООП не використовуємо, можна використовувати різні структури даних, але обʼєкти створювати не треба

Приклад

*обрали супи дня*
*підбили статистику*
Наше меню супів на тиждень згідно з уподобань гурмана:
пн - Борщ
вт - Грибний суп
...

Ось оцінки від наших відвідувачів:

День 1:
Клієнт Вітя 2,
Клієнт Коля 3,
Клієнт Алекс 10

День 2:
Клієнт Вітя 4,
Клієнт Коля 7,
Клієнт Алекс 6

 */
import 'dart:core';
import 'dart:io';
import 'dart:math';

void main() {
  startGame();
}

const int userSoupsLimitPerDay = 2;
const int countDays = 5;
final List<String> usersList = [];
final Map<int, String> soupCounter = {};
Map<String, List<Map<int, String>>> userData = {};

const Map<int, String> soups = {
  1: '«Борщ»',
  2: '«Солянка»',
  3: '«Розсольник»',
  4: '«Грибний суп»',
  5: '«Том Ям»',
  6: '«Курячий бульйон»',
  7: '«Суп-пюре з гарбуза»',
};

//Main UserFlow
void startGame() {
  var dayCounter = 1;
  var soupId = 0;
  String userName = '';
  String? _userInput = createNewUser();
  if (_userInput == null) {
    print('Помилка при вводі імені, повторіть спробу');
    _userInput = createNewUser();
  }
  userName = _userInput!;
  while (dayCounter <= countDays) {
    soupId = userInputHandler(soups);
    if (soupId > 0 && soupId <= soups.length) {
      //Fill user data
      userData[userName] ??= [];
      userData[userName]!.add({dayCounter: soups[soupId]!});
      dayCounter++;
      print(userData);
    } else {
      print('Помилка при вводі меню');
    }
  }
  //Show popular soup
  String popularSoup = getMostCommonSoupPick(userName, showStatistics: true);
  print('Най популярніша страва це $popularSoup');
}

//User
int userInputHandler(Map<int, String> menuData) {
  int userChoice = 0;

  print('Обери суп. Введи його номер в меню');
  soups.forEach((k, v) {
    print('$k - $v');
  });
  String? userInput = stdin.readLineSync();
  if (userInput != null && userInput.isNotEmpty) {
    try {
      userChoice = int.parse(userInput);
      if (userChoice >= 1 && userChoice <= soups.keys.length) {
        return userChoice;
      } else {
        userChoice = 0;
        print('Введіть значення запропоноване в меню');
      }
    } catch (e) {
      print('Convert Error $e');
      return 0;
    }
  }
  return userChoice;
}

String? createNewUser() {
  print('Ведить своє ім`я');
  String? userName = stdin.readLineSync();
  if (userName != null && userName.isNotEmpty) {
    return userName;
  }
  return null;
}

String getMostCommonSoupPick(String dataKey, {bool showStatistics = false}) {
  Map<String, int> countSoups = {};
  String result = '';
  var soupMaps = userData[dataKey];
  if (soupMaps == null || soupMaps.isEmpty) {
    return 'Нема данных';
  }
  List<String> soupList = soupMaps.expand((item) => item.values).toList();

  for (String soup in soupList) {
    if (countSoups.containsKey(soup)) {
      countSoups[soup] = countSoups[soup]! + 1;
    } else {
      countSoups[soup] = 1;
    }
  }
  if (showStatistics) {
    print('Статистика по вибору страв за період.');
    countSoups.forEach((k, v) {
      print('$v обрано разів - $k');
    });
  }
  int maxScore = countSoups.values.reduce(max);
  int minScore = countSoups.values.reduce(min);
  if (maxScore > minScore) {
    result = countSoups.entries.firstWhere((entry) => entry.value == maxScore).key;
  } else {
    print('Улюбленої страви немає');
    result = '(не обрано)';
  }
  return result;
}
