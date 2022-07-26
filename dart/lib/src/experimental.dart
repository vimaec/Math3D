// ISliceable?
// IRayHittable?
// ISignedDistanceField?
// http://jamie-wong.com/2016/07/15/ray-marching-signed-distance-functions/
part of '../vim_math3d.dart';

// https://github.com/Unity-Technologies/Unity.Mathematics/tree/master/src/Unity.Mathematics/Noise

// https://en.wikipedia.org/wiki/Set_theory
// https://en.wikipedia.org/wiki/Set_(mathematics)

abstract class IAlgebraicSetExperimental<T> {
  IAlgebraicSetExperimental<T> union(IAlgebraicSetExperimental<T> other);
  IAlgebraicSetExperimental<T> get complement;
  IAlgebraicSetExperimental<T> intersection(IAlgebraicSetExperimental<T> other);
}

abstract class IPolygonExperimental {
  int get numPoints;
  Vector3 getPoint(int n);
  bool get closed;
}

abstract class SurfaceDistanceExperimental {}

abstract class IInsideOutsideExperimental {}

abstract class ILerpExperimental<T> {
  T lerp(T other, double amount);
}

abstract class IPositionRotationScaleExperimental {
  Vector3 get position;
  Quaternion get rotation;
  Vector3 get scale;
}

abstract class IPointsExperimental<T> implements ITransformable3D<T> {
  Iterable<Vector3> get points;
  T setPoints(Iterable<Vector3> points);
}

abstract class IRangeExperimental<T> {
  T get min;
  T get max;
}

abstract class IFieldExperimental<T> {
  T sample(Vector3 point);
  Vector3 get domain;
  // Could be null
  IRangeExperimental<T>? get range;
}

abstract class IVectorFieldExperimental implements IFieldExperimental<Vector3> {
}

abstract class ISignedDistanceFieldExperimental
    implements IFieldExperimental<double> {}

abstract class ICurveExperimental {
  // This is what makes something a 3D curve: a parameterization on 1D
  Vector3 query(double t);

  // Magnitude gives distance, note similar to an SDF
  Vector3 closestPoint(Vector3 v);

  // Could also be called an "extent", and is also effectively the bounding box
  IRangeExperimental<Vector3> get range;
}

abstract class ISurfaceExperimental {
  // This is what makes something a 3D surface: a parameterization on 2D
  Vector3 querySurface(Vector2 uv);

  // Magnitude gives distance, note similar to an SDF
  Vector3 closestPoint(Vector3 v);

  // Could also be called an "extent", and is also effectively the bounding box
  IRangeExperimental<Vector3> get range;
}

// Closed shapes when they are extruded create volumes.
//
abstract class IClosedShapeExperimental implements ICurveExperimental {}

abstract class IVolumeExperimental {
  // This is what makes something a 3D volume: a distance function (which is effectively a boolean with extra info)
  // Distance of "0" means inside of volume.
  double distance(Vector3 point);

  ISurfaceExperimental get surface;

  // Magnitude gives distance, note similar to an SDF
  // Note: inside volume, the point is unchanged.
  // This is like a "Clamp" or constraint
  Vector3 closestPoint(Vector3 v);

  // Could also be called an "extent", and is also effectively the bounding box
  IRangeExperimental<Vector3> get range;
}

abstract class IPrimitiveShapeExperimental
    implements
        IPolygonExperimental,
        IPositionRotationScaleExperimental,
        ITransformable3D<IPrimitiveVolumeExperimental> {}

abstract class IPrimitiveCurveExperimental
    implements
        ICurveExperimental,
        IPositionRotationScaleExperimental,
        ITransformable3D<IPrimitiveVolumeExperimental> {}

abstract class IPrimitiveVolumeExperimental
    implements
        IVolumeExperimental,
        IPositionRotationScaleExperimental,
        ITransformable3D<IPrimitiveVolumeExperimental> {}

// This assumes a linear extrusion. This is a degenerate case of ILoftedCurve
abstract class IExtrudedCurveExperimental implements ISurfaceExperimental {
  ICurveExperimental get from;
  ICurveExperimental get to;
}

// Sampling a curve along 0..1 gives us some interesting shapes.
abstract class ILoftedCurveExperimental implements ISurfaceExperimental {
  ICurveExperimental sample(double t);
}

// class PrimitiveShapes {
//   // Not sure this should be a shape (it isn't closed)
//   static IPrimitiveCurve LineSegment;

//   static IPrimitiveShape Circle;
//   static IPrimitiveShape Triangle;
//   static IPrimitiveShape Square;
//   static IPrimitiveShape Hexagon;
//   static IPrimitiveShape Pentagon;

//   static IPrimitiveVolume Box;
//   static IPrimitiveVolume Cone;
//   static IPrimitiveVolume Capsule;
//   static IPrimitiveVolume Cylinder;
//   static IPrimitiveVolume Sphere;
//   static IPrimitiveVolume Pyramid;
//   static IPrimitiveVolume Prism;
//   static IPrimitiveVolume Tetrahedron;
//   static IPrimitiveVolume Octahedron;
//   static IPrimitiveVolume Dodecahedron;
//   static IPrimitiveVolume Icosahedron;
// }
