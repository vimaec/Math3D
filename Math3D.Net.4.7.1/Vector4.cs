// MIT License 
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com

using System.Runtime.CompilerServices;

namespace Ara3D
{
    public partial struct Vector4
    {
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector4(Vector3 v, float w)
            : this(v.X, v.Y, v.Z, w)
        {  }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector4(Vector2 v, float z, float w)
            : this(v.X, v.Y, z, w)
        { }
    }
}
