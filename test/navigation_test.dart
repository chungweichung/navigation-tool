import 'dart:math';

import 'package:navigation/navigation.dart';
import 'package:navigation/src/great_circle.dart';
import 'package:navigation/src/mercator_sailing.dart';
import 'package:navigation/src/position.dart';
import 'package:navigation/src/rhumb_line_sailing.dart';
import 'package:test/test.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  group('great_circle_test', () {
    List<Map> distanceAndCourse = [
      GreatCircle(start: Position(0, 0)).to(Position(0, pi / 2)), //cours90
      GreatCircle(start: Position(0, 0)).to(Position(pi / 2, 0)), //cours000
      GreatCircle(start: Position(0, 0)).to(Position(0, -pi / 2)), //cours270
      GreatCircle(start: Position(0, 0)).to(Position(-pi / 2, 0)), //cours180
      GreatCircle(start: Position(radians(-35), radians(176.5)))
          .to(Position(radians(7), radians(-82.5))) //auckland to Balboa
    ];

    test('First Test', () {
      expect(distanceAndCourse[0], {'distance': pi / 2, 'course': pi / 2});
      expect(distanceAndCourse[1], {'distance': pi / 2, 'course': 0});
      expect(distanceAndCourse[2], {'distance': pi / 2, 'course': 3 * pi / 2});
      expect(distanceAndCourse[3], {'distance': pi / 2, 'course': pi});
      expect(distanceAndCourse[4]['distance'],
          closeTo(radians(103.0051077), 0.00003));
      expect(distanceAndCourse[4]['course'],
          closeTo(radians(90.51738005), 0.00003));
    });
  });
  group('mercator_test', () {
    List<Map> distanceAndCourse = [
      MercatorSailing(start: Position(0, 0)).to(Position(0, pi / 2)), //cours90
      MercatorSailing(start: Position(0, 0)).to(Position(pi / 2, 0)), //cours000
      MercatorSailing(start: Position(0, 0))
          .to(Position(0, -pi / 2)), //cours270
      MercatorSailing(start: Position(0, 0))
          .to(Position(-pi / 2, 0)), //cours180
      MercatorSailing(start: Position(radians(-35), radians(176.5)))
          .to(Position(radians(7), radians(-82.5))) //auckland to Balboa
    ];

    test('APN version', () {
      expect(distanceAndCourse[0], {'distance': pi / 2, 'course': pi / 2});
      expect(distanceAndCourse[1], {'distance': pi / 2, 'course': 0});
      expect(distanceAndCourse[2], {'distance': pi / 2, 'course': 3 * pi / 2});
      expect(distanceAndCourse[3], {'distance': pi / 2, 'course': pi});
      expect(distanceAndCourse[4]['distance'],
          closeTo(radians(104.8502348), 0.00003));
      expect(distanceAndCourse[4]['course'],
          closeTo(radians(66.38609889), 0.00003));
    });
  });

  group('mercator_test', () {
    List<Map> distanceAndCourse = [
      MeanLatitudeSailing(start: Position(0, 0)).to(Position(0, pi / 2)), //cours90
      MeanLatitudeSailing(start: Position(0, 0)).to(Position(pi / 2, 0)), //cours000
      MeanLatitudeSailing(start: Position(0, 0))
          .to(Position(0, -pi / 2)), //cours270
      MeanLatitudeSailing(start: Position(0, 0))
          .to(Position(-pi / 2, 0)), //cours180
      MeanLatitudeSailing(start: Position(radians(-35), radians(176.5)))
          .to(Position(radians(7), radians(-82.5))) //auckland to Balboa
    ];

    test('nonCorrect version', () {
      expect(distanceAndCourse[0], {'distance': pi / 2, 'course': pi / 2});
      expect(distanceAndCourse[1], {'distance': pi / 2, 'course': 0});
      expect(distanceAndCourse[2], {'distance': pi / 2, 'course': 3 * pi / 2});
      expect(distanceAndCourse[3], {'distance': pi / 2, 'course': pi});
      expect(distanceAndCourse[4]['distance'],
          closeTo(radians(106.6207025), 0.00003));
      expect(distanceAndCourse[4]['course'],
          closeTo(radians(66.80138162), 0.00003));
    });
  });
}
