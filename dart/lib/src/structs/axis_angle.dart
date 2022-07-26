part of '../../vim_math3d.dart';

class AxisAngle {
  final Vector3 axis;
  final double angle;

  static const AxisAngle zero = AxisAngle(Vector3.zero, 0.0);
  static const AxisAngle minValue =
      AxisAngle(Vector3.minValue, -double.maxFinite);
  static const AxisAngle maxValue =
      AxisAngle(Vector3.maxValue, double.maxFinite);

  const AxisAngle(this.axis, this.angle);

  @override
  int get hashCode => Hash.combine(axis.hashCode, angle.hashCode);

  bool almostEquals(AxisAngle x, [double tolerance = Constants.tolerance]) =>
      axis.almostEquals(x.axis, tolerance) &&
      angle.almostEquals(x.angle, tolerance);
  AxisAngle setAxis(Vector3 x) => AxisAngle(x, angle);
  AxisAngle setAngle(double x) => AxisAngle(axis, x);

  @override
  String toString() => "AxisAngle(Axis = $axis, Angle = $angle)";

  @override
  bool operator ==(Object other) =>
      other is AxisAngle && (axis == other.axis && angle == other.angle);
}
