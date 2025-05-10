// TODO: Write task condition.

void main() {
  // TODO: Rename firstDetailCount
  int firstDetail = findDetail(inputData, '*', '.');
  // TODO: Rename firstDetailCount
  int secondDetail = findDetail(inputData, ':', null);

  // TODO: Make user friendly.
  print(firstDetail);
  print(secondDetail);

  int phoneCount = createPhone(firstDetail, secondDetail);
  print('Phone created is $phoneCount');
}

const inputData = [
  '*.**::::**..*::.*…**.*::',
  '*.**::::**..*::.*…**.*::',
  '*.**::::**..*::.*…**.*::',
];

// TODO: Rename getDetailsCount
// TODO: Rename firstDetailChar
// TODO: Rename secondDetailChar
int findDetail(List<String> inputData, String firstDetailPart, String? secondDetailPart) {
  int counter = 0;
  String firstChar;
  String secondChar;

  assert(firstDetailPart.length == 1, 'Use one symbol');

  for (String dataPart in inputData) {
    // TODO: Reactor range
    for (int i = 0; i < dataPart.length - 1; i++) {
      if (secondDetailPart == null) {
        firstChar = dataPart[i];
        if (firstChar == firstDetailPart) {
          counter++;
        }
      } else {
        firstChar = dataPart[i];
        secondChar = dataPart[i + 1];
        if (firstChar == firstDetailPart && secondChar == secondDetailPart) {
          counter++;
        }
      }
    }
  }
  return counter;
}

// TODO: calculatePhoneCount
int createPhone(int firstDetailCount, int secondDetailCount) {
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
