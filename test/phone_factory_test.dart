import 'package:phone_factory/phone_factory.dart' show getDetailsCount;
import 'package:test/test.dart';

void main() {
  group('Find Details', () {
    test('Return 0 of second part', () {
      final input = ['**.', '.**'];
      expect(getDetailsCount(input, '*.', ''), 0);
    });

    test('Return count of second part', () {
      final input = ['**.', '.**'];
      expect(getDetailsCount(input, '*', '.'), 1);
    });
  });
}
