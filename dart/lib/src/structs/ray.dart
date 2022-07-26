part of '../../vim_math3d.dart';

class Ray implements ITransformable3D<Ray> {
  final Vector3 position;
  final Vector3 direction;

  static const Ray zero = Ray(Vector3.zero, Vector3.zero);
  static const Ray minValue = Ray(Vector3.minValue, Vector3.minValue);
  static const Ray maxValue = Ray(Vector3.maxValue, Vector3.maxValue);

  @override
  int get hashCode => Hash.combine(position.hashCode, direction.hashCode);

  const Ray(this.position, this.direction);

  factory Ray.fromProjectionMatrix(
    Matrix4x4 mtx,
    Vector2 normalisedScreenCoordinates,
  ) {
    final invProjection = mtx.inverse();

    final invertedY = Vector2(
        normalisedScreenCoordinates.x, 1.0 - normalisedScreenCoordinates.y);
    final scalesNormalisedScreenCoordinates = invertedY * 2.0 - 1.0;

    var p0 = Vector4.fromVector2(scalesNormalisedScreenCoordinates, 0.0, 1.0);
    var p1 = Vector4.fromVector2(scalesNormalisedScreenCoordinates, 1.0, 1.0);

    p0 = p0.transform(invProjection);
    p1 = p1.transform(invProjection);

    p0 = p0 / p0.w;
    p1 = p1 / p1.w;

    final ret = Ray(p0.toVector3(), (p1 - p0).toVector3().normalize());
    return ret;
  }

  // adapted from http://www.scratchapixel.com/lessons/3d-basic-lessons/lesson-7-intersecting-simple-shapes/ray-box-intersection/
  double? intersectsBox(AABox box) {
    const epsilon = 1e-06;

    double? tMin, tMax;
    if (direction.x.abs() < epsilon) {
      if (position.x < box.min.x || position.x > box.max.x) {
        return null;
      }
    } else {
      tMin = (box.min.x - position.x) / direction.x;
      tMax = (box.max.x - position.x) / direction.x;

      if (tMin > tMax) {
        final temp = tMin;
        tMin = tMax;
        tMax = temp;
      }
    }

    if (direction.y.abs() < epsilon) {
      if (position.y < box.min.y || position.y > box.max.y) {
        return null;
      }
    } else {
      var tMinY = (box.min.y - position.y) / direction.y;
      var tMaxY = (box.max.y - position.y) / direction.y;

      if (tMinY > tMaxY) {
        final temp = tMinY;
        tMinY = tMaxY;
        tMaxY = temp;
      }

      if ((tMin != null && tMin > tMaxY) || (tMax != null && tMinY > tMax)) {
        return null;
      }

      if (tMin == null || tMinY > tMin) {
        tMin = tMinY;
      }

      if (tMax == null || tMaxY < tMax) {
        tMax = tMaxY;
      }
    }

    if (direction.z.abs() < epsilon) {
      if (position.z < box.min.z || position.z > box.max.z) {
        return null;
      }
    } else {
      var tMinZ = (box.min.z - position.z) / direction.z;
      var tMaxZ = (box.max.z - position.z) / direction.z;

      if (tMinZ > tMaxZ) {
        final temp = tMinZ;
        tMinZ = tMaxZ;
        tMaxZ = temp;
      }

      if ((tMin != null && tMin > tMaxZ) || (tMax != null && tMinZ > tMax)) {
        return null;
      }

      if (tMin == null || tMinZ > tMin) {
        tMin = tMinZ;
      }

      if (tMax == null || tMaxZ < tMax) {
        tMax = tMaxZ;
      }
    }

    // having a positive tMin and a negative tMax means the ray is inside the box
    // we expect the intesection distance to be 0 in that case
    if ((tMin != null && tMin < 0) && (tMax != null && tMax > 0)) {
      return 0;
    }

    // a negative tMin means that the intersection point is behind the ray's origin
    // we discard these as not hitting the AABB
    if (tMin != null && tMin < 0) {
      return null;
    }

    return tMin;
  }

  double? intersects(Plane plane, [double tolerance = Constants.tolerance]) {
    final den = direction.dot(plane.normal);
    if (den.abs() < tolerance) {
      return null;
    }
    var result = (-plane.d - plane.normal.dot(position)) / den;
    if (result < 0.0) {
      if (result < -tolerance) {
        return null;
      }
      result = 0.0;
    }
    return result;
  }

  double? intersectsSphere(Sphere sphere) {
    // Find the vector between where the ray starts the the sphere's centre
    final difference = sphere.center - position;
    final differenceLengthSq = difference.lengthSquared;
    final sphereRadiusSq = sphere.radius * sphere.radius;
    // If the distance between the ray start and the sphere's centre is less than
    // the radius of the sphere, it means we've intersected. N.B. checking the LengthSquared is faster.
    if (differenceLengthSq < sphereRadiusSq) {
      return 0;
    }
    final distanceAlongRay = direction.dot(difference);
    // If the ray is pointing away from the sphere then we don't ever intersect
    if (distanceAlongRay < 0.0) {
      return null;
    }
    // Next we kinda use Pythagoras to check if we are within the bounds of the sphere
    // if x = radius of sphere
    // if y = distance between ray position and sphere centre
    // if z = the distance we've travelled along the ray
    // if x^2 + z^2 - y^2 < 0, we do not intersect
    final dist = sphereRadiusSq + distanceAlongRay.sqr() - differenceLengthSq;
    return (dist < 0.0) ? null : distanceAlongRay - dist.sqrt();
  }

  // Adapted from https://en.wikipedia.org/wiki/M%C3%B6ller%E2%80%93Trumbore_intersection_algorithm
  // Does not require or benefit from precomputed normals.
  double? intersectsTriangle(Triangle tri,
      [double tolerance = Constants.tolerance]) {
    final edge1 = tri.b - tri.a;
    final edge2 = tri.c - tri.a;

    final h = direction.cross(edge2);
    final a = edge1.dot(h);
    if (a > -tolerance && a < tolerance) {
      return null;
      // This ray is parallel to this triangle.
    }
    final f = 1.0 / a;
    final s = position - tri.a;
    final u = f * s.dot(h);
    if (u < 0.0 || u > 1.0) {
      return null;
    }
    final q = s.cross(edge1);
    final v = f * direction.dot(q);
    if (v < 0.0 || u + v > 1.0) {
      return null;
    }
    // At this stage we can compute t to find out where the intersection point is on the line.
    final t = f * edge2.dot(q);
    if (t > tolerance) {
      return t;
    }
    // This means that there is a line intersection but not a ray intersection.
    return null;
  }

  bool almostEquals(Ray x, [double tolerance = Constants.tolerance]) =>
      position.almostEquals(x.position, tolerance) &&
      direction.almostEquals(x.direction, tolerance);
  Ray setPosition(Vector3 x) => Ray(x, direction);
  Ray setDirection(Vector3 x) => Ray(position, x);

  @override
  Ray transform(Matrix4x4 mat) =>
      Ray(position.transform(mat), direction.transformNormal(mat));
  @override
  String toString() => "Ray(Position = $position, Direction = $direction)";

  @override
  bool operator ==(Object other) =>
      other is Ray &&
      (position == other.position && direction == other.direction);
}
