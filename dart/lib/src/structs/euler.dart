part of '../../vim_math3d.dart';

class Euler implements Comparable<Euler> {
  final double yaw;
  final double pitch;
  final double roll;

  static const int numComponents = 3;
  static const Euler zero = Euler.value(0.0);
  static const Euler minValue = Euler.value(-double.maxFinite);
  static const Euler maxValue = Euler.value(double.maxFinite);
  static const Euler one = Euler.value(1.0);
  static const Euler unitYaw = Euler(1.0, 0.0, 0.0);
  static const Euler unitPitch = Euler(0.0, 1.0, 0.0);
  static const Euler unitRoll = Euler(0.0, 0.0, 1.0);

  const Euler(this.yaw, this.pitch, this.roll);
  const Euler.value(double value) : this(value, value, value);

  bool get isNaN => yaw.isNaN || pitch.isNaN || roll.isNaN;
  bool get isInfinite => yaw.isInfinite || pitch.isInfinite || roll.isInfinite;
  @override
  int get hashCode =>
      Hash.combine3(yaw.hashCode, pitch.hashCode, roll.hashCode);

  bool almostEquals(Euler x, [double tolerance = Constants.tolerance]) =>
      yaw.almostEquals(x.yaw, tolerance) &&
      pitch.almostEquals(x.pitch, tolerance) &&
      roll.almostEquals(x.roll, tolerance);
  Euler setYaw(double x) => Euler(x, pitch, roll);
  Euler setPitch(double x) => Euler(yaw, x, roll);
  Euler setRoll(double x) => Euler(yaw, pitch, x);
  double dot(Euler value2) =>
      yaw * value2.yaw + pitch * value2.pitch + roll * value2.roll;
  bool almostZero([double tolerance = Constants.tolerance]) =>
      yaw.abs() < tolerance &&
      pitch.abs() < tolerance &&
      roll.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0.0;
  double minComponent() => (yaw).min(pitch).min(roll);
  double maxComponent() => (yaw).max(pitch).max(roll);
  double sumComponents() => (yaw) + (pitch) + (roll);
  double sumSqrComponents() => (yaw).sqr() + (pitch).sqr() + (roll).sqr();
  double productComponents() => (yaw) * (pitch) * (roll);
  double getComponent(int n) {
    if (n == 0) {
      return yaw;
    } else {
      return n == 1 ? pitch : roll;
    }
  }

  double magnitudeSquared() => sumSqrComponents();
  double magnitude() => magnitudeSquared().sqrt();

  @override
  int compareTo(Euler x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() => "Euler(Yaw = $yaw, Pitch = $pitch, Roll = $roll)";

  @override
  bool operator ==(Object other) =>
      other is Euler &&
      (yaw == other.yaw && pitch == other.pitch && roll == other.roll);
  Euler operator +(Object value2) => value2 is Euler
      ? Euler(yaw + value2.yaw, pitch + value2.pitch, roll + value2.roll)
      : value2 is num
          ? Euler(yaw + value2, pitch + value2, roll + value2)
          : throw UnsupportedError('operator + (${value2.runtimeType})');
  Euler operator -(Object value2) => value2 is Euler
      ? Euler(yaw - value2.yaw, pitch - value2.pitch, roll - value2.roll)
      : value2 is num
          ? Euler(yaw - value2, pitch - value2, roll - value2)
          : throw UnsupportedError('operator - (${value2.runtimeType})');
  Euler operator *(Object value2) => value2 is Euler
      ? Euler(yaw * value2.yaw, pitch * value2.pitch, roll * value2.roll)
      : value2 is num
          ? Euler(yaw * value2, pitch * value2, roll * value2)
          : throw UnsupportedError('operator * (${value2.runtimeType})');
  Euler operator /(Object value2) => value2 is Euler
      ? Euler(yaw / value2.yaw, pitch / value2.pitch, roll / value2.roll)
      : value2 is num
          ? Euler(yaw / value2, pitch / value2, roll / value2)
          : throw UnsupportedError('operator / (${value2.runtimeType})');
  Euler operator -() => zero - this;
  bool operator <(Euler x1) => compareTo(x1) < 0;
  bool operator <=(Euler x1) => compareTo(x1) <= 0;
  bool operator >(Euler x1) => compareTo(x1) > 0;
  bool operator >=(Euler x1) => compareTo(x1) >= 0;
}
