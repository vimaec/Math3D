part of '../../vim_math3d.dart';

class Vector3 implements Comparable<Vector3>, ITransformable3D<Vector3> {
  final double x;
  final double y;
  final double z;

  static const int numComponents = 3;
  static const Vector3 zero = Vector3.value(0.0);
  static const Vector3 minValue = Vector3.value(-double.maxFinite);
  static const Vector3 maxValue = Vector3.value(double.maxFinite);
  static const Vector3 one = Vector3.value(1.0);
  static const Vector3 unitX = Vector3(1.0, 0.0, 0.0);
  static const Vector3 unitY = Vector3(0.0, 1.0, 0.0);
  static const Vector3 unitZ = Vector3(0.0, 0.0, 1.0);

  Vector2 get xY => Vector2(x, y);
  Vector2 get xZ => Vector2(x, z);
  Vector2 get yZ => Vector2(y, z);
  Vector3 get xZY => Vector3(x, z, y);
  Vector3 get zXY => Vector3(z, x, y);
  Vector3 get zYX => Vector3(z, y, z);
  Vector3 get yXZ => Vector3(y, x, z);
  Vector3 get yZX => Vector3(y, z, x);

  const Vector3(this.x, this.y, [this.z = 0]);
  const Vector3.value(double value) : this(value, value, value);
  Vector3.fromVector2(Vector2 xy, double z) : this(xy.x, xy.y, z);

  bool get isNaN => x.isNaN || y.isNaN || z.isNaN;
  bool get isInfinite => x.isInfinite || y.isInfinite || z.isInfinite;
  @override
  int get hashCode => Hash.combine3(x.hashCode, y.hashCode, z.hashCode);

  /// Computes the cross product of two vectors.
  Vector3 cross(Vector3 vector2) => Vector3(y * vector2.z - z * vector2.y,
      z * vector2.x - x * vector2.z, x * vector2.y - y * vector2.x);

  /// Returns the mixed product
  double mixedProduct(Vector3 v1, Vector3 v2) => cross(v1).dot(v2);

  /// Returns the reflection of a vector off a surface that has the specified normal.
  //this - (2 * (this.dot(normal) * normal));
  Vector3 reflect(Vector3 normal) => this - normal * dot(normal) * 2.0;

  /// Transforms a vector normal by the given matrix.
  Vector3 transformNormal(Matrix4x4 matrix) => Vector3(
      x * matrix.m11 + y * matrix.m21 + z * matrix.m31,
      x * matrix.m12 + y * matrix.m22 + z * matrix.m32,
      x * matrix.m13 + y * matrix.m23 + z * matrix.m33);
  Vector3 clampBox(AABox box) => clamp(box.min, box.max);
  bool almostEquals(Vector3 v, [double tolerance = Constants.tolerance]) =>
      x.almostEquals(v.x, tolerance) &&
      y.almostEquals(v.y, tolerance) &&
      z.almostEquals(v.z, tolerance);
  Vector3 setX(double value) => Vector3(value, y, z);
  Vector3 setY(double value) => Vector3(x, value, z);
  Vector3 setZ(double value) => Vector3(x, y, value);
  bool almostZero([double tolerance = Constants.tolerance]) =>
      x.abs() < tolerance && y.abs() < tolerance && z.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0.0;
  double minComponent() => (x).min(y).min(z);
  double maxComponent() => (x).max(y).max(z);
  double sumComponents() => (x) + (y) + (z);
  double sumSqrComponents() => (x).sqr() + (y).sqr() + (z).sqr();
  double productComponents() => (x) * (y) * (z);
  double getComponent(int n) {
    if (n == 0) {
      return x;
    } else {
      return n == 1 ? y : z;
    }
  }

  double magnitudeSquared() => sumSqrComponents();
  double magnitude() => magnitudeSquared().sqrt();

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
        x * (1.0 - yy2 - zz2) + y * (xy2 - wz2) + z * (xz2 + wy2),
        x * (xy2 + wz2) + y * (1.0 - xx2 - zz2) + z * (yz2 - wx2),
        x * (xz2 - wy2) + y * (yz2 + wx2) + z * (1.0 - xx2 - yy2),
        1.0);
  }

  /// <summary>
  /// Transforms a vector by the given matrix.
  /// </summary>
  Vector4 transformToVector4(Matrix4x4 m) => Vector4(
      x * m.m11 + y * m.m21 + z * m.m31 + m.m41,
      x * m.m12 + y * m.m22 + z * m.m32 + m.m42,
      x * m.m13 + y * m.m23 + z * m.m33 + m.m43,
      x * m.m14 + y * m.m24 + z * m.m34 + m.m44);

  /// Returns true if the four points are co-planar.
  bool coplanar(Vector3 v2, Vector3 v3, Vector3 v4,
          [double epsilon = Constants.tolerance]) =>
      ((v3 - this).dot((v2 - this).cross(v4 - this))).abs() < epsilon;
  // The smaller of the two possible angles between the two vectors is returned, therefore the result will never be greater than 180 degrees or smaller than -180 degrees.
  // If you imagine the from and to vectors as lines on a piece of paper, both originating from the same point, then the /axis/ vector would point up out of the paper.
  // The measured angle between the two vectors would be positive in a clockwise direction and negative in an anti-clockwise direction.
  double signedAngleByAxis(Vector3 to, Vector3 axis) =>
      angle(to) * ((axis.dot(cross(to))).sign);
  Vector3 rotate(Vector3 axis, double angle) =>
      transform(Matrix4x4.fromAxisAndAngle(axis, angle));
  bool isNonZeroAndValid() => lengthSquared.isNonZeroAndValid();
  bool isZeroOrInvalid() => !isNonZeroAndValid();
// If either vector is vector(0,0,0) the vectors are not perpendicular
  bool isPerpendicular(Vector3 v2, [double tolerance = Constants.tolerance]) =>
      this != Vector3.zero &&
      v2 != Vector3.zero &&
      dot(v2).almostZero(tolerance);
  Vector3 projection(Vector3 v2) => v2 * (dot(v2) / v2.lengthSquared);
  Vector3 rejection(Vector3 v2) => this - projection(v2);
  // The smaller of the two possible angles between the two vectors is returned, therefore the result will never be greater than 180 degrees or smaller than -180 degrees.
  // If you imagine the from and to vectors as lines on a piece of paper, both originating from the same point, then the /axis/ vector would point up out of the paper.
  // The measured angle between the two vectors would be positive in a clockwise direction and negative in an anti-clockwise direction.
  double signedAngle(Vector3 to) => signedAngleByAxis(to, Vector3.unitZ);
  double angle(Vector3 v2, [double tolerance = Constants.tolerance]) {
    final d = lengthSquared * v2.lengthSquared.sqrt();
    if (d < tolerance) {
      return 0.0;
    }
    return (dot(v2) / d).clamp(-1.0, 1.0).acos();
  }

  bool colinear(Vector3 v2, [double tolerance = Constants.tolerance]) =>
      !isNaN && !v2.isNaN && signedAngle(v2) <= tolerance;
  bool isBackFace(Vector3 lineOfSight) => dot(lineOfSight) < 0.0;

  /// Creates a new [Vector3] that contains CatmullRom interpolation of the specified vectors.
  Vector3 catmullRom(Vector3 v2, Vector3 v3, Vector3 v4, double amount) =>
      Vector3(
          x.catmullRom(v2.x, v3.x, v4.x, amount),
          y.catmullRom(v2.y, v3.y, v4.y, amount),
          z.catmullRom(v2.z, v3.z, v4.z, amount));

  /// Creates a new [Vector3] that contains hermite spline interpolation.
  Vector3 hermite(Vector3 tan1, Vector3 v2, Vector3 tan2, double amount) =>
      Vector3(
          x.hermite(tan1.x, v2.x, tan2.x, amount),
          y.hermite(tan1.y, v2.y, tan2.y, amount),
          z.hermite(tan1.z, v2.z, tan2.z, amount));

  /// Creates a new [Vector3] that contains cubic interpolation of the specified vectors.
  Vector3 smoothStep(Vector3 v2, double amount) => Vector3(
      x.smoothStep(v2.x, amount),
      y.smoothStep(v2.y, amount),
      z.smoothStep(v2.z, amount));
  Vector3 along(double d) => normalize() * d;

  /// Transforms a vector by the given Quaternion rotation value.
  Vector3 transformByQuaternion(Quaternion rotation) {
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

    return Vector3(
        x * (1.0 - yy2 - zz2) + y * (xy2 - wz2) + z * (xz2 + wy2),
        x * (xy2 + wz2) + y * (1.0 - xx2 - zz2) + z * (yz2 - wx2),
        x * (xz2 - wy2) + y * (yz2 + wx2) + z * (1.0 - xx2 - yy2));
  }

  Vector4 toVector4() => Vector4(x, y, z, 0.0);
  Vector2 toVector2() => Vector2(x, y);
  Matrix4x4 toMatrix() => Matrix4x4.translation(this);
  Line toLine() => Line(Vector3.zero, this);

  /// Transforms a vector by the given matrix.
  @override
  Vector3 transform(Matrix4x4 matrix) => Vector3(
      x * matrix.m11 + y * matrix.m21 + z * matrix.m31 + matrix.m41,
      x * matrix.m12 + y * matrix.m22 + z * matrix.m32 + matrix.m42,
      x * matrix.m13 + y * matrix.m23 + z * matrix.m33 + matrix.m43);
  @override
  int compareTo(Vector3 x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() => "Vector3(X = $x, Y = $y, Z = $z)";

  @override
  bool operator ==(Object other) =>
      other is Vector3 && (x == other.x && y == other.y && z == other.z);
  Vector3 operator -() => zero - this;
  Vector3 operator +(Object v) => v is Vector3
      ? Vector3(x + v.x, y + v.y, z + v.z)
      : v is num
          ? Vector3(x + v, y + v, z + v)
          : throw UnsupportedError('operator + (${v.runtimeType})');
  Vector3 operator -(Object v) => v is Vector3
      ? Vector3(x - v.x, y - v.y, z - v.z)
      : v is num
          ? Vector3(x - v, y - v, z - v)
          : throw UnsupportedError('operator - (${v.runtimeType})');
  Vector3 operator *(Object v) => v is Vector3
      ? Vector3(x * v.x, y * v.y, z * v.z)
      : v is num
          ? Vector3(x * v, y * v, z * v)
          : throw UnsupportedError('operator * (${v.runtimeType})');
  Vector3 operator /(Object v) => v is Vector3
      ? Vector3(x / v.x, y / v.y, z / v.z)
      : v is num
          ? Vector3(x / v, y / v, z / v)
          : throw UnsupportedError('operator / (${v.runtimeType})');
  bool operator <(Vector3 x1) => compareTo(x1) < 0;
  bool operator <=(Vector3 x1) => compareTo(x1) <= 0;
  bool operator >(Vector3 x1) => compareTo(x1) > 0;
  bool operator >=(Vector3 x1) => compareTo(x1) >= 0;
}

extension Vector3MathOps on Vector3 {
  double get length => lengthSquared.sqrt();
  double get lengthSquared => sumSqrComponents();

  Vector3 lerp(Vector3 v2, double t) => this + (v2 - this) * t;
  Vector3 inverseLerp(Vector3 a, Vector3 b) => (this - a) / (b - a);
  //((1 - t) * this) + (v2 * t);
  Vector3 lerpPrecise(Vector3 v2, double t) => (this * (1 - t)) + (v2 * t);
  Vector3 clampLower(Vector3 min) => max(min);
  Vector3 clampUpper(Vector3 max) => min(max);
  Vector3 clamp(Vector3 min, Vector3 max) => this.min(max).max(min);
  Vector3 average(Vector3 v2) => lerp(v2, 0.5);
  Vector3 barycentric(Vector3 v2, Vector3 v3, double u, double v) =>
      this + (v2 - this) * u + (v3 - this) * v;

  double distanceSquared(Vector3 v2) => (this - v2).lengthSquared;
  double distance(Vector3 v2) => (this - v2).length;
  Vector3 normalize() => this / length;
  Vector3 safeNormalize() {
    var v = this;
    final l = v.length;
    if (l != 0.0) {
      v = v / l;
    }
    return v;
  }

  double dot(Vector3 v2) => x * v2.x + y * v2.y + z * v2.z;
  Vector3 min(Vector3 v) => Vector3(x.min(v.x), y.min(v.y), z.min(v.z));
  Vector3 max(Vector3 v2) => Vector3(x.max(v2.x), y.max(v2.y), z.max(v2.z));
  Vector3 squareRoot() => sqrt();

  Vector3 add(Vector3 v2) => this + v2;
  Vector3 subtract(Vector3 v2) => this - v2;
  Vector3 multiply(Vector3 v2) => this * v2;
  Vector3 divide(Vector3 v2) => this / v2;
  Vector3 negate() => -this;

  Vector3 abs() => Vector3(x.abs(), y.abs(), z.abs());
  Vector3 acos() => Vector3(x.acos(), y.acos(), z.acos());
  Vector3 asin() => Vector3(x.asin(), y.asin(), z.asin());
  Vector3 atan() => Vector3(x.atan(), y.atan(), z.atan());
  Vector3 cos() => Vector3(x.cos(), y.cos(), z.cos());
  Vector3 cosh() => Vector3(x.cosh(), y.cosh(), z.cosh());
  Vector3 exp() => Vector3(x.exp(), y.exp(), z.exp());
  Vector3 log() => Vector3(x.log(), y.log(), z.log());
  Vector3 log10() => Vector3(x.log10(), y.log10(), z.log10());
  Vector3 sin() => Vector3(x.sin(), y.sin(), z.sin());
  Vector3 sinh() => Vector3(x.sinh(), y.sinh(), z.sinh());
  Vector3 sqrt() => Vector3(x.sqrt(), y.sqrt(), z.sqrt());
  Vector3 tan() => Vector3(x.tan(), y.tan(), z.tan());
  Vector3 tanh() => Vector3(x.tanh(), y.tanh(), z.tanh());

  Vector3 inverse() => Vector3(x.inverse(), y.inverse(), z.inverse());
  Vector3 ceiling() => Vector3(x.ceiling(), y.ceiling(), z.ceiling());
  Vector3 floor() =>
      Vector3(x.floorToDouble(), y.floorToDouble(), z.floorToDouble());
  Vector3 round() =>
      Vector3(x.roundToDouble(), y.roundToDouble(), z.roundToDouble());
  Vector3 truncate() =>
      Vector3(x.truncateToDouble(), y.truncateToDouble(), z.truncateToDouble());
  Vector3 toRadians() => Vector3(x.toRadians(), y.toRadians(), z.toRadians());
  Vector3 toDegrees() => Vector3(x.toDegrees(), y.toDegrees(), z.toDegrees());
  Vector3 sqr() => Vector3(x.sqr(), y.sqr(), z.sqr());
  Vector3 cube() => Vector3(x.cube(), y.cube(), z.cube());
}

extension Vector3MathOptsStats on Stats<Vector3> {
  Vector3 average() => sum / count;
  Vector3 extents() => max - min;
  Vector3 middle() => extents() / 2.0 + min;
  AABox toBox() => AABox(min, max);
}

extension Vector3MathOptsIterable on Iterable<Vector3> {
  Vector3 sum() => stats().sum;
  Vector3 average() => stats().average();
  Vector3 min() => stats().min;
  Vector3 max() => stats().max;
  Vector3 extents() => stats().extents();
  Vector3 middle() => stats().middle();
  AABox toBox() => AABox.points(this);
  Stats<Vector3> stats() {
    var a = const Stats<Vector3>(0, Vector3.zero, Vector3.zero, Vector3.zero);
    for (var b in this) {
      a = Stats<Vector3>(a.count + 1, b.min(a.min), b.max(a.max), a.sum + b);
    }
    return a;
  }
}
