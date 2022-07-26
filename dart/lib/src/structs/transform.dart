part of '../../vim_math3d.dart';

class Transform {
  final Vector3 position;
  final Quaternion orientation;

  static const Transform zero = Transform(Vector3.zero, Quaternion.zero);
  static const Transform minValue =
      Transform(Vector3.minValue, Quaternion.minValue);
  static const Transform maxValue =
      Transform(Vector3.maxValue, Quaternion.maxValue);
  static const Transform identity =
      Transform(Vector3.zero, Quaternion.identity);

  const Transform(this.position, this.orientation);

  @override
  int get hashCode => Hash.combine(position.hashCode, orientation.hashCode);

  bool almostEquals(Transform x, [double tolerance = Constants.tolerance]) =>
      position.almostEquals(x.position, tolerance) &&
      orientation.almostEquals(x.orientation, tolerance);
  Transform setPosition(Vector3 x) => Transform(x, orientation);
  Transform setOrientation(Quaternion x) => Transform(position, x);

  Matrix4x4 toMatrix() => Matrix4x4.tRS(position, orientation, Vector3.one);

  @override
  String toString() =>
      "Transform(Position = $position, Orientation = $orientation)";

  @override
  bool operator ==(Object other) =>
      other is Transform &&
      (position == other.position && orientation == other.orientation);
}
