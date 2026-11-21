import 'package:flutter_test/flutter_test.dart';
import 'package:demo2/main.dart';

void main() {
  test('computeTip calculates correct tip and total', () {
    final result = computeTip(500, 15);

    expect(result.tip, 75.0);
    expect(result.total, 575.0);
  });

  test('parseBill reads valid amount', () {
    expect(parseBill('500'), 500.0);
  });

  test('parseBill rejects invalid amount', () {
    expect(parseBill('abc'), null);
  });
}
