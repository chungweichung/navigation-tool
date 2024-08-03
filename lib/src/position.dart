import 'package:navigation/navigation.dart';

///lat and long are the radian unit
class Position {
  final double lat;
  final double long;

  Position(this.lat, this.long);

  Position.clone(Position other) : this(other.lat, other.long);

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
