// MIT License 
// Copyright (C) 2018 Ara 3D. Inc
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;
using System.Numerics;

namespace Ara3D
{
    public static class VectorHelper
    {
        public static Vector2 Select(this Vector2 self, Func<float, float> f)
        {
            return new Vector2(f(self.X), f(self.Y));
        }

        public static Vector3 Select(this Vector3 self, Func<float, float> f)
        {
            return new Vector3(f(self.X), f(self.Y), f(self.Y));
        }

        public static Vector4 Select(this Vector4 self, Func<float, float> f)
        {
            return new Vector4(f(self.X), f(self.Y), f(self.Z), f(self.W));
        }

        public static Vector2 Zip(this Vector2 self, Vector2 v, Func<float, float, float> f)
        {
            return new Vector2(f(self.X, v.X), f(self.Y, v.Y));
        }

        public static Vector3 Zip(this Vector3 self, Vector3 v, Func<float, float, float> f)
        {
            return new Vector3(f(self.X, v.X), f(self.Y, v.Y), f(self.Z, v.Z));
        }

        public static Vector4 Zip(this Vector4 self, Vector4 v, Func<float, float, float> f)
        {
            return new Vector4(f(self.X, v.X), f(self.Y, v.Y), f(self.Z, v.Z), f(self.W, v.W));
        }

        // TODO: I am not implementing all of these for all of the different types of Vectors

        public static float MaxComponent(this Vector3 self)
        {
            return Math.Max(Math.Max(self.X, self.Y), self.Z);
        }

        public static float MinComponent(this Vector3 self)
        {
            return Math.Min(Math.Min(self.X, self.Y), self.Z);
        }

        public static float SumComponents(this Vector3 self)
        {
            return self.X + self.Y + self.Z;
        }

        public static float SumSqrComponents(this Vector3 self)
        {
            return self.X.Sqr() + self.Y.Sqr() + self.Z.Sqr();
        }

        public static Vector3 Rotate(this Vector3 self, Vector3 axis, float angle)
        {
            return self.Transform(Matrix4x4.CreateFromAxisAngle(axis, angle));
        }

        public static Vector3 Transform(this Vector3 self, Matrix4x4 matrix)
        {
            return Vector3.Transform(self, matrix);
        }

        public static Vector3 Transform(this Vector3 self, Quaternion quat)
        {
            return Vector3.Transform(self, quat);
        }

        public static Vector3 Transform(this Vector2 self, Matrix4x4 matrix)
        {
            return self.To3D().Transform(matrix);
        }

        public static Vector3 Transform(this Vector2 self, Quaternion quat)
        {
            return self.To3D().Transform(quat);
        }

        public static Vector3 To3D(this Vector2 self)
        {
            return new Vector3(self.X, self.Y, 0);
        }

        public static double MixedProduct(this Vector3 v1, Vector3 v2, Vector3 v3)
        {
            return v1.Cross(v2).Dot(v3);
        }

        public static bool AlmostEquals(this Vector3 self, Vector3 other, float tolerance = Constants.Tolerance)
        {
            var diff = self - other.Abs();
            return diff.X < tolerance && diff.Y < tolerance && diff.Z < tolerance;
        }

        public static bool IsNaN(this Vector3 self)
        {
            return float.IsNaN(self.X) || float.IsNaN(self.Y) || float.IsNaN(self.Z);
        }

        public static bool IsInfinity(this Vector3 self)
        {
            return float.IsInfinity(self.X) || float.IsInfinity(self.Y) || float.IsInfinity(self.Z);
        }

        public static bool IsNonZeroAndValid(this Vector3 self)
        {
            return self.LengthSquared().IsNonZeroAndValid();
        }

        public static bool IsZeroOrInvalid(this Vector3 self)
        {
            return !self.IsNonZeroAndValid();
        }

        public static bool IsPerpendicular(this Vector3 v1, Vector3 v2, float tolerance = Constants.Tolerance)
        {
            // If either vector is vector(0,0,0) the vectors are not perpendicular
            if (v1 == Vector3.Zero || v2 == Vector3.Zero)
                return false;
            return v1.Dot(v2).AlmostEquals(0, tolerance);
        }

        public static Vector3 Projection(this Vector3 v1, Vector3 v2)
        {
            return v2 * (v1.Dot(v2) / v2.LengthSquared());
        }

        public static Vector3 Rejection(this Vector3 v1, Vector3 v2)
        {
            return v1 - v1.Projection(v2);
        }

        public static float Angle(this Vector3 v1, Vector3 v2, float tolerance = Constants.Tolerance)
        {
            if (v1.IsZeroOrInvalid() || v2.IsZeroOrInvalid() || v1.AlmostEquals(v2, tolerance))
                return 0;

            return Math.Min(1.0f, v1.Normal().Dot(v2.Normal())).Acos();
        }

        public static bool IsBackFace(this Vector3 normal, Vector3 lineOfSight)
        {
            return normal.Dot(lineOfSight) < 0;
        }

        /// <summary>
        /// Creates a new <see cref="Vector3"/> that contains the cartesian coordinates of a vector specified in barycentric coordinates and relative to 3d-triangle.
        /// </summary>
        /// <param name="value1">The first vector of 3d-triangle.</param>
        /// <param name="value2">The second vector of 3d-triangle.</param>
        /// <param name="value3">The third vector of 3d-triangle.</param>
        /// <param name="amount1">Barycentric scalar <c>b2</c> which represents a weighting factor towards second vector of 3d-triangle.</param>
        /// <param name="amount2">Barycentric scalar <c>b3</c> which represents a weighting factor towards third vector of 3d-triangle.</param>
        /// <returns>The cartesian translation of barycentric coordinates.</returns>
        public static Vector3 Barycentric(this Vector3 value1, Vector3 value2, Vector3 value3, float amount1, float amount2)
        {
            return new Vector3(
                MathHelper.Barycentric(value1.X, value2.X, value3.X, amount1, amount2),
                MathHelper.Barycentric(value1.Y, value2.Y, value3.Y, amount1, amount2),
                MathHelper.Barycentric(value1.Z, value2.Z, value3.Z, amount1, amount2));
        }

        /// <summary>
        /// Creates a new <see cref="Vector3"/> that contains CatmullRom interpolation of the specified vectors.
        /// </summary>
        /// <param name="value1">The first vector in interpolation.</param>
        /// <param name="value2">The second vector in interpolation.</param>
        /// <param name="value3">The third vector in interpolation.</param>
        /// <param name="value4">The fourth vector in interpolation.</param>
        /// <param name="amount">Weighting factor.</param>
        /// <returns>The result of CatmullRom interpolation.</returns>
        public static Vector3 CatmullRom(this Vector3 value1, Vector3 value2, Vector3 value3, Vector3 value4, float amount)
        {
            return new Vector3(
                MathHelper.CatmullRom(value1.X, value2.X, value3.X, value4.X, amount),
                MathHelper.CatmullRom(value1.Y, value2.Y, value3.Y, value4.Y, amount),
                MathHelper.CatmullRom(value1.Z, value2.Z, value3.Z, value4.Z, amount));
        }

        /// <summary>
        /// Creates a new <see cref="Vector3"/> that contains hermite spline interpolation.
        /// </summary>
        /// <param name="value1">The first position vector.</param>
        /// <param name="tangent1">The first tangent vector.</param>
        /// <param name="value2">The second position vector.</param>
        /// <param name="tangent2">The second tangent vector.</param>
        /// <param name="amount">Weighting factor.</param>
        /// <returns>The hermite spline interpolation vector.</returns>
        public static Vector3 Hermite(this Vector3 value1, Vector3 tangent1, Vector3 value2, Vector3 tangent2, float amount)
        {
            return new Vector3(
                MathHelper.Hermite(value1.X, tangent1.X, value2.X, tangent2.X, amount),
                MathHelper.Hermite(value1.Y, tangent1.Y, value2.Y, tangent2.Y, amount),
                MathHelper.Hermite(value1.Z, tangent1.Z, value2.Z, tangent2.Z, amount));
        }

        /// <summary>
        /// Creates a new <see cref="Vector3"/> that contains cubic interpolation of the specified vectors.
        /// </summary>
        /// <param name="value1">Source <see cref="Vector3"/>.</param>
        /// <param name="value2">Source <see cref="Vector3"/>.</param>
        /// <param name="amount">Weighting value.</param>
        /// <returns>Cubic interpolation of the specified vectors.</returns>
        public static Vector3 SmoothStep(this Vector3 value1, Vector3 value2, float amount)
        {
            return new Vector3(
                MathHelper.SmoothStep(value1.X, value2.X, amount),
                MathHelper.SmoothStep(value1.Y, value2.Y, amount),
                MathHelper.SmoothStep(value1.Z, value2.Z, amount));
        }

        public static Line ToLine(this Vector3 v)
        {
            return new Line(Vector3.Zero, v);
        }
        
        public static Vector3 AlongVector(this Vector3 v, float d)
        {
            return v.Normal() * d;
        }

        public static Vector3 AlongX(this float self)
        {
            return Vector3.UnitX.AlongVector(self);
        }

        public static Vector3 AlongY(this float self)
        {
            return Vector3.UnitY.AlongVector(self);
        }

        public static Vector3 AlongZ(this float self)
        {
            return Vector3.UnitX.AlongVector(self);
        }
    }
}
