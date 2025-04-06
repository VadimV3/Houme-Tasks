import 'dart:io';

void main() {
  Map<String, dynamic> data = checkInput();

  String wordData = data['word'];
  LanguageChoice langData = data['lang'];
  int numberData = data['number'];

  WordSplitter wordSplitter = WordSplitter(wordData, numberData, langData);
  wordSplitter.printFinalString();
  wordSplitter.countVowelLetters();
  wordSplitter.findCoolestPart();
}

enum LanguageChoice { english, ukranian }

class WordSplitter {
  String? word;
  int? countOfSymbols;
  String _result = '';
  List<String> partOfWord = [];
  LanguageChoice choiceLang = LanguageChoice.english;

  String ukrainianVowels = "АЕЄИІЇОУЮЯ";
  String englishVowels = "AEIOU";

  WordSplitter(this.word, this.countOfSymbols, this.choiceLang) {
    _splitWord();
  }

  void _splitWord() {
    if (this.word == null ||
        this.countOfSymbols == null ||
        this.word!.isEmpty ||
        this.countOfSymbols! <= 0) {
      return;
    }
    for (int i = 0; i < this.word!.length; i += this.countOfSymbols!) {
      int endIndex;
      if (i + this.countOfSymbols! <= word!.length) {
        endIndex = i + this.countOfSymbols!;
      } else {
        endIndex = word!.length;
      }
      String part = this.word!.substring(i, endIndex);
      if (part.length < this.countOfSymbols!) {
        part = part + '*';
      }
      partOfWord.add(part);
    }
  }

  void countVowelLetters() {
    Map<String, int> vowelLetterCountResult = {};
    String vowelsLetters = '';
    if (choiceLang == LanguageChoice.english) {
      vowelsLetters = englishVowels;
    } else {
      vowelsLetters = ukrainianVowels;
    }

    for (var i = 0; i < partOfWord.length; i++) {
      String partStr = partOfWord[i].toUpperCase();

      int count = partStr.split('').where((char) => vowelsLetters.contains(char)).length;

      vowelLetterCountResult[partStr] = count;
    }
    print(vowelLetterCountResult);
  }

  void findCoolestPart() {
    Map<String, String> scoreData = {};
    int score = 0;
    String vowelsLetters = '';

    if (choiceLang == LanguageChoice.english) {
      vowelsLetters = englishVowels;
    } else {
      vowelsLetters = ukrainianVowels;
    }
    //iterate list
    for (var i = 0; i < partOfWord.length; i++) {
      String partStr = partOfWord[i].toString().toUpperCase();
      //iterate String of list
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

  void printFinalString() {
    List<String> wordParts = partOfWord;
    this._result = wordParts.join('-');
    int len = _result.length;
    if (_result.substring(len - 1, len) == '-') {
      _result = _result.substring(0, len - 1);
    }
    print(_result);
  }
}

//Uer Flow

Map<String, dynamic> checkInput() {
  Map<String, dynamic> result = {};
  LanguageChoice lang = LanguageChoice.ukranian;
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
      lang = LanguageChoice.ukranian;
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

  result['word'] = word;
  result['lang'] = lang;
  result['number'] = splitNumber;
  return result;
}
