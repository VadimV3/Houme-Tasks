// Треба зробити фабрику з виробництва смартфонів.
//
// Наша фабрика отримує руду у вигляді масиву зі строк
// [
// ʼ*.**::::**..*::.*…**.*::’ ,
// ʼ*.**::::**..*::.*…**.*::’ ,
// ʼ*.**::::**..*::.*…**.*::’ ,
// ]
//
// Перший етап обробки руди - це діставання необхідних елементів з неї.
//
// Нас цікавить:
// *. Та :
//
// З трьох поєднань *. робиться одна така частина смартфону _
//
// З двох поєднань : робиться така |
//
// На виході, треба показати смартфони, що зробила наша фабрика та їх кількість.
//
// |_| |_| |_| - 3 смартфони
//
//
// Необхідно створити масив руди. Тип даних List<String> та написати логіку її обробки.
//
// Якщо руди недостатньо для виробництва хоча б одного смартфону, мають бути помилки
//
// Задачу треба розбити на функції
//
//
//
// Без налл сейфті
// Без ООП
// Без глобальних та статичних змінних (за виключенням констант)

void main() {
  int firstDetailCount = getDetailsCount(inputData, '*', '.');
  int secondDetail = getDetailsCount(inputData, ':', null);
  int phoneCount = calculatePhoneCount(firstDetailCount, secondDetail);

  // TODO: Make user friendly.

  print('З цієї руди\n $inputData');
  print('Ми отримали кількість деталей першого типу $firstDetailCount шт.');
  print('Ми отримали кількість деталей другого типу $secondDetail шт.');
  print('Зможемо зробити телефонів $phoneCount ');
}

const inputData = [
  '*.**::::**..*::.*…**.*::',
  '*.**::::**..*::.*…**.*::',
  '*.**::::**..*::.*…**.*::',
];

int getDetailsCount(List<String> inputData, String firstDetailPart, String? secondDetailPart) {
  int counter = 0;
  String firstDetailChar;
  String secondDetailChar;

  assert(firstDetailPart.length == 1, 'Use one symbol');

  for (String dataPart in inputData) {
    for (int i = 0; i < dataPart.length; i++) {
      if (secondDetailPart == null) {
        firstDetailChar = dataPart[i];
        if (firstDetailChar == firstDetailPart) {
          counter++;
        }
      } else {
        try {
          firstDetailChar = dataPart[i];
          secondDetailChar = dataPart[i + 1];
          if (firstDetailChar == firstDetailPart && secondDetailChar == secondDetailPart) {
            counter++;
          }
        } catch (e) {
          return counter;
        }
      }
    }
  }
  return counter;
}

int calculatePhoneCount(int firstDetailCount, int secondDetailCount) {
  int phoneCount = 0;
  bool cheker = true;

  int firstDetail = (firstDetailCount / 3).floor();
  int secondDetail = (secondDetailCount / 2).floor();

  while (cheker) {
    if (firstDetail <= 0 || secondDetail <= 0) {
      cheker = false;
    } else {
      phoneCount++;
      firstDetail -= 1;
      secondDetail -= 2;
    }
  }
  return phoneCount;
}
