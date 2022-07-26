part of '../../vim_math3d.dart';

class GeoCoordinate implements Comparable<GeoCoordinate> {
  final double latitude;
  final double longitude;

  static const int numComponents = 2;
  static const GeoCoordinate zero = GeoCoordinate.value(0);
  static const GeoCoordinate minValue = GeoCoordinate.value(-double.maxFinite);
  static const GeoCoordinate maxValue = GeoCoordinate.value(double.maxFinite);
  static const GeoCoordinate one = GeoCoordinate.value(1.0);
  static const GeoCoordinate unitLatitude = GeoCoordinate(1.0, 0.0);
  static const GeoCoordinate unitLongitude = GeoCoordinate(0.0, 1.0);

  const GeoCoordinate(this.latitude, this.longitude);
  const GeoCoordinate.value(double value) : this(value, value);

  bool get isNaN => latitude.isNaN || longitude.isNaN;
  bool get isInfinite => latitude.isInfinite || longitude.isInfinite;
  @override
  int get hashCode => Hash.combine(latitude.hashCode, longitude.hashCode);

  bool almostEquals(GeoCoordinate x,
          [double tolerance = Constants.tolerance]) =>
      latitude.almostEquals(x.latitude, tolerance) &&
      longitude.almostEquals(x.longitude, tolerance);
  GeoCoordinate setLatitude(double x) => GeoCoordinate(x, longitude);
  GeoCoordinate setLongitude(double x) => GeoCoordinate(latitude, x);
  double dot(GeoCoordinate value2) =>
      latitude * value2.latitude + longitude * value2.longitude;
  bool almostZero([double tolerance = Constants.tolerance]) =>
      latitude.abs() < tolerance && longitude.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0.0;
  double minComponent() => (latitude).min(longitude);
  double maxComponent() => (latitude).max(longitude);
  double sumComponents() => (latitude) + (longitude);
  double sumSqrComponents() => (latitude).sqr() + (longitude).sqr();
  double productComponents() => (latitude) * (longitude);
  double getComponent(int n) => n == 0 ? latitude : longitude;
  double magnitudeSquared() => sumSqrComponents();
  double magnitude() => magnitudeSquared().sqrt();

  @override
  int compareTo(GeoCoordinate x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() =>
      "GeoCoordinate(Latitude = $latitude, Longitude = $longitude)";

  @override
  bool operator ==(Object other) =>
      other is GeoCoordinate &&
      (latitude == other.latitude && longitude == other.longitude);
  GeoCoordinate operator +(Object v) => v is GeoCoordinate
      ? GeoCoordinate(latitude + v.latitude, longitude + v.longitude)
      : v is num
          ? GeoCoordinate(latitude + v, longitude + v)
          : throw UnsupportedError('operator + (${v.runtimeType})');
  GeoCoordinate operator -(Object v) => v is GeoCoordinate
      ? GeoCoordinate(latitude - v.latitude, longitude - v.longitude)
      : v is num
          ? GeoCoordinate(latitude - v, longitude - v)
          : throw UnsupportedError('operator - (${v.runtimeType})');
  GeoCoordinate operator *(Object v) => v is GeoCoordinate
      ? GeoCoordinate(latitude * v.latitude, longitude * v.longitude)
      : v is num
          ? GeoCoordinate(latitude * v, longitude * v)
          : throw UnsupportedError('operator * (${v.runtimeType})');
  GeoCoordinate operator /(Object v) => v is GeoCoordinate
      ? GeoCoordinate(latitude / v.latitude, longitude / v.longitude)
      : v is num
          ? GeoCoordinate(latitude / v, longitude / v)
          : throw UnsupportedError('operator / (${v.runtimeType})');
  GeoCoordinate operator -() => zero - this;
  bool operator <(GeoCoordinate x1) => compareTo(x1) < 0;
  bool operator <=(GeoCoordinate x1) => compareTo(x1) <= 0;
  bool operator >(GeoCoordinate x1) => compareTo(x1) > 0;
  bool operator >=(GeoCoordinate x1) => compareTo(x1) >= 0;
}

class SphericalCoordinate {
  final double radius;
  final double azimuth;
  final double inclination;

  static const SphericalCoordinate zero = SphericalCoordinate(0, 0, 0);
  // static const SphericalCoordinate minValue = SphericalCoordinate(.minValue, .minValue, .minValue);
  // static const SphericalCoordinate maxValue = SphericalCoordinate(.maxValue, .maxValue, .maxValue);

  const SphericalCoordinate(this.radius, this.azimuth, this.inclination);

  @override
  int get hashCode =>
      Hash.combine3(radius.hashCode, azimuth.hashCode, inclination.hashCode);

  bool almostEquals(SphericalCoordinate x,
          [double tolerance = Constants.tolerance]) =>
      radius.almostEquals(x.radius, tolerance) &&
      azimuth.almostEquals(x.azimuth, tolerance) &&
      inclination.almostEquals(x.inclination, tolerance);
  SphericalCoordinate setRadius(double x) =>
      SphericalCoordinate(x, azimuth, inclination);
  SphericalCoordinate setAzimuth(double x) =>
      SphericalCoordinate(radius, x, inclination);
  SphericalCoordinate setInclination(double x) =>
      SphericalCoordinate(radius, azimuth, x);

  @override
  String toString() =>
      "SphericalCoordinate(Radius = $radius, Azimuth = $azimuth, Inclination = $inclination)";

  @override
  bool operator ==(Object other) =>
      other is SphericalCoordinate &&
      (radius == other.radius &&
          azimuth == other.azimuth &&
          inclination == other.inclination);
}

class PolarCoordinate {
  final double radius;
  final double azimuth;

  static const PolarCoordinate zero = PolarCoordinate(0.0, 0.0);
  // static const PolarCoordinate MinValue = PolarCoordinate(.minValue, .minValue);
  // static const PolarCoordinate MaxValue = PolarCoordinate(.maxValue, .maxValue);

  const PolarCoordinate(this.radius, this.azimuth);

  @override
  int get hashCode => Hash.combine(radius.hashCode, azimuth.hashCode);

  bool almostEquals(PolarCoordinate x,
          [double tolerance = Constants.tolerance]) =>
      radius.almostEquals(x.radius, tolerance) &&
      azimuth.almostEquals(x.azimuth, tolerance);
  PolarCoordinate setRadius(double x) => PolarCoordinate(x, azimuth);
  PolarCoordinate setAzimuth(double x) => PolarCoordinate(radius, x);

  @override
  String toString() => "PolarCoordinate(Radius = $radius, Azimuth = $azimuth)";

  @override
  bool operator ==(Object other) =>
      other is PolarCoordinate &&
      (radius == other.radius && azimuth == other.azimuth);
}

class LogPolarCoordinate {
  final double rho;
  final double azimuth;

  static const LogPolarCoordinate zero = LogPolarCoordinate(0.0, 0.0);
  // static const LogPolarCoordinate minValue = LogPolarCoordinate(.minValue, .minValue);
  // static const LogPolarCoordinate maxValue = LogPolarCoordinate(.maxValue, .maxValue);

  const LogPolarCoordinate(this.rho, this.azimuth);

  @override
  int get hashCode => Hash.combine(rho.hashCode, azimuth.hashCode);

  bool almostEquals(LogPolarCoordinate x,
          [double tolerance = Constants.tolerance]) =>
      rho.almostEquals(x.rho, tolerance) &&
      azimuth.almostEquals(x.azimuth, tolerance);
  LogPolarCoordinate setRho(double x) => LogPolarCoordinate(x, azimuth);
  LogPolarCoordinate setAzimuth(double x) => LogPolarCoordinate(rho, x);

  @override
  String toString() => "LogPolarCoordinate(Rho = $rho, Azimuth = $azimuth)";

  @override
  bool operator ==(Object other) =>
      other is LogPolarCoordinate &&
      (rho == other.rho && azimuth == other.azimuth);
}

class CylindricalCoordinate {
  final double radius;
  final double azimuth;
  final double height;

  static const CylindricalCoordinate zero =
      CylindricalCoordinate(0.0, 0.0, 0.0);
  // static const CylindricalCoordinate MinValue = CylindricalCoordinate(.minValue, .minValue, .minValue);
  // static const CylindricalCoordinate MaxValue = CylindricalCoordinate(.maxValue, .maxValue, .maxValue);

  const CylindricalCoordinate(this.radius, this.azimuth, this.height);

  @override
  int get hashCode =>
      Hash.combine3(radius.hashCode, azimuth.hashCode, height.hashCode);

  bool almostEquals(CylindricalCoordinate x,
          [double tolerance = Constants.tolerance]) =>
      radius.almostEquals(x.radius, tolerance) &&
      azimuth.almostEquals(x.azimuth, tolerance) &&
      height.almostEquals(x.height, tolerance);
  CylindricalCoordinate setRadius(double x) =>
      CylindricalCoordinate(x, azimuth, height);
  CylindricalCoordinate setAzimuth(double x) =>
      CylindricalCoordinate(radius, x, height);
  CylindricalCoordinate setHeight(double x) =>
      CylindricalCoordinate(radius, azimuth, x);
  @override
  String toString() =>
      "CylindricalCoordinate(Radius = $radius, Azimuth = $azimuth, Height = $height)";

  @override
  bool operator ==(Object other) =>
      other is CylindricalCoordinate &&
      (radius == other.radius &&
          azimuth == other.azimuth &&
          height == other.height);
}

class HorizontalCoordinate implements Comparable<HorizontalCoordinate> {
  final double azimuth;
  final double inclination;

  static const int numComponents = 2;
  static const HorizontalCoordinate zero = HorizontalCoordinate.value(0.0);
  // static const HorizontalCoordinate minValue = HorizontalCoordinate(.minValue, .minValue);
  // static const HorizontalCoordinate maxValue = HorizontalCoordinate(.maxValue, .maxValue);
  static const HorizontalCoordinate one = HorizontalCoordinate.value(1.0);
  static const HorizontalCoordinate unitAzimuth =
      HorizontalCoordinate(1.0, 0.0);
  static const HorizontalCoordinate unitInclination =
      HorizontalCoordinate(0.0, 1.0);

  const HorizontalCoordinate(this.azimuth, this.inclination);
  const HorizontalCoordinate.value(double value) : this(value, value);

  bool get isNaN => azimuth.isNaN || inclination.isNaN;
  bool get isInfinite => azimuth.isInfinite || inclination.isInfinite;
  @override
  int get hashCode => Hash.combine(azimuth.hashCode, inclination.hashCode);

  bool almostEquals(HorizontalCoordinate x,
          [double tolerance = Constants.tolerance]) =>
      azimuth.almostEquals(x.azimuth, tolerance) &&
      inclination.almostEquals(x.inclination, tolerance);
  HorizontalCoordinate setAzimuth(double x) =>
      HorizontalCoordinate(x, inclination);
  HorizontalCoordinate setInclination(double x) =>
      HorizontalCoordinate(azimuth, x);
  double dot(HorizontalCoordinate value2) =>
      azimuth * value2.azimuth + inclination * value2.inclination;
  bool almostZero([double tolerance = Constants.tolerance]) =>
      azimuth.abs() < tolerance && inclination.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0.0;
  double minComponent() => (azimuth).min(inclination);
  double maxComponent() => (azimuth).max(inclination);
  double sumComponents() => (azimuth) + (inclination);
  double sumSqrComponents() => (azimuth).sqr() + (inclination).sqr();
  double productComponents() => (azimuth) * (inclination);
  double getComponent(int n) => n == 0 ? azimuth : inclination;
  double magnitudeSquared() => sumSqrComponents();
  double magnitude() => magnitudeSquared().sqrt();

  @override
  int compareTo(HorizontalCoordinate x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() =>
      "HorizontalCoordinate(Azimuth = $azimuth, Inclination = $inclination)";

  @override
  bool operator ==(Object other) =>
      other is HorizontalCoordinate &&
      (azimuth == other.azimuth && inclination == other.inclination);
  HorizontalCoordinate operator +(Object value2) =>
      value2 is HorizontalCoordinate
          ? HorizontalCoordinate(
              azimuth + value2.azimuth, inclination + value2.inclination)
          : value2 is num
              ? HorizontalCoordinate(azimuth + value2, inclination + value2)
              : throw UnsupportedError('operator + (${value2.runtimeType})');
  HorizontalCoordinate operator -(Object value2) =>
      value2 is HorizontalCoordinate
          ? HorizontalCoordinate(
              azimuth - value2.azimuth, inclination - value2.inclination)
          : value2 is num
              ? HorizontalCoordinate(azimuth - value2, inclination - value2)
              : throw UnsupportedError('operator - (${value2.runtimeType})');
  HorizontalCoordinate operator *(Object value2) =>
      value2 is HorizontalCoordinate
          ? HorizontalCoordinate(
              azimuth * value2.azimuth, inclination * value2.inclination)
          : value2 is num
              ? HorizontalCoordinate(azimuth * value2, inclination * value2)
              : throw UnsupportedError('operator * (${value2.runtimeType})');
  HorizontalCoordinate operator /(Object value2) =>
      value2 is HorizontalCoordinate
          ? HorizontalCoordinate(
              azimuth / value2.azimuth, inclination / value2.inclination)
          : value2 is num
              ? HorizontalCoordinate(azimuth / value2, inclination / value2)
              : throw UnsupportedError('operator / (${value2.runtimeType})');
  HorizontalCoordinate operator -() => zero - this;
  bool operator <(HorizontalCoordinate x1) => compareTo(x1) < 0;
  bool operator <=(HorizontalCoordinate x1) => compareTo(x1) <= 0;
  bool operator >(HorizontalCoordinate x1) => compareTo(x1) > 0;
  bool operator >=(HorizontalCoordinate x1) => compareTo(x1) >= 0;
}
