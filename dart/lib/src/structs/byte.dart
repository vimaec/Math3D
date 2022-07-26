part of '../../vim_math3d.dart';

class Byte2 {
  final int x;
  final int y;

  static const Byte2 zero = Byte2.value(0);
  // static Byte2 MinValue = Byte2(.minValue, .minValue);
  // static Byte2 MaxValue = Byte2(.maxValue, .maxValue);

  const Byte2(this.x, this.y);
  const Byte2.value(int value) : this(value, value);

  @override
  int get hashCode => Hash.combine(x.hashCode, y.hashCode);

  Byte2 setX(int value) => Byte2(value, y);
  Byte2 setY(int value) => Byte2(x, value);

  @override
  String toString() => "Byte2(X = $x, Y = $y)";

  @override
  bool operator ==(Object other) =>
      other is Byte2 && (x == other.x && y == other.y);
}

class Byte3 {
  final int x;
  final int y;
  final int z;

  static const Byte3 zero = Byte3.value(0);
  // static Byte3 MinValue = Byte3(.minValue, .minValue, .minValue);
  // static Byte3 MaxValue = Byte3(.maxValue, .maxValue, .maxValue);

  const Byte3(this.x, this.y, this.z);
  const Byte3.value(int value) : this(value, value, value);

  @override
  int get hashCode => Hash.combine3(x.hashCode, y.hashCode, z.hashCode);

  Byte3 setX(int value) => Byte3(value, y, z);
  Byte3 setY(int value) => Byte3(x, value, z);
  Byte3 setZ(int value) => Byte3(x, y, value);

  @override
  String toString() => "Byte3(X = $x, Y = $y, Z = $z)";

  @override
  bool operator ==(Object other) =>
      other is Byte3 && (x == other.x && y == other.y && z == other.z);
}

class Byte4 {
  final int x;
  final int y;
  final int z;
  final int w;

  static const Byte4 zero = Byte4.value(0);
  // static const Byte4 MinValue = Byte4(.minValue, .minValue, .minValue, .minValue);
  // static const Byte4 MaxValue = Byte4(.maxValue, .maxValue, .maxValue, .maxValue);

  const Byte4(this.x, this.y, this.z, this.w);
  const Byte4.value(int value) : this(value, value, value, value);

  @override
  int get hashCode =>
      Hash.combine4(x.hashCode, y.hashCode, z.hashCode, w.hashCode);

  Byte4 setX(int value) => Byte4(value, y, z, w);
  Byte4 setY(int value) => Byte4(x, value, z, w);
  Byte4 setZ(int value) => Byte4(x, y, value, w);
  Byte4 setW(int value) => Byte4(x, y, z, value);

  @override
  String toString() => "Byte4(X = $x, Y = $y, Z = $z, W = $w)";

  @override
  bool operator ==(Object other) =>
      other is Byte4 &&
      (x == other.x && y == other.y && z == other.z && w == other.w);
}
