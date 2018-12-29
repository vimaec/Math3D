// MIT License 
// Copyright (C) 2018 Ara 3D. Inc
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;
using System.Numerics;

namespace Ara3D
{
    /// <summary>
    /// Represents a straight line between two points in three dimensions.
    /// </summary>
    public partial struct Line 
    {
        public Vector3 Vector => B - A;
        public Ray Ray => new Ray(A, Vector);
        public float Length => A.Distance(B);
        public float LengthSquared => A.DistanceSquared(B);
        public Vector3 MidPoint => A.Average(B);
        public Line Normal => new Line(A, A + Vector.Normal());
        public Vector3 Lerp(float amount) => A.Lerp(B, amount);
        public Line SetLength(float length) => new Line(A, A + Vector.AlongVector(length));
    }
}
