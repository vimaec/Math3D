part of '../../vim_math3d.dart';

class Vector4 implements Comparable<Vector4>, ITransformable3D<Vector4> {
  final double x;
  final double y;
  final double z;
  final double w;

  static const int numComponents = 4;
  static const Vector4 zero = Vector4.value(0.0);
  static const Vector4 minValue = Vector4.value(-double.maxFinite);
  static const Vector4 maxValue = Vector4.value(double.maxFinite);
  static const Vector4 one = Vector4.value(1.0);
  static const Vector4 unitX = Vector4(1.0, 0.0, 0.0, 0.0);
  static const Vector4 unitY = Vector4(0.0, 1.0, 0.0, 0.0);
  static const Vector4 unitZ = Vector4(0.0, 0.0, 1.0, 0.0);
  static const Vector4 unitW = Vector4(0.0, 0.0, 0.0, 1.0);

  Vector3 get xYZ => Vector3(x, y, z);
  Vector2 get xY => Vector2(x, y);

  const Vector4(this.x, this.y, this.z, this.w);
  const Vector4.value(double value) : this(value, value, value, value);
  Vector4.fromVector2(Vector2 xy, double z, double w) : this(xy.x, xy.y, z, w);
  Vector4.fromVector3(Vector3 xyz, double w) : this(xyz.x, xyz.y, xyz.z, w);

  bool get isNaN => x.isNaN || y.isNaN || z.isNaN || w.isNaN;
  bool get isInfinite =>
      x.isInfinite || y.isInfinite || z.isInfinite || w.isInfinite;
  @override
  int get hashCode =>
      Hash.combine4(x.hashCode, y.hashCode, z.hashCode, w.hashCode);

  bool almostEquals(Vector4 v, [double tolerance = Constants.tolerance]) =>
      x.almostEquals(v.x, tolerance) &&
      y.almostEquals(v.y, tolerance) &&
      z.almostEquals(v.z, tolerance) &&
      w.almostEquals(v.w, tolerance);
  Vector4 setX(double value) => Vector4(value, y, z, w);
  Vector4 setY(double value) => Vector4(x, value, z, w);
  Vector4 setZ(double value) => Vector4(x, y, value, w);
  Vector4 setW(double value) => Vector4(x, y, z, value);

  //double dot(Vector4 value) => Vector4.dot(this, value);
  bool almostZero([double tolerance = Constants.tolerance]) =>
      x.abs() < tolerance &&
      y.abs() < tolerance &&
      z.abs() < tolerance &&
      w.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0.0;
  double minComponent() => (x).min(y).min(z).min(w);
  double maxComponent() => (x).max(y).max(z).max(w);
  double sumComponents() => (x) + (y) + (z) + (w);
  double sumSqrComponents() => (x).sqr() + (y).sqr() + (z).sqr() + (w).sqr();
  double productComponents() => (x) * (y) * (z) * (w);
  double getComponent(int n) {
    if (n == 0) {
      return x;
    } else {
      if (n == 1) {
        return y;
      } else {
        return n == 2 ? z : w;
      }
    }
  }

  double magnitudeSquared() => sumSqrComponents();
  double magnitude() => magnitudeSquared().sqrt();

  /// <summary>
  /// Transforms a vector normal by the given matrix.
  /// </summary>
  static Vector4 transformNormal(Vector4 normal, Matrix4x4 matrix) => Vector4(
      normal.x * matrix.m11 +
          normal.y * matrix.m21 +
          normal.z * matrix.m31 +
          normal.w * matrix.m41,
      normal.x * matrix.m12 +
          normal.y * matrix.m22 +
          normal.z * matrix.m32 +
          normal.w * matrix.m42,
      normal.x * matrix.m13 +
          normal.y * matrix.m23 +
          normal.z * matrix.m33 +
          normal.w * matrix.m43,
      normal.x * matrix.m14 +
          normal.y * matrix.m24 +
          normal.z * matrix.m34 +
          normal.w * matrix.m44);

  /// Transforms a vector by the given Quaternion rotation value.
  Vector4 transformByQuaternion(Quaternion rotation) {
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
        x * (1.0 - yy2 - zz2) + y * (xy2 - wz2) + z * (xz2 + wy2),
        x * (xy2 + wz2) + y * (1.0 - xx2 - zz2) + z * (yz2 - wx2),
        x * (xz2 - wy2) + y * (yz2 + wx2) + z * (1.0 - xx2 - yy2),
        w);
  }

  Vector3 toVector3() => Vector3(x, y, z);
  Vector2 toVector2() => Vector2(x, y);

  /// Transforms a vector by the given matrix.
  @override
  Vector4 transform(Matrix4x4 matrix) => Vector4(
      x * matrix.m11 + y * matrix.m21 + z * matrix.m31 + w * matrix.m41,
      x * matrix.m12 + y * matrix.m22 + z * matrix.m32 + w * matrix.m42,
      x * matrix.m13 + y * matrix.m23 + z * matrix.m33 + w * matrix.m43,
      x * matrix.m14 + y * matrix.m24 + z * matrix.m34 + w * matrix.m44);
  @override
  int compareTo(Vector4 x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() => "Vector4(X = $x, Y = $y, Z = $z, W = $w)";

  @override
  bool operator ==(Object other) =>
      other is Vector4 &&
      (x == other.x && y == other.y && z == other.z && w == other.w);
  Vector4 operator -() => zero - this;
  Vector4 operator +(Object v) => v is Vector4
      ? Vector4(x + v.x, y + v.y, z + v.z, w + v.w)
      : v is num
          ? Vector4(x + v, y + v, z + v, w + v)
          : throw UnsupportedError('operator + (${v.runtimeType})');
  Vector4 operator -(Object v) => v is Vector4
      ? Vector4(x - v.x, y - v.y, z - v.z, w - v.w)
      : v is num
          ? Vector4(x - v, y - v, z - v, w - v)
          : throw UnsupportedError('operator - (${v.runtimeType})');
  Vector4 operator *(Object v) => v is Vector4
      ? Vector4(x * v.x, y * v.y, z * v.z, w * v.w)
      : v is num
          ? Vector4(x * v, y * v, z * v, w * v)
          : throw UnsupportedError('operator * (${v.runtimeType})');
  Vector4 operator /(Object v) => v is Vector4
      ? Vector4(x / v.x, y / v.y, z / v.z, w / v.w)
      : v is num
          ? Vector4(x / v, y / v, z / v, w / v)
          : throw UnsupportedError('operator / (${v.runtimeType})');
  bool operator <(Vector4 x1) => compareTo(x1) < 0;
  bool operator <=(Vector4 x1) => compareTo(x1) <= 0;
  bool operator >(Vector4 x1) => compareTo(x1) > 0;
  bool operator >=(Vector4 x1) => compareTo(x1) >= 0;
}

extension Vector4MathOps on Vector4 {
  double get length => lengthSquared.sqrt();
  double get lengthSquared => sumSqrComponents();

  Vector4 lerp(Vector4 v2, double t) => this + (v2 - this) * t;
  Vector4 inverseLerp(Vector4 a, Vector4 b) => (this - a) / (b - a);
  //((1 - t) * this) + (v2 * t);
  Vector4 lerpPrecise(Vector4 v2, double t) => (this * (1 - t)) + (v2 * t);
  Vector4 clampLower(Vector4 min) => max(min);
  Vector4 clampUpper(Vector4 max) => min(max);
  Vector4 clamp(Vector4 min, Vector4 max) => this.min(max).max(min);
  Vector4 average(Vector4 v2) => lerp(v2, 0.5);
  Vector4 barycentric(Vector4 v2, Vector4 v3, double u, double v) =>
      this + (v2 - this) * u + (v3 - this) * v;

  double distanceSquared(Vector4 v2) => (this - v2).lengthSquared;
  double distance(Vector4 v2) => (this - v2).length;
  Vector4 normalize() => this / length;
  Vector4 safeNormalize() {
    var v = this;
    final l = v.length;
    if (l != 0.0) {
      v = v / l;
    }
    return v;
  }

  double dot(Vector4 v2) => x * v2.x + y * v2.y + z * v2.z + w * v2.w;
  Vector4 min(Vector4 v) =>
      Vector4(x.min(v.x), y.min(v.y), z.min(v.z), w.min(v.w));
  Vector4 max(Vector4 v2) =>
      Vector4(x.max(v2.x), y.max(v2.y), z.max(v2.z), w.max(v2.w));
  Vector4 squareRoot() => sqrt();

  Vector4 add(Vector4 v2) => this + v2;
  Vector4 subtract(Vector4 v2) => this - v2;
  Vector4 multiply(Vector4 v2) => this * v2;
  Vector4 divide(Vector4 v2) => this / v2;
  Vector4 negate() => -this;

  Vector4 abs() => Vector4(x.abs(), y.abs(), z.abs(), w.abs());
  Vector4 acos() => Vector4(x.acos(), y.acos(), z.acos(), w.acos());
  Vector4 asin() => Vector4(x.asin(), y.asin(), z.asin(), w.asin());
  Vector4 atan() => Vector4(x.atan(), y.atan(), z.atan(), w.atan());
  Vector4 cos() => Vector4(x.cos(), y.cos(), z.cos(), w.cos());
  Vector4 cosh() => Vector4(x.cosh(), y.cosh(), z.cosh(), w.cosh());
  Vector4 exp() => Vector4(x.exp(), y.exp(), z.exp(), w.exp());
  Vector4 log() => Vector4(x.log(), y.log(), z.log(), w.log());
  Vector4 log10() => Vector4(x.log10(), y.log10(), z.log10(), w.log10());
  Vector4 sin() => Vector4(x.sin(), y.sin(), z.sin(), w.sin());
  Vector4 sinh() => Vector4(x.sinh(), y.sinh(), z.sinh(), w.sinh());
  Vector4 sqrt() => Vector4(x.sqrt(), y.sqrt(), z.sqrt(), w.sqrt());
  Vector4 tan() => Vector4(x.tan(), y.tan(), z.tan(), w.tan());
  Vector4 tanh() => Vector4(x.tanh(), y.tanh(), z.tanh(), w.tanh());

  Vector4 inverse() =>
      Vector4(x.inverse(), y.inverse(), z.inverse(), w.inverse());
  Vector4 ceiling() =>
      Vector4(x.ceiling(), y.ceiling(), z.ceiling(), w.ceiling());
  Vector4 floor() => Vector4(x.floorToDouble(), y.floorToDouble(),
      z.floorToDouble(), w.floorToDouble());
  Vector4 round() => Vector4(x.roundToDouble(), y.roundToDouble(),
      z.roundToDouble(), w.roundToDouble());
  Vector4 truncate() => Vector4(x.truncateToDouble(), y.truncateToDouble(),
      z.truncateToDouble(), w.truncateToDouble());
  Vector4 toRadians() =>
      Vector4(x.toRadians(), y.toRadians(), z.toRadians(), w.toRadians());
  Vector4 toDegrees() =>
      Vector4(x.toDegrees(), y.toDegrees(), z.toDegrees(), w.toDegrees());
  Vector4 sqr() => Vector4(x.sqr(), y.sqr(), z.sqr(), w.sqr());
  Vector4 cube() => Vector4(x.cube(), y.cube(), z.cube(), w.cube());
}

extension Vector4MathOptsStats on Stats<Vector4> {
  Vector4 average() => sum / count;
  Vector4 extents() => max - min;
  Vector4 middle() => extents() / 2.0 + min;
  AABox toBox() => AABox(min.toVector3(), max.toVector3());
}

extension Vector4MathOptsIterable on Iterable<Vector4> {
  Vector4 sum() => stats().sum;
  Vector4 average() => stats().average();
  Vector4 min() => stats().min;
  Vector4 max() => stats().max;
  Vector4 extents() => stats().extents();
  Vector4 middle() => stats().middle();
  Stats<Vector4> stats() {
    var a = const Stats<Vector4>(0, Vector4.zero, Vector4.zero, Vector4.zero);
    for (var b in this) {
      a = Stats<Vector4>(a.count + 1, b.min(a.min), b.max(a.max), a.sum + b);
    }
    return a;
  }
}
