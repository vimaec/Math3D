part of '../../vim_math3d.dart';

// A structure encapsulating a 3D Plane
class Interval implements Comparable<Interval> {
  final double min;
  final double max;

  static const Interval zero = Interval.value(0.0);
  static const Interval minValue = Interval.value(-double.maxFinite);
  static const Interval maxValue = Interval.value(double.maxFinite);
  static const Interval empty = Interval(double.maxFinite, -double.maxFinite);

  const Interval(this.min, this.max);
  const Interval.value(double value) : this(value, value);

  double get extent => (max - min);
  double get center => min.average(max);
  bool get isNaN => min.isNaN || max.isNaN;
  bool get isInfinite => min.isInfinite || max.isInfinite;
  @override
  int get hashCode => Hash.combine(min.hashCode, max.hashCode);

  bool almostEquals(Interval x, [double tolerance = Constants.tolerance]) =>
      min.almostEquals(x.min, tolerance) && max.almostEquals(x.max, tolerance);
  Interval setMin(double x) => Interval(x, max);
  Interval setMax(double x) => Interval(min, x);
  double magnitudeSquared() => extent.magnitudeSquared();
  double magnitude() => magnitudeSquared().sqrt();
  Interval merge(Interval other) =>
      Interval(min.min(other.min), max.max(other.max));
  Interval intersection(Interval other) =>
      Interval(min.max(other.min), max.min(other.max));
  Interval mergeValue(double other) => Interval(min.min(other), max.max(other));

  @override
  int compareTo(Interval x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() => "Interval(Min = $min, Max = $max)";

  @override
  bool operator ==(Object other) =>
      other is Interval && (min == other.min && max == other.max);
  Interval operator -(Interval value2) => intersection(value2);
  Interval operator +(Object value2) => value2 is Interval
      ? merge(value2)
      : value2 is num
          ? mergeValue(value2.toDouble())
          : throw UnsupportedError('operator + (${value2.runtimeType})');
  bool operator <(Interval x1) => compareTo(x1) < 0;
  bool operator <=(Interval x1) => compareTo(x1) <= 0;
  bool operator >(Interval x1) => compareTo(x1) > 0;
  bool operator >=(Interval x1) => compareTo(x1) >= 0;
}
