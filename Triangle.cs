// MIT License 
// Copyright (C) 2018 Ara 3D. Inc
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;
using System.Numerics;

namespace Ara3D
{
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
