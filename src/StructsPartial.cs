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
        { }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector4(Vector2 v, float z, float w)
            : this(v.X, v.Y, z, w)
        { }
    }

    public partial struct Vector3
    {

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3(float x, float y)
            : this(x, y, 0)
        {
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3(Vector2 xy, float z)
            : this(xy.X, xy.Y, z)
        {
        }
    }

    public partial struct Line
    {
        public Vector3 Vector => B - A;
        public Ray Ray => new Ray(A, Vector);
        public float Length => A.Distance(B);
        public float LengthSquared => A.DistanceSquared(B);
        public Vector3 MidPoint => A.Average(B);
        public Line Normal => new Line(A, A + Vector.Normalize());
        public Vector3 Lerp(float amount) => A.Lerp(B, amount);
        public Line SetLength(float length) => new Line(A, A + Vector.Along(length));
    }
}
