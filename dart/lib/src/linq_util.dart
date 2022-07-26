part of '../vim_math3d.dart';

class LinqUtil {
  static AABox toAABox(Iterable<Vector3> self) {
    return AABox.points(self);
  }
}
