// MIT License 
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com

using System;
using System.Runtime.CompilerServices;

namespace Ara3D
{
    public partial struct Vector4 : ITransformable3D<Vector4>
    {
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector4(Vector3 v, float w)
            : this(v.X, v.Y, v.Z, w)
        { }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector4(Vector2 v, float z, float w)
            : this(v.X, v.Y, z, w)
        { }

        /// <summary>
        /// Transforms a vector by the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector4 Transform(Matrix4x4 matrix)
            => new Vector4(
                X * matrix.M11 + Y * matrix.M21 + Z * matrix.M31 + W * matrix.M41,
                X * matrix.M12 + Y * matrix.M22 + Z * matrix.M32 + W * matrix.M42,
                X * matrix.M13 + Y * matrix.M23 + Z * matrix.M33 + W * matrix.M43,
                X * matrix.M14 + Y * matrix.M24 + Z * matrix.M34 + W * matrix.M44);

        public Vector3 XYZ => new Vector3(X, Y, Z);
        public Vector2 XY => new Vector2(X, Y);
    }

    public partial struct Vector3 : ITransformable3D<Vector3>
    {
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3(float x, float y)
            : this(x, y, 0)
        { }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3(Vector2 xy, float z)
            : this(xy.X, xy.Y, z)
        { }

        /// <summary>
        /// Transforms a vector by the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 Transform(Matrix4x4 matrix)
            => new Vector3(
                X * matrix.M11 + Y * matrix.M21 + Z * matrix.M31 + matrix.M41,
                X * matrix.M12 + Y * matrix.M22 + Z * matrix.M32 + matrix.M42,
                X * matrix.M13 + Y * matrix.M23 + Z * matrix.M33 + matrix.M43);

        /// <summary>
        /// Computes the cross product of two vectors.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 Cross(Vector3 vector2)
            => new Vector3(
                Y * vector2.Z - Z * vector2.Y,
                Z * vector2.X - X * vector2.Z,
                X * vector2.Y - Y * vector2.X);

        /// <summary>
        /// Returns the mixed product
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public double MixedProduct(Vector3 v1, Vector3 v2)
            => Cross(v1).Dot(v2);

        /// <summary>
        /// Returns the reflection of a vector off a surface that has the specified normal.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 Reflect(Vector3 normal)
            => this - normal * Dot(normal) * 2f;

        /// <summary>
        /// Transforms a vector normal by the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 TransformNormal(Matrix4x4 matrix)
            => new Vector3(
                X * matrix.M11 + Y * matrix.M21 + Z * matrix.M31,
                X * matrix.M12 + Y * matrix.M22 + Z * matrix.M32,
                X * matrix.M13 + Y * matrix.M23 + Z * matrix.M33);

        public Vector2 XY => new Vector2(X, Y);
    }

    public partial struct Line : ITransformable3D<Line>, IPoints, IMappable<Line, Vector3>
    {
        public Vector3 Vector => B - A;
        public Ray Ray => new Ray(A, Vector);
        public float Length => A.Distance(B);
        public float LengthSquared => A.DistanceSquared(B);
        public Vector3 MidPoint => A.Average(B);
        public Line Normal => new Line(A, A + Vector.Normalize());

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 Lerp(float amount) 
            => A.Lerp(B, amount);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Line SetLength(float length) 
            => new Line(A, A + Vector.Along(length));

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Line Transform(Matrix4x4 mat) 
            => new Line(A.Transform(mat), B.Transform(mat));

        public int NumPoints => 2;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 GetPoint(int n) => n == 0 ? A : B;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Line Map(Func<Vector3, Vector3> f) 
            => new Line(f(A), f(B));
    }

    public partial struct Quad : ITransformable3D<Quad>, IPoints, IMappable<Quad, Vector3>
    {
        public Quad Transform(Matrix4x4 mat) => Map(x => x.Transform(mat));
        public int NumPoints => 4;
        public Vector3 GetPoint(int n) => n == 0 ? A : n == 1 ? B : n == 2 ? C : D;
        public Quad Map(Func<Vector3, Vector3> f) => new Quad(f(A), f(B), f(C), f(D));
    }

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
        public AABox BoundingBox => AABox.Create(A, B, C);
        public Sphere BoundingSphere => Sphere.Create(A, B, C);

        public bool IsSliver(float tolerance = Constants.Tolerance)
            => LengthA <= tolerance || LengthB <= tolerance || LengthC <= tolerance;
    }

}