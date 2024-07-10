import 'dart:math';

import 'package:navigation/src/navigation_base.dart';

import 'position.dart';

class MeanLatitudeSailing {
  Position start;
  MeanLatitudeSailing(this.start);

  Map<String, double> to(Position end) {
    double meanLat = (start.lat + end.lat) / 2;
    double course = atan2(
        departure(
            difLong: difLong(startLong: start.long, endLong: end.long),
            lat: meanLat),
        difLat(startLat: start.lat, endLat: end.lat));
    double distance =
        difLat(startLat: start.lat, endLat: end.lat) / cos(course);
    return {'distance': distance, 'course': course};
  }///the distance and course is radian unit
}

class CorrectedMeanLatitudeSailing {
  Position start;
  CorrectedMeanLatitudeSailing(this.start);

  Map<String, double> to(Position end) {
    double meanLat = acos(difLat(startLat: start.lat, endLat: end.lat) /
        (log(tan(pi / 4 + end.lat / 2)) - log(tan(pi / 4 + start.lat / 2))));
    double course = atan2(
        departure(
            difLong: difLong(startLong: start.long, endLong: end.long),
            lat: meanLat),
        difLat(startLat: start.lat, endLat: end.lat));
    double distance =
        difLat(startLat: start.lat, endLat: end.lat) / cos(course);
    return {'distance': distance, 'course': course};
  }///the distance and course is radian unit
}
