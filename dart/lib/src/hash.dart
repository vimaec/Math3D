// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.
part of '../vim_math3d.dart';

class Hash {
  // Discussion: if we want to go deeper into the subject, check out
  // https://en.wikipedia.org/wiki/List_of_hash_functions
  // https://stackoverflow.com/questions/5889238/why-is-xor-the-default-way-to-combine-hashes
  // https://en.wikipedia.org/wiki/Jenkins_hash_function#cite_note-11
  // https://referencesource.microsoft.com/#System.Numerics/System/Numerics/HashCodeHelper.cs
  // https://github.com/dotnet/corefx/blob/master/src/Common/src/CoreLib/System/Numerics/Hashing/HashHelpers.cs
  static int combine(int h1, int h2) {
    return ((h1 << 5) + h1) ^ h2;
  }

  static int combine1(List<int> xs) {
    if (xs.isEmpty) {
      return 0;
    }
    var r = xs[0];
    for (var i = 1; i < xs.length; ++i) {
      r = combine(r, i);
    }
    return r;
  }

  static int combine3(int x0, int x1, int x2) {
    return combine(combine(x0, x1), x2);
  }

  static int combine4(int x0, int x1, int x2, int x3) {
    return combine(combine3(x0, x1, x2), x3);
  }

  static int hashValues(Iterable<int> values) {
    var acc = 0;
    for (var x in values) {
      acc = combine(acc, x);
    }
    return acc;
  }

  static int hashCodes<T>(Iterable<T> values) {
    return hashValues(values.map((x) => x.hashCode));
  }
}
