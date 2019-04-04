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

    public partial struct Quad
    {
    }

    public partial struct Triangle
    {
        public int Count => 3;

        public Vector3 this[int n] => n == 0 ? A : n == 1 ? B : C;

        public float LengthA => A.Distance(B);
        public float LengthB => B.Distance(C);
        public float LengthC => C.Distance(A);

        public bool HasArea => A != B && B != C && C != A;

        public float Area
        {
            get
            {
                var s = (LengthA + LengthB + LengthC) / 2;
                return (s * (s - LengthA) * (s - LengthB) * (s - LengthC)).Sqrt();
            }
        }

        public float Perimeter => LengthA + LengthB + LengthC;
        public Vector3 MidPoint => (A + B + C) / 3f;
        public Vector3 NormalDirection => (B - A).Cross(C - A);
        public Vector3 Normal => NormalDirection.Normalize();
        public Box BoundingBox => Box.Create(A, B, C);
        public Sphere BoundingSphere => Sphere.Create(A, B, C);
    }
}
