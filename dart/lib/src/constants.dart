// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

part of '../vim_math3d.dart';

class Constants {
  static const Plane xyPlane = Plane(Vector3.unitZ, 0.0);
  static const Plane xzPlane = Plane(Vector3.unitY, 0.0);
  static const Plane yzPlane = Plane(Vector3.unitX, 0.0);

  static const double pi = math.pi;
  static const double halfPi = math.pi / 2.0;
  static const double twoPi = math.pi * 2.0;
  static const double tolerance = 0.0000001;
  static const double log10E = math.log10e;
  static const double log2E = math.log2e;
  static const double e = math.e;
  static const double epsilon = double.minPositive;

  static const double radiansToDegrees = 57.295779513082320876798154814105;
  static const double degreesToRadians = 0.017453292519943295769236907684886;

  static const double oneTenthOfADegree = degreesToRadians / 10.0;

  // TODO: BUG: these two values are inverted dumb-dumb
  static const double mmToFeet = 0.00328084;
  static const double feetToMm = 1.0 / mmToFeet;
}
