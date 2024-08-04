import 'dart:math';

import 'package:navigation/navigation.dart';

///lat and long are the radian unit
class Position {
  double lat;
  double long;

  Position(this.lat, this.long);
  Position.zero()
      : lat = 0,
        long = 0;
  Position.random(Position? start, Position? end) 
      : lat = start == null || end == null
          ? -pi / 2 + Random().nextDouble() * pi
          : start.lat + Random().nextDouble() * (end.lat - start.lat),
        long = start == null || end == null
          ? -pi + Random().nextDouble() * 2 * pi
          : addDLon(start.long, Random().nextDouble()*difLong(startLong: start.long, endLong: end.long));


  Position clone() {
    return Position(this.lat, this.long);
  }

  Position operator *(num factor) {
    return Position(lat * factor, long * factor);
  }

  Position operator +(Position other) {
    return Position(lat + other.lat, long + other.long);
  }

  Position operator -(Position other) {
    return Position(lat - other.lat, long - other.long);
  }

  double greatCircleDistanceTo(Position other) {
    Map sail = GreatCircle(start: Position(lat, long)).to(other);
    return sail['distance'];
  }

  double mercatorDistanceTo(Position other,
      {bool isEllipticMeridianal = true, bool isEllipticLat = false}) {
    Map sail = MercatorSailing(start: Position(lat, long)).to(other,
        isEllipticMeridianal: isEllipticMeridianal,
        isEllipticLat: isEllipticLat);
    return sail['distance'];
  }

  double dLong(Position other) {
    return difLong(startLong: long, endLong: other.long);
  }

  double dLat(Position other) {
    return difLat(startLat: lat, endLat: other.lat);
  }

  @override
  String toString() => 'Position(lat: $lat, long: $long)';
}

// 为 num 类型（包括 int 和 double）添加扩展方法
