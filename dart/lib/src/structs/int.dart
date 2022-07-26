part of '../../vim_math3d.dart';

class Int2 implements Comparable<Int2> {
  final int x;
  final int y;

  static const int numComponents = 2;
  static const Int2 zero = Int2.value(0);
  // static Int2 MinValue = Int2(.minValue, .minValue);
  // static Int2 MaxValue = Int2(.maxValue, .maxValue);
  static const Int2 one = Int2.value(1);
  static const Int2 unitX = Int2(1, 0);
  static const Int2 unitY = Int2(0, 1);

  const Int2(this.x, this.y);
  const Int2.value(int value) : this(value, value);

  bool get isNaN => x.isNaN || y.isNaN;
  bool get isInfinite => x.isInfinite || y.isInfinite;
  @override
  int get hashCode => Hash.combine(x.hashCode, y.hashCode);

  Int2 setX(int value) => Int2(value, y);
  Int2 setY(int value) => Int2(x, value);
  int dot(Int2 value2) => x * value2.x + y * value2.y;
  bool almostZero([double tolerance = Constants.tolerance]) =>
      x.abs() < tolerance && y.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0;
  int minComponent() => (x).min(y);
  int maxComponent() => (x).max(y);
  int sumComponents() => (x) + (y);
  int sumSqrComponents() => (x).sqr() + (y).sqr();
  int productComponents() => (x) * (y);
  int getComponent(int n) => n == 0 ? x : y;
  double magnitudeSquared() => sumSqrComponents().toDouble();
  double magnitude() => magnitudeSquared().sqrt();

  Vector2 toVector2() => Vector2(x.toDouble(), y.toDouble());

  @override
  int compareTo(Int2 x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() => "Int2(X = $x, Y = $y)";

  @override
  bool operator ==(Object other) =>
      other is Int2 && (x == other.x && y == other.y);

  Int2 operator +(Object value2) => value2 is Int2
      ? Int2(x + value2.x, y + value2.y)
      : value2 is int
          ? Int2(x + value2, y + value2)
          : throw UnsupportedError('operator + (${value2.runtimeType})');

  Int2 operator -(Object value2) => value2 is Int2
      ? Int2(x - value2.x, y - value2.y)
      : value2 is int
          ? Int2(x - value2, y - value2)
          : throw UnsupportedError('operator - (${value2.runtimeType})');

  Int2 operator *(Object value2) => value2 is Int2
      ? Int2(x * value2.x, y * value2.y)
      : value2 is int
          ? Int2(x * value2, y * value2)
          : throw UnsupportedError('operator * (${value2.runtimeType})');

  Int2 operator /(Object value2) => value2 is Int2
      ? Int2(x ~/ value2.x, y ~/ value2.y)
      : value2 is int
          ? Int2(x ~/ value2, y ~/ value2)
          : throw UnsupportedError('operator / (${value2.runtimeType})');

  Int2 operator -() => zero - this;
  bool operator <(Int2 x1) => compareTo(x1) < 0;
  bool operator <=(Int2 x1) => compareTo(x1) <= 0;
  bool operator >(Int2 x1) => compareTo(x1) > 0;
  bool operator >=(Int2 x1) => compareTo(x1) >= 0;
}

class Int3 implements Comparable<Int3> {
  final int x;
  final int y;
  final int z;

  static const int numComponents = 3;
  static const Int3 zero = Int3.value(0);
  // static const Int3 minValue = Int3(.minValue, .minValue, .minValue);
  // static const Int3 maxValue = Int3(.maxValue, .maxValue, .maxValue);
  static const Int3 one = Int3.value(1);
  static const Int3 unitX = Int3(1, 0, 0);
  static const Int3 unitY = Int3(0, 1, 0);
  static const Int3 unitZ = Int3(0, 0, 1);

  const Int3(this.x, this.y, this.z);
  const Int3.value(int value) : this(value, value, value);

  bool get isNaN => x.isNaN || y.isNaN || z.isNaN;
  bool get isInfinite => x.isInfinite || y.isInfinite || z.isInfinite;
  @override
  int get hashCode => Hash.combine3(x.hashCode, y.hashCode, z.hashCode);

  int dot(Int3 value2) => x * value2.x + y * value2.y + z * value2.z;
  bool almostZero([double tolerance = Constants.tolerance]) =>
      x.abs() < tolerance && y.abs() < tolerance && z.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0;
  int minComponent() => (x).min(y).min(z);
  int maxComponent() => (x).max(y).max(z);
  int sumComponents() => (x) + (y) + (z);
  int sumSqrComponents() => (x).sqr() + (y).sqr() + (z).sqr();
  int productComponents() => (x) * (y) * (z);
  int getComponent(int n) {
    if (n == 0) {
      return x;
    } else {
      return n == 1 ? y : z;
    }
  }

  double magnitudeSquared() => sumSqrComponents().toDouble();
  double magnitude() => magnitudeSquared().sqrt();
  Int3 setX(int value) => Int3(value, y, z);
  Int3 setY(int value) => Int3(x, value, z);
  Int3 setZ(int value) => Int3(x, y, value);

  Vector3 toVector3() => Vector3(x.toDouble(), y.toDouble(), z.toDouble());

  @override
  int compareTo(Int3 x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() => "Int3(X = $x, Y = $y, Z = $z)";

  @override
  bool operator ==(Object other) =>
      other is Int3 && (x == other.x && y == other.y && z == other.z);

  Int3 operator +(Object value2) => value2 is Int3
      ? Int3(x + value2.x, y + value2.y, z + value2.z)
      : value2 is int
          ? Int3(x + value2, y + value2, z + value2)
          : throw UnsupportedError('operator + (${value2.runtimeType})');

  Int3 operator -(Object value2) => value2 is Int3
      ? Int3(x - value2.x, y - value2.y, z - value2.z)
      : value2 is int
          ? Int3(x - value2, y - value2, z - value2)
          : throw UnsupportedError('operator - (${value2.runtimeType})');

  Int3 operator *(Object value2) => value2 is Int3
      ? Int3(x * value2.x, y * value2.y, z * value2.z)
      : value2 is int
          ? Int3(x * value2, y * value2, z * value2)
          : throw UnsupportedError('operator * (${value2.runtimeType})');

  Int3 operator /(Object value2) => value2 is Int3
      ? Int3((x ~/ value2.x), y ~/ value2.y, z ~/ value2.z)
      : value2 is int
          ? Int3(x ~/ value2, y ~/ value2, z ~/ value2)
          : throw UnsupportedError('operator / (${value2.runtimeType})');

  Int3 operator -() => zero - this;
  bool operator <(Int3 x1) => compareTo(x1) < 0;
  bool operator <=(Int3 x1) => compareTo(x1) <= 0;
  bool operator >(Int3 x1) => compareTo(x1) > 0;
  bool operator >=(Int3 x1) => compareTo(x1) >= 0;
}

class Int4 implements Comparable<Int4> {
  final int x;
  final int y;
  final int z;
  final int w;

  static const int numComponents = 4;
  static const Int4 zero = Int4.value(0);
  // static Int4 MinValue = Int4(.minValue, .minValue, .minValue, .minValue);
  // static Int4 MaxValue = Int4(.maxValue, .maxValue, .maxValue, .maxValue);
  static const Int4 one = Int4.value(1);
  static const Int4 unitX = Int4(1, 0, 0, 0);
  static const Int4 unitY = Int4(0, 1, 0, 0);
  static const Int4 unitZ = Int4(0, 0, 1, 0);
  static const Int4 unitW = Int4(0, 0, 0, 1);

  const Int4(this.x, this.y, this.z, this.w);
  const Int4.value(int value) : this(value, value, value, value);

  bool get isNaN => x.isNaN || y.isNaN || z.isNaN || w.isNaN;
  bool get isInfinite =>
      x.isInfinite || y.isInfinite || z.isInfinite || w.isInfinite;
  @override
  int get hashCode =>
      Hash.combine4(x.hashCode, y.hashCode, z.hashCode, w.hashCode);

  int dot(Int4 v) => x * v.x + y * v.y + z * v.z + w * v.w;
  bool almostZero([double tolerance = Constants.tolerance]) =>
      x.abs() < tolerance &&
      y.abs() < tolerance &&
      z.abs() < tolerance &&
      w.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0;
  int minComponent() => (x).min(y).min(z).min(w);
  int maxComponent() => (x).max(y).max(z).max(w);
  int sumComponents() => (x) + (y) + (z) + (w);
  int sumSqrComponents() => (x).sqr() + (y).sqr() + (z).sqr() + (w).sqr();
  int productComponents() => (x) * (y) * (z) * (w);
  int getComponent(int n) {
    if (n == 0) {
      return x;
    } else {
      if (n == 1) {
        return y;
      } else {
        return n == 2 ? z : w;
      }
    }
  }

  double magnitudeSquared() => sumSqrComponents().toDouble();
  double magnitude() => magnitudeSquared().sqrt();
  Int4 setX(int value) => Int4(value, y, z, w);
  Int4 setY(int value) => Int4(x, value, z, w);
  Int4 setZ(int value) => Int4(x, y, value, w);
  Int4 setW(int value) => Int4(x, y, z, value);

  @override
  int compareTo(Int4 x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() => "Int4(X = $x, Y = $y, Z = $z, W = $w)";

  @override
  bool operator ==(Object other) =>
      other is Int4 &&
      (x == other.x && y == other.y && z == other.z && w == other.w);

  Int4 operator +(Object value2) => value2 is Int4
      ? Int4(x + value2.x, y + value2.y, z + value2.z, w + value2.w)
      : value2 is int
          ? Int4(x + value2, y + value2, z + value2, w + value2)
          : throw UnsupportedError('operator + (${value2.runtimeType})');
  Int4 operator -(Object value2) => value2 is Int4
      ? Int4(x - value2.x, y - value2.y, z - value2.z, w - value2.w)
      : value2 is int
          ? Int4(x - value2, y - value2, z - value2, w - value2)
          : throw UnsupportedError('operator - (${value2.runtimeType})');
  Int4 operator *(Object value2) => value2 is Int4
      ? Int4(x * value2.x, y * value2.y, z * value2.z, w * value2.w)
      : value2 is int
          ? Int4(x * value2, y * value2, z * value2, w * value2)
          : throw UnsupportedError('operator * (${value2.runtimeType})');
  Int4 operator /(Object value2) => value2 is Int4
      ? Int4(x ~/ value2.x, y ~/ value2.y, z ~/ value2.z, w ~/ value2.w)
      : value2 is int
          ? Int4(x ~/ value2, y ~/ value2, z ~/ value2, w ~/ value2)
          : throw UnsupportedError('operator / (${value2.runtimeType})');
  Int4 operator -() => zero - this;
  bool operator <(Int4 x1) => compareTo(x1) < 0;
  bool operator <=(Int4 x1) => compareTo(x1) <= 0;
  bool operator >(Int4 x1) => compareTo(x1) > 0;
  bool operator >=(Int4 x1) => compareTo(x1) >= 0;
}
