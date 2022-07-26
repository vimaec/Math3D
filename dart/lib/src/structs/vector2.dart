part of '../../vim_math3d.dart';

class Vector2 implements Comparable<Vector2>, ITransformable3D<Vector2> {
  final double x;
  final double y;

  static const int numComponents = 2;
  static const Vector2 zero = Vector2.value(0.0);
  static const Vector2 minValue = Vector2.value(-double.maxFinite);
  static const Vector2 maxValue = Vector2.value(double.maxFinite);
  static const Vector2 one = Vector2.value(1.0);
  static const Vector2 unitX = Vector2(1.0, 0.0);
  static const Vector2 unitY = Vector2(0.0, 1.0);

  const Vector2(this.x, this.y);
  const Vector2.value(double value) : this(value, value);

  bool get isNaN => x.isNaN || y.isNaN;
  bool get isInfinite => x.isInfinite || y.isInfinite;
  @override
  int get hashCode => Hash.combine(x.hashCode, y.hashCode);

  double pointCrossProduct(Vector2 other) => x * other.y - other.x * y;
  // Computes the cross product of two vectors.
  double cross(Vector2 v2) => x * v2.y - y * v2.x;
  bool almostEquals(Vector2 v, [double tolerance = Constants.tolerance]) =>
      x.almostEquals(v.x, tolerance) && y.almostEquals(v.y, tolerance);
  Vector2 setX(double value) => Vector2(value, y);
  Vector2 setY(double value) => Vector2(x, value);
  bool almostZero([double tolerance = Constants.tolerance]) =>
      x.abs() < tolerance && y.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0.0;
  double minComponent() => (x).min(y);
  double maxComponent() => (x).max(y);
  double sumComponents() => (x) + (y);
  double sumSqrComponents() => (x).sqr() + (y).sqr();
  double productComponents() => (x) * (y);
  double getComponent(int n) => n == 0 ? x : y;
  double magnitudeSquared() => sumSqrComponents();
  double magnitude() => magnitudeSquared().sqrt();

  // Returns the reflection of a vector off a surface that has the specified normal.
  // this - (2 * (this.dot(normal) * normal));
  Vector2 reflect(Vector2 normal) => this - ((normal * dot(normal)) * 2);

  /// <summary>
  /// Transforms a vector by the given Quaternion rotation value.
  /// </summary>
  Vector4 transformToVector4ByQuaternion(Quaternion rotation) {
    final x2 = rotation.x + rotation.x;
    final y2 = rotation.y + rotation.y;
    final z2 = rotation.z + rotation.z;

    final wx2 = rotation.w * x2;
    final wy2 = rotation.w * y2;
    final wz2 = rotation.w * z2;
    final xx2 = rotation.x * x2;
    final xy2 = rotation.x * y2;
    final xz2 = rotation.x * z2;
    final yy2 = rotation.y * y2;
    final yz2 = rotation.y * z2;
    final zz2 = rotation.z * z2;

    return Vector4(
        x * (1.0 - yy2 - zz2) + y * (xy2 - wz2),
        x * (xy2 + wz2) + y * (1.0 - xx2 - zz2),
        x * (xz2 - wy2) + y * (yz2 + wx2),
        1.0);
  }

  /// <summary>
  /// Transforms a vector by the given matrix.
  /// </summary>
  Vector4 transformToVector4(Matrix4x4 matrix) => Vector4(
      x * matrix.m11 + y * matrix.m21 + matrix.m41,
      x * matrix.m12 + y * matrix.m22 + matrix.m42,
      x * matrix.m13 + y * matrix.m23 + matrix.m43,
      x * matrix.m14 + y * matrix.m24 + matrix.m44);
  static Vector2 transformNormal(Vector2 normal, Matrix4x4 matrix) => Vector2(
        normal.x * matrix.m11 + normal.y * matrix.m21,
        normal.x * matrix.m12 + normal.y * matrix.m22,
      );
  Vector2 transformByQuaternion(Quaternion rotation) {
    final x2 = rotation.x + rotation.x;
    final y2 = rotation.y + rotation.y;
    final z2 = rotation.z + rotation.z;

    final wz2 = rotation.w * z2;
    final xx2 = rotation.x * x2;
    final xy2 = rotation.x * y2;
    final yy2 = rotation.y * y2;
    final zz2 = rotation.z * z2;

    return Vector2(x * (1.0 - yy2 - zz2) + y * (xy2 - wz2),
        x * (xy2 + wz2) + y * (1.0 - xx2 - zz2));
  }
  Vector4 toVector4() => Vector4(x, y, 0.0, 0.0);
  Vector3 toVector3() => Vector3(x, y, 0.0);

  @override
  String toString() => "Vector2(X = $x, Y = $y)";
  @override
  int compareTo(Vector2 other) =>
      (magnitudeSquared() - other.magnitudeSquared()).sign.toInt();
  @override
  Vector2 transform(Matrix4x4 mat) => Vector2(
        x * mat.m11 + y * mat.m21 + mat.m41,
        x * mat.m12 + y * mat.m22 + mat.m42,
      );

  @override
  bool operator ==(Object other) =>
      other is Vector2 && (x == other.x && y == other.y);
  Vector2 operator -() => zero - this;
  Vector2 operator +(Object v) => v is Vector2
      ? Vector2(x + v.x, y + v.y)
      : v is num
          ? Vector2(x + v, y + v)
          : throw UnsupportedError('operator + (${v.runtimeType})');
  Vector2 operator -(Object v) => v is Vector2
      ? Vector2(x - v.x, y - v.y)
      : v is num
          ? Vector2(x - v, y - v)
          : throw UnsupportedError('operator - (${v.runtimeType})');
  Vector2 operator *(Object v) => v is Vector2
      ? Vector2(x * v.x, y * v.y)
      : v is num
          ? Vector2(x * v, y * v)
          : throw UnsupportedError('operator * (${v.runtimeType})');
  Vector2 operator /(Object v) => v is Vector2
      ? Vector2(x / v.x, y / v.y)
      : v is num
          ? Vector2(x / v, y / v)
          : throw UnsupportedError('operator / (${v.runtimeType})');
  bool operator <(Vector2 x1) => compareTo(x1) < 0;
  bool operator <=(Vector2 x1) => compareTo(x1) <= 0;
  bool operator >(Vector2 x1) => compareTo(x1) > 0;
  bool operator >=(Vector2 x1) => compareTo(x1) >= 0;
}

extension Vector2MathOps on Vector2 {
  double get length => lengthSquared.sqrt();
  double get lengthSquared => sumSqrComponents();

  Vector2 lerp(Vector2 v2, double t) => this + (v2 - this) * t;
  Vector2 inverseLerp(Vector2 a, Vector2 b) => (this - a) / (b - a);
  //((1 - t) * this) + (v2 * t);
  Vector2 lerpPrecise(Vector2 v2, double t) => (this * (1 - t)) + (v2 * t);
  Vector2 clampLower(Vector2 min) => max(min);
  Vector2 clampUpper(Vector2 max) => min(max);
  Vector2 clamp(Vector2 min, Vector2 max) => this.min(max).max(min);
  Vector2 average(Vector2 v2) => lerp(v2, 0.5);
  Vector2 barycentric(Vector2 v2, Vector2 v3, double u, double v) =>
      this + (v2 - this) * u + (v3 - this) * v;

  double distanceSquared(Vector2 v2) => (this - v2).lengthSquared;
  double distance(Vector2 v2) => (this - v2).length;
  Vector2 normalize() => this / length;
  Vector2 safeNormalize() {
    var v = this;
    final l = v.length;
    if (l != 0.0) {
      v = v / l;
    }
    return v;
  }

  double dot(Vector2 v2) => x * v2.x + y * v2.y;
  Vector2 min(Vector2 v2) => Vector2(x.min(v2.x), y.min(v2.y));
  Vector2 max(Vector2 v2) => Vector2(x.max(v2.x), y.max(v2.y));
  Vector2 squareRoot() => sqrt();

  Vector2 add(Vector2 v2) => this + v2;
  Vector2 subtract(Vector2 v2) => this - v2;
  Vector2 multiply(Vector2 v2) => this * v2;
  Vector2 divide(Vector2 v2) => this / v2;
  Vector2 negate() => -this;

  Vector2 abs() => Vector2(x.abs(), y.abs());
  Vector2 acos() => Vector2(x.acos(), y.acos());
  Vector2 asin() => Vector2(x.asin(), y.asin());
  Vector2 atan() => Vector2(x.atan(), y.atan());
  Vector2 cos() => Vector2(x.cos(), y.cos());
  Vector2 cosh() => Vector2(x.cosh(), y.cosh());
  Vector2 exp() => Vector2(x.exp(), y.exp());
  Vector2 log() => Vector2(x.log(), y.log());
  Vector2 log10() => Vector2(x.log10(), y.log10());
  Vector2 sin() => Vector2(x.sin(), y.sin());
  Vector2 sinh() => Vector2(x.sinh(), y.sinh());
  Vector2 sqrt() => Vector2(x.sqrt(), y.sqrt());
  Vector2 tan() => Vector2(x.tan(), y.tan());
  Vector2 tanh() => Vector2(x.tanh(), y.tanh());

  Vector2 inverse() => Vector2(x.inverse(), y.inverse());
  Vector2 ceiling() => Vector2(x.ceiling(), y.ceiling());
  Vector2 floor() => Vector2(x.floorToDouble(), y.floorToDouble());
  Vector2 round() => Vector2(x.roundToDouble(), y.roundToDouble());
  Vector2 truncate() => Vector2(x.truncateToDouble(), y.truncateToDouble());
  Vector2 toRadians() => Vector2(x.toRadians(), y.toRadians());
  Vector2 toDegrees() => Vector2(x.toDegrees(), y.toDegrees());
  Vector2 sqr() => Vector2(x.sqr(), y.sqr());
  Vector2 cube() => Vector2(x.cube(), y.cube());
}

extension Vector2MathOptsStats on Stats<Vector2> {
  Vector2 average() => sum / count;
  Vector2 extents() => max - min;
  Vector2 middle() => extents() / 2.0 + min;
  AABox toBox() => AABox(min.toVector3(), max.toVector3());
}

extension Vector2MathOptsIterable on Iterable<Vector2> {
  Vector2 sum() => stats().sum;
  Vector2 average() => stats().average();
  Vector2 min() => stats().min;
  Vector2 max() => stats().max;
  Vector2 extents() => stats().extents();
  Vector2 middle() => stats().middle();
  Stats<Vector2> stats() {
    var a = const Stats<Vector2>(0, Vector2.zero, Vector2.zero, Vector2.zero);
    for (var b in this) {
      a = Stats<Vector2>(a.count + 1, b.min(a.min), b.max(a.max), a.sum + b);
    }
    return a;
  }
}
