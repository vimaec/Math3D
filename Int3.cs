// MIT License 
// Copyright (C) 2018 Ara 3D. Inc
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System.Collections.Generic;

namespace Ara3D
{
    public struct Int3 
    {
        public readonly int X;
        public readonly int Y;
        public readonly int Z;

        public Int3(int x, int y, int z)
        {
            X = x; Y = y; Z = z;
        }

        public int this[int n] => n == 0 ? X : n == 1 ? Y : Z;

        public int Count => 3;

        public IEnumerable<int> ToEnumerable()
        {
            yield return X;
            yield return Y;
            yield return Z;                 
        }
    }
}