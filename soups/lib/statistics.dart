void showUserChoice(Map<String, Map<int, List<int>>> userData) {}

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
      int daysCount = userMenu!.keys.length;
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
    print('Такого пользователя нету');
  }
  return translatedData;
}
