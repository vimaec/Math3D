part of '../../vim_math3d.dart';

/// A structure encapsulating a four-dimensional vector (x,y,z,w),
/// which is used to efficiently rotate an object about the (x,y,z) vector by the angle theta, where w = cos(theta/2).
class Quaternion {
  final double x;
  final double y;
  final double z;
  final double w;

  /// Returns a Quaternion representing no rotation.
  static const Quaternion identity = Quaternion(0.0, 0.0, 0.0, 1.0);
  static const Quaternion zero = Quaternion.value(0.0);
  static const Quaternion nan = Quaternion.value(double.nan);
  static const Quaternion minValue = Quaternion.value(-double.maxFinite);
  static const Quaternion maxValue = Quaternion.value(double.maxFinite);

  const Quaternion(this.x, this.y, this.z, this.w);
  const Quaternion.value(double v) : this(v, v, v, v);

  // Constructs a Quaternion from the given vector and rotation parts.
  Quaternion.fromVectorAndScalar(Vector3 vectorPart, double scalarPart)
      : this(vectorPart.x, vectorPart.y, vectorPart.z, scalarPart);
  factory Quaternion.fromHorizontalCoordinate(HorizontalCoordinate angle) =>
      Quaternion.fromZRotation(angle.azimuth) *
      Quaternion.fromXRotation(angle.inclination);
  // Creates a Quaternion from a normalized vector axis and an angle to rotate about the vector.
  factory Quaternion.fromAxisAndAngle(Vector3 axis, double angle) =>
      Quaternion.fromVectorAndScalar(
          axis * (angle * 0.5).sin(), (angle * 0.5).cos());
  // Creates a new Quaternion from the given rotation around X, Y, and Z
  factory Quaternion.fromEulerAngles(Vector3 v) {
    final c1 = (v.x / 2.0).cos();
    final s1 = (v.x / 2.0).sin();
    final c2 = (v.y / 2.0).cos();
    final s2 = (v.y / 2.0).sin();
    final c3 = (v.z / 2.0).cos();
    final s3 = (v.z / 2.0).sin();

    final qw = c1 * c2 * c3 - s1 * s2 * s3;
    final qx = s1 * c2 * c3 + c1 * s2 * s3;
    final qy = c1 * s2 * c3 - s1 * c2 * s3;
    final qz = c1 * c2 * s3 + s1 * s2 * c3;
    return Quaternion(qx, qy, qz, qw);
  }
  // Creates a new Quaternion from the given rotation around the X axis
  factory Quaternion.fromXRotation(double theta) =>
      Quaternion((theta * 0.5).sin(), 0.0, 0.0, (theta * 0.5).cos());
  // Creates a new Quaternion from the given rotation around the Y axis
  factory Quaternion.fromYRotation(double theta) =>
      Quaternion(0.0, (theta * 0.5).sin(), 0.0, (theta * 0.5).cos());
  // Creates a new Quaternion from the given rotation around the Z axis
  factory Quaternion.fromZRotation(double theta) =>
      Quaternion(0.0, 0.0, (theta * 0.5).sin(), (theta * 0.5).cos());
  // Creates a new look-at Quaternion
  factory Quaternion.lookAt(
      Vector3 position, Vector3 targetPosition, Vector3 up, Vector3 forward) {
    final plane = Plane.fromNormalAndPoint(up, position);
    final projectedTarget = Plane.projectPointOntoPlane(plane, targetPosition);
    final projectedDirection = (projectedTarget - position).normalize();
    final q1 = Quaternion.rotationFromAToB(forward, projectedDirection, up);
    final q2 = Quaternion.rotationFromAToB(
        projectedDirection, (targetPosition - position).normalize(), up);
    return q2 * q1;
  }

  /// Creates a new Quaternion rotating vector 'fromA' to 'toB'.<br
  /// Precondition: fromA and toB are normalized.
  factory Quaternion.rotationFromAToB(Vector3 fromA, Vector3 toB,
      [Vector3 up = Vector3.unitZ]) {
    final axis = fromA.cross(toB);
    final lengthSquared = axis.lengthSquared;
    // The vectors are parallel to each other
    // The vectors are in opposite directions so rotate by half a circle.
    // The vectors are in the same direction so no rotation is required.
    return lengthSquared > 0.0
        ? Quaternion.fromAxisAndAngle(
            axis / lengthSquared.sqrt(), fromA.dot(toB).acos())
        : (fromA + toB).almostZero()
            ? Quaternion.fromAxisAndAngle(up, Constants.pi)
            : identity;
  }

  /// Creates a new Quaternion from the given yaw, pitch, and roll, in radians.
  /// Roll first, about axis the object is facing, then
  /// pitch upward, then yaw to face into the new heading
  /// 1. Z(roll), 2. X (pitch), 3. Y (yaw)
  /// [yaw] The yaw angle, in radians, around the Y-axis.
  /// [pitch] The pitch angle, in radians, around the X-axis.
  /// [roll] The roll angle, in radians, around the Z-axis.
  factory Quaternion.fromYawPitchRoll(double yaw, double pitch, double roll) {
    final halfRoll = roll * 0.5;
    final sr = halfRoll.sin();
    final cr = halfRoll.cos();

    final halfPitch = pitch * 0.5;
    final sp = halfPitch.sin();
    final cp = halfPitch.cos();

    final halfYaw = yaw * 0.5;
    final sy = halfYaw.sin();
    final cy = halfYaw.cos();

    return Quaternion(cy * sp * cr + sy * cp * sr, sy * cp * cr - cy * sp * sr,
        cy * cp * sr - sy * sp * cr, cy * cp * cr + sy * sp * sr);
  }

  /// Creates a Quaternion from the given rotation matrix.
  factory Quaternion.fromRotationMatrix(Matrix4x4 matrix) {
    final trace = matrix.m11 + matrix.m22 + matrix.m33;
    if (trace > 0.0) {
      double s = (trace + 1.0).sqrt();
      final w = s * 0.5;
      s = 0.5 / s;
      return Quaternion((matrix.m23 - matrix.m32) * s,
          (matrix.m31 - matrix.m13) * s, (matrix.m12 - matrix.m21) * s, w);
    }
    if (matrix.m11 >= matrix.m22 && matrix.m11 >= matrix.m33) {
      final s = (1.0 + matrix.m11 - matrix.m22 - matrix.m33).sqrt();
      final invS = 0.5 / s;
      return Quaternion(0.5 * s, (matrix.m12 + matrix.m21) * invS,
          (matrix.m13 + matrix.m31) * invS, (matrix.m23 - matrix.m32) * invS);
    }
    if (matrix.m22 > matrix.m33) {
      final s = (1.0 + matrix.m22 - matrix.m11 - matrix.m33).sqrt();
      final invS = 0.5 / s;
      return Quaternion((matrix.m21 + matrix.m12) * invS, 0.5 * s,
          (matrix.m32 + matrix.m23) * invS, (matrix.m31 - matrix.m13) * invS);
    }
    {
      final s = (1.0 + matrix.m33 - matrix.m11 - matrix.m22).sqrt();
      final invS = 0.5 / s;
      return Quaternion(
          (matrix.m31 + matrix.m13) * invS,
          (matrix.m32 + matrix.m23) * invS,
          0.5 * s,
          (matrix.m12 - matrix.m21) * invS);
    }
  }
  // Interpolates between two quaternions, using spherical linear interpolation.
  factory Quaternion.slerp(Quaternion q1, Quaternion q2, double t) {
    const double epsilon = 1e-06;
    double cosOmega = q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w;
    bool flip = false;
    if (cosOmega < 0.0) {
      flip = true;
      cosOmega = -cosOmega;
    }
    double s1 = 0.0, s2 = 0.0;
    if (cosOmega > (1.0 - epsilon)) {
      // Too close, do straight linear interpolation.
      s1 = 1.0 - t;
      s2 = (flip) ? -t : t;
    } else {
      final omega = cosOmega.acos();
      final invSinOmega = 1.0 / omega.sin();

      s1 = ((1.0 - t) * omega).sin() * invSinOmega;
      s2 = (flip)
          ? -(t * omega).sin() * invSinOmega
          : (t * omega).sin() * invSinOmega;
    }
    return q1 * s1 + q2 * s2;
  }

  /// Linearly interpolates between two quaternions.
  /// (1.0f - 1)
  factory Quaternion.lerp(Quaternion q1, Quaternion q2, double t) =>
      (q1.dot(q2) >= 0.0
              ? (q1 * (1.0 - t) + q2 * t)
              : (q1 * (1.0 - t) - q2 * t))
          .normalize();

  /// Concatenates two Quaternions; the result represents the value1 rotation followed by the value2 rotation.
  factory Quaternion.concatenate(Quaternion value1, Quaternion value2) {
    // Concatenate rotation is actually q2 * q1 instead of q1 * q2.
    // So that's why value2 goes q1 and value1 goes q2.
    final q1x = value2.x;
    final q1y = value2.y;
    final q1z = value2.z;
    final q1w = value2.w;

    final q2x = value1.x;
    final q2y = value1.y;
    final q2z = value1.z;
    final q2w = value1.w;

    // cross(av, bv)
    final cx = q1y * q2z - q1z * q2y;
    final cy = q1z * q2x - q1x * q2z;
    final cz = q1x * q2y - q1y * q2x;

    final dot = q1x * q2x + q1y * q2y + q1z * q2z;

    return Quaternion(q1x * q2w + q2x * q1w + cx, q1y * q2w + q2y * q1w + cy,
        q1z * q2w + q2z * q1w + cz, q1w * q2w - dot);
  }

  // Returns whether the Quaternion is the identity Quaternion.
  bool get isIdentity => this == identity;

  /// Calculates the length of the Quaternion.
  double get length => lengthSquared.sqrt();

  /// Calculates the length squared of the Quaternion. This operation is cheaper than Length().
  double get lengthSquared => x * x + y * y + z * z + w * w;
  Vector4 get vector4 => Vector4(x, y, z, w);
  @override
  int get hashCode =>
      Hash.combine4(x.hashCode, y.hashCode, z.hashCode, w.hashCode);

  /// Divides each component of the Quaternion by the length of the Quaternion.
  Quaternion normalize() => this * length.inverse();

  /// Returns the conjugate of the quaternion
  Quaternion conjugate() => Quaternion(-x, -y, -z, w);

  /// Returns the inverse of a Quaternion.
  Quaternion inverse() => conjugate() * lengthSquared.inverse();

  /// Calculates the dot product of two Quaternions.
  double dot(Quaternion q2) => x * q2.x + y * q2.y + z * q2.z + w * q2.w;

  /// Returns Euler123 angles (rotate around, X, then Y, then Z).
  /// Returns:
  Vector3 toEulerAngles() {
    /*
    // https://stackoverflow.com/questions/5782658/extracting-yaw-from-a-quaternion
    // This should fit for intrinsic tait-bryan rotation of xyz-order.
    final yaw = (float)Math.Atan2(2.0 * (Y * Z + W * X), W * W - X * X - Y * Y + Z * Z);
    final pitch = (float)Math.Asin(-2.0 * (X * Z - W * Y));
    final roll = (float)Math.Atan2(2.0 * (X * Y + W * Z), W * W + X * X - Y * Y - Z * Z);
    */

    /*
    // https://community.monogame.net/t/solved-reverse-createfromyawpitchroll-or-how-to-get-the-vector-that-would-produce-the-matrix-given-only-the-matrix/9054/3
    final matrix = Matrix4x4.CreateFromQuaternion(this);
    final yaw = (float)System.Math.Atan2(matrix.M13, matrix.M33);
    final pitch = (float)System.Math.Asin(-matrix.M23);
    final roll = (float)System.Math.Atan2(matrix.M21, matrix.M22);
    */

    /*
    // https://stackoverflow.com/questions/11492299/quaternion-to-euler-angles-algorithm-how-to-convert-to-y-up-and-between-ha
    final yaw = (float)Math.Atan2(2f * q.X * q.W + 2f * q.Y * q.Z, 1 - 2f * (sqz + sqw));     // Yaw
    final pitch = (float)Math.Asin(2f * (q.X * q.Z - q.W * q.Y));                             // Pitch
    final roll = (float)Math.Atan2(2f * q.X * q.Y + 2f * q.Z * q.W, 1 - 2f * (sqy + sqz));      // Roll
    */

    /*
    //This is the code from  http://www.mawsoft.com/blog/?p=197
    final yaw = (float)Math.Atan2(2 * (W * X + Y * Z), 1 - 2 * (Math.Pow(X, 2) + Math.Pow(Y, 2)));
    final pitch = (float)Math.Asin(2 * (W * Y - Z * X));
    final roll = (float)Math.Atan2(2 * (W * Z + X * Y), 1 - 2 * (Math.Pow(Y, 2) + Math.Pow(Z, 2)));
    */

    //return new Vector3(pitch, yaw, roll);

    //https://www.gamedev.net/forums/topic/597324-quaternion-to-euler-angles-and-back-why-is-the-rotation-changing/
    final x1 = (-2.0 * (y * z - w * x)).atan2(w * w - x * x - y * y + z * z);
    final y1 = (2.0 * (x * z + w * y)).asin();
    final z1 = (-2.0 * (x * y - w * z)).atan2(w * w + x * x - y * y - z * z);
    return Vector3(x1, y1, z1);
  }

  bool almostEquals(Quaternion q, [double tolerance = Constants.tolerance]) =>
      x.almostEquals(q.x, tolerance) &&
      y.almostEquals(q.y, tolerance) &&
      z.almostEquals(q.z, tolerance) &&
      w.almostEquals(q.w, tolerance);
  Quaternion setX(double value) => Quaternion(value, y, z, w);
  Quaternion setY(double value) => Quaternion(x, value, z, w);
  Quaternion setZ(double value) => Quaternion(x, y, value, w);
  Quaternion setW(double value) => Quaternion(x, y, z, value);
  HorizontalCoordinate toSphericalAngle(
      [Vector3 forwardVector = Vector3.unitY]) {
    final newForward = forwardVector.transformByQuaternion(this);
    final forwardXY = Vector3(newForward.x, newForward.y, 0.0).normalize();
    final angle = forwardXY.y.acos();
    final azimuth = forwardXY.x < 0.0 ? angle : -angle;
    final inclination = -newForward.z.acos() + Constants.halfPi;
    return HorizontalCoordinate(azimuth, inclination);
  }

  // Returns a rotation matrix.
  Matrix4x4 toMatrix() => Matrix4x4.rotation(this);

  @override
  String toString() => "Quaternion(X = $x, Y = $y, Z = $z, W = $w)";

  @override
  bool operator ==(Object other) =>
      other is Quaternion &&
      (x == other.x && y == other.y && z == other.z && w == other.w);

  /// Flips the sign of each component of the quaternion.
  Quaternion operator -() => Quaternion(-x, -y, -z, -w);

  /// Adds two Quaternions element-by-element.
  Quaternion operator +(Quaternion value2) =>
      Quaternion(x + value2.x, y + value2.y, z + value2.z, w + value2.w);

  /// Subtracts one Quaternion from another.
  Quaternion operator -(Quaternion value2) =>
      Quaternion(x - value2.x, y - value2.y, z - value2.z, w - value2.w);
  // Multiplies two Quaternions together.
  // Multiplies a Quaternion by a scalar value.
  Quaternion operator *(Object v) {
    if (v is Quaternion) {
      // 9 muls, 27 adds
      final tmp_00 = (z - y) * (v.y - v.z);
      final tmp_01 = (w + x) * (v.w + v.x);
      final tmp_02 = (w - x) * (v.y + v.z);
      final tmp_03 = (y + z) * (v.w - v.x);
      final tmp_04 = (z - x) * (v.x - v.y);
      final tmp_05 = (z + x) * (v.x + v.y);
      final tmp_06 = (w + y) * (v.w - v.z);
      final tmp_07 = (w - y) * (v.w + v.z);
      final tmp_08 = tmp_05 + tmp_06 + tmp_07;
      final tmp_09 = (tmp_04 + tmp_08) * 0.5;

      return Quaternion(
        tmp_01 + tmp_09 - tmp_08,
        tmp_02 + tmp_09 - tmp_07,
        tmp_03 + tmp_09 - tmp_06,
        tmp_00 + tmp_09 - tmp_05,
      );
    } else if (v is num) {
      return Quaternion(x * v, y * v, z * v, w * v);
    } else {
      throw UnsupportedError('operator / (${v.runtimeType})');
    }
  }

  /// Divides a Quaternion by another Quaternion.
  Quaternion operator /(Quaternion value2) => this * value2.inverse();
}
