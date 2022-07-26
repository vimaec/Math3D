part of '../../vim_math3d.dart';

class Line
    implements ITransformable3D<Line>, IPoints, IMappable<Line, Vector3> {
  final Vector3 a;
  final Vector3 b;

  static const Line zero = Line(Vector3.zero, Vector3.zero);
  static const Line minValue = Line(Vector3.minValue, Vector3.minValue);
  static const Line maxValue = Line(Vector3.maxValue, Vector3.maxValue);

  const Line(this.a, this.b);

  Vector3 get vector => b - a;
  Ray get ray => Ray(a, vector);
  double get length => a.distance(b);
  double get lengthSquared => a.distanceSquared(b);
  Vector3 get midPoint => a.average(b);
  Line get normal => Line(a, a + vector.normalize());
  Line get inverse => Line(b, a);
  @override
  int get hashCode => Hash.combine(a.hashCode, b.hashCode);
  @override
  int get numPoints => 2;

  Vector3 lerp(double amount) => a.lerp(b, amount);
  Line setLength(double length) => Line(a, a + vector.along(length));
  bool almostEquals(Line x, [double tolerance = Constants.tolerance]) =>
      a.almostEquals(x.a, tolerance) && b.almostEquals(x.b, tolerance);
  Line setA(Vector3 x) => Line(x, b);
  Line setB(Vector3 x) => Line(a, x);

  @override
  Line transform(Matrix4x4 mat) => Line(a.transform(mat), b.transform(mat));
  @override
  Vector3 getPoint(int n) => n == 0 ? a : b;
  @override
  Line map(Vector3 Function(Vector3) f) => Line(f(a), f(b));
  @override
  String toString() => "Line(A = $a, B = $b)";

  @override
  bool operator ==(Object other) =>
      other is Line && (a == other.a && b == other.b);
}

class Line2D {
  final Vector2 a;
  final Vector2 b;

  const Line2D(this.a, this.b);

  static const Line2D zero = Line2D(Vector2.zero, Vector2.zero);
  static const Line2D minValue = Line2D(Vector2.minValue, Vector2.minValue);
  static const Line2D maxValue = Line2D(Vector2.maxValue, Vector2.maxValue);

  @override
  int get hashCode => Hash.combine(a.hashCode, b.hashCode);

  AABox2D boundingBox() => AABox2D(a.min(b), a.max(b));
  double linePointCrossProduct(Vector2 point) {
    final tmpLine = Line2D(Vector2.zero, b - a);
    final tmpPoint = point - a;
    return tmpLine.b.pointCrossProduct(tmpPoint);
  }

  bool isPointOnLine(Vector2 point) =>
      (linePointCrossProduct(point)).abs() < Constants.tolerance;
  bool isPointRightOfLine(Vector2 point) => linePointCrossProduct(point) < 0.0;
  bool touchesOrCrosses(Line2D other) =>
      isPointOnLine(other.a) ||
      isPointOnLine(other.b) ||
      (isPointRightOfLine(other.a) ^ isPointRightOfLine(other.b));
  bool intersectsBox(AABox2D thisBox, Line2D otherLine, AABox2D otherBox) =>
      thisBox.intersects(otherBox) &&
      touchesOrCrosses(otherLine) &&
      otherLine.touchesOrCrosses(this);
  // Inspired by: https://martin-thoma.com/how-to-check-if-two-line-segments-intersect/
  bool intersects(Line2D other) =>
      intersectsBox(boundingBox(), other, other.boundingBox());
  bool almostEquals(Line2D x, [double tolerance = Constants.tolerance]) =>
      a.almostEquals(x.a, tolerance) && b.almostEquals(x.b, tolerance);
  Line2D setA(Vector2 x) => Line2D(x, b);
  Line2D setB(Vector2 x) => Line2D(a, x);

  @override
  String toString() => "Line2D(A = $a, B = $b)";

  @override
  bool operator ==(Object other) =>
      other is Line2D && (a == other.a && b == other.b);
}
