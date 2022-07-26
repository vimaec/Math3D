// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.
part of '../vim_math3d.dart';

/// Defines how the bounding volumes intersects or contain one another.
enum ContainmentType {
  disjoint(0),
  contains(1),
  intersects(1);

  final int value;
  const ContainmentType(this.value);

  @override
  String toString() => 'ContainmentType.$name';
}
