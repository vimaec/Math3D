part of '../../vim_math3d.dart';

class Plane implements ITransformable3D<Plane> {
  final Vector3 normal;
  final double d;

  static const Plane zero = Plane(Vector3.zero, 0.0);
  static const Plane minValue = Plane(Vector3.minValue, -double.maxFinite);
  static const Plane maxValue = Plane(Vector3.maxValue, double.maxFinite);

  const Plane(this.normal, this.d);
  Plane.fromVector(Vector4 v) : this(Vector3(v.x, v.y, v.z), v.w);
  Plane.values(double x, double y, double z, double d)
      : this(Vector3(x, y, z), d);

  /// Creates a Plane that contains the three given points.
  factory Plane.fromVertices(Vector3 point1, Vector3 point2, Vector3 point3) {
    final a = point2 - point1;
    final b = point3 - point1;
    final n = a.cross(b);
    final d = -n.normalize().dot(point1);
    return Plane(n.normalize(), d);
  }

  /// Creates a Plane with the given normal that contains the point
  factory Plane.fromNormalAndPoint(Vector3 normal, Vector3 point) {
    final n = normal.normalize();
    final d = n.dot(point);
    return Plane(n, d);
  }

  /// Creates a new Plane whose normal vector is the source Plane's normal vector normalized.
  /// [value] The source Plane.
  factory Plane.normalize(Plane value) {
    const fltEpsilon = 1.1920929E-07;
    // smallest such that 1.0+FLT_EPSILON != 1.0
    final normalLengthSquared = value.normal.lengthSquared;
    if ((normalLengthSquared - 1.0).abs() < fltEpsilon) {
      // It already normalized, so we don't need to farther process.
      return value;
    }
    final normalLength = normalLengthSquared.sqrt();
    return Plane(value.normal / normalLength, value.d / normalLength);
  }

  @override
  int get hashCode => Hash.combine(normal.hashCode, d.hashCode);

  /// Transforms a normalized Plane by a Quaternion rotation.
  Plane transformByQuaternion(Quaternion rotation) {
    // Compute rotation matrix.
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

    final m11 = 1.0 - yy2 - zz2;
    final m21 = xy2 - wz2;
    final m31 = xz2 + wy2;

    final m12 = xy2 + wz2;
    final m22 = 1.0 - xx2 - zz2;
    final m32 = yz2 - wx2;

    final m13 = xz2 - wy2;
    final m23 = yz2 + wx2;
    final m33 = 1.0 - xx2 - yy2;

    final x = normal.x, y = normal.y, z = normal.z;

    return Plane.values(x * m11 + y * m21 + z * m31,
        x * m12 + y * m22 + z * m32, x * m13 + y * m23 + z * m33, d);
  }

  /// Projects a point onto the plane
  static Vector3 projectPointOntoPlane(Plane plane, Vector3 point) {
    final dist = point.dot(plane.normal) - plane.d;
    return point - plane.normal * dist;
  }

  /// Calculates the dot product of a Plane and Vector4.
  double dot(Vector4 value) => toVector4().dot(value);

  /// Returns the dot product of a specified Vector3 and the normal vector of this Plane plus the distance (D) value of the Plane.
  static double dotCoordinate(Plane plane, Vector3 value) =>
      plane.normal.dot(value) + plane.d;

  /// Returns the dot product of a specified Vector3 and the Normal vector of this Plane.
  static double dotNormal(Plane plane, Vector3 value) =>
      plane.normal.dot(value);

  /// Returns a value less than zero if the points is below the plane, above zero if above the plane, or zero if coplanar
  /// [point]
  double classifyPoint(Vector3 point) => point.dot(normal) + d;
  bool almostEquals(Plane x, [double tolerance = Constants.tolerance]) =>
      normal.almostEquals(x.normal, tolerance) &&
      d.almostEquals(x.d, tolerance);
  Plane setNormal(Vector3 x) => Plane(x, d);
  Plane setD(double x) => Plane(normal, x);

  // Returns a Vector4 representation of the Plane
  Vector4 toVector4() => Vector4(normal.x, normal.y, normal.z, d);

  /// Transforms a normalized Plane by a Matrix.
  @override
  Plane transform(Matrix4x4 matrix) {
    //Matrix4x4.nan
    var m = Matrix4x4.invert(matrix);
    if (m == Matrix4x4.nan) {
      m = Matrix4x4.identity;
    }
    final x = normal.x, y = normal.y, z = normal.z, w = d;
    return Plane.values(
        x * m.m11 + y * m.m12 + z * m.m13 + w * m.m14,
        x * m.m21 + y * m.m22 + z * m.m23 + w * m.m24,
        x * m.m31 + y * m.m32 + z * m.m33 + w * m.m34,
        x * m.m41 + y * m.m42 + z * m.m43 + w * m.m44);
  }

  @override
  String toString() => "Plane(Normal = $normal, D = $d)";

  @override
  bool operator ==(Object other) =>
      other is Plane && (normal == other.normal && d == other.d);
}
