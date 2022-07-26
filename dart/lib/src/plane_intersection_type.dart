// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.
part of '../vim_math3d.dart';

/// Defines the intersection between a Plane and a bounding volume.
enum PlaneIntersectionType {
  front(0),
  back(1),
  intersecting(1);

  final int value;
  const PlaneIntersectionType(this.value);

  @override
  String toString() => 'ContainmentType.$name';
}
