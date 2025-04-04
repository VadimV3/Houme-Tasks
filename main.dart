void main() {
  WordSplitter wordSplitter = WordSplitter('Hello World', 3);
  wordSplitter.printFinalString();
}

class WordSplitter {
  String? word;
  int? countOfSymbols;
  late String result;
  List<String> partOfWord = [];

  String ukrainianVowels = "АЕЄИІЇОУЮЯ";
  String englishVowels = "AEIOU";

  WordSplitter(this.word, this.countOfSymbols);

  List<String> _splitWord() {
    String wordPart = '';

    if (this.word == null ||
        this.countOfSymbols == null ||
        this.word!.isEmpty ||
        this.countOfSymbols! <= 0) {
      return partOfWord;
    }
    try {
      for (var i = 0; i < this.word!.length; i += this.countOfSymbols!) {
        wordPart = this.word!.substring(i, i + this.countOfSymbols!);
        partOfWord.add('$wordPart');
      }
    } catch (e) {
      wordPart = this.word!.substring(this.countOfSymbols! - 1, this.countOfSymbols!);
      partOfWord.add('$wordPart*');
    }
    return partOfWord;
  }

  void _countVowelLetters() {
    Map<String, int> vowelLetterCountResult = {};

    for (var i = 0; i < partOfWord.length; i++) {
      String partStr = partOfWord[i].toUpperCase();

      int count = partStr.split('').where((char) => englishVowels.contains(char)).length;

      vowelLetterCountResult[partStr] = count;
    }
    print(vowelLetterCountResult);
  }

  void _findCoolestPart() {
    Map<String, String> scoreData = {};
    int score = 0;
    //iterate list
    for (var i = 0; i < partOfWord.length; i++) {
      String partStr = partOfWord[i].toString().toUpperCase();
      //iterate String of list
      for (var k = 0; k < partStr.length; k++) {
        String letter = partStr[k].toUpperCase();
        if (englishVowels.contains(letter)) {
          score += englishVowels.indexOf(letter) + 1;
        }
      }
      scoreData[partStr] = '$score scores';
      score = 0;
    }
    print(scoreData);
  }

  void printFinalString() {
    List<String> wordParts = this._splitWord();
    this.result = wordParts.join('-');
    int len = result.length;
    if (result.substring(len - 1, len) == '-') {
      result = result.substring(0, len - 1);
    }
    //Task1
    print(result);
    //Task 2
    _countVowelLetters();
    //Task 3
    _findCoolestPart();
  }
}
