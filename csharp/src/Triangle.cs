// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com

using System;
using System.Runtime.CompilerServices;

namespace Vim.Math3d
{
    public partial struct Triangle : ITransformable3D<Triangle>, IPoints, IMappable<Triangle, Vector3>
    {
        public Triangle Transform(Matrix4x4 mat) => Map(x => x.Transform(mat));
        public int NumPoints => 3;
        public Vector3 GetPoint(int n) => n == 0 ? A : n == 1 ? B : C;
        public Triangle Map(Func<Vector3, Vector3> f) => new Triangle(f(A), f(B), f(C));

        public float LengthA => A.Distance(B);
        public float LengthB => B.Distance(C);
        public float LengthC => C.Distance(A);

        public bool HasArea => A != B && B != C && C != A;

        public float Area => (B - A).Cross(C - A).Length() * 0.5f;

        public float Perimeter => LengthA + LengthB + LengthC;
        public Vector3 MidPoint => (A + B + C) / 3f;
        public Vector3 NormalDirection => (B - A).Cross(C - A);
        public Vector3 Normal => NormalDirection.Normalize();
        public Vector3 SafeNormal => NormalDirection.SafeNormalize();
        public AABox BoundingBox => AABox.Create(A, B, C);
        public Sphere BoundingSphere => Sphere.Create(A, B, C);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool IsSliver(float tolerance = Constants.Tolerance)
            => LengthA <= tolerance || LengthB <= tolerance || LengthC <= tolerance;

        public Line Side(int n) => n == 0 ? AB : n == 1 ? BC : CA;
        public Vector3 Binormal => (B - A).SafeNormalize();
        public Vector3 Tangent => (C - A).SafeNormalize();

        public Line AB => new Line(A, B);
        public Line BC => new Line(B, C);
        public Line CA => new Line(C, A);

        public Line BA => AB.Inverse;
        public Line CB => BC.Inverse;
        public Line AC => CA.Inverse;
    }
}
