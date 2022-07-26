// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com

part of '../vim_math3d.dart';

class StatelessRandom {
  // static int randomUInt(int index, [int seed = 0]) {
  //   return Hash.combine(seed, index);
  // }
  static int randomInt(int index, [int seed = 0]) {
    return Hash.combine(seed, index);
  }

  static double randomFloatMinMax(double min, double max, int index,
      [int seed = 0]) {
    final hugeInt = double.maxFinite.toInt();
    return randomInt(index, seed) / hugeInt * (max - min) + min;
  }

  static double randomFloat(int index, [int seed = 0]) {
    return randomFloatMinMax(0.0, 1.0, index, seed);
  }

  static Vector2 randomVector2(int index, [int seed = 0]) {
    return Vector2(
      randomFloat(index * 2, seed),
      randomFloat(index * 2 + 1, seed),
    );
  }

  static Vector3 randomVector3(int index, [int seed = 0]) {
    return Vector3(
      randomFloat(index * 3, seed),
      randomFloat(index * 3 + 1, seed),
      randomFloat(index * 3 + 2, seed),
    );
  }

  static Vector4 randomVector4(int index, [int seed = 0]) {
    return Vector4(
        randomFloat(index * 4, seed),
        randomFloat(index * 4 + 1, seed),
        randomFloat(index * 4 + 2, seed),
        randomFloat(index * 4 + 3, seed));
  }
}
