part of '../vim_math3d.dart';

abstract class IPoints {
  int get numPoints;
  Vector3 getPoint(int n);
}

abstract class IPoints2D {
  int get numPoints;
  Vector2 getPoint(int n);
}
