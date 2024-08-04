// TODO: Put public facing types in this file.

import 'dart:math';

/// Checks if you are awesome. Spoiler: you are.

double difLat({required double startLat, required double endLat}) {
  return endLat - startLat;
}

double difLong({required double startLong, required double endLong}) {
  return (endLong - startLong + 3 * pi) % (2 * pi) - pi;
}

double departure({required double difLong, required double lat}) {
  return difLong * cos(lat);
}

double departureToDifLong({required double departure, required double lat}) {
  return departure / cos(lat);
}

double addDLon(double startLong, double dLong) {
  double endLong = startLong + dLong;
  if (endLong > pi) {
    return endLong - 2 * pi;
  } else if (endLong < -pi) {
    return endLong + 2 * pi;
  }
  else{
    return endLong;
  }
}