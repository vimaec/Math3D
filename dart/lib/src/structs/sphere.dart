part of '../../vim_math3d.dart';

/// Describes a sphere in 3D-space for bounding operations.
class Sphere implements ITransformable3D<Sphere> {
  final Vector3 center;
  final double radius;

  static const Sphere zero = Sphere(Vector3.zero, 0);
  static const Sphere minValue = Sphere(Vector3.minValue, -double.maxFinite);
  static const Sphere maxValue = Sphere(Vector3.maxValue, double.maxFinite);

  const Sphere(this.center, this.radius);
  // Creates the smallest sphere that contains the box.
  factory Sphere.box(AABox box) {
    final center = box.center;
    final radius = center.distance(box.max);
    return Sphere(center, radius);
  }
  // Creates the smallest Sphere that contains the given points
  factory Sphere.points(Iterable<Vector3> points) {
    // From "Real-Time Collision Detection" (Page 89)
    var minx = Vector3.maxValue;
    var maxx = -minx;
    var miny = minx;
    var maxy = -minx;
    var minz = minx;
    var maxz = -minx;

    // Find the most extreme points along the principle axis.
    var numPoints = 0;
    for (var pt in points) {
      ++numPoints;
      if (pt.x < minx.x) {
        minx = pt;
      }
      if (pt.x > maxx.x) {
        maxx = pt;
      }
      if (pt.y < miny.y) {
        miny = pt;
      }
      if (pt.y > maxy.y) {
        maxy = pt;
      }
      if (pt.z < minz.z) {
        minz = pt;
      }
      if (pt.z > maxz.z) {
        maxz = pt;
      }
    }
    if (numPoints == 0) {
      throw Exception("You should have at least one point in points.");
    }
    final sqDistX = maxx.distanceSquared(minx);
    final sqDistY = maxy.distanceSquared(miny);
    final sqDistZ = maxz.distanceSquared(minz);
    // Pick the pair of most distant points.
    var min = minx;
    var max = maxx;
    if (sqDistY > sqDistX && sqDistY > sqDistZ) {
      max = maxy;
      min = miny;
    }
    if (sqDistZ > sqDistX && sqDistZ > sqDistY) {
      max = maxz;
      min = minz;
    }
    var center = (min + max) * 0.5;
    var radius = max.distance(center);
    // Test every point and expand the sphere.
    // The current bounding sphere is just a good approximation and may not enclose all points.
    // From: Mathematics for 3D Game Programming and Computer Graphics, Eric Lengyel, Third Edition.
    // Page 218
    var sqRadius = radius * radius;
    for (var pt in points) {
      var diff = pt - center;
      var sqDist = diff.lengthSquared;
      if (sqDist > sqRadius) {
        var distance = sqDist.sqrt();
        // equal to diff.Length();
        var direction = diff / distance;
        //var g = center - radius * direction;
        final g = center - direction * radius;
        center = (g + pt) / 2.0;
        radius = pt.distance(center);
        sqRadius = radius * radius;
      }
    }
    return Sphere(center, radius);
  }

  @override
  int get hashCode => Hash.combine(center.hashCode, radius.hashCode);

  bool almostEquals(Sphere x, [double tolerance = Constants.tolerance]) =>
      center.almostEquals(x.center, tolerance) &&
      radius.almostEquals(x.radius, tolerance);
  Sphere setCenter(Vector3 x) => Sphere(x, radius);
  Sphere setRadius(double x) => Sphere(center, x);
  Sphere translate(Vector3 offset) => Sphere(center + offset, radius);
  double distanceVector3(Vector3 point) =>
      (center.distance(point) - radius).clampLower(0.0);
  double distance(Sphere other) =>
      (center.distance(other.center) - radius - other.radius).clampLower(0.0);
  // Gets whether or not a specified [Ray] intersects with this sphere.
  double? intersectsRay(Ray ray) => ray.intersectsSphere(this);
  // Gets whether or not a specified [AABox] intersects with this sphere.
  bool intersectsBox(AABox box) => box.intersectsSphere(this);
  // Gets whether or not the other [Sphere] intersects with this sphere.
  bool intersects(Sphere sphere) {
    final sqDistance = sphere.center.distanceSquared(center);
    return !(sqDistance > (sphere.radius + radius) * (sphere.radius + radius));
  }

  // Gets whether or not a specified [Plane] intersects with this sphere.
  PlaneIntersectionType intersectsPlane(Plane plane) {
    var distance = plane.normal.dot(center);
    distance += plane.d;
    if (distance > radius) {
      return PlaneIntersectionType.front;
    }
    if (distance < -radius) {
      return PlaneIntersectionType.back;
    }
    return PlaneIntersectionType.intersecting;
  }

  // Creates a sphere merging it with another
  Sphere merge(Sphere additional) {
    var ocenterToaCenter = additional.center - center;
    final distance = ocenterToaCenter.length;
    if (distance <= radius + additional.radius) {
      if (distance <= radius - additional.radius) {
        return this;
      }
      if (distance <= additional.radius - radius) {
        return additional;
      }
    }
    //else find center of new sphere and radius
    final leftRadius = (radius - distance).max(additional.radius);
    final rightradius = (radius + distance).max(additional.radius);
    ocenterToaCenter = ocenterToaCenter +
        (ocenterToaCenter *
            (leftRadius - rightradius) /
            (2.0 * ocenterToaCenter.length));
    return Sphere(center + ocenterToaCenter, (leftRadius + rightradius) / 2.0);
  }

  /// Test if a bounding box is fully inside, outside, or just intersecting the sphere.
  ContainmentType containsBox(AABox box) {
    //check if all corner is in sphere
    var inside = true;
    for (var corner in box.corners) {
      if (containsVector3(corner) == ContainmentType.disjoint) {
        inside = false;
        break;
      }
    }
    if (inside) {
      return ContainmentType.contains;
    }
    //check if the distance from sphere center to cube face < radius
    double dmin = 0.0;
    if (center.x < box.min.x) {
      dmin += (center.x - box.min.x) * (center.x - box.min.x);
    } else if (center.x > box.max.x) {
      dmin += (center.x - box.max.x) * (center.x - box.max.x);
    }
    if (center.y < box.min.y) {
      dmin += (center.y - box.min.y) * (center.y - box.min.y);
    } else if (center.y > box.max.y) {
      dmin += (center.y - box.max.y) * (center.y - box.max.y);
    }
    if (center.z < box.min.z) {
      dmin += (center.z - box.min.z) * (center.z - box.min.z);
    } else if (center.z > box.max.z) {
      dmin += (center.z - box.max.z) * (center.z - box.max.z);
    }
    if (dmin <= radius * radius) {
      return ContainmentType.intersects;
    }
    //else disjoint
    return ContainmentType.disjoint;
  }

  /// Test if a sphere is fully inside, outside, or just intersecting the sphere.
  ContainmentType contains(Sphere sphere) {
    final sqDistance = sphere.center.distanceSquared(center);
    if (sqDistance > (sphere.radius + radius) * (sphere.radius + radius)) {
      return ContainmentType.disjoint;
    }
    if (sqDistance <= (radius - sphere.radius) * (radius - sphere.radius)) {
      return ContainmentType.contains;
    }
    return ContainmentType.intersects;
  }

  /// Test if a point is fully inside, outside, or just intersecting the sphere.
  ContainmentType containsVector3(Vector3 point) {
    var result = ContainmentType.disjoint;
    final sqRadius = radius * radius;
    final sqDistance = point.distanceSquared(center);

    if (sqDistance > sqRadius) {
      result = ContainmentType.disjoint;
    } else if (sqDistance < sqRadius) {
      result = ContainmentType.contains;
    } else {
      result = ContainmentType.intersects;
    }
    return result;
  }

  @override
  Sphere transform(Matrix4x4 m) => Sphere(
      center.transform(m),
      radius *
          ((((m.m11 * m.m11) + (m.m12 * m.m12) + (m.m13 * m.m13)).max(
                  ((m.m21 * m.m21) + (m.m22 * m.m22) + (m.m23 * m.m23)).max(
                      (m.m31 * m.m31) + (m.m32 * m.m32) + (m.m33 * m.m33))))
              .sqrt()));
  @override
  String toString() => "Sphere(Center = $center, Radius = $radius)";

  @override
  bool operator ==(Object other) =>
      other is Sphere && (center == other.center && radius == other.radius);
}
