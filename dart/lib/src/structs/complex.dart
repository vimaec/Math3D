part of '../../vim_math3d.dart';

class Complex implements Comparable<Complex> {
  final double real;
  final double imaginary;

  static const int numComponents = 2;
  static const Complex zero = Complex.value(0.0);
  static const Complex minValue = Complex.value(-double.maxFinite);
  static const Complex maxValue = Complex.value(double.maxFinite);
  static const Complex one = Complex.value(1.0);
  static const Complex unitReal = Complex(1.0, 0.0);
  static const Complex unitImaginary = Complex(0.0, 1.0);

  const Complex(this.real, this.imaginary);
  const Complex.value(double value) : this(value, value);

  bool get isNaN => real.isNaN || imaginary.isNaN;
  bool get isInfinite => real.isInfinite || imaginary.isInfinite;
  @override
  int get hashCode => Hash.combine(real.hashCode, imaginary.hashCode);

  bool almostEquals(Complex x, [double tolerance = Constants.tolerance]) =>
      real.almostEquals(x.real, tolerance) &&
      imaginary.almostEquals(x.imaginary, tolerance);
  Complex setReal(double x) => Complex(x, imaginary);
  Complex setImaginary(double x) => Complex(real, x);
  double dot(Complex value2) =>
      real * value2.real + imaginary * value2.imaginary;
  bool almostZero([double tolerance = Constants.tolerance]) =>
      real.abs() < tolerance && imaginary.abs() < tolerance;
  bool anyComponentNegative() => minComponent() < 0.0;
  double minComponent() => (real).min(imaginary);
  double maxComponent() => (real).max(imaginary);
  double sumComponents() => (real) + (imaginary);
  double sumSqrComponents() => (real).sqr() + (imaginary).sqr();
  double productComponents() => (real) * (imaginary);
  double getComponent(int n) => n == 0 ? real : imaginary;
  double magnitudeSquared() => sumSqrComponents();
  double magnitude() => magnitudeSquared().sqrt();

  @override
  int compareTo(Complex x) =>
      (magnitudeSquared() - x.magnitudeSquared()).sign.toInt();
  @override
  String toString() => "Complex(Real = $real, Imaginary = $imaginary)";

  @override
  bool operator ==(Object other) =>
      other is Complex && (real == other.real && imaginary == other.imaginary);
  Complex operator +(Object value2) => value2 is Complex
      ? Complex(real + value2.real, imaginary + value2.imaginary)
      : value2 is num
          ? Complex(real + value2, imaginary + value2)
          : throw UnsupportedError('operator + (${value2.runtimeType})');
  Complex operator -(Object value2) => value2 is Complex
      ? Complex(real - value2.real, imaginary - value2.imaginary)
      : value2 is num
          ? Complex(real - value2, imaginary - value2)
          : throw UnsupportedError('operator - (${value2.runtimeType})');
  Complex operator *(Object value2) => value2 is Complex
      ? Complex(real * value2.real, imaginary * value2.imaginary)
      : value2 is num
          ? Complex(real * value2, imaginary * value2)
          : throw UnsupportedError('operator * (${value2.runtimeType})');
  Complex operator /(Object value2) => value2 is Complex
      ? Complex(real / value2.real, imaginary / value2.imaginary)
      : value2 is num
          ? Complex(real / value2, imaginary / value2)
          : throw UnsupportedError('operator / (${value2.runtimeType})');
  Complex operator -() => zero - this;
  bool operator <(Complex x1) => compareTo(x1) < 0;
  bool operator <=(Complex x1) => compareTo(x1) <= 0;
  bool operator >(Complex x1) => compareTo(x1) > 0;
  bool operator >=(Complex x1) => compareTo(x1) >= 0;
}
