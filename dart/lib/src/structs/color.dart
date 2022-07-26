part of '../../vim_math3d.dart';

class ColorRGB {
  final int r;
  final int g;
  final int b;

  static const ColorRGB zero = ColorRGB.value(0);
  // static const ColorRGB minValue = ColorRGB.value(-double.maxFinite.toInt());
  // static const ColorRGB maxValue = ColorRGB.value(double.maxFinite.toInt());

  const ColorRGB(this.r, this.g, this.b);
  const ColorRGB.value(int value) : this(value, value, value);

  @override
  int get hashCode => Hash.combine3(r.hashCode, g.hashCode, b.hashCode);

  ColorRGB setR(int x) => ColorRGB(x, g, b);
  ColorRGB setG(int x) => ColorRGB(r, x, b);
  ColorRGB setB(int x) => ColorRGB(r, g, x);

  @override
  String toString() => "ColorRGB(R = $r, G = $g, B = $b)";

  @override
  bool operator ==(Object other) =>
      other is ColorRGB && (r == other.r && g == other.g && b == other.b);
}

class ColorRGBA {
  final int r;
  final int g;
  final int b;
  final int a;

  static const ColorRGBA lightRed = ColorRGBA(255, 128, 128, 255);
  static const ColorRGBA darkRed = ColorRGBA(255, 0, 0, 255);
  static const ColorRGBA lightGreen = ColorRGBA(128, 255, 128, 255);
  static const ColorRGBA darkGreen = ColorRGBA(0, 255, 0, 255);
  static const ColorRGBA lightBlue = ColorRGBA(128, 128, 255, 255);
  static const ColorRGBA darkBlue = ColorRGBA(0, 0, 255, 255);

  static const ColorRGBA zero = ColorRGBA.value(0);
  // static ColorRGBA MinValue = ColorRGBA(.minValue, .minValue, .minValue, .minValue);
  // static ColorRGBA MaxValue = ColorRGBA(.maxValue, .maxValue, .maxValue, .maxValue);

  const ColorRGBA(this.r, this.g, this.b, this.a);
  const ColorRGBA.value(int value) : this(value, value, value, value);

  @override
  int get hashCode =>
      Hash.combine4(r.hashCode, g.hashCode, b.hashCode, a.hashCode);

  ColorRGBA setR(int x) => ColorRGBA(x, g, b, a);
  ColorRGBA setG(int x) => ColorRGBA(r, x, b, a);
  ColorRGBA setB(int x) => ColorRGBA(r, g, x, a);
  ColorRGBA setA(int x) => ColorRGBA(r, g, b, x);

  @override
  String toString() => "ColorRGBA(R = $r, G = $g, B = $b, A = $a)";

  @override
  bool operator ==(Object other) =>
      other is ColorRGBA &&
      (r == other.r && g == other.g && b == other.b && a == other.a);
}

class ColorHDR {
  final double r;
  final double g;
  final double b;
  final double a;

  static const ColorHDR zero = ColorHDR.value(0);
  // static ColorHDR MinValue = ColorHDR(.minValue, .minValue, .minValue, .minValue);
  // static ColorHDR MaxValue = ColorHDR(.maxValue, .maxValue, .maxValue, .maxValue);

  const ColorHDR(this.r, this.g, this.b, this.a);
  const ColorHDR.value(double value) : this(value, value, value, value);

  @override
  int get hashCode =>
      Hash.combine4(r.hashCode, g.hashCode, b.hashCode, a.hashCode);

  bool almostEquals(ColorHDR x, [double tolerance = Constants.tolerance]) =>
      r.almostEquals(x.r, tolerance) &&
      g.almostEquals(x.g, tolerance) &&
      b.almostEquals(x.b, tolerance) &&
      a.almostEquals(x.a, tolerance);
  ColorHDR setR(double x) => ColorHDR(x, g, b, a);
  ColorHDR setG(double x) => ColorHDR(r, x, b, a);
  ColorHDR setB(double x) => ColorHDR(r, g, x, a);
  ColorHDR setA(double x) => ColorHDR(r, g, b, x);

  @override
  String toString() => "ColorHDR(R = $r, G = $g, B = $b, A = $a)";

  @override
  bool operator ==(Object other) =>
      other is ColorHDR &&
      (r == other.r && g == other.g && b == other.b && a == other.a);
}
