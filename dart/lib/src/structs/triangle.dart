part of '../../vim_math3d.dart';

class Triangle
    implements
        ITransformable3D<Triangle>,
        IPoints,
        IMappable<Triangle, Vector3> {
  final Vector3 a;
  final Vector3 b;
  final Vector3 c;

  static const Triangle zero = Triangle.value(Vector3.zero);
  static const Triangle minValue = Triangle.value(Vector3.minValue);
  static const Triangle maxValue = Triangle.value(Vector3.maxValue);

  const Triangle(this.a, this.b, this.c);
  const Triangle.value(Vector3 value) : this(value, value, value);

  double get lengthA => a.distance(b);
  double get lengthB => b.distance(c);
  double get lengthC => c.distance(a);
  bool get hasArea => a != b && b != c && c != a;
  double get area => (b - a).cross(c - a).length * 0.5;
  double get perimeter => lengthA + lengthB + lengthC;
  Vector3 get midPoint => (a + b + c) / 3.0;
  Vector3 get normalDirection => (b - a).cross(c - a);
  Vector3 get normal => normalDirection.normalize();
  Vector3 get safeNormal => normalDirection.safeNormalize();
  AABox get boundingBox => AABox.points([a, b, c]);
  Sphere get boundingSphere => Sphere.points([a, b, c]);
  Vector3 get binormal => (b - a).safeNormalize();
  Vector3 get tangent => (c - a).safeNormalize();
  Line get aB => Line(a, b);
  Line get bC => Line(b, c);
  Line get cA => Line(c, a);
  Line get bA => aB.inverse;
  Line get cB => bC.inverse;
  Line get aC => cA.inverse;
  @override
  int get numPoints => 3;
  @override
  int get hashCode => Hash.combine3(a.hashCode, b.hashCode, c.hashCode);

  bool isSliver([double tolerance = Constants.tolerance]) =>
      lengthA <= tolerance || lengthB <= tolerance || lengthC <= tolerance;
  Line side(int n) => n == 0
      ? aB
      : n == 1
          ? bC
          : cA;
  bool almostEquals(Triangle x, [double tolerance = Constants.tolerance]) =>
      a.almostEquals(x.a, tolerance) &&
      b.almostEquals(x.b, tolerance) &&
      c.almostEquals(x.c, tolerance);
  Triangle setA(Vector3 x) => Triangle(x, b, c);
  Triangle setB(Vector3 x) => Triangle(a, x, c);
  Triangle setC(Vector3 x) => Triangle(a, b, x);

  @override
  Triangle transform(Matrix4x4 mat) => map((x) => x.transform(mat));
  @override
  Vector3 getPoint(int n) {
    if (n == 0) {
      return a;
    } else {
      return n == 1 ? b : c;
    }
  }

  @override
  Triangle map(Vector3 Function(Vector3) f) => Triangle(f(a), f(b), f(c));
  @override
  String toString() => "Triangle(A = $a, B = $b, C = $c)";

  @override
  bool operator ==(Object other) =>
      other is Triangle && (a == other.a && b == other.b && c == other.c);
}

class Triangle2D {
  final Vector2 a;
  final Vector2 b;
  final Vector2 c;

  static const Triangle2D zero = Triangle2D.value(Vector2.zero);
  static const Triangle2D minValue = Triangle2D.value(Vector2.minValue);
  static const Triangle2D maxValue = Triangle2D.value(Vector2.maxValue);

  const Triangle2D(this.a, this.b, this.c);
  const Triangle2D.value(Vector2 value) : this(value, value, value);

  final int count = 3;
  // Compute the signed area of a triangle.
  double get area =>
      0.5 * (a.x * (c.y - b.y) + b.x * (a.y - c.y) + c.x * (b.y - a.y));
  @override
  int get hashCode => Hash.combine3(a.hashCode, b.hashCode, c.hashCode);

  // Test if a given point p2 is on the left side of the line formed by p0-p1.
  static bool onLeftSideOfLine(Vector2 p0, Vector2 p1, Vector2 p2) =>
      Triangle2D(p0, p2, p1).area > 0.0;
  // Test if a given point is inside a given triangle in R2.
  bool contains(Vector2 pp) {
    // Point in triangle test using barycentric coordinates
    final v0 = b - a;
    final v1 = c - a;
    final v2 = pp - a;

    var dot00 = v0.dot(v0);
    final dot01 = v0.dot(v1);
    final dot02 = v0.dot(v2);
    var dot11 = v1.dot(v1);
    final dot12 = v1.dot(v2);

    final invDenom = 1.0 / (dot00 * dot11 - dot01 * dot01);
    dot11 = (dot11 * dot02 - dot01 * dot12) * invDenom;
    dot00 = (dot00 * dot12 - dot01 * dot02) * invDenom;

    return (dot11 > 0.0) && (dot00 > 0.0) && (dot11 + dot00 < 1.0);
  }

  bool almostEquals(Triangle2D x, [double tolerance = Constants.tolerance]) =>
      a.almostEquals(x.a, tolerance) &&
      b.almostEquals(x.b, tolerance) &&
      c.almostEquals(x.c, tolerance);
  Triangle2D setA(Vector2 x) => Triangle2D(x, b, c);
  Triangle2D setB(Vector2 x) => Triangle2D(a, x, c);
  Triangle2D setC(Vector2 x) => Triangle2D(a, b, x);

  @override
  String toString() => "Triangle2D(A = $a, B = $b, C = $c)";

  @override
  bool operator ==(Object other) =>
      other is Triangle2D && (a == other.a && b == other.b && c == other.c);
  Vector2 operator [](int n) {
    if (n == 0) {
      return a;
    } else {
      return n == 1 ? b : c;
    }
  }
}
