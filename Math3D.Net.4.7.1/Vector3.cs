// MIT License 
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com

using System.Runtime.CompilerServices;

namespace Ara3D
{
    public partial struct Vector3
    {
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3(float x, float y)
           : this(x, y, 0)
        { }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3(Vector2 xy, float z)
            : this(xy.X, xy.Y, z)
        { }
    }
}