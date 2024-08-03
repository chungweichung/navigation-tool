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

  /*double distanceTo(Position other) {
    double dlat = lat - other.lat;
    double dlong = long - other.long;
    return sqrt(dlat * dlat + dlong * dlong);
  }*/

  @override
  String toString() => 'Position(lat: $lat, long: $long)';
}

// 为 num 类型（包括 int 和 double）添加扩展方法
