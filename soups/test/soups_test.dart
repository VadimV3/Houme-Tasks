import 'package:soups/soups.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Test', () {
    const Map<int, String> soups = {
      1: '«Борщ»',
      2: '«Солянка»',
      3: '«Розсольник»',
      4: '«Грибний суп»',
      5: '«Том Ям»',
      6: '«Курячий бульйон»',
      7: '«Суп-пюре з гарбуза»',
    };
    expect(userInputHandler(soups), greaterThan(0));
  });
}
