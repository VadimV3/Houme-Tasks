// Введіть кількість днів (від 1 до 30): 33
// Неправильне значення. Спробуйте ще раз.
// Введіть кількість днів (від 1 до 30): 5
//
// Введіть супи, які ви обрали на день 1 (числа від 1 до 7 через пробіл): 1 3
// Введіть супи, які ви обрали на день 2 (числа від 1 до 7 через пробіл): 2
// Введіть супи, які ви обрали на день 3 (числа від 1 до 7 через пробіл): 3 1 6
// Введіть супи, які ви обрали на день 4 (числа від 1 до 7 через пробіл): 5 7
// Введіть супи, які ви обрали на день 5 (числа від 1 до 7 через пробіл): 1 1
//
// Супи, обрані користувачем:
// День 1: Борщ, Розсольник
// День 2: Солянка
// День 3: Розсольник, Борщ, Курячий бульйон
// День 4: Том Ям, Суп-пюре з гарбуза
// День 5: Борщ, Борщ
//
// Статистика вибору супів:
// Борщ — 5 раз(ів)
// Солянка — 1 раз(ів)
// Розсольник — 2 раз(ів)
// Грибний суп — 0 раз(ів)
// Том Ям — 1 раз(ів)
// Курячий бульйон — 1 раз(ів)
// Суп-пюре з гарбуза — 1 раз(ів)
//
// Найпопулярніший суп: Борщ!
//
// +---------------------------------------------+
// |           НАЙПОПУЛЯРНІШИЙ СУП ДНЯ           |
// +---------------------------------------------+
// | Назва:         Борщ                         |
// | Вибрано разів: 5                            |
// | Опис:          Справжній смак традицій!     |
// |                Смакуй, як вдома!            |
// +---------------------------------------------+
//
// Наше меню супів на тиждень згідно з уподобань гурмана:
// Понеділок — Борщ
// Вівторок — Розсольник
// Середа — Курячий бульйон
// Четвер — Суп-пюре з гарбуза
// П’ятниця — Солянка
// Субота — Том Ям
// Неділя — Борщ
//
// Оцінки від наших відвідувачів:
//
// День 1:
// Клієнт Вітя — 6
// Клієнт Коля — 3
// Клієнт Алекс — 8
//
// День 2:
// Клієнт Вітя — 9
// Клієнт Коля — 6
// Клієнт Алекс — 6
//
// День 3:
// Клієнт Вітя — 10
// Клієнт Коля — 5
// Клієнт Алекс — 9
//
// День 4:
// Клієнт Вітя — 7
// Клієнт Коля — 4
// Клієнт Алекс — 10
//
// День 5:
// Клієнт Вітя — 6
// Клієнт Коля — 6
// Клієнт Алекс — 7
//
// День 6:
// Клієнт Вітя — 9
// Клієнт Коля — 2
// Клієнт Алекс — 10
//
// День 7:
// Клієнт Вітя — 6
// Клієнт Коля — 1
// // Клієнт Алекс — 10
import 'dart:io';

void main() {
  final Map<String, Map<int, List<int>>> mainData = addUserMenu();
  String userName = mainData.keys.first;
  var data = convertIdToNameOfDishForUser(mainData, userName, dishData);
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
        print('Ви ввели неправельні значення спробуйте ще раз');
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
  bool isRun = true;
  while (isRun) {
    print('Меню програми!');
    print(
      '1 - Показати статистику по вибору користувача\n'
      '2 - Показати рекламу напуполярнішої страви\n'
      '3 - Вихід\n',
    );

    String userInput = stdin.readLineSync() ?? ' ';
    int? userChoice = int.tryParse(userInput);
    Map<String, int> soupCountData = calculateDish(data);

    if (userChoice != null) {
      switch (userChoice) {
        case 1:
          showMenuByWeek(soupCountData);
          break;
        case 2:
          Map<String, int> favoriteSoupForAds = showSoupStatic(soupCountData);
          showSoupAds(favoriteSoupForAds);
          break;
        case 3:
          isRun = false;
          break;
        default:
          break;
      }
    }
  }
}

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

Map<int, List<String>> convertIdToNameOfDishForUser(
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
        List<int> menuList = userMenu[i]!;
        for (int j = 0; j <= menuList.length - 1; j++) {
          int dishID = menuList[j];
          String dishName = dishData[dishID]!;
          dishMenuList.insert(j, dishName);
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

Map<String, int> calculateDish(Map<int, List<String>> data) {
  Map<String, int> result = {};
  for (int i = 0; i <= data.keys.length; i++) {
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
  return result;
}

Map<String, int> showSoupStatic(Map<String, int> result) {
  Map<String, int> favoriteSoup = {};
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
  favoriteSoup[maxKey] = maxValue;
  return favoriteSoup;
}

void showSoupAds(Map<String, int> favoriteSoup) {
  if (favoriteSoup.keys.length > 1) {
    return;
  }
  String maxKey = favoriteSoup.keys.first;
  int count = 0;
  if (favoriteSoup.containsKey(maxKey)) {
    count = favoriteSoup[maxKey]!;
  } else {
    print('Key Error in ads');
    count = 0;
  }

  print("          РЕКЛАМА!              \n");
  print('+----------------------------------+');
  print('|    НАЙПОПУЛЯРНІШИЙ СУП ДНЯ       |');
  print('|Назва: $maxKey');
  print('|Выбрано разів: $count');
  print('|Опис:${adsDishTexts[maxKey]}');
  print('+----------------------------------+');
}

void showMenuByWeek(Map<String, int> soupData) {
  Map<String, String> soupByDay = {
    'Понеділок': '',
    'Вівторок': '',
    'Середа': '',
    'Четвер': '',
    'П`ятниця': '',
    'Суббота': '',
    'Неділя': '',
  };
  List<MapEntry<String, int>> sortedEntry = soupData.entries.toList();

  for (int i = 0; i < sortedEntry.length - 1; i++) {
    for (int j = 0; j < sortedEntry.length - i - 1; j++) {
      if (sortedEntry[j].value < sortedEntry[j + 1].value) {
        MapEntry<String, int> temp = sortedEntry[j];
        sortedEntry[j] = sortedEntry[j + 1];
        sortedEntry[j + 1] = temp;
      }
    }
  }

  List<String> sortedSoupsByFrequency = sortedEntry.map((e) => e.key).toList();
  int index = 0;
  for (String day in soupByDay.keys) {
    if (index < sortedSoupsByFrequency.length) {
      soupByDay[day] = sortedSoupsByFrequency[index];
      index++;
    } else {
      soupByDay[day] = '-';
    }
  }
  print('--------------МЕНЮ НА ТИЖДЕНЬ---------------');

  soupByDay.forEach((day, soup) {
    print('В $day - $soup');
  });
}
