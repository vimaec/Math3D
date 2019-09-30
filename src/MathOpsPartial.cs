// MIT License 
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;
using System.Runtime.CompilerServices;

namespace Vim
{
    public static partial class MathOps
    {
        /// <summary>
        /// Performs a Catmull-Rom interpolation using the specified positions.
        /// </summary>
        /// <param name="value1">The first position in the interpolation.</param>
        /// <param name="value2">The second position in the interpolation.</param>
        /// <param name="value3">The third position in the interpolation.</param>
        /// <param name="value4">The fourth position in the interpolation.</param>
        /// <param name="amount">Weighting factor.</param>
        /// <returns>A position that is the result of the Catmull-Rom interpolation.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float CatmullRom(this float value1, float value2, float value3, float value4, float amount)
        {
            // Using formula from http://www.mvps.org/directx/articles/catmull/
            // Internally using doubles not to lose precision
            double amountSquared = amount * amount;
            var amountCubed = amountSquared * amount;
            return (float)(0.5 * (2.0 * value2 +
                (value3 - value1) * amount +
                (2.0 * value1 - 5.0 * value2 + 4.0 * value3 - value4) * amountSquared +
                (3.0 * value2 - value1 - 3.0 * value3 + value4) * amountCubed));
        }

        /// <summary>
        /// Performs a Hermite spline interpolation.
        /// </summary>
        /// <param name="value1">Source position.</param>
        /// <param name="tangent1">Source tangent.</param>
        /// <param name="value2">Source position.</param>
        /// <param name="tangent2">Source tangent.</param>
        /// <param name="amount">Weighting factor.</param>
        /// <returns>The result of the Hermite spline interpolation.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float Hermite(this float value1, float tangent1, float value2, float tangent2, float amount)
        {
            // All transformed to double not to lose precision
            // Otherwise, for high numbers of param:amount the result is NaN instead of Infinity
            double v1 = value1, v2 = value2, t1 = tangent1, t2 = tangent2, s = amount, result;
            var sCubed = s * s * s;
            var sSquared = s * s;

            if (amount == 0f)
                result = value1;
            else if (amount == 1f)
                result = value2;
            else
                result = (2 * v1 - 2 * v2 + t2 + t1) * sCubed +
                    (3 * v2 - 3 * v1 - 2 * t1 - t2) * sSquared +
                    t1 * s +
                    v1;
            return (float)result;
        }

        /// <summary>
        /// Interpolates between two values using a cubic equation (Hermite),
        /// clamping the amount to 0 to 1
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float SmoothStep(this float value1, float value2, float amount)
            => Hermite(value1, 0f, value2, 0f, Clamp(amount, 0f, 1f));
	 
        /// <summary>
        /// Reduces a given angle to a value between π and -π.
        /// </summary>
        /// <param name="angle">The angle to reduce, in radians.</param>
        /// <returns>The new angle, in radians.</returns>
        public static float WrapAngle(this float angle)
        {
            if ((angle > -Constants.Pi) && (angle <= Constants.Pi))
                return angle;
            angle %= Constants.TwoPi;
            if (angle <= -Constants.Pi)
                return angle + Constants.TwoPi;
            if (angle > Constants.Pi)
                return angle - Constants.TwoPi;
            return angle;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool IsNonZeroAndValid(this float self, float tolerance = Constants.Tolerance)
            => !self.IsInfinity() && !self.IsNaN() && self.Abs() > tolerance;        

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float[] ToFloats(this Matrix4x4 m)
            => new[]
            {
                m.M11, m.M12, m.M13, m.M14,
                m.M21, m.M22, m.M23, m.M24,
                m.M31, m.M32, m.M33, m.M34,
                m.M41, m.M42, m.M43, m.M44
            };

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 ToMatrix(this float[] m)
            => new Matrix4x4(m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8], m[9], m[10], m[11], m[12], m[13],
                m[14], m[15]);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 Inverse(this Matrix4x4 m)
            => Matrix4x4.Invert(m, out var r) ? r : throw new Exception("No inversion of matrix available");

        /// <summary>
        /// Transforms a vector by the given Quaternion rotation value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector4 Transform(this Vector4 value, Matrix4x4 matrix)
            => value.Transform(matrix);

        /// <summary>
        /// Transforms a vector by the given Quaternion rotation value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector4 Transform(this Vector4 value, Quaternion rotation)
        {
            var x2 = rotation.X + rotation.X;
            var y2 = rotation.Y + rotation.Y;
            var z2 = rotation.Z + rotation.Z;

            var wx2 = rotation.W * x2;
            var wy2 = rotation.W * y2;
            var wz2 = rotation.W * z2;
            var xx2 = rotation.X * x2;
            var xy2 = rotation.X * y2;
            var xz2 = rotation.X * z2;
            var yy2 = rotation.Y * y2;
            var yz2 = rotation.Y * z2;
            var zz2 = rotation.Z * z2;

            return new Vector4(
                value.X * (1.0f - yy2 - zz2) + value.Y * (xy2 - wz2) + value.Z * (xz2 + wy2),
                value.X * (xy2 + wz2) + value.Y * (1.0f - xx2 - zz2) + value.Z * (yz2 - wx2),
                value.X * (xz2 - wy2) + value.Y * (yz2 + wx2) + value.Z * (1.0f - xx2 - yy2),
                value.W);
        }
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector2 ToVector2(this float v) => new Vector2(v);
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector2 ToVector2(this Vector3 v) => new Vector2(v.X, v.Y);
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector2 ToVector2(this Vector4 v) => new Vector2(v.X, v.Y);
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector3 ToVector3(this float v) => new Vector3(v);
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector3 ToVector3(this Vector2 v) => new Vector3(v.X, v.Y, 0);
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector3 ToVector3(this Vector4 v) => new Vector3(v.X, v.Y, v.Z);
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector4 ToVector4(this float v) => new Vector4(v);
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector4 ToVector4(this Vector2 v) => new Vector4(v.X, v.Y, 0, 0);
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector4 ToVector4(this Vector3 v) => new Vector4(v.X, v.Y, v.Z, 0);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 Rotate(this Vector3 self, Vector3 axis, float angle)
            => self.Transform(Matrix4x4.CreateFromAxisAngle(axis, angle));

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool IsNonZeroAndValid(this Vector3 self)
            => self.LengthSquared().IsNonZeroAndValid();

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool IsZeroOrInvalid(this Vector3 self)
            => !self.IsNonZeroAndValid();

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool IsPerpendicular(this Vector3 v1, Vector3 v2, float tolerance = Constants.Tolerance)
            // If either vector is vector(0,0,0) the vectors are not perpendicular
            => v1 != Vector3.Zero && v2 != Vector3.Zero && v1.Dot(v2).AlmostZero(tolerance);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 Projection(this Vector3 v1, Vector3 v2)
            => v2 * (v1.Dot(v2) / v2.LengthSquared());

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 Rejection(this Vector3 v1, Vector3 v2)
            => v1 - v1.Projection(v2);

        // The smaller of the two possible angles between the two vectors is returned, therefore the result will never be greater than 180 degrees or smaller than -180 degrees.
        // If you imagine the from and to vectors as lines on a piece of paper, both originating from the same point, then the /axis/ vector would point up out of the paper.
        // The measured angle between the two vectors would be positive in a clockwise direction and negative in an anti-clockwise direction.
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float SignedAngle(Vector3 from, Vector3 to, Vector3 axis)
            => Angle(from, to) * Math.Sign(axis.Dot(from.Cross(to)));

        // The smaller of the two possible angles between the two vectors is returned, therefore the result will never be greater than 180 degrees or smaller than -180 degrees.
        // If you imagine the from and to vectors as lines on a piece of paper, both originating from the same point, then the /axis/ vector would point up out of the paper.
        // The measured angle between the two vectors would be positive in a clockwise direction and negative in an anti-clockwise direction.
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float SignedAngle(this Vector3 from, Vector3 to)
            => SignedAngle(from, to, Vector3.UnitZ);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float Angle(this Vector3 v1, Vector3 v2, float tolerance = Constants.Tolerance)
        {
            var d = v1.LengthSquared() * v2.LengthSquared().Sqrt();
            if (d < tolerance)
                return 0;
            return (v1.Dot(v2) / d).Clamp(-1F, 1F).Acos();
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool Colinear(this Vector3 v1, Vector3 v2, float tolerance = Constants.Tolerance)
            => !v1.IsNaN() && !v2.IsNaN() && v1.SignedAngle(v2) <= tolerance;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool IsBackFace(this Vector3 normal, Vector3 lineOfSight)
            => normal.Dot(lineOfSight) < 0;

        /// <summary>
        /// Creates a new <see cref="Vector3"/> that contains CatmullRom interpolation of the specified vectors.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 CatmullRom(this Vector3 value1, Vector3 value2, Vector3 value3, Vector3 value4, float amount) =>
            new Vector3(value1.X.CatmullRom(value2.X, value3.X, value4.X, amount), value1.Y.CatmullRom(value2.Y, value3.Y, value4.Y, amount), value1.Z.CatmullRom(value2.Z, value3.Z, value4.Z, amount));

        /// <summary>
        /// Creates a new <see cref="Vector3"/> that contains hermite spline interpolation.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 Hermite(this Vector3 value1, Vector3 tangent1, Vector3 value2, Vector3 tangent2, float amount) =>
            new Vector3(value1.X.Hermite(tangent1.X, value2.X, tangent2.X, amount), value1.Y.Hermite(tangent1.Y, value2.Y, tangent2.Y, amount), value1.Z.Hermite(tangent1.Z, value2.Z, tangent2.Z, amount));

        /// <summary>
        /// Creates a new <see cref="Vector3"/> that contains cubic interpolation of the specified vectors.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 SmoothStep(this Vector3 value1, Vector3 value2, float amount) =>
            new Vector3(value1.X.SmoothStep(value2.X, amount), value1.Y.SmoothStep(value2.Y, amount), value1.Z.SmoothStep(value2.Z, amount));

        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Line ToLine(this Vector3 v) => new Line(Vector3.Zero, v);
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector3 Along(this Vector3 v, float d) => v.Normalize() * d;
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector3 AlongX(this float self) => Vector3.UnitX * self;
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector3 AlongY(this float self) => Vector3.UnitY * self;
        [MethodImpl(MethodImplOptions.AggressiveInlining)] public static Vector3 AlongZ(this float self) => Vector3.UnitX * self;

        /// <summary>
        /// Transforms a vector by the given Quaternion rotation value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 Transform(this Vector3 value, Quaternion rotation)
        {
            var x2 = rotation.X + rotation.X;
            var y2 = rotation.Y + rotation.Y;
            var z2 = rotation.Z + rotation.Z;

            var wx2 = rotation.W * x2;
            var wy2 = rotation.W * y2;
            var wz2 = rotation.W * z2;
            var xx2 = rotation.X * x2;
            var xy2 = rotation.X * y2;
            var xz2 = rotation.X * z2;
            var yy2 = rotation.Y * y2;
            var yz2 = rotation.Y * z2;
            var zz2 = rotation.Z * z2;

            return new Vector3(
                value.X * (1.0f - yy2 - zz2) + value.Y * (xy2 - wz2) + value.Z * (xz2 + wy2),
                value.X * (xy2 + wz2) + value.Y * (1.0f - xx2 - zz2) + value.Z * (yz2 - wx2),
                value.X * (xz2 - wy2) + value.Y * (yz2 + wx2) + value.Z * (1.0f - xx2 - yy2));
        }

        /// <summary>
        /// Returns the reflection of a vector off a surface that has the specified normal.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector2 Reflect(Vector2 vector, Vector2 normal)
            => vector - (2 * (vector.Dot(normal) * normal));

        /// <summary>
        /// Returns the reflection of a vector off a surface that has the specified normal.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 Reflect(Vector3 vector, Vector3 normal)
            => vector - (2 * (vector.Dot(normal) * normal));

        /// <summary>
        /// Transforms a vector by the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector2 Transform(this Vector2 position, Matrix4x4 matrix)
            => new Vector2(
                position.X * matrix.M11 + position.Y * matrix.M21 + matrix.M41,
                position.X * matrix.M12 + position.Y * matrix.M22 + matrix.M42);

        /// <summary>
        /// Transforms a vector normal by the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector2 TransformNormal(Vector2 normal, Matrix4x4 matrix)
            => new Vector2(
                normal.X * matrix.M11 + normal.Y * matrix.M21,
                normal.X * matrix.M12 + normal.Y * matrix.M22);

        /// <summary>
        /// Transforms a vector normal by the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 TransformNormal(Vector3 normal, Matrix4x4 matrix)
            => new Vector3(
                normal.X * matrix.M11 + normal.Y * matrix.M21 + normal.Z * matrix.M31,
                normal.X * matrix.M12 + normal.Y * matrix.M22 + normal.Z * matrix.M32,
                normal.X * matrix.M13 + normal.Y * matrix.M23 + normal.Z * matrix.M33
                );

        /// <summary>
        /// Transforms a vector normal by the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector4 TransformNormal(Vector4 normal, Matrix4x4 matrix)
            => new Vector4(
                normal.X * matrix.M11 + normal.Y * matrix.M21 + normal.Z * matrix.M31 + normal.W * matrix.M41,
                normal.X * matrix.M12 + normal.Y * matrix.M22 + normal.Z * matrix.M32 + normal.W * matrix.M42,
                normal.X * matrix.M13 + normal.Y * matrix.M23 + normal.Z * matrix.M33 + normal.W * matrix.M43,
                normal.X * matrix.M14 + normal.Y * matrix.M24 + normal.Z * matrix.M34 + normal.W * matrix.M44
                );

        /// <summary>
        /// Transforms a vector by the given Quaternion rotation value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector2 Transform(this Vector2 value, Quaternion rotation)
        {
            var x2 = rotation.X + rotation.X;
            var y2 = rotation.Y + rotation.Y;
            var z2 = rotation.Z + rotation.Z;

            var wz2 = rotation.W * z2;
            var xx2 = rotation.X * x2;
            var xy2 = rotation.X * y2;
            var yy2 = rotation.Y * y2;
            var zz2 = rotation.Z * z2;

            return new Vector2(
                value.X * (1.0f - yy2 - zz2) + value.Y * (xy2 - wz2),
                value.X * (xy2 + wz2) + value.Y * (1.0f - xx2 - zz2));
        }
        /// <summary>
        /// Transforms a vector by the given Quaternion rotation value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector4 TransformToVector4(Vector2 value, Quaternion rotation)
        {
            float x2 = rotation.X + rotation.X;
            float y2 = rotation.Y + rotation.Y;
            float z2 = rotation.Z + rotation.Z;

            float wx2 = rotation.W * x2;
            float wy2 = rotation.W * y2;
            float wz2 = rotation.W * z2;
            float xx2 = rotation.X * x2;
            float xy2 = rotation.X * y2;
            float xz2 = rotation.X * z2;
            float yy2 = rotation.Y * y2;
            float yz2 = rotation.Y * z2;
            float zz2 = rotation.Z * z2;

            return new Vector4(
                value.X * (1.0f - yy2 - zz2) + value.Y * (xy2 - wz2),
                value.X * (xy2 + wz2) + value.Y * (1.0f - xx2 - zz2),
                value.X * (xz2 - wy2) + value.Y * (yz2 + wx2),
                1.0f);
        }

        /// <summary>
        /// Transforms a vector by the given Quaternion rotation value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector4 TransformToVector4(Vector3 value, Quaternion rotation)
        {
            float x2 = rotation.X + rotation.X;
            float y2 = rotation.Y + rotation.Y;
            float z2 = rotation.Z + rotation.Z;

            float wx2 = rotation.W * x2;
            float wy2 = rotation.W * y2;
            float wz2 = rotation.W * z2;
            float xx2 = rotation.X * x2;
            float xy2 = rotation.X * y2;
            float xz2 = rotation.X * z2;
            float yy2 = rotation.Y * y2;
            float yz2 = rotation.Y * z2;
            float zz2 = rotation.Z * z2;

            return new Vector4(
                value.X * (1.0f - yy2 - zz2) + value.Y * (xy2 - wz2) + value.Z * (xz2 + wy2),
                value.X * (xy2 + wz2) + value.Y * (1.0f - xx2 - zz2) + value.Z * (yz2 - wx2),
                value.X * (xz2 - wy2) + value.Y * (yz2 + wx2) + value.Z * (1.0f - xx2 - yy2),
                1.0f);
        }

        /// <summary>
        /// Transforms a vector by the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector4 TransformToVector4(Vector2 position, Matrix4x4 matrix)
        {
            return new Vector4(
                position.X * matrix.M11 + position.Y * matrix.M21 + matrix.M41,
                position.X * matrix.M12 + position.Y * matrix.M22 + matrix.M42,
                position.X * matrix.M13 + position.Y * matrix.M23 + matrix.M43,
                position.X * matrix.M14 + position.Y * matrix.M24 + matrix.M44);
        }

        /// <summary>
        /// Transforms a vector by the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector4 TransformToVector4(Vector3 position, Matrix4x4 matrix)
        {
            return new Vector4(
                position.X * matrix.M11 + position.Y * matrix.M21 + position.Z * matrix.M31 + matrix.M41,
                position.X * matrix.M12 + position.Y * matrix.M22 + position.Z * matrix.M32 + matrix.M42,
                position.X * matrix.M13 + position.Y * matrix.M23 + position.Z * matrix.M33 + matrix.M43,
                position.X * matrix.M14 + position.Y * matrix.M24 + position.Z * matrix.M34 + matrix.M44);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Vector3 Cross(Vector3 a, Vector3 b)
            => a.Cross(b);
    }
}
