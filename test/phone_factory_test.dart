import 'package:test/test.dart';

import '../main.dart';

void main() {
  group('Find Details', () {
    test('Return 0 of second part', () {
      final input = ['**.', '.**'];
      expect(findDetail(input, '*.', 2), 0);
    });

    test('Return count of second part', () {
      final input = ['**.', '.**'];
      expect(findDetail(input, '*', '.'), 1);
    });
  });
}
