import 'package:soups/data/soup_data.dart';

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
