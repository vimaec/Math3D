// MIT License 
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System.Runtime.CompilerServices;

namespace Ara3D
{
    /// <summary>
    /// A structure encapsulating a 3D Plane
    /// </summary>
    public partial struct Plane 
    {
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Plane(float x, float y, float z, float d)
            : this(new Vector3(x, y, z), d)
        { }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Plane(Vector4 v)
            : this(v.X, v.Y, v.Z, v.W)
        { }

        /// <summary>
        /// Creates a Plane that contains the three given points.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Plane CreateFromVertices(Vector3 point1, Vector3 point2, Vector3 point3)
        {
            var a = point2 - point1;
            var b = point3 - point1;
            var n = a.Cross(b);
            var d = -n.Normalize().Dot(point1);
            return new Plane(n.Normalize(), d);
        }

        /// <summary>
        /// Creates a new Plane whose normal vector is the source Plane's normal vector normalized.
        /// </summary>
        /// <param name="value">The source Plane.</param>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Plane Normalize(Plane value)
        {
            const float FLT_EPSILON = 1.192092896e-07f; // smallest such that 1.0+FLT_EPSILON != 1.0
            var normalLengthSquared = value.Normal.LengthSquared();
            if ((normalLengthSquared - 1.0f).Abs() < FLT_EPSILON)
            {
                // It already normalized, so we don't need to farther process.
                return value;
            }
            var normalLength = normalLengthSquared.Sqrt();
            return new Plane(
                value.Normal / normalLength,
                value.D / normalLength);
        }

        /// <summary>
        /// Transforms a normalized Plane by a Matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Plane Transform(Plane plane, Matrix4x4 matrix)
        {
            Matrix4x4.Invert(matrix, out var m);
            float x = plane.Normal.X, y = plane.Normal.Y, z = plane.Normal.Z, w = plane.D;
            return new Plane(
                x * m.M11 + y * m.M12 + z * m.M13 + w * m.M14,
                x * m.M21 + y * m.M22 + z * m.M23 + w * m.M24,
                x * m.M31 + y * m.M32 + z * m.M33 + w * m.M34,
                x * m.M41 + y * m.M42 + z * m.M43 + w * m.M44);
        }

        /// <summary>
        ///  Transforms a normalized Plane by a Quaternion rotation.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Plane Transform(Plane plane, Quaternion rotation)
        {
            // Compute rotation matrix.
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

            var m11 = 1.0f - yy2 - zz2;
            var m21 = xy2 - wz2;
            var m31 = xz2 + wy2;

            var m12 = xy2 + wz2;
            var m22 = 1.0f - xx2 - zz2;
            var m32 = yz2 - wx2;

            var m13 = xz2 - wy2;
            var m23 = yz2 + wx2;
            var m33 = 1.0f - xx2 - yy2;

            float x = plane.Normal.X, y = plane.Normal.Y, z = plane.Normal.Z;

            return new Plane(
                x * m11 + y * m21 + z * m31,
                x * m12 + y * m22 + z * m32,
                x * m13 + y * m23 + z * m33,
                plane.D);
        }

        /// <summary>
        /// Calculates the dot product of a Plane and Vector4.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float Dot(Plane plane, Vector4 value)
            => plane.Dot(value);

        /// <summary>
        /// Calculates the dot product of a Plane and Vector4.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float Dot(Vector4 value)
            => ToVector4().Dot(value);

        /// <summary>
        /// Returns the dot product of a specified Vector3 and the normal vector of this Plane plus the distance (D) value of the Plane.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float DotCoordinate(Plane plane, Vector3 value)
            => Vector3.Dot(plane.Normal, value) + plane.D;

        /// <summary>
        /// Returns the dot product of a specified Vector3 and the Normal vector of this Plane.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float DotNormal(Plane plane, Vector3 value)
            => plane.Normal.Dot(value);

        /// <summary>
        /// Returns a value less than zero if the points is below the plane, above zero if above the plane, or zero if coplanar
        /// </summary>
        /// <param name="point"></param>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float ClassifyPoint(Vector3 point)
            => point.Dot(Normal) + D;

        /// <summary>
        /// Returns a Vector4 representation of the Plane
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector4 ToVector4()
            => new Vector4(Normal.X, Normal.Y, Normal.Z, D);
    }
}
