part of '../vim_math3d.dart';

class ValueDomain {
  final double lower;
  final double upper;

  const ValueDomain([this.lower = 0.0, this.upper = 0.0]);

  double normalize(double value) {
    return value.clamp(lower, upper) / upper;
  }
}
