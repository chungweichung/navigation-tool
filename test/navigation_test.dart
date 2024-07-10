import 'dart:math';

import 'package:navigation/navigation.dart';
import 'package:navigation/src/great_circle.dart';
import 'package:navigation/src/position.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    Map distanceAndCourse =
        GreatCircle(start: Position(0, 0)).to(Position(0, pi / 2));

    test('First Test', () {
      expect(distanceAndCourse, {'distance':  pi/2, 'course': pi / 2});
    });
  });
}
