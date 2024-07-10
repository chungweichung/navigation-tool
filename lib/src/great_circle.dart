import 'dart:math';

import 'package:navigation/navigation.dart';

import 'position.dart';

class GreatCircle {
  Position start;
  GreatCircle({required this.start});

  Map<String, double> to(Position end) {
    double distance = acos(sin(start.lat) * sin(end.lat) +
        cos(start.lat) * cos(end.lat) * cos(end.long - start.long));
    if (distance < 0) distance = distance + pi;
    double _cosTheta = (sin(end.lat) - sin(start.lat) * cos(distance)) /
        (cos(start.lat) * sin(distance));
    _cosTheta = _cosTheta.clamp(-1, 1);
    double course = acos(_cosTheta);
    if(difLong(startLong: start.long, endLong: end.long)<0) {
      course = 2*pi - course;
    }
    return {'distance': distance, 'course': course};///return radians
  }
}
