// MIT License 
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

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
                return (s * (s - LengthA) * (s - LengthB) * (s - LengthC)).Sqrt();
            }
        }

        public float Perimeter => LengthA + LengthB + LengthC;
        public Vector3 MidPoint => (A + B + C) / 3f;
        public Vector3 NormalDirection => (B - A).Cross(C - A);
        public Vector3 Normal => NormalDirection.Normalize();
        public Box BoundingBox => Box.Create(A, B, C);
        public Sphere BoundingSphere => Sphere.Create(A, B, C);
        
        // TODO: plane
        // TODO: contained sphere
        // TODO: bounding sphere 
    }
}
