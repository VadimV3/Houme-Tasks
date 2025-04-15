void main() {
  int firstDetailCount = findDetailByRegularExp(RegExp(r'\*\.'), inputData);
  int secondDetailCount = findDetailByRegularExp(RegExp(r'\:'), inputData);
  int phoneCount = phonefactory(firstDetailCount, secondDetailCount);
  print('You will get $phoneCount phones');
}

const inputData = [
  '*.**::::**..*::.*…**.*::',
  '*.**::::**..*::.*…**.*::',
  '*.**::::**..*::.*…**.*::',
];

int findDetailByRegularExp(RegExp pattern, List<String> data) {
  int count = 0;
  RegExp regExp = pattern;

  for (String part in data) {
    count += regExp.allMatches(part).length;
  }
  return count;
}

int phonefactory(int countOffirstDetails, int countOfSecondDetails) {
  int needFirstDetails = 3;
  int needSecondDetails = 4;

  int result =
      ((countOffirstDetails + countOfSecondDetails) / (needSecondDetails + needFirstDetails))
          .floor();

  return result;
}
