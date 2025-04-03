void main() {
  WordSplitter wordSplitter = WordSplitter('HelloWorld', 4);
  wordSplitter.printFinalString();
}

class WordSplitter {
  String? word;
  int? countOfSymbols;
  late String result;

  WordSplitter(this.word, this.countOfSymbols);

  List<String> _splitWord() {
    List<String> partOfWord = [];
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

  void printFinalString() {
    List<String> wordParts = this._splitWord();
    this.result = wordParts.join('-');
    int len = result.length;
    if (result.substring(len - 1, len) == '-') {
      result = result.substring(0, len - 1);
    }
    print(result);
  }
}
