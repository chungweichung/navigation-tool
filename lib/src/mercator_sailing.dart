import 'dart:math';
import 'package:vector_math/vector_math_64.dart';
import 'package:navigation/navigation.dart';
import 'package:navigation/src/position.dart';

class MercatorSailing {
  Position start;
  MercatorSailing({required this.start});

  double ellipticMeridianalPart(double lat) {
    double f = 1 / 298.257223563, eccentricity = sqrt(2 * f - pow(f, 2));
    return log(tan(0.25 * pi + (lat / 2)) *
        pow((1 - eccentricity * sin(lat)) / (1 + eccentricity * sin(lat)),
            eccentricity / 2));
  }

  double meridianalPart(double lat) {
    return log(tan(0.25 * pi + (lat / 2)));
  }

  double meridianArc(double lat) {
    double f = 1 / 298.257223563, eccentricity = sqrt(2 * f - pow(f, 2));
    final e2 = eccentricity * eccentricity;
    final e4 = e2 * e2;
    final e6 = e4 * e2;
    final e8 = e6 * e2;
    final e10 = e8 * e2;
    final a = 3443.918467;
    final fac = a * (1 - e2);

    final C1 = 1 +
        e2 *
            (3 / 4 +
                e2 *
                    (45 / 64 +
                        e2 *
                            (175 / 256 +
                                e2 * (11025 / 16384 + (43659 / 65536) * e2))));

    final C2 = e2 *
        (3 / 4 +
            e2 *
                (15 / 16 +
                    e2 *
                        (525 / 512 +
                            e2 * (2205 / 2048 + (72765 / 65536) * e2))));

    final C3 = e4 *
        (15 / 64 +
            e2 * (105 / 256 + e2 * (2205 / 4096 + (10395 / 16384) * e2)));

    final C4 = e6 * (35 / 512 + e2 * (315 / 2048 + (31185 / 131072) * e2));

    final C5 = e8 * (315 / 16384 + (3465 / 65536) * e2);

    final C6 = e10 * (693 / 131072);

    final sin2f = sin(2 * lat);
    final sin4f = sin(4 * lat);
    final sin6f = sin(6 * lat);
    final sin8f = sin(8 * lat);
    final sin10f = sin(10 * lat);

    return radians(fac *
        (C1 * lat -
            C2 * sin2f / 2 +
            C3 * sin4f / 4 -
            C4 * sin6f / 6 +
            C5 * sin8f / 8 -
            C6 * sin10f / 10)/60);
  }

  Map<String, double> to(
      {required Position end,
      bool isEllipticMeridianal = true,
      bool isEllipticLat = true}) {
    double dLong = difLong(startLong: start.long, endLong: end.long);
    double meridianalPartDiff, dLat;
    if (isEllipticMeridianal) {
      meridianalPartDiff =
          ellipticMeridianalPart(end.lat) - ellipticMeridianalPart(start.lat);
    } else {
      meridianalPartDiff = meridianalPart(end.lat) - meridianalPart(start.lat);
    }
    if (isEllipticLat) {
      dLat = meridianArc(end.lat) - meridianArc(start.lat);
    } else {
      dLat = difLat(startLat: start.lat, endLat: end.lat);
    }
    double courseAngle = atan(dLong / meridianalPartDiff.abs());
    double course;
    if (meridianalPartDiff > 0) {
      course = courseAngle % (2 * pi);
    } else if (meridianalPartDiff < 0) {
      course = pi - courseAngle;
    } else {
      courseAngle = (dLong.sign * (pi / 2));
      course = courseAngle % (pi * 2);
    }
    double distance = dLat / cos(courseAngle);
    return {'distance': distance, 'course': course, 'courseAngle': courseAngle};
  }
}
