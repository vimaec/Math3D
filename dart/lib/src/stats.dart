// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.
part of '../vim_math3d.dart';

/// Contains basic statistics that can be computed in a single pass over a collection.
class Stats<T> extends Object {
  final int count;
  final T min;
  final T max;
  final T sum;

  const Stats(this.count, this.min, this.max, this.sum);

  @override
  int get hashCode => Hash.combine4(
        count.hashCode,
        min.hashCode,
        max.hashCode,
        sum.hashCode,
      );

  @override
  bool operator ==(other) {
    return other is Stats<T> &&
        (other.count == count &&
            other.min == min &&
            other.max == max &&
            other.sum == sum);
  }

  //static final Stats Default = Stats<T>(0,  , default, default);
  @override
  String toString() =>
      "Stats<${T.runtimeType}(Count = $count, Min = $min, Max = $max, Sum = $sum)";
}
