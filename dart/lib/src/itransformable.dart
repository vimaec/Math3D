part of '../vim_math3d.dart';

abstract class ITransformable3D<TSelf> {
  TSelf transform(Matrix4x4 mat);
}

extension Transformable3D<T> on ITransformable3D<T> {
  static Matrix4x4 multiply(Iterable<Matrix4x4> matrices) {
    var seed = Matrix4x4.identity;
    for (var m in matrices) {
      seed = seed * m;
    }
    return seed;
  }

  T transform(List<Matrix4x4> matrices) {
    return this.transform(multiply(matrices));
  }

  T translate(Vector3 offset) {
    return this.transform(Matrix4x4.translation(offset));
  }

  T translateXyz(
    double x,
    double y,
    double z,
  ) {
    return translate(Vector3(x, y, z));
  }

  T rotate(Quaternion q) {
    return this.transform(Matrix4x4.rotation(q));
  }

  T scale(double scale) {
    return scaleVector(Vector3(scale, scale, scale));
  }

  T scaleVector(Vector3 scales) {
    return this.transform(Matrix4x4.scaleVector3(scales));
  }

  T scaleXyz(double x, double y, double z) {
    return scaleVector(Vector3(x, y, z));
  }

  T scaleX(double x) {
    return scaleXyz(x, 0.0, 0.0);
  }

  T scaleY(double y) {
    return scaleXyz(0.0, y, 0.0);
  }

  T scaleZ(double z) {
    return scaleXyz(0.0, 0.0, z);
  }

  T lookAt(
    Vector3 cameraPosition,
    Vector3 cameraTarget,
    Vector3 cameraUpVector,
  ) {
    return this.transform(
      Matrix4x4.lookAt(
        cameraPosition,
        cameraTarget,
        cameraUpVector,
      ),
    );
  }

  T rotateAround(Vector3 axis, double angle) {
    return this.transform(Matrix4x4.fromAxisAndAngle(axis, angle));
  }

  T rotateYpr(double yaw, double pitch, double roll) {
    return this.transform(Matrix4x4.fromYawPitchRoll(yaw, pitch, roll));
  }

  T reflect(Plane plane) {
    return this.transform(Matrix4x4.reflection(plane));
  }

  T rotateX(double angle) {
    return rotateAround(Vector3.unitX, angle);
  }

  T rotateY(double angle) {
    return rotateAround(Vector3.unitY, angle);
  }

  T rotateZ(double angle) {
    return rotateAround(Vector3.unitZ, angle);
  }
}

extension SelfTransformable3D<T> on ITransformable3D<ITransformable3D<T>> {
  ITransformable3D<T> translateRotateScale(
    Vector3 pos,
    Quaternion rot,
    Vector3 scale,
  ) {
    return translate(pos)
      ..rotate(rot)
      ..scaleVector(scale);
  }
}
