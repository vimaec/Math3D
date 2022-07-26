part of '../../vim_math3d.dart';

class Quad
    implements ITransformable3D<Quad>, IPoints, IMappable<Quad, Vector3> {
  final Vector3 a;
  final Vector3 b;
  final Vector3 c;
  final Vector3 d;

  static const Quad zero = Quad.value(Vector3.zero);
  static const Quad minValue = Quad.value(Vector3.minValue);
  static const Quad maxValue = Quad.value(Vector3.maxValue);

  const Quad(this.a, this.b, this.c, this.d);
  const Quad.value(Vector3 value) : this(value, value, value, value);

  @override
  int get hashCode =>
      Hash.combine4(a.hashCode, b.hashCode, c.hashCode, d.hashCode);
  @override
  int get numPoints => 4;

  bool almostEquals(Quad x, [double tolerance = Constants.tolerance]) =>
      a.almostEquals(x.a, tolerance) &&
      b.almostEquals(x.b, tolerance) &&
      c.almostEquals(x.c, tolerance) &&
      d.almostEquals(x.d, tolerance);
  Quad setA(Vector3 x) => Quad(x, b, c, d);
  Quad setB(Vector3 x) => Quad(a, x, c, d);
  Quad setC(Vector3 x) => Quad(a, b, x, d);
  Quad setD(Vector3 x) => Quad(a, b, c, x);

  @override
  Quad transform(Matrix4x4 mat) => map((x) => x.transform(mat));
  @override
  Vector3 getPoint(int n) => n == 0
      ? a
      : n == 1
          ? b
          : n == 2
              ? c
              : d;
  @override
  Quad map(Vector3 Function(Vector3) f) => Quad(f(a), f(b), f(c), f(d));
  @override
  String toString() => "Quad(A = $a, B = $b, C = $c, D = $d)";

  @override
  bool operator ==(Object other) =>
      other is Quad &&
      (a == other.a && b == other.b && c == other.c && d == other.d);
}

class Quad2D {
  final Vector2 a;
  final Vector2 b;
  final Vector2 c;
  final Vector2 d;

  static const Quad2D zero = Quad2D.value(Vector2.zero);
  static const Quad2D minValue = Quad2D.value(Vector2.minValue);
  static const Quad2D maxValue = Quad2D.value(Vector2.maxValue);

  const Quad2D(this.a, this.b, this.c, this.d);
  const Quad2D.value(Vector2 value) : this(value, value, value, value);

  @override
  int get hashCode =>
      Hash.combine4(a.hashCode, b.hashCode, c.hashCode, d.hashCode);

  bool almostEquals(Quad2D x, [double tolerance = Constants.tolerance]) =>
      a.almostEquals(x.a, tolerance) &&
      b.almostEquals(x.b, tolerance) &&
      c.almostEquals(x.c, tolerance) &&
      d.almostEquals(x.d, tolerance);
  Quad2D setA(Vector2 x) => Quad2D(x, b, c, d);
  Quad2D setB(Vector2 x) => Quad2D(a, x, c, d);
  Quad2D setC(Vector2 x) => Quad2D(a, b, x, d);
  Quad2D setD(Vector2 x) => Quad2D(a, b, c, x);

  @override
  String toString() => "Quad2D(A = $a, B = $b, C = $c, D = $d)";

  @override
  bool operator ==(Object other) =>
      other is Quad2D &&
      (a == other.a && b == other.b && c == other.c && d == other.d);
}
