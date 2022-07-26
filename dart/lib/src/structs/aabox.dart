part of '../../vim_math3d.dart';

class AABox implements Comparable<AABox>, ITransformable3D<AABox> {
  final Vector3 min;
  final Vector3 max;
  // CCW
  static const List<int> topIndices = [0, 1, 2, 3];
  static const List<int> bottomIndices = [7, 6, 5, 4];
  static const List<int> frontIndices = [4, 5, 1, 0];
  static const List<int> rightIndices = [5, 6, 2, 1];
  static const List<int> backIndices = [6, 7, 3, 2];
  static const List<int> leftIndices = [7, 4, 0, 3];

  static const AABox unit = AABox(Vector3.zero, Vector3.value(1.0));
  static const AABox zero = AABox(Vector3.zero, Vector3.zero);
  static const AABox minValue = AABox(Vector3.minValue, Vector3.minValue);
  static const AABox maxValue = AABox(Vector3.maxValue, Vector3.maxValue);
  static const AABox empty = AABox(Vector3.maxValue, Vector3.minValue);

  const AABox(this.min, this.max);

  /// Create a bounding box from the given list of points.
  factory AABox.points([Iterable<Vector3>? points]) {
    var minVec = Vector3.maxValue;
    var maxVec = Vector3.minValue;
    if (points != null) {
      for (var pt in points) {
        minVec = minVec.min(pt);
        maxVec = maxVec.max(pt);
      }
    }
    return AABox(minVec, maxVec);
  }
  factory AABox.fromSphere(Sphere sphere) => AABox(
      sphere.center - Vector3.value(sphere.radius),
      sphere.center + Vector3.value(sphere.radius));
  factory AABox.fromCenterAndExtent(Vector3 center, Vector3 extent) =>
      AABox(center - extent / 2.0, center + extent / 2.0);

  final int count = 2;
  Vector3 get centerBottom => center.setZ(min.z);
  List<Vector3> get corners => getCorners();
  bool get isEmpty => !isValid;
  bool get isValid => min.x <= max.x && min.y <= max.y && min.z <= max.z;
  double get distanceToOrigin => distance(Vector3.zero);
  double get centerDistanceToOrigin => centerDistance(Vector3.zero);
  double get volume => isEmpty ? 0.0 : extent.productComponents();
  double get maxSide => extent.maxComponent();
  double get maxFaceArea => extent.x > extent.y
      ? extent.x * extent.z.max(extent.y)
      : extent.y * extent.z.max(extent.x);
  double get minSide => extent.minComponent();
  double get diagonal => extent.length;
  Vector3 get extent => (max - min);
  Vector3 get center => min.average(max);
  double get magnitudeSquared => extent.magnitudeSquared();
  double get magnitude => magnitudeSquared.sqrt();
  bool get isNaN => min.isNaN || max.isNaN;
  bool get isInfinite => min.isInfinite || max.isInfinite;
  @override
  int get hashCode => Hash.combine(min.hashCode, max.hashCode);

  // Inspired by: https://stackoverflow.com/questions/5254838/calculating-distance-between-a-point-and-a-rectangular-box-nearest-point
  double distance(Vector3 p) => Vector3.zero.max(min - p).max(p - max).length;
  // Returns the distance of the point to the box center.
  double centerDistance(Vector3 p) => center.distance(p);
  // Moves the box by the given vector offset
  AABox translate(Vector3 offset) => AABox(min + offset, max + offset);
  ContainmentType contains(AABox box) {
    //test if all corner is in the same side of a face by just checking min and max
    if (box.max.x < min.x ||
        box.min.x > max.x ||
        box.max.y < min.y ||
        box.min.y > max.y ||
        box.max.z < min.z ||
        box.min.z > max.z) {
      return ContainmentType.disjoint;
    }
    if (box.min.x >= min.x &&
        box.max.x <= max.x &&
        box.min.y >= min.y &&
        box.max.y <= max.y &&
        box.min.z >= min.z &&
        box.max.z <= max.z) {
      return ContainmentType.contains;
    }
    return ContainmentType.intersects;
  }

  ContainmentType containsSphere(Sphere sphere) {
    if (sphere.center.x - min.x >= sphere.radius &&
        sphere.center.y - min.y >= sphere.radius &&
        sphere.center.z - min.z >= sphere.radius &&
        max.x - sphere.center.x >= sphere.radius &&
        max.y - sphere.center.y >= sphere.radius &&
        max.z - sphere.center.z >= sphere.radius) {
      return ContainmentType.contains;
    }
    double dmin = 0.0;
    double e = sphere.center.x - min.x;
    if (e < 0.0) {
      if (e < -sphere.radius) {
        return ContainmentType.disjoint;
      }
      dmin += e * e;
    } else {
      e = sphere.center.x - max.x;
      if (e > 0.0) {
        if (e > sphere.radius) {
          return ContainmentType.disjoint;
        }
        dmin += e * e;
      }
    }
    e = sphere.center.y - min.y;
    if (e < 0.0) {
      if (e < -sphere.radius) {
        return ContainmentType.disjoint;
      }
      dmin += e * e;
    } else {
      e = sphere.center.y - max.y;
      if (e > 0.0) {
        if (e > sphere.radius) {
          return ContainmentType.disjoint;
        }
        dmin += e * e;
      }
    }
    e = sphere.center.z - min.z;
    if (e < 0.0) {
      if (e < -sphere.radius) {
        return ContainmentType.disjoint;
      }
      dmin += e * e;
    } else {
      e = sphere.center.z - max.z;
      if (e > 0.0) {
        if (e > sphere.radius) {
          return ContainmentType.disjoint;
        }
        dmin += e * e;
      }
    }
    if (dmin <= sphere.radius * sphere.radius) {
      return ContainmentType.intersects;
    }
    return ContainmentType.disjoint;
  }

  bool containsVector3(Vector3 point) => !(point.x < min.x ||
      point.x > max.x ||
      point.y < min.y ||
      point.y > max.y ||
      point.z < min.z ||
      point.z > max.z);
  // This is the four front corners followed by the four back corners all as if looking from the front
  // going in counter-clockwise order from bottom left.
  List<Vector3> getCorners([List<Vector3>? corners]) {
    corners = corners ?? <Vector3>[];
    if (corners.length < 8) {
      throw RangeError.range(corners.length, 0, 8);
    }
    // Bottom (looking down)
    corners[0] = Vector3(min.x, min.y, min.z);
    corners[1] = Vector3(max.x, min.y, min.z);
    corners[2] = Vector3(max.x, max.y, min.z);
    corners[3] = Vector3(min.x, max.y, min.z);
    // Top (looking down)
    corners[4] = Vector3(min.x, min.y, max.z);
    corners[5] = Vector3(max.x, min.y, max.z);
    corners[6] = Vector3(max.x, max.y, max.z);
    corners[7] = Vector3(min.x, max.y, max.z);
    return corners;
  }

  bool intersects(AABox box) => (max.x >= box.min.x) && (min.x <= box.max.x)
      ? (max.y < box.min.y) || (min.y > box.max.y)
          ? false
          : (max.z >= box.min.z) && (min.z <= box.max.z)
      : false;
  bool intersectsSphere(Sphere sphere) {
    if (sphere.center.x - min.x > sphere.radius &&
        sphere.center.y - min.y > sphere.radius &&
        sphere.center.z - min.z > sphere.radius &&
        max.x - sphere.center.x > sphere.radius &&
        max.y - sphere.center.y > sphere.radius &&
        max.z - sphere.center.z > sphere.radius) {
      return true;
    }
    double dmin = 0.0;
    if (sphere.center.x - min.x <= sphere.radius) {
      dmin += (sphere.center.x - min.x) * (sphere.center.x - min.x);
    } else if (max.x - sphere.center.x <= sphere.radius) {
      dmin += (sphere.center.x - max.x) * (sphere.center.x - max.x);
    }
    if (sphere.center.y - min.y <= sphere.radius) {
      dmin += (sphere.center.y - min.y) * (sphere.center.y - min.y);
    } else if (max.y - sphere.center.y <= sphere.radius) {
      dmin += (sphere.center.y - max.y) * (sphere.center.y - max.y);
    }
    if (sphere.center.z - min.z <= sphere.radius) {
      dmin += (sphere.center.z - min.z) * (sphere.center.z - min.z);
    } else if (max.z - sphere.center.z <= sphere.radius) {
      dmin += (sphere.center.z - max.z) * (sphere.center.z - max.z);
    }
    if (dmin <= sphere.radius * sphere.radius) {
      return true;
    }
    return false;
  }

  PlaneIntersectionType intersectsPlane(Plane plane) {
    // See http://zach.in.tu-clausthal.de/teaching/cg_literatur/lighthouse3d_view_frustum_culling/index.html
    double ax = 0.0, ay = 0.0, az = 0.0, bx = 0.0, by = 0.0, bz = 0.0;
    if (plane.normal.x >= 0.0) {
      ax = max.x;
      bx = min.x;
    } else {
      ax = min.x;
      bx = max.x;
    }

    if (plane.normal.y >= 0.0) {
      ay = max.y;
      by = min.y;
    } else {
      ay = min.y;
      by = max.y;
    }

    if (plane.normal.z >= 0.0) {
      az = max.z;
      bz = min.z;
    } else {
      az = min.z;
      bz = max.z;
    }
    // Inline Vector3.Dot(plane.Normal, negativeVertex) + plane.D;
    var distance = plane.normal.x * bx +
        plane.normal.y * by +
        plane.normal.z * bz +
        plane.d;
    if (distance > 0.0) {
      return PlaneIntersectionType.front;
    }
    // Inline Vector3.Dot(plane.Normal, positiveVertex) + plane.D;
    distance = plane.normal.x * ax +
        plane.normal.y * ay +
        plane.normal.z * az +
        plane.d;
    if (distance < 0.0) {
      return PlaneIntersectionType.back;
    }
    return PlaneIntersectionType.intersecting;
  }

  // Returns where a point is relative to the bounding box on a scale of 0..1
  Vector3 relativePosition(Vector3 v) => v.inverseLerp(min, max);
  // Moves the box so that it's origin is on the center
  AABox recenter() => translate(-center);
  // Rescales the box
  AABox scale(double scale) =>
      AABox(recenter().min * scale, recenter().max * scale).translate(center);
  // Returns the center of each face.
  List<Vector3> faceCenters() {
    final corners = getCorners();
    return [
      corners[frontIndices[0]].average(corners[frontIndices[2]]),
      corners[rightIndices[0]].average(corners[rightIndices[2]]),
      corners[backIndices[0]].average(corners[backIndices[2]]),
      corners[leftIndices[0]].average(corners[leftIndices[2]]),
      corners[topIndices[0]].average(corners[topIndices[2]]),
      corners[bottomIndices[0]].average(corners[bottomIndices[2]])
    ];
  }

  Iterable<Vector3> getCornersAndFaceCenters() => (corners + faceCenters());
  // Given a normalized position in bounding box, returns the actual position.
  Vector3 lerp(Vector3 v) => min + extent * v;
  AABox setCenter(Vector3 v) => AABox.fromCenterAndExtent(v, extent);
  AABox setExtent(Vector3 v) => AABox.fromCenterAndExtent(center, v);
  bool almostEquals(AABox value, [double tolerance = Constants.tolerance]) =>
      min.almostEquals(value.min, tolerance) &&
      max.almostEquals(value.max, tolerance);
  AABox setMin(Vector3 value) => AABox(value, max);
  AABox setMax(Vector3 value) => AABox(min, value);
  AABox merge(AABox other) => AABox(min.min(other.min), max.max(other.max));
  AABox mergeVector3(Vector3 other) => AABox(min.min(other), max.max(other));
  AABox intersection(AABox other) =>
      AABox(min.max(other.min), max.min(other.max));
  static List<AABox> toAABoxArray(List<double> m) {
    int numFloats = 6;
    assert((m.length % numFloats) == 0);
    final ret = <AABox>[];
    for (var i = 0; i < ret.length; i++) {
      final i6 = i * numFloats;
      ret[i] = AABox(Vector3(m[i6 + 0], m[i6 + 1], m[i6 + 2]),
          Vector3(m[i6 + 3], m[i6 + 4], m[i6 + 5]));
    }
    return ret;
  }

  // Returns the enclosing bounding sphere.
  Sphere toSphere() => Sphere.box(this);

  @override
  AABox transform(Matrix4x4 mat) =>
      AABox.points(corners.map((v) => v.transform(mat)));
  @override
  String toString() => "AABox(Min = $min, Max = $max)";
  @override
  int compareTo(AABox x) =>
      (magnitudeSquared - x.magnitudeSquared).sign.toInt();

  @override
  bool operator ==(Object other) =>
      other is AABox && (min == other.min && max == other.max);
  AABox operator +(Object other) => other is AABox
      ? merge(other)
      : other is Vector3
          ? mergeVector3(other)
          : throw UnsupportedError('operator + (${other.runtimeType})');
  AABox operator -(AABox value2) => intersection(value2);
  Vector3 operator [](int n) => n == 0 ? min : max;
  bool operator <(AABox x1) => compareTo(x1) < 0;
  bool operator <=(AABox x1) => compareTo(x1) <= 0;
  bool operator >(AABox x1) => compareTo(x1) > 0;
  bool operator >=(AABox x1) => compareTo(x1) >= 0;
}

class AABox2D implements Comparable<AABox2D> {
  final Vector2 min;
  final Vector2 max;

  // CCW
  static const List<int> indices = [0, 1, 2, 3];
  static const AABox2D unit = AABox2D(Vector2.zero, Vector2.value(1.0));
  static const AABox2D empty = AABox2D(Vector2.maxValue, Vector2.minValue);
  static const AABox2D zero = AABox2D(Vector2.zero, Vector2.zero);
  static const AABox2D minValue = AABox2D(Vector2.minValue, Vector2.minValue);
  static const AABox2D maxValue = AABox2D(Vector2.maxValue, Vector2.maxValue);

  const AABox2D(this.min, this.max);

  /// Create a bounding box from the given list of points.
  factory AABox2D.points(Iterable<Vector2> points) {
    var minVec = Vector2.maxValue;
    var maxVec = Vector2.minValue;
    for (var pt in points) {
      minVec = minVec.min(pt);
      maxVec = maxVec.max(pt);
    }
    return AABox2D(minVec, maxVec);
  }

  final int count = 2;
  Vector2 get centerBottom => center.setY(min.y);
  List<Vector2> get corners => getCorners();
  bool get isEmpty => !isValid;
  bool get isValid => min.x <= max.x && min.y <= max.y;
  double get distanceToOrigin => distance(Vector2.zero);
  double get centerDistanceToOrigin => centerDistance(Vector2.zero);
  double get area => isEmpty ? 0.0 : extent.productComponents();
  double get maxSide => extent.maxComponent();
  double get minSide => extent.minComponent();
  double get diagonal => extent.length;
  Vector2 get extent => (max - min);
  Vector2 get center => min.average(max);
  bool get isNaN => min.isNaN || max.isNaN;
  bool get isInfinity => min.isInfinite || max.isInfinite;
  @override
  int get hashCode => Hash.combine(min.hashCode, max.hashCode);

  double distance(Vector2 point) =>
      Vector2.zero.max(min - point).max(point - max).length;
  // Returns the distance of the point to the box center.
  double centerDistance(Vector2 point) => center.distance(point);
  // Moves the box by the given vector offset
  AABox2D translate(Vector2 offset) => AABox2D(min + offset, max + offset);
  ContainmentType contains(AABox2D box) {
    //test if all corner is in the same side of a face by just checking min and max
    if (box.max.x < min.x ||
        box.min.x > max.x ||
        box.max.y < min.y ||
        box.min.y > max.y) {
      return ContainmentType.disjoint;
    }
    if (box.min.x >= min.x &&
        box.max.x <= max.x &&
        box.min.y >= min.y &&
        box.max.y <= max.y) {
      return ContainmentType.contains;
    }
    return ContainmentType.intersects;
  }

  bool containsVector(Vector2 point) => !(point.x < min.x ||
      point.x > max.x ||
      point.y < min.y ||
      point.y > max.y);
  List<Vector2> getCorners([List<Vector2>? corners]) {
    corners = corners ?? List.filled(4, Vector2.zero);
    if (corners.length < 4) {
      throw RangeError.value(corners.length, 'corners');
    }
    corners[0] = Vector2(min.x, min.y);
    corners[1] = Vector2(max.x, min.y);
    corners[2] = Vector2(max.x, max.y);
    corners[3] = Vector2(min.x, max.y);
    return corners;
  }

  bool intersects(AABox2D box2) =>
      min.x <= box2.max.x &&
      max.x >= box2.min.x &&
      min.y <= box2.max.y &&
      max.y >= box2.min.y;

  /// Returns where a point is relative to the bounding box on a scale of 0..1
  Vector2 relativePosition(Vector2 v) => v.inverseLerp(min, max);

  /// Moves the box so that it's origin is on the center
  AABox2D recenter() => translate(-center);

  /// Rescales the box
  AABox2D scale(double scale) =>
      AABox2D(recenter().min * scale, recenter().max * scale).translate(center);
  bool almostEquals(AABox2D x, [double tolerance = Constants.tolerance]) =>
      min.almostEquals(x.min, tolerance) && max.almostEquals(x.max, tolerance);
  AABox2D setMin(Vector2 x) => AABox2D(x, max);
  AABox2D setMax(Vector2 x) => AABox2D(min, x);
  double magnitudeSquared() => extent.magnitudeSquared();
  double magnitude() => magnitudeSquared().sqrt();
  AABox2D mergeVector(Vector2 other) => AABox2D(min.min(other), max.max(other));
  AABox2D merge(AABox2D other) =>
      AABox2D(min.min(other.min), max.max(other.max));
  AABox2D intersection(AABox2D other) =>
      AABox2D(min.max(other.min), max.min(other.max));

  @override
  String toString() => "AABox2D(Min = $min, Max = $max)";
  @override
  int compareTo(AABox2D x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();

  @override
  bool operator ==(Object other) =>
      other is AABox2D && (min == other.min && max == other.max);
  AABox2D operator -(AABox2D value2) => intersection(value2);
  AABox2D operator +(Object value2) => value2 is AABox2D
      ? merge(value2)
      : value2 is Vector2
          ? mergeVector(value2)
          : throw UnsupportedError('operator + (${value2.runtimeType})');
  bool operator <(AABox2D x1) => compareTo(x1) < 0;
  bool operator <=(AABox2D x1) => compareTo(x1) <= 0;
  bool operator >(AABox2D x1) => compareTo(x1) > 0;
  bool operator >=(AABox2D x1) => compareTo(x1) >= 0;
  Vector2 operator [](int n) => n == 0 ? min : max;
}

class AABox4D implements Comparable<AABox4D> {
  final Vector4 min;
  final Vector4 max;

  static const AABox4D zero = AABox4D(Vector4.zero, Vector4.zero);
  static const AABox4D minValue = AABox4D(Vector4.minValue, Vector4.minValue);
  static const AABox4D maxValue = AABox4D(Vector4.maxValue, Vector4.maxValue);
  static const AABox4D empty = AABox4D(Vector4.maxValue, Vector4.minValue);

  const AABox4D(this.min, this.max);

  Vector4 get extent => (max - min);
  Vector4 get center => min.average(max);
  bool get isNaN => min.isNaN || max.isNaN;
  bool get isInfinite => min.isInfinite || max.isInfinite;
  @override
  int get hashCode => Hash.combine(min.hashCode, max.hashCode);

  bool almostEquals(AABox4D x, [double tolerance = Constants.tolerance]) =>
      min.almostEquals(x.min, tolerance) && max.almostEquals(x.max, tolerance);
  AABox4D setMin(Vector4 x) => AABox4D(x, max);
  AABox4D setMax(Vector4 x) => AABox4D(min, x);
  double magnitudeSquared() => extent.magnitudeSquared();
  double magnitude() => magnitudeSquared().sqrt();
  AABox4D merge(AABox4D x) => AABox4D(min.min(x.min), max.max(x.max));
  AABox4D mergeVector(Vector4 x) => AABox4D(min.min(x), max.max(x));
  AABox4D intersection(AABox4D x) => AABox4D(min.max(x.min), max.min(x.max));

  @override
  int compareTo(AABox4D x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() => "AABox4D(Min = $min, Max = $max)";

  @override
  bool operator ==(Object other) =>
      other is AABox4D && (min == other.min && max == other.max);
  AABox4D operator +(Object value2) => value2 is AABox4D
      ? merge(value2)
      : value2 is Vector4
          ? mergeVector(value2)
          : throw UnsupportedError('operator + (${value2.runtimeType})');
  AABox4D operator -(AABox4D value2) => intersection(value2);
  bool operator <(AABox4D x1) => compareTo(x1) < 0;
  bool operator <=(AABox4D x1) => compareTo(x1) <= 0;
  bool operator >(AABox4D x1) => compareTo(x1) > 0;
  bool operator >=(AABox4D x1) => compareTo(x1) >= 0;
}
