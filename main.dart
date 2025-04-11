import 'dart:io';

void main() {
  checkInput((word, splitCount, userLang) {
    var lang = userLang;
    var partsOfWord = splitWord(word, splitCount);
    printFinalString(partsOfWord);
    countVowelLetters(partsOfWord, lang);
    findCoolestPart(partsOfWord, lang);
  });
}

enum LanguageChoice { english, ukrainian }

LanguageChoice choiceLang = LanguageChoice.english;

const ukrainianVowels = "АЕЄИІЇОУЮЯ";
const englishVowels = "AEIOU";

//Task 1
List<String> splitWord(String word, int countOfSymbols) {
  List<String> partOfWord = [];

  if (word == null || countOfSymbols == null || word.isEmpty || countOfSymbols <= 0) {
    return partOfWord;
  }
  for (int i = 0; i < word.length; i += countOfSymbols) {
    int endIndex;
    if (i + countOfSymbols <= word.length) {
      endIndex = i + countOfSymbols;
    } else {
      endIndex = word.length;
    }
    String part = word.substring(i, endIndex);
    if (part.length < countOfSymbols) {
      part = part + '*';
    }
    partOfWord.add(part);
  }
  return partOfWord;
}

void printFinalString(List<String> partOfWord) {
  List<String> wordParts = partOfWord;
  _result = wordParts.join('-');
  int len = _result.length;
  if (_result.substring(len - 1, len) == '-') {
    _result = _result.substring(0, len - 1);
  }
  print(_result);
}

//Task 2

void countVowelLetters(List<String> partsOfWord, LanguageChoice choiceLang) {
  Map<String, int> vowelLetterCountResult = {};
  String vowelsLetters = '';
  if (choiceLang == LanguageChoice.english) {
    vowelsLetters = englishVowels;
  } else {
    vowelsLetters = ukrainianVowels;
  }

  for (var i = 0; i < partsOfWord.length; i++) {
    String partStr = partsOfWord[i].toUpperCase();

    int count = partStr.split('').where((char) => vowelsLetters.contains(char)).length;

    vowelLetterCountResult[partStr] = count;
  }
  print(vowelLetterCountResult);
}

//Task 3

void findCoolestPart(List<String> partOfWord, LanguageChoice choiceLang) {
  Map<String, String> scoreData = {};
  int score = 0;
  String vowelsLetters = '';

  if (choiceLang == LanguageChoice.english) {
    vowelsLetters = englishVowels;
  } else {
    vowelsLetters = ukrainianVowels;
  }
  for (var i = 0; i < partOfWord.length; i++) {
    String partStr = partOfWord[i].toString().toUpperCase();
    for (var k = 0; k < partStr.length; k++) {
      String letter = partStr[k].toUpperCase();
      if (vowelsLetters.contains(letter)) {
        score += vowelsLetters.indexOf(letter) + 1;
      }
    }
    scoreData[partStr] = '$score scores';
    score = 0;
  }
  print(scoreData);
}

//Uer Flow

void checkInput(Function(String userWord, int splitNumber, LanguageChoice lang) complition) {
  Map<String, dynamic> result = {};
  LanguageChoice lang = LanguageChoice.ukrainian;
  String word = '';
  int splitNumber = 0;
  print('Choose your Language \n1- en \n2 - uk \n');
  String? langStr = stdin.readLineSync() ?? '';
  int langNum = 0;

  //Texts
  const EN_INPUT_WORD = 'Enter the word!';
  const UK_INPUT_WORD = 'Введіть ваше слово!';
  const EN_INPUT_NUMBER = 'Enter the split number';
  const UK_INPUT_NUMBER = 'Введіть число щоб розділити слово';
  const EN_ERROR = 'Word error';
  const UK_ERROR = 'Помилка при вводі слова';

  //Handle lang choice
  if (langStr.isNotEmpty) {
    langNum = int.parse(langStr);
    if (langNum == 1) {
      lang = LanguageChoice.english;
    } else {
      lang = LanguageChoice.ukrainian;
    }
  }

  //Handle word
  String questionWord = '';
  String questionNumber = '';
  String wordInputError = '';
  if (lang == LanguageChoice.english) {
    questionWord = EN_INPUT_WORD;
    questionNumber = EN_INPUT_NUMBER;
    wordInputError = EN_ERROR;
  } else {
    questionWord = UK_INPUT_WORD;
    questionNumber = UK_INPUT_NUMBER;
    wordInputError = UK_ERROR;
  }

  print('$questionWord');
  String? userWord = stdin.readLineSync() ?? '';
  if (userWord.isNotEmpty) {
    word = userWord;
  } else {
    word = '';
    print(wordInputError);
  }
  print('$questionNumber');
  String? userNumber = stdin.readLineSync() ?? '';
  splitNumber = int.parse(userNumber);

  return complition(word, splitNumber, lang);
}
