part of '../vim_math3d.dart';

extension MathOpsBool on bool {
  bool and(bool b) => this && b;
  bool or(bool b) => this || b;
  bool nAnd(bool b) => !(this && b);
  bool xOr(bool b) => this || b && !(this && b);
  bool nOr(bool b) => !(this || b);
  bool not() => !this;
  bool eq(bool b) => this == b;
  bool nEq(bool b) => this != b;
}

extension MathOpsInt on int {
  int magnitude() => this;
  int magnitudeSquared() => this * this;
  int and(int b) => this & b;
  int or(int b) => this | b;
  int nAnd(int b) => ~(this & b);
  int xOr(int b) => this | b & ~(this & b);
  int nOr(int b) => ~(this | b);
  int not() => ~this;
  double divideRoundUp(int b) => this / b + (this % b > 0 ? 1 : 0);
  bool isPowerOfTwo() => this > 0 && (this & (this - 1)) == 0;

  int sqr() => this * this;
  int cube() => this * this * this;

  int add(int v2) => this + v2;
  int subtract(int v2) => this - v2;
  int multiply(int v2) => this * v2;
  int negate() => -this;
}

extension MathOpsFloat on double {
  double magnitude() => this;
  double magnitudeSquared() => this * this;
  double distance(double v2) => (this - v2).abs();
  bool almostEquals(double v2, [double tolerance = Constants.tolerance]) =>
      (v2 - this).almostZero(tolerance);
  bool almostZero([double tolerance = Constants.tolerance]) =>
      abs() < tolerance;
  double smoothstep() => this * this * (3 - 2 * this);

  double sqr() => this * this;
  double cube() => this * this * this;

  double lerp(double v2, double t) => this + (v2 - this) * t;
  double inverseLerp(double a, double b) => (this - a) / (b - a);
  double lerpPrecise(double v2, double t) => ((1 - t) * this) + (v2 * t);
  double clampLower(double min) => math.max(this, min);
  double clampUpper(double max) => math.min(this, max);
  double average(double v2) => lerp(v2, 0.5);
  double barycentric(double v2, double v3, double u, double v) =>
      this + (v2 - this) * u + (v3 - this) * v;

  double add(double v2) => this + v2;
  double subtract(double v2) => this - v2;
  double multiply(double v2) => this * v2;
  double negate() => -this;

  /// Reduces a given angle to a value between π and -π.
  /// [angle] The angle to reduce, in radians.
  /// Returns: The new angle, in radians.
  double wrapAngle() {
    double angle = this;
    if ((angle > -Constants.pi) && (angle <= Constants.pi)) {
      return angle;
    }
    angle %= Constants.twoPi;
    if (angle <= -Constants.pi) {
      return angle + Constants.twoPi;
    }
    if (angle > Constants.pi) {
      return angle - Constants.twoPi;
    }
    return angle;
  }

  /// Performs a Hermite spline interpolation.
  double hermite(
    double tangent1,
    double value2,
    double tangent2,
    double amount,
  ) {
    // All transformed to double not to lose precision
    // Otherwise, for high numbers of param:amount the result is NaN instead of Infinity
    double value1 = this;
    double v1 = value1,
        v2 = value2,
        t1 = tangent1,
        t2 = tangent2,
        s = amount,
        result;
    final sCubed = s * s * s;
    final sSquared = s * s;

    if (amount == 0.0) {
      result = value1;
    } else if (amount == 1.0) {
      result = value2;
    } else {
      result = (2.0 * v1 - 2.0 * v2 + t2 + t1) * sCubed +
          (3.0 * v2 - 3.0 * v1 - 2.0 * t1 - t2) * sSquared +
          t1 * s +
          v1;
    }
    return result;
  }

  // Interpolates between two values using a cubic equation (Hermite),
  // clamping the amount to 0 to 1
  double smoothStep(double value2, double amount) {
    return hermite(0.0, value2, 0.0, amount.clamp(0.0, 1.0));
  }
}

extension MathOpsNum<T extends num> on T {
  // Expresses two vlaues as a ratio
  double percentage(T numerator) => (numerator / this) * 100.0;

  double inverse() => 1 / this;
  double ceiling() => ceilToDouble();
  double toRadians() => this * Constants.degreesToRadians;
  double toDegrees() => this * Constants.radiansToDegrees;

  bool within(T min, T max) => this >= min && this < max;
  T min(T v2) => math.min(this, v2);
  T max(T v2) => math.max(this, v2);

  bool gt(T v2) => this > v2;
  bool lt(T v2) => this < v2;
  bool gtEq(T v2) => this >= v2;
  bool ltEq(T v2) => this <= v2;
  bool eq(T v2) => this == v2;
  bool nEq(T v2) => this != v2;

  double divide(T v2) => this / v2;

  double atan2(T b) => math.atan2(this, b);
  num pow(T exponent) => math.pow(this, exponent);
  // double abs() is already implemented
  double acos() => math.acos(this);
  double asin() => math.asin(this);
  double atan() => math.atan(this);
  double cos() => math.cos(this);
  double cosh() => (math.exp(this) + math.exp(-this)) / 2.0;
  double exp() => math.exp(this);
  double log() => math.log(this);
  double log10() => math.log(this) / math.ln10;
  double sin() => math.sin(this);
  double sinh() => (math.exp(this) - math.exp(-this)) / 2.0;
  double sqrt() => math.sqrt(this);
  double tan() => math.tan(this);
  double tanh() {
    if (this > 19.1) return 1.0;
    if (this < -19.1) return -1.0;
    final e1 = math.exp(this);
    final e2 = math.exp(-this);
    return (e1 - e2) / (e1 + e2);
  }

  bool isNonZeroAndValid([double tolerance = Constants.tolerance]) =>
      !isInfinite && !isNaN && abs() > tolerance;
  // Calculate the nearest power of 2 from the input number
  num toNearestPowOf2() =>
      math.pow(2.0, (math.log(this) / math.log(2.0)).roundToDouble());
  // Performs a Catmull-Rom interpolation using the specified positions.
  double catmullRom(T v2, T v3, T v4, double amount) {
    // Using formula from http://www.mvps.org/directx/articles/catmull/
    // Internally using doubles not to lose precision
    final v1 = this;
    final aSquared = amount * amount;
    final aCubed = aSquared * amount;
    return (0.5 *
        (2.0 * v2 +
            (v3 - v1) * amount +
            (2.0 * v1 - 5.0 * v2 + 4.0 * v3 - v4) * aSquared +
            (3.0 * v2 - v1 - 3.0 * v3 + v4) * aCubed));
  }
}

extension MathOpsCast<T extends num> on T {
  Vector3 alongVector3X() => Vector3.unitX * this;
  Vector3 alongVector3Y() => Vector3.unitY * this;
  Vector3 alongVector3Z() => Vector3.unitX * this;
  Vector2 toVector2() => Vector2.value(toDouble());
  Vector3 toVector3() => Vector3.value(toDouble());
  Vector4 toVector4() => Vector4.value(toDouble());
}
