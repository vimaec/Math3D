// MIT License 
// Copyright (C) 2018 Ara 3D. Inc
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;
using System.Numerics;

namespace Ara3D
{
    public struct Triangle : IEquatable<Triangle>
    {
        public readonly Vector3 A;
        public readonly Vector3 B;
        public readonly Vector3 C;

        public Triangle(Vector3 a, Vector3 b, Vector3 c)
        {
            A = a; B = b; C = c;
        }

        public int Count => 3;

        public Vector3 this[int n] => n == 0 ? A : n == 1 ? B : C;

        public bool Equals(Triangle other)
        {
            return other.A == A && other.B == B && other.C == C;
        }

        public override int GetHashCode()
        {
            return Hash.Combine(A.GetHashCode(), B.GetHashCode(), C.GetHashCode());
        }

        public override string ToString()
        {
            return $"Triangle({A}, {B}, {C})";
        }

        public float LengthA => A.Distance(B);
        public float LengthB => B.Distance(C);
        public float LengthC => C.Distance(A);

        public bool HasArea => A != B && B != C && C != A;

        public float Area
        {
            get
            {
                var s = (LengthA + LengthB + LengthC) / 2;
                return MathOps.Sqrt(s * (s - LengthA) * (s - LengthB) * (s - LengthC));
            }
        }

        public Vector3 MidPoint => (A + B + C) / 3f;
        public Vector3 NormalDirection => (B - A).Cross(C - A);
        public Vector3 Normal => NormalDirection.Normal();
        public Box BoundingBox => Box.Create(A, B, C);
        public Sphere BoundingSphere => Sphere.Create(A, B, C);
        
        // TODO: plane
        // TODO: contained sphere
        // TODO: bounding sphere 

        public static Triangle Zero = new Triangle(Vector3.Zero, Vector3.Zero, Vector3.Zero);                
    }
}
