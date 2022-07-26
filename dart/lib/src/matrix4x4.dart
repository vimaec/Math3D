// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information
part of '../vim_math3d.dart';

/// A structure encapsulating a 4x4 matrix.
class Matrix4x4 implements ITransformable3D<Matrix4x4> {
  // Value at row 1, column 1 of the matrix.
  final double m11;
  // Value at row 1, column 2 of the matrix.
  final double m12;
  // Value at row 1, column 3 of the matrix.
  final double m13;
  // Value at row 1, column 4 of the matrix.
  final double m14;
  // Value at row 2, column 1 of the matrix.
  final double m21;
  // Value at row 2, column 2 of the matrix.
  final double m22;
  // Value at row 2, column 3 of the matrix.
  final double m23;
  // Value at row 2, column 4 of the matrix.
  final double m24;
  // Value at row 3, column 1 of the matrix.
  final double m31;
  // Value at row 3, column 2 of the matrix.
  final double m32;
  // Value at row 3, column 3 of the matrix.
  final double m33;
  // Value at row 3, column 4 of the matrix.
  final double m34;
  // Value at row 4, column 1 of the matrix.
  final double m41;
  // Value at row 4, column 2 of the matrix.
  final double m42;
  // Value at row 4, column 3 of the matrix.
  final double m43;
  // Value at row 4, column 4 of the matrix.
  final double m44;

  // Returns the multiplicative identity matrix.
  static const Matrix4x4 identity = Matrix4x4(1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0,
      0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0);
  static const Matrix4x4 zero = Matrix4x4(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  static const Matrix4x4 nan = Matrix4x4(
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan,
      double.nan);

  Vector3 get col0 => Vector3(m11, m21, m31);
  Vector3 get col1 => Vector3(m12, m22, m32);
  Vector3 get col2 => Vector3(m13, m23, m33);
  Vector3 get col3 => Vector3(m14, m24, m34);

  Vector3 get row0 => Vector3(m11, m12, m13);
  Vector3 get row1 => Vector3(m21, m22, m23);
  Vector3 get row2 => Vector3(m31, m32, m33);
  Vector3 get row3 => Vector3(m41, m42, m43);

  // Returns whether the matrix is the identity matrix.
  bool get isIdentity =>
      m11 == 1.0 &&
      m22 == 1.0 &&
      m33 == 1.0 &&
      m44 == 1.0 &&
      m12 == 0.0 &&
      m13 == 0.0 &&
      m14 == 0.0 &&
      m21 == 0.0 &&
      m23 == 0.0 &&
      m24 == 0.0 &&
      m31 == 0.0 &&
      m32 == 0.0 &&
      m34 == 0.0 &&
      m41 == 0.0 &&
      m42 == 0.0 &&
      m43 == 0.0;
  bool get isNaN =>
      m11.isNaN &&
      m22.isNaN &&
      m33.isNaN &&
      m44.isNaN &&
      m12.isNaN &&
      m13.isNaN &&
      m14.isNaN &&
      m21.isNaN &&
      m23.isNaN &&
      m24.isNaN &&
      m31.isNaN &&
      m32.isNaN &&
      m34.isNaN &&
      m41.isNaN &&
      m42.isNaN &&
      m43.isNaN;
  // Gets the translation component of this matrix.
  Vector3 get translation => Vector3(m41, m42, m43);

  /// Returns true if the 3x3 rotation determinant of the matrix is less than 0. This assumes the matrix represents
  /// an affine transform.
  // From: https://math.stackexchange.com/a/1064759
  // "If your matrix is the augmented matrix representing an affine transformation in 3D, then yes,
  // the proper thing to do to see if it switches orientation is checking the sign of the top 3×3 determinant.
  // This is easy to see: if your transformation is Ax+b, then the +b part is a translation and does not
  // affect orientation, and x->Ax switches orientation iff detA < 0."
  bool get isReflection => get3x3RotationDeterminant() < 0.0;
  @override
  int get hashCode => Hash.hashCodes([
        m11,
        m12,
        m13,
        m14,
        m21,
        m22,
        m23,
        m24,
        m31,
        m32,
        m33,
        m34,
        m41,
        m42,
        m43,
        m44
      ]);

  /// Constructs a Matrix4x4 from the given components.
  const Matrix4x4(
    this.m11,
    this.m12,
    this.m13,
    this.m14,
    this.m21,
    this.m22,
    this.m23,
    this.m24,
    this.m31,
    this.m32,
    this.m33,
    this.m34,
    this.m41,
    this.m42,
    this.m43,
    this.m44,
  );
  Matrix4x4.fromList(List<double> m)
      : this(m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8], m[9], m[10],
            m[11], m[12], m[13], m[14], m[15]);
  factory Matrix4x4.fromVector3Rows(Vector3 row0, Vector3 row1, Vector3 row2,
          [Vector3? row3]) =>
      row3 != null
          ? Matrix4x4.fromVector4Rows(row0.toVector4(), row1.toVector4(),
              row2.toVector4(), Vector4(row3.x, row3.y, row3.z, 1))
          : Matrix4x4.fromVector4Rows(row0.toVector4(), row1.toVector4(),
              row2.toVector4(), const Vector4(0, 0, 0, 1));
  factory Matrix4x4.fromVector4Rows(Vector4 row0, Vector4 row1, Vector4 row2,
          [Vector4? row3]) =>
      row3 != null
          ? Matrix4x4(
              row0.x,
              row0.y,
              row0.z,
              row0.w,
              row1.x,
              row1.y,
              row1.z,
              row1.w,
              row2.x,
              row2.y,
              row2.z,
              row2.w,
              row3.x,
              row3.y,
              row3.z,
              row3.w)
          : Matrix4x4.fromVector3Rows(row0.toVector3(), row1.toVector3(),
              row2.toVector3(), Vector3.zero);
  // Creates a spherical billboard that rotates around a specified object position.
  factory Matrix4x4.billboard(Vector3 objectPosition, Vector3 cameraPosition,
      Vector3 cameraUpVector, Vector3 cameraForwardVector) {
    double epsilon = 0.0001;
    var zaxis = Vector3(
        objectPosition.x - cameraPosition.x,
        objectPosition.y - cameraPosition.y,
        objectPosition.z - cameraPosition.z);
    final norm = zaxis.lengthSquared;
    if (norm < epsilon) {
      zaxis = -cameraForwardVector;
    } else {
      zaxis = zaxis * (1.0 / norm.sqrt());
    }
    final xaxis = cameraUpVector.cross(zaxis).normalize();
    final yaxis = zaxis.cross(xaxis);
    return Matrix4x4(
        xaxis.x,
        xaxis.y,
        xaxis.z,
        0.0,
        yaxis.x,
        yaxis.y,
        yaxis.z,
        0.0,
        zaxis.x,
        zaxis.y,
        zaxis.z,
        0.0,
        objectPosition.x,
        objectPosition.y,
        objectPosition.z,
        1.0);
  }

  /// Creates a cylindrical billboard that rotates around a specified axis.
  factory Matrix4x4.constrainedBillboard(
      Vector3 objectPosition,
      Vector3 cameraPosition,
      Vector3 rotateAxis,
      Vector3 cameraForwardVector,
      Vector3 objectForwardVector) {
    const epsilon = 0.0001;
    const minAngle = 1.0 - (0.1 * (Constants.pi / 180.0));
    // 0.1 degrees
    // Treat the case when object and camera positions are too close.
    var faceDir = Vector3(
        objectPosition.x - cameraPosition.x,
        objectPosition.y - cameraPosition.y,
        objectPosition.z - cameraPosition.z);
    final norm = faceDir.lengthSquared;
    faceDir =
        norm < epsilon ? -cameraForwardVector : faceDir * 1.0 / norm.sqrt();

    final yaxis = rotateAxis;
    Vector3 xaxis;
    Vector3 zaxis;
    // Treat the case when angle between faceDir and rotateAxis is too close to 0.
    var dot = rotateAxis.dot(faceDir);
    if (dot.abs() > minAngle) {
      zaxis = objectForwardVector;
      // Make sure passed values are useful for compute.
      dot = rotateAxis.dot(zaxis);
      if (dot.abs() > minAngle) {
        zaxis = (rotateAxis.z.abs() > minAngle)
            ? const Vector3(1.0, 0.0, 0.0)
            : const Vector3(0.0, 0.0, -1);
      }
      xaxis = rotateAxis.cross(zaxis).normalize();
      zaxis = xaxis.cross(rotateAxis).normalize();
    } else {
      xaxis = rotateAxis.cross(faceDir).normalize();
      zaxis = xaxis.cross(yaxis).normalize();
    }

    return Matrix4x4(
        xaxis.x,
        xaxis.y,
        xaxis.z,
        0.0,
        yaxis.x,
        yaxis.y,
        yaxis.z,
        0.0,
        zaxis.x,
        zaxis.y,
        zaxis.z,
        0.0,
        objectPosition.x,
        objectPosition.y,
        objectPosition.z,
        1.0);
  }

  /// Creates a translation matrix.
  /// [position] The amount to translate in each axis.
  /// Returns: The translation matrix.
  Matrix4x4.translation(Vector3 position)
      : this(1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0,
            position.x, position.y, position.z, 1.0);

  /// Creates a translation matrix.
  Matrix4x4.translationXyz(double x, double y, double z)
      : this.translation(Vector3(x, y, z));

  /// Creates a scaling matrix.
  /// [xScale] Value to scale by on the X-axis.
  /// [yScale] Value to scale by on the Y-axis.
  /// [zScale] Value to scale by on the Z-axis.
  /// Returns: The scaling matrix.
  Matrix4x4.scaleXyz(double xScale, double yScale, double zScale)
      : this(
          xScale,
          0.0,
          0.0,
          0.0,
          0.0,
          yScale,
          0.0,
          0.0,
          0.0,
          0.0,
          zScale,
          0.0,
          0.0,
          0.0,
          0.0,
          1.0,
        );

  /// Creates a scaling matrix with a center point.
  /// [xScale] Value to scale by on the X-axis.
  /// [yScale] Value to scale by on the Y-axis.
  /// [zScale] Value to scale by on the Z-axis.
  /// [centerPoint] The center point.
  /// Returns: The scaling matrix.
  Matrix4x4.scaleXyzByCenterPoint(
      double xScale, double yScale, double zScale, Vector3 centerPoint)
      : this(
            xScale,
            0.0,
            0.0,
            0.0,
            0.0,
            yScale,
            0.0,
            0.0,
            0.0,
            0.0,
            zScale,
            0.0,
            centerPoint.x * (1.0 - xScale),
            centerPoint.y * (1.0 - yScale),
            centerPoint.z * (1.0 - zScale),
            1.0);

  /// Creates a scaling matrix.
  /// [scales] The vector containing the amount to scale by on each axis.
  /// Returns: The scaling matrix.
  Matrix4x4.scaleVector3(Vector3 scales)
      : this.scaleXyz(scales.x, scales.y, scales.z);

  /// Creates a scaling matrix with a center point.
  Matrix4x4.scaleVector3ByCenterPoint(Vector3 scales, Vector3 centerPoint)
      : this.scaleXyzByCenterPoint(scales.x, scales.y, scales.z, centerPoint);

  /// Creates a uniform scaling matrix that scales equally on each axis.
  /// [scale] The uniform scaling factor.
  /// Returns: The scaling matrix.
  Matrix4x4.scale(double scale) : this.scaleXyz(scale, scale, scale);

  /// Creates a uniform scaling matrix that scales equally on each axis with a center point.
  /// [scale] The uniform scaling factor.
  /// [centerPoint] The center point.
  /// Returns: The scaling matrix.
  Matrix4x4.scaleByCenterPoint(double scale, Vector3 centerPoint)
      : this.scaleXyzByCenterPoint(scale, scale, scale, centerPoint);

  /// Creates a matrix for rotating points around the X-axis.
  factory Matrix4x4.rotationX(double radians) {
    final c = radians.cos();
    final s = radians.sin();
    // [  1  0  0  0 ]
    // [  0  c  s  0 ]
    // [  0 -s  c  0 ]
    // [  0  0  0  1 ]
    return Matrix4x4(1.0, 0.0, 0.0, 0.0, 0.0, c, s, 0.0, 0.0, -s, c, 0.0, 0.0,
        0.0, 0.0, 1.0);
  }

  /// Creates a matrix for rotating points around the X-axis, from a center point.
  /// [radians] The amount, in radians, by which to rotate around the X-axis.
  /// [centerPoint] The center point.
  /// Returns: The rotation matrix.
  factory Matrix4x4.rotationXByCenterPoint(
      double radians, Vector3 centerPoint) {
    final c = radians.cos();
    final s = radians.sin();

    final y = centerPoint.y * (1.0 - c) + centerPoint.z * s;
    final z = centerPoint.z * (1.0 - c) - centerPoint.y * s;

    // [  1  0  0  0 ]
    // [  0  c  s  0 ]
    // [  0 -s  c  0 ]
    // [  0  y  z  1 ]
    return Matrix4x4(
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      c,
      s,
      0.0,
      0.0,
      -s,
      c,
      0.0,
      0.0,
      y,
      z,
      1.0,
    );
  }

  /// Creates a matrix for rotating points around the Y-axis.
  /// [radians] The amount, in radians, by which to rotate around the Y-axis.
  /// Returns: The rotation matrix.
  factory Matrix4x4.rotationY(double radians) {
    final c = radians.cos();
    final s = radians.sin();

    // [  c  0 -s  0 ]
    // [  0  1  0  0 ]
    // [  s  0  c  0 ]
    // [  0  0  0  1 ]
    return Matrix4x4(c, 0.0, -s, 0.0, 0.0, 1.0, 0.0, 0.0, s, 0.0, c, 0.0, 0.0,
        0.0, 0.0, 1.0);
  }

  /// Creates a matrix for rotating points around the Y-axis, from a center point.
  /// [radians] The amount, in radians, by which to rotate around the Y-axis.
  /// [centerPoint] The center point.
  /// Returns: The rotation matrix.
  factory Matrix4x4.rotationYByCenterPoint(
      double radians, Vector3 centerPoint) {
    final c = radians.cos();
    final s = radians.sin();

    final x = centerPoint.x * (1.0 - c) - centerPoint.z * s;
    final z = centerPoint.z * (1.0 - c) + centerPoint.x * s;
    // [  c  0 -s  0 ]
    // [  0  1  0  0 ]
    // [  s  0  c  0 ]
    // [  x  0  z  1 ]
    return Matrix4x4(
        c, 0.0, -s, 0.0, 0.0, 1.0, 0.0, 0.0, s, 0.0, c, 0.0, x, 0.0, z, 1.0);
  }

  /// Creates a matrix for rotating points around the Z-axis.
  /// [radians] The amount, in radians, by which to rotate around the Z-axis.
  /// Returns: The rotation matrix.
  factory Matrix4x4.rotationZ(double radians) {
    final c = radians.cos();
    final s = radians.sin();

    // [  c  s  0  0 ]
    // [ -s  c  0  0 ]
    // [  0  0  1  0 ]
    // [  0  0  0  1 ]
    return Matrix4x4(c, s, 0.0, 0.0, -s, c, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0);
  }

  /// Creates a matrix for rotating points around the Z-axis, from a center point.
  /// [radians] The amount, in radians, by which to rotate around the Z-axis.
  /// [centerPoint] The center point.
  /// Returns: The rotation matrix.
  factory Matrix4x4.rotationZByCenterPoint(
      double radians, Vector3 centerPoint) {
    final c = radians.cos();
    final s = radians.sin();
    final x = centerPoint.x * (1.0 - c) + centerPoint.y * s;
    final y = centerPoint.y * (1.0 - c) - centerPoint.x * s;
    // [  c  s  0  0 ]
    // [ -s  c  0  0 ]
    // [  0  0  1  0 ]
    // [  x  y  0  1 ]
    return Matrix4x4(
        c, s, 0.0, 0.0, -s, c, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, x, y, 0.0, 1.0);
  }

  /// Creates a matrix that rotates around an arbitrary vector.
  /// [axis] The axis to rotate around.
  /// [angle] The angle to rotate around the given axis, in radians.
  /// Returns: The rotation matrix.
  factory Matrix4x4.fromAxisAndAngle(Vector3 axis, double angle) {
    // a: angle
    // x, y, z: unit vector for axis.
    //
    // Rotation matrix M can compute by using below equation.
    //
    //        T               T
    //  M = uu + (cos a)( I-uu ) + (sin a)S
    //
    // Where:
    //
    //  u = ( x, y, z )
    //
    //      [  0 -z  y ]
    //  S = [  z  0 -x ]
    //      [ -y  x  0 ]
    //
    //      [ 1 0 0 ]
    //  I = [ 0 1 0 ]
    //      [ 0 0 1 ]
    //
    //
    //     [  xx+cosa*(1-xx)   yx-cosa*yx-sina*z zx-cosa*xz+sina*y ]
    // M = [ xy-cosa*yx+sina*z    yy+cosa(1-yy)  yz-cosa*yz-sina*x ]
    //     [ zx-cosa*zx-sina*y zy-cosa*zy+sina*x   zz+cosa*(1-zz)  ]
    //
    double x = axis.x, y = axis.y, z = axis.z;
    double sa = angle.sin(), ca = angle.cos();
    double xx = x * x, yy = y * y, zz = z * z;
    double xy = x * y, xz = x * z, yz = y * z;

    return Matrix4x4(
        xx + ca * (1.0 - xx),
        xy - ca * xy + sa * z,
        xz - ca * xz - sa * y,
        0.0,
        xy - ca * xy - sa * z,
        yy + ca * (1.0 - yy),
        yz - ca * yz + sa * x,
        0.0,
        xz - ca * xz + sa * y,
        yz - ca * yz - sa * x,
        zz + ca * (1.0 - zz),
        0.0,
        0.0,
        0.0,
        0.0,
        1.0);
  }

  /// Creates a perspective projection matrix based on a field of view, aspect ratio, and near and far view plane distances.
  /// [fieldOfView] Field of view in the y direction, in radians.
  /// [aspectRatio] Aspect ratio, defined as view space width divided by height.
  /// [nearPlaneDistance] Distance to the near view plane.
  /// [farPlaneDistance] Distance to the far view plane.
  /// Returns: The perspective projection matrix.
  factory Matrix4x4.perspectiveFieldOfView(double fieldOfView,
      double aspectRatio, double nearPlaneDistance, double farPlaneDistance) {
    if (fieldOfView <= 0.0 || fieldOfView >= Constants.pi) {
      throw RangeError.value(fieldOfView, 'fieldOfView');
    }
    if (nearPlaneDistance <= 0.0) {
      throw RangeError.value(nearPlaneDistance, 'nearPlaneDistance');
    }
    if (farPlaneDistance <= 0.0) {
      throw RangeError.value(farPlaneDistance, 'farPlaneDistance');
    }
    if (nearPlaneDistance >= farPlaneDistance) {
      throw RangeError.value(nearPlaneDistance, 'nearPlaneDistance');
    }

    final yScale = 1.0 / (fieldOfView * 0.5).tan();
    final xScale = yScale / aspectRatio;

    final isPositiveInfinity =
        farPlaneDistance.isInfinite && !farPlaneDistance.isNegative;
    final negFarRange = isPositiveInfinity
        ? -1.0
        : farPlaneDistance / (nearPlaneDistance - farPlaneDistance);

    return Matrix4x4(xScale, 0.0, 0.0, 0.0, 0.0, yScale, 0.0, 0.0, 0.0, 0.0,
        negFarRange, -1.0, 0.0, 0.0, nearPlaneDistance * negFarRange, 0.0);
  }

  /// Creates a perspective projection matrix from the given view volume dimensions.
  /// [width] Width of the view volume at the near view plane.
  /// [height] Height of the view volume at the near view plane.
  /// [nearPlaneDistance] Distance to the near view plane.
  /// [farPlaneDistance] Distance to the far view plane.
  /// Returns: The perspective projection matrix.
  factory Matrix4x4.perspective(double width, double height,
      double nearPlaneDistance, double farPlaneDistance) {
    if (nearPlaneDistance <= 0.0) {
      throw RangeError.value(nearPlaneDistance, 'nearPlaneDistance');
    }
    if (farPlaneDistance <= 0.0) {
      throw RangeError.value(farPlaneDistance, 'farPlaneDistance');
    }
    if (nearPlaneDistance >= farPlaneDistance) {
      throw RangeError.value(nearPlaneDistance, 'nearPlaneDistance');
    }

    final isPositiveInfinity =
        farPlaneDistance.isInfinite && !farPlaneDistance.isNegative;
    final negFarRange = isPositiveInfinity
        ? -1.0
        : farPlaneDistance / (nearPlaneDistance - farPlaneDistance);

    return Matrix4x4(
      2.0 * nearPlaneDistance / width,
      0.0,
      0.0,
      0.0,

      0.0,
      2.0 * nearPlaneDistance / height,
      0.0,
      0.0,

      0.0,
      0.0,
      negFarRange,
      -1.0,

      0.0,
      0.0,
      nearPlaneDistance * negFarRange,
      0.0,
    );
  }

  /// Creates a customized, perspective projection matrix.
  /// [left] Minimum x-value of the view volume at the near view plane.
  /// [right] Maximum x-value of the view volume at the near view plane.
  /// [bottom] Minimum y-value of the view volume at the near view plane.
  /// [top] Maximum y-value of the view volume at the near view plane.
  /// [nearPlaneDistance] Distance to the near view plane.
  /// [farPlaneDistance] Distance to of the far view plane.
  /// Returns: The perspective projection matrix.
  factory Matrix4x4.perspectiveOffCenter(
      double left,
      double right,
      double bottom,
      double top,
      double nearPlaneDistance,
      double farPlaneDistance) {
    if (nearPlaneDistance <= 0.0) {
      throw RangeError.value(nearPlaneDistance, 'nearPlaneDistance');
    }
    if (farPlaneDistance <= 0.0) {
      throw RangeError.value(farPlaneDistance, 'farPlaneDistance');
    }
    if (nearPlaneDistance >= farPlaneDistance) {
      throw RangeError.value(nearPlaneDistance, 'nearPlaneDistance');
    }
    final isPositiveInfinity =
        farPlaneDistance.isInfinite && !farPlaneDistance.isNegative;
    final negFarRange = isPositiveInfinity
        ? -1.0
        : farPlaneDistance / (nearPlaneDistance - farPlaneDistance);

    return Matrix4x4(
        2.0 * nearPlaneDistance / (right - left),
        0.0,
        0.0,
        0.0,

        0.0,
        2.0 * nearPlaneDistance / (top - bottom),
        0.0,
        0.0,

        (left + right) / (right - left),
        (top + bottom) / (top - bottom),
        negFarRange,
        -1.0,

        0.0,
        0.0,
        nearPlaneDistance * negFarRange,
        0.0);
  }

  /// Creates an orthographic perspective matrix from the given view volume dimensions.
  /// [width] Width of the view volume.
  /// [height] Height of the view volume.
  /// [zNearPlane] Minimum Z-value of the view volume.
  /// [zFarPlane] Maximum Z-value of the view volume.
  /// Returns: The orthographic projection matrix.
  Matrix4x4.orthographic(
      double width, double height, double zNearPlane, double zFarPlane)
      : this(
          2.0 / width,
          0.0,
          0.0,
          0.0,

          0.0,
          2.0 / height,
          0.0,
          0.0,

          0.0,
          0.0,
          1.0 / (zNearPlane - zFarPlane),
          0.0,

          0.0,
          0.0,
          zNearPlane / (zNearPlane - zFarPlane),
          1.0,
        );

  /// Builds a customized, orthographic projection matrix.
  /// [left] Minimum X-value of the view volume.
  /// [right] Maximum X-value of the view volume.
  /// [bottom] Minimum Y-value of the view volume.
  /// [top] Maximum Y-value of the view volume.
  /// [zNearPlane] Minimum Z-value of the view volume.
  /// [zFarPlane] Maximum Z-value of the view volume.
  /// Returns: The orthographic projection matrix.
  Matrix4x4.orthographicOffCenter(double left, double right, double bottom,
      double top, double zNearPlane, double zFarPlane)
      : this(
          2.0 / (right - left),
          0.0,
          0.0,
          0.0,

          0.0,
          2.0 / (top - bottom),
          0.0,
          0.0,

          
          0.0,
          0.0,
          1.0 / (zNearPlane - zFarPlane),
          0.0,

          (left + right) / (left - right),
          (top + bottom) / (bottom - top),
          zNearPlane / (zNearPlane - zFarPlane),
          1.0,
        );

  /// Creates a view matrix.
  /// [cameraPosition] The position of the camera.
  /// [cameraTarget] The target towards which the camera is pointing.
  /// [cameraUpVector] The direction that is "up" from the camera's point of view.
  /// Returns: The view matrix.
  factory Matrix4x4.lookAt(
      Vector3 cameraPosition, Vector3 cameraTarget, Vector3 cameraUpVector) {
    final zaxis = (cameraPosition - cameraTarget).normalize();
    final xaxis = cameraUpVector.cross(zaxis).normalize();
    final yaxis = zaxis.cross(xaxis);

    return Matrix4x4(
        xaxis.x,
        yaxis.x,
        zaxis.x,
        0.0,
        xaxis.y,
        yaxis.y,
        zaxis.y,
        0.0,
        xaxis.z,
        yaxis.z,
        zaxis.z,
        0.0,
        -xaxis.dot(cameraPosition),
        -yaxis.dot(cameraPosition),
        -zaxis.dot(cameraPosition),
        1.0);
  }

  /// Creates a world matrix with the specified parameters.
  /// [position] The position of the object; used in translation operations.
  /// [forward] Forward direction of the object.
  /// [up] Upward direction of the object; usually [0, 1, 0].
  /// Returns: The world matrix.
  factory Matrix4x4.world(Vector3 position, Vector3 forward, Vector3 up) {
    final zaxis = (-forward).normalize();
    final xaxis = up.cross(zaxis).normalize();
    final yaxis = zaxis.cross(xaxis);

    return Matrix4x4(
        xaxis.x,
        xaxis.y,
        xaxis.z,
        0.0,
        yaxis.x,
        yaxis.y,
        yaxis.z,
        0.0,
        zaxis.x,
        zaxis.y,
        zaxis.z,
        0.0,
        position.x,
        position.y,
        position.z,
        1.0);
  }

  /// Creates a rotation matrix from the given Quaternion rotation value.
  factory Matrix4x4.fromQuaternion(Quaternion quaternion) =>
      Matrix4x4.rotation(quaternion);

  /// Creates a rotation matrix from the given Quaternion rotation value.
  factory Matrix4x4.rotation(Quaternion quaternion) {
    final xx = quaternion.x * quaternion.x;
    final yy = quaternion.y * quaternion.y;
    final zz = quaternion.z * quaternion.z;

    final xy = quaternion.x * quaternion.y;
    final wz = quaternion.z * quaternion.w;
    final xz = quaternion.z * quaternion.x;
    final wy = quaternion.y * quaternion.w;
    final yz = quaternion.y * quaternion.z;
    final wx = quaternion.x * quaternion.w;

    return Matrix4x4(
        1.0 - 2.0 * (yy + zz),
        2.0 * (xy + wz),
        2.0 * (xz - wy),
        0.0,
        2.0 * (xy - wz),
        1.0 - 2.0 * (zz + xx),
        2.0 * (yz + wx),
        0.0,
        2.0 * (xz + wy),
        2.0 * (yz - wx),
        1.0 - 2.0 * (yy + xx),
        0.0,
        0.0,
        0.0,
        0.0,
        1.0);
  }

  /// Creates a rotation matrix from the specified yaw, pitch, and roll.
  /// [yaw] Angle of rotation, in radians, around the Y-axis.
  /// [pitch] Angle of rotation, in radians, around the X-axis.
  /// [roll] Angle of rotation, in radians, around the Z-axis.
  /// Returns: The rotation matrix.
  factory Matrix4x4.fromYawPitchRoll(double yaw, double pitch, double roll) {
    return Matrix4x4.rotation(Quaternion.fromYawPitchRoll(yaw, pitch, roll));
  }

  /// Creates a Matrix that flattens geometry into a specified Plane as if casting a shadow from a specified light source.
  /// [lightDirection] The direction from which the light that will cast the shadow is coming.
  /// [plane] The Plane onto which the new matrix should flatten geometry so as to cast a shadow.
  /// Returns: A new Matrix that can be used to flatten geometry onto the specified plane from the specified direction.
  factory Matrix4x4.shadow(Vector3 lightDirection, Plane plane) {
    final p = Plane.normalize(plane);

    final dot = p.normal.x * lightDirection.x +
        p.normal.y * lightDirection.y +
        p.normal.z * lightDirection.z;
    final a = -p.normal.x;
    final b = -p.normal.y;
    final c = -p.normal.z;
    final d = -p.d;

    return Matrix4x4(
        a * lightDirection.x + dot,
        b * lightDirection.x,
        c * lightDirection.x,
        d * lightDirection.x,
        a * lightDirection.y,
        b * lightDirection.y + dot,
        c * lightDirection.y,
        d * lightDirection.y,
        a * lightDirection.z,
        b * lightDirection.z,
        c * lightDirection.z + dot,
        d * lightDirection.z,
        0.0,
        0.0,
        0.0,
        dot);
  }

  /// Creates a Matrix that reflects the coordinate system about a specified Plane.
  /// [value] The Plane about which to create a reflection.
  /// Returns: A new matrix expressing the reflection.
  factory Matrix4x4.reflection(Plane value) {
    value = Plane.normalize(value);

    final a = value.normal.x;
    final b = value.normal.y;
    final c = value.normal.z;
    final fa = -2.0 * a;
    final fb = -2.0 * b;
    final fc = -2.0 * c;
    return Matrix4x4(
        fa * a + 1.0,
        fb * a,
        fc * a,
        0.0,
        fa * b,
        fb * b + 1.0,
        fc * b,
        0.0,
        fa * c,
        fb * c,
        fc * c + 1.0,
        0.0,
        fa * value.d,
        fb * value.d,
        fc * value.d,
        1.0);
  }

  // Transforms the given matrix by applying the given Quaternion rotation.
  // [value] The source matrix to transform.
  // [rotation] The rotation to apply.
  // Returns: The transformed matrix.
  factory Matrix4x4.transform(Matrix4x4 value, Quaternion rotation) {
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

    final q11 = 1.0 - yy2 - zz2;
    final q21 = xy2 - wz2;
    final q31 = xz2 + wy2;

    final q12 = xy2 + wz2;
    final q22 = 1.0 - xx2 - zz2;
    final q32 = yz2 - wx2;

    final q13 = xz2 - wy2;
    final q23 = yz2 + wx2;
    final q33 = 1.0 - xx2 - yy2;

    return Matrix4x4(
        // First row
        value.m11 * q11 + value.m12 * q21 + value.m13 * q31,
        value.m11 * q12 + value.m12 * q22 + value.m13 * q32,
        value.m11 * q13 + value.m12 * q23 + value.m13 * q33,
        value.m14,

        // Second row
        value.m21 * q11 + value.m22 * q21 + value.m23 * q31,
        value.m21 * q12 + value.m22 * q22 + value.m23 * q32,
        value.m21 * q13 + value.m22 * q23 + value.m23 * q33,
        value.m24,

        // Third row
        value.m31 * q11 + value.m32 * q21 + value.m33 * q31,
        value.m31 * q12 + value.m32 * q22 + value.m33 * q32,
        value.m31 * q13 + value.m32 * q23 + value.m33 * q33,
        value.m34,

        // Fourth row
        value.m41 * q11 + value.m42 * q21 + value.m43 * q31,
        value.m41 * q12 + value.m42 * q22 + value.m43 * q32,
        value.m41 * q13 + value.m42 * q23 + value.m43 * q33,
        value.m44);
  }

  /// Transposes the rows and columns of a matrix.
  Matrix4x4.transpose(Matrix4x4 matrix)
      : this(
            matrix.m11,
            matrix.m21,
            matrix.m31,
            matrix.m41,
            matrix.m12,
            matrix.m22,
            matrix.m32,
            matrix.m42,
            matrix.m13,
            matrix.m23,
            matrix.m33,
            matrix.m43,
            matrix.m14,
            matrix.m24,
            matrix.m34,
            matrix.m44);

  /// Linearly interpolates between the corresponding values of two matrices.
  Matrix4x4.lerp(Matrix4x4 matrix1, Matrix4x4 matrix2, double amount)
      : this(
            // First row
            matrix1.m11 + (matrix2.m11 - matrix1.m11) * amount,
            matrix1.m12 + (matrix2.m12 - matrix1.m12) * amount,
            matrix1.m13 + (matrix2.m13 - matrix1.m13) * amount,
            matrix1.m14 + (matrix2.m14 - matrix1.m14) * amount,

            // Second row
            matrix1.m21 + (matrix2.m21 - matrix1.m21) * amount,
            matrix1.m22 + (matrix2.m22 - matrix1.m22) * amount,
            matrix1.m23 + (matrix2.m23 - matrix1.m23) * amount,
            matrix1.m24 + (matrix2.m24 - matrix1.m24) * amount,

            // Third row
            matrix1.m31 + (matrix2.m31 - matrix1.m31) * amount,
            matrix1.m32 + (matrix2.m32 - matrix1.m32) * amount,
            matrix1.m33 + (matrix2.m33 - matrix1.m33) * amount,
            matrix1.m34 + (matrix2.m34 - matrix1.m34) * amount,

            // Fourth row
            matrix1.m41 + (matrix2.m41 - matrix1.m41) * amount,
            matrix1.m42 + (matrix2.m42 - matrix1.m42) * amount,
            matrix1.m43 + (matrix2.m43 - matrix1.m43) * amount,
            matrix1.m44 + (matrix2.m44 - matrix1.m44) * amount);

  /// Returns a new matrix with the negated elements of the given matrix.
  /// [value] The source matrix.
  /// Returns: The negated matrix.
  factory Matrix4x4.negate(Matrix4x4 value) => -value;

  /// Adds two matrices together.
  factory Matrix4x4.add(Matrix4x4 value1, Matrix4x4 value2) => value1 + value2;

  /// Subtracts the second matrix from the first.
  factory Matrix4x4.subtract(Matrix4x4 value1, Matrix4x4 value2) =>
      value1 - value2;

  /// Multiplies a matrix by another matrix.
  factory Matrix4x4.multiply(Matrix4x4 value1, Matrix4x4 value2) =>
      value1 * value2;

  /// Multiplies a matrix by a scalar value.
  factory Matrix4x4.multiplyScalar(Matrix4x4 value1, double value2) =>
      value1 * value2;

  /// Attempts to calculate the inverse of the given matrix. If successful, result will contain the inverted matrix.
  /// [matrix] The source matrix to invert.
  /// [result] If successful, contains the inverted matrix.
  /// Returns: True if the source matrix could be inverted; False otherwise.
  factory Matrix4x4.invert(Matrix4x4 matrix) {
    //                                       -1
    // If you have matrix M, inverse Matrix M   can compute
    //
    //     -1       1
    //    M   = --------- A
    //            det(M)
    //
    // A is adjugate (adjoint) of M, where,
    //
    //      T
    // A = C
    //
    // C is Cofactor matrix of M, where,
    //           i + j
    // C   = (-1)      * det(M  )
    //  ij                    ij
    //
    //     [ a b c d ]
    // M = [ e f g h ]
    //     [ i j k l ]
    //     [ m n o p ]
    //
    // First Row
    //           2 | f g h |
    // C   = (-1)  | j k l | = + ( f ( kp - lo ) - g ( jp - ln ) + h ( jo - kn ) )
    //  11         | n o p |
    //
    //           3 | e g h |
    // C   = (-1)  | i k l | = - ( e ( kp - lo ) - g ( ip - lm ) + h ( io - km ) )
    //  12         | m o p |
    //
    //           4 | e f h |
    // C   = (-1)  | i j l | = + ( e ( jp - ln ) - f ( ip - lm ) + h ( in - jm ) )
    //  13         | m n p |
    //
    //           5 | e f g |
    // C   = (-1)  | i j k | = - ( e ( jo - kn ) - f ( io - km ) + g ( in - jm ) )
    //  14         | m n o |
    //
    // Second Row
    //           3 | b c d |
    // C   = (-1)  | j k l | = - ( b ( kp - lo ) - c ( jp - ln ) + d ( jo - kn ) )
    //  21         | n o p |
    //
    //           4 | a c d |
    // C   = (-1)  | i k l | = + ( a ( kp - lo ) - c ( ip - lm ) + d ( io - km ) )
    //  22         | m o p |
    //
    //           5 | a b d |
    // C   = (-1)  | i j l | = - ( a ( jp - ln ) - b ( ip - lm ) + d ( in - jm ) )
    //  23         | m n p |
    //
    //           6 | a b c |
    // C   = (-1)  | i j k | = + ( a ( jo - kn ) - b ( io - km ) + c ( in - jm ) )
    //  24         | m n o |
    //
    // Third Row
    //           4 | b c d |
    // C   = (-1)  | f g h | = + ( b ( gp - ho ) - c ( fp - hn ) + d ( fo - gn ) )
    //  31         | n o p |
    //
    //           5 | a c d |
    // C   = (-1)  | e g h | = - ( a ( gp - ho ) - c ( ep - hm ) + d ( eo - gm ) )
    //  32         | m o p |
    //
    //           6 | a b d |
    // C   = (-1)  | e f h | = + ( a ( fp - hn ) - b ( ep - hm ) + d ( en - fm ) )
    //  33         | m n p |
    //
    //           7 | a b c |
    // C   = (-1)  | e f g | = - ( a ( fo - gn ) - b ( eo - gm ) + c ( en - fm ) )
    //  34         | m n o |
    //
    // Fourth Row
    //           5 | b c d |
    // C   = (-1)  | f g h | = - ( b ( gl - hk ) - c ( fl - hj ) + d ( fk - gj ) )
    //  41         | j k l |
    //
    //           6 | a c d |
    // C   = (-1)  | e g h | = + ( a ( gl - hk ) - c ( el - hi ) + d ( ek - gi ) )
    //  42         | i k l |
    //
    //           7 | a b d |
    // C   = (-1)  | e f h | = - ( a ( fl - hj ) - b ( el - hi ) + d ( ej - fi ) )
    //  43         | i j l |
    //
    //           8 | a b c |
    // C   = (-1)  | e f g | = + ( a ( fk - gj ) - b ( ek - gi ) + c ( ej - fi ) )
    //  44         | i j k |
    //
    // Cost of operation
    // 53 adds, 104 muls, and 1 div.
    final a = matrix.m11, b = matrix.m12, c = matrix.m13, d = matrix.m14;
    final e = matrix.m21, f = matrix.m22, g = matrix.m23, h = matrix.m24;
    final i = matrix.m31, j = matrix.m32, k = matrix.m33, l = matrix.m34;
    final m = matrix.m41, n = matrix.m42, o = matrix.m43, p = matrix.m44;

    final kpLo = k * p - l * o;
    final jpLn = j * p - l * n;
    final joKn = j * o - k * n;
    final ipLm = i * p - l * m;
    final ioKm = i * o - k * m;
    final inJm = i * n - j * m;

    final a11 = (f * kpLo - g * jpLn + h * joKn);
    final a12 = -(e * kpLo - g * ipLm + h * ioKm);
    final a13 = (e * jpLn - f * ipLm + h * inJm);
    final a14 = -(e * joKn - f * ioKm + g * inJm);

    final det = a * a11 + b * a12 + c * a13 + d * a14;

    if (det.abs() < double.minPositive) {
      return Matrix4x4.nan;
    }

    final invDet = 1.0 / det;

    final gpHo = g * p - h * o;
    final fpHn = f * p - h * n;
    final foGn = f * o - g * n;
    final epHm = e * p - h * m;
    final eoGm = e * o - g * m;
    final enFm = e * n - f * m;

    final glHk = g * l - h * k;
    final flHj = f * l - h * j;
    final fkGj = f * k - g * j;
    final elHi = e * l - h * i;
    final ekGi = e * k - g * i;
    final ejFi = e * j - f * i;

    return Matrix4x4(
        a11 * invDet,
        -(b * kpLo - c * jpLn + d * joKn) * invDet,
        (b * gpHo - c * fpHn + d * foGn) * invDet,
        -(b * glHk - c * flHj + d * fkGj) * invDet,
        a12 * invDet,
        (a * kpLo - c * ipLm + d * ioKm) * invDet,
        -(a * gpHo - c * epHm + d * eoGm) * invDet,
        (a * glHk - c * elHi + d * ekGi) * invDet,
        a13 * invDet,
        -(a * jpLn - b * ipLm + d * inJm) * invDet,
        (a * fpHn - b * epHm + d * enFm) * invDet,
        -(a * flHj - b * elHi + d * ejFi) * invDet,
        a14 * invDet,
        (a * joKn - b * ioKm + c * inJm) * invDet,
        -(a * foGn - b * eoGm + c * enFm) * invDet,
        (a * fkGj - b * ekGi + c * ejFi) * invDet);
  }

  factory Matrix4x4.tRS(
          Vector3 translation, Quaternion rotation, Vector3 scale) =>
      Matrix4x4.translation(translation) *
      Matrix4x4.rotation(rotation) *
      Matrix4x4.scaleVector3(scale);

  /// Calculates the determinant of the 3x3 rotational component of the matrix.
  /// Returns: The determinant of the 3x3 rotational component matrix.
  double get3x3RotationDeterminant() {
    // | a b c |
    // | d e f | = a | e f | - b | d f | + c | d e |
    // | g h i |     | h i |     | g i |     | g h |
    //
    // a | e f | = a ( ei - fh )
    //   | h i |
    //
    // b | d f | = b ( di - gf )
    //   | g i |
    //
    // c | d e | = c ( dh - eg )
    //   | g h |
    final a = m11, b = m12, c = m13;
    final d = m21, e = m22, f = m23;
    final g = m31, h = m32, i = m33;
    final eiFh = e * i - f * h;
    final diGf = d * i - g * f;
    final dhEg = d * h - e * g;
    return a * eiFh - b * diGf + c * dhEg;
  }

  /// Calculates the determinant of the matrix.
  /// Returns: The determinant of the matrix.
  double getDeterminant() {
    // | a b c d |     | f g h |     | e g h |     | e f h |     | e f g |
    // | e f g h | = a | j k l | - b | i k l | + c | i j l | - d | i j k |
    // | i j k l |     | n o p |     | m o p |     | m n p |     | m n o |
    // | m n o p |
    //
    //   | f g h |
    // a | j k l | = a ( f ( kp - lo ) - g ( jp - ln ) + h ( jo - kn ) )
    //   | n o p |
    //
    //   | e g h |
    // b | i k l | = b ( e ( kp - lo ) - g ( ip - lm ) + h ( io - km ) )
    //   | m o p |
    //
    //   | e f h |
    // c | i j l | = c ( e ( jp - ln ) - f ( ip - lm ) + h ( in - jm ) )
    //   | m n p |
    //
    //   | e f g |
    // d | i j k | = d ( e ( jo - kn ) - f ( io - km ) + g ( in - jm ) )
    //   | m n o |
    //
    // Cost of operation
    // 17 adds and 28 muls.
    //
    // add: 6 + 8 + 3 = 17
    // mul: 12 + 16 = 28
    final a = m11, b = m12, c = m13, d = m14;
    final e = m21, f = m22, g = m23, h = m24;
    final i = m31, j = m32, k = m33, l = m34;
    final m = m41, n = m42, o = m43, p = m44;
    final kpLo = k * p - l * o;
    final jpLn = j * p - l * n;
    final joKn = j * o - k * n;
    final ipLm = i * p - l * m;
    final ioKm = i * o - k * m;
    final inJm = i * n - j * m;
    return a * (f * kpLo - g * jpLn + h * joKn) -
        b * (e * kpLo - g * ipLm + h * ioKm) +
        c * (e * jpLn - f * ipLm + h * inJm) -
        d * (e * joKn - f * ioKm + g * inJm);
  }

  /// Get's the scale factor of each axis.  This implementation extracts the scale exclusively,
  /// so it attempts to ignore rotation.  This is contrary to most math libraries
  /// that use decompose, so a negation on Y becomes a 90 degree rotation and a negation on X.
  /// We have implemented this extraction to be able to quickly remove scaling from matrices.
  /// Multiplying a matrix by the inverse of it's direct scale will preserve it's current rotation.
  /// It's implemented this way mostly so we can get easy testing on unit tests, and because this
  /// implementation is equally valid.
  /// NOTE: This could probably be improved to handle more generic cases by using
  /// CrossProduct to determine axis flipping: (X Cross Y) Dot Z < 0 == Flip
  Vector3 extractDirectScale() => Vector3(row0.length * (m11 > 0.0 ? 1 : -1),
      row1.length * (m22 > 0.0 ? 1 : -1), row2.length * (m33 > 0.0 ? 1 : -1));
  Vector3 getRow(int row) => row == 0
      ? row0
      : row == 1
          ? row1
          : row == 2
              ? row2
              : row3;
  Vector3 getCol(int col) => col == 0
      ? col0
      : col == 1
          ? col1
          : col == 2
              ? col2
              : col3;

  /// Sets the translation component of this matrix, returning a new Matrix
  Matrix4x4 setTranslation(Vector3 v) =>
      Matrix4x4.fromVector3Rows(row0, row1, row2, v);
  Matrix4x4 scaleTranslation(double amount) =>
      setTranslation(translation * amount);

  /// Transposes the rows and columns of a matrix.
  Matrix4x4 transpose() => Matrix4x4.transpose(this);
  Matrix4x4 inverse() {
    final rRef = Matrix4x4.invert(this);
    if (rRef == Matrix4x4.nan) {
      throw Exception("No inversion of matrix available");
    }
    return rRef;
  }

  /// Attempts to extract the scale, translation, and rotation components from the given scale/rotation/translation matrix.
  /// If successful, the out parameters will contained the extracted values.
  /// https://referencesource.microsoft.com/#System.Numerics/System/Numerics/Matrix4x4.cs
  static SRT? tryDecompose(Matrix4x4 matrix) {
    var rotationVal = Quaternion.identity;
    final pfScales = List.filled(3, 0.0, growable: false);
    const double epsilon = 0.0001;
    final pCanonicalBasis = [Vector3.unitX, Vector3.unitY, Vector3.unitZ];
    final pVectorBasis = [matrix.row0, matrix.row1, matrix.row2];

    pfScales[0] = pVectorBasis[0].length;
    pfScales[1] = pVectorBasis[1].length;
    pfScales[2] = pVectorBasis[2].length;

    int a = 0, b = 0, c = 0;
    double x = pfScales[0], y = pfScales[1], z = pfScales[2];
    if (x < y) {
      if (y < z) {
        a = 2;
        b = 1;
        c = 0;
      } else {
        a = 1;
        if (x < z) {
          b = 2;
          c = 0;
        } else {
          b = 0;
          c = 2;
        }
      }
    } else {
      if (x < z) {
        a = 2;
        b = 0;
        c = 1;
      } else {
        a = 0;

        if (y < z) {
          b = 2;
          c = 1;
        } else {
          b = 1;
          c = 2;
        }
      }
    }

    if (pfScales[a] < epsilon) {
      pVectorBasis[a] = pCanonicalBasis[a];
    }

    pVectorBasis[a] = pVectorBasis[a].normalize();

    if (pfScales[b] < epsilon) {
      final fAbsX = pVectorBasis[a].x.abs();
      final fAbsY = pVectorBasis[a].y.abs();
      final fAbsZ = pVectorBasis[a].z.abs();

      var cc = 0;
      if (fAbsX < fAbsY) {
        if (fAbsY < fAbsZ) {
          cc = 0;
        } else {
          if (fAbsX < fAbsZ) {
            cc = 0;
          } else {
            cc = 2;
          }
        }
      } else {
        if (fAbsX < fAbsZ) {
          cc = 1;
        } else {
          if (fAbsY < fAbsZ) {
            cc = 1;
          } else {
            cc = 2;
          }
        }
      }
      pVectorBasis[b] = pVectorBasis[a].cross(pCanonicalBasis[cc]);
    }

    pVectorBasis[b] = pVectorBasis[b].normalize();

    if (pfScales[c] < epsilon) {
      pVectorBasis[c] = pVectorBasis[a].cross(pVectorBasis[b]);
    }

    pVectorBasis[c] = pVectorBasis[c].normalize();

    // Update mat tmp;
    var det = Matrix4x4.fromVector3Rows(
            pVectorBasis[0], pVectorBasis[1], pVectorBasis[2])
        .getDeterminant();

    // use Kramer's rule to check for handedness of coordinate system
    if (det < 0.0) {
      // switch coordinate system by negating the scale and inverting the basis vector on the x-axis
      pfScales[a] = -pfScales[a];
      pVectorBasis[a] = -pVectorBasis[a];
      det = -det;
    }

    det -= 1.0;
    det *= det;

    if (epsilon < det) {
      // Non-SRT matrix encountered
      return null;
    } else {
      // generate the quaternion from the matrix
      final matTemp = Matrix4x4.fromVector3Rows(
          pVectorBasis[0], pVectorBasis[1], pVectorBasis[2]);
      rotationVal = Quaternion.fromRotationMatrix(matTemp);
    }

    final translationVal = matrix.translation;
    final scaleVal = Vector3(pfScales[0], pfScales[1], pfScales[2]);
    return SRT(scaleVal, rotationVal, translationVal);
  }

  List<double> toFloats() => [
        m11,
        m12,
        m13,
        m14,
        m21,
        m22,
        m23,
        m24,
        m31,
        m32,
        m33,
        m34,
        m41,
        m42,
        m43,
        m44
      ];

  static List<double> toFloatsArray(List<Matrix4x4> matrixArray) {
    final ret = <double>[];
    for (var i = 0; i < matrixArray.length; i++) {
      final j = i * 16;
      ret[j + 0] = matrixArray[i].m11;
      ret[j + 1] = matrixArray[i].m12;
      ret[j + 2] = matrixArray[i].m13;
      ret[j + 3] = matrixArray[i].m14;
      ret[j + 4] = matrixArray[i].m21;
      ret[j + 5] = matrixArray[i].m22;
      ret[j + 6] = matrixArray[i].m23;
      ret[j + 7] = matrixArray[i].m24;
      ret[j + 8] = matrixArray[i].m31;
      ret[j + 9] = matrixArray[i].m32;
      ret[j + 10] = matrixArray[i].m33;
      ret[j + 11] = matrixArray[i].m34;
      ret[j + 12] = matrixArray[i].m41;
      ret[j + 13] = matrixArray[i].m42;
      ret[j + 14] = matrixArray[i].m43;
      ret[j + 15] = matrixArray[i].m44;
    }
    return ret;
  }

  static List<Matrix4x4> toMatrixArray(List<double> m) {
    assert((m.length % 16) == 0);
    List<Matrix4x4> ret = <Matrix4x4>[];
    for (var i = 0; i < ret.length; i++) {
      final i16 = i * 16;
      ret[i] = Matrix4x4(
          m[i16 + 0],
          m[i16 + 1],
          m[i16 + 2],
          m[i16 + 3],
          m[i16 + 4],
          m[i16 + 5],
          m[i16 + 6],
          m[i16 + 7],
          m[i16 + 8],
          m[i16 + 9],
          m[i16 + 10],
          m[i16 + 11],
          m[i16 + 12],
          m[i16 + 13],
          m[i16 + 14],
          m[i16 + 15]);
    }
    return ret;
  }
  Matrix4x4 copyWith({
    double? m11,
    double? m12,
    double? m13,
    double? m14,
    double? m21,
    double? m22,
    double? m23,
    double? m24,
    double? m31,
    double? m32,
    double? m33,
    double? m34,
    double? m41,
    double? m42,
    double? m43,
    double? m44,
  }) =>
      Matrix4x4(
        m11 ?? this.m11,
        m12 ?? this.m12,
        m13 ?? this.m13,
        m14 ?? this.m14,
        m21 ?? this.m21,
        m22 ?? this.m22,
        m23 ?? this.m23,
        m24 ?? this.m24,
        m31 ?? this.m31,
        m32 ?? this.m32,
        m33 ?? this.m33,
        m34 ?? this.m34,
        m41 ?? this.m41,
        m42 ?? this.m42,
        m43 ?? this.m43,
        m44 ?? this.m44,
      );

  @override
  Matrix4x4 transform(Matrix4x4 mat) => this * mat;
  @override
  String toString() =>
      "{{ {{M11:$m11 M12:$m12 M13:$m13 M14:$m14}} {{M21:$m21 M22:$m22 M23:$m23 M24:$m24}} {{M31:$m31 M32:$m32 M33:$m33 M34:$m34}} {{M41:$m41 M42:$m42 M43:$m43 M44:$m44}} }}";

  @override
  bool operator ==(Object other) =>
      (other is Matrix4x4) &&
      (m11 == other.m11 &&
          m22 == other.m22 &&
          m33 == other.m33 &&
          m44 == other.m44 &&
          m12 == other.m12 &&
          m13 == other.m13 &&
          m14 == other.m14 &&
          m21 == other.m21 &&
          m23 == other.m23 &&
          m24 == other.m24 &&
          m31 == other.m31 &&
          m32 == other.m32 &&
          m34 == other.m34 &&
          m41 == other.m41 &&
          m42 == other.m42 &&
          m43 == other.m43);
  // Returns a new matrix with the negated elements of the given matrix.
  Matrix4x4 operator -() => Matrix4x4(-m11, -m12, -m13, -m14, -m21, -m22, -m23,
      -m24, -m31, -m32, -m33, -m34, -m41, -m42, -m43, -m44);

  /// Adds two matrices together.
  /// [value1] The first source matrix.
  /// [value2] The second source matrix.
  /// Returns: The resulting matrix.
  Matrix4x4 operator +(Matrix4x4 value2) => Matrix4x4(
      m11 + value2.m11,
      m12 + value2.m12,
      m13 + value2.m13,
      m14 + value2.m14,
      m21 + value2.m21,
      m22 + value2.m22,
      m23 + value2.m23,
      m24 + value2.m24,
      m31 + value2.m31,
      m32 + value2.m32,
      m33 + value2.m33,
      m34 + value2.m34,
      m41 + value2.m41,
      m42 + value2.m42,
      m43 + value2.m43,
      m44 + value2.m44);

  /// Subtracts the second matrix from the first.
  /// [value1] The first source matrix.
  /// [value2] The second source matrix.
  /// Returns: The result of the subtraction.
  Matrix4x4 operator -(Matrix4x4 value2) => Matrix4x4(
      m11 - value2.m11,
      m12 - value2.m12,
      m13 - value2.m13,
      m14 - value2.m14,
      m21 - value2.m21,
      m22 - value2.m22,
      m23 - value2.m23,
      m24 - value2.m24,
      m31 - value2.m31,
      m32 - value2.m32,
      m33 - value2.m33,
      m34 - value2.m34,
      m41 - value2.m41,
      m42 - value2.m42,
      m43 - value2.m43,
      m44 - value2.m44);

  /// Multiplies a matrix by another matrix.
  /// [value1] The first source matrix.
  /// [value2] The second source matrix.
  /// Returns: The result of the multiplication.
  Matrix4x4 operator *(Object value2) {
    if (value2 is Matrix4x4) {
      return Matrix4x4(
          // First row
          m11 * value2.m11 +
              m12 * value2.m21 +
              m13 * value2.m31 +
              m14 * value2.m41,
          m11 * value2.m12 +
              m12 * value2.m22 +
              m13 * value2.m32 +
              m14 * value2.m42,
          m11 * value2.m13 +
              m12 * value2.m23 +
              m13 * value2.m33 +
              m14 * value2.m43,
          m11 * value2.m14 +
              m12 * value2.m24 +
              m13 * value2.m34 +
              m14 * value2.m44,

          // Second row
          m21 * value2.m11 +
              m22 * value2.m21 +
              m23 * value2.m31 +
              m24 * value2.m41,
          m21 * value2.m12 +
              m22 * value2.m22 +
              m23 * value2.m32 +
              m24 * value2.m42,
          m21 * value2.m13 +
              m22 * value2.m23 +
              m23 * value2.m33 +
              m24 * value2.m43,
          m21 * value2.m14 +
              m22 * value2.m24 +
              m23 * value2.m34 +
              m24 * value2.m44,

          // Third row
          m31 * value2.m11 +
              m32 * value2.m21 +
              m33 * value2.m31 +
              m34 * value2.m41,
          m31 * value2.m12 +
              m32 * value2.m22 +
              m33 * value2.m32 +
              m34 * value2.m42,
          m31 * value2.m13 +
              m32 * value2.m23 +
              m33 * value2.m33 +
              m34 * value2.m43,
          m31 * value2.m14 +
              m32 * value2.m24 +
              m33 * value2.m34 +
              m34 * value2.m44,

          // Fourth row
          m41 * value2.m11 +
              m42 * value2.m21 +
              m43 * value2.m31 +
              m44 * value2.m41,
          m41 * value2.m12 +
              m42 * value2.m22 +
              m43 * value2.m32 +
              m44 * value2.m42,
          m41 * value2.m13 +
              m42 * value2.m23 +
              m43 * value2.m33 +
              m44 * value2.m43,
          m41 * value2.m14 +
              m42 * value2.m24 +
              m43 * value2.m34 +
              m44 * value2.m44);
    } else if (value2 is num) {
      return Matrix4x4(
          m11 * value2,
          m12 * value2,
          m13 * value2,
          m14 * value2,
          m21 * value2,
          m22 * value2,
          m23 * value2,
          m24 * value2,
          m31 * value2,
          m32 * value2,
          m33 * value2,
          m34 * value2,
          m41 * value2,
          m42 * value2,
          m43 * value2,
          m44 * value2);
    }
    throw UnsupportedError('operator * (${value2.runtimeType})');
  }

  /// Returns a boolean indicating whether the given two matrices are not equal.
  //bool operator !=(Matrix4x4 value2) => (this.m11 != value2.m11 || this.m12 != value2.m12 || this.m13 != value2.m13 || this.m14 != value2.m14 || this.m21 != value2.m21 || this.m22 != value2.m22 || this.m23 != value2.m23 || this.m24 != value2.m24 || this.m31 != value2.m31 || this.m32 != value2.m32 || this.m33 != value2.m33 || this.m34 != value2.m34 || this.m41 != value2.m41 || this.m42 != value2.m42 || this.m43 != value2.m43 || this.m44 != value2.m44);

}

class SRT {
  final Vector3 scale;
  final Quaternion rotation;
  final Vector3 translation;

  const SRT(this.scale, this.rotation, this.translation);
}
