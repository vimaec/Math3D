// MIT License 
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System.Runtime.CompilerServices;

namespace Vim
{
    /// <summary>
    /// A structure encapsulating a four-dimensional vector (x,y,z,w), 
    /// which is used to efficiently rotate an object about the (x,y,z) vector by the angle theta, where w = cos(theta/2).
    /// </summary>
    public partial struct Quaternion
    {
        /// <summary>
        /// Returns a Quaternion representing no rotation. 
        /// </summary>
        public static Quaternion Identity 
            => new Quaternion(0, 0, 0, 1);

        /// <summary>
        /// Returns whether the Quaternion is the identity Quaternion.
        /// </summary>
        public bool IsIdentity 
            => this == Identity;

        /// <summary>
        /// Constructs a Quaternion from the given vector and rotation parts.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Quaternion(Vector3 vectorPart, float scalarPart)
            : this(vectorPart.X, vectorPart.Y, vectorPart.Z, scalarPart)
        {  }

        /// <summary>
        /// Calculates the length of the Quaternion.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float Length()
            => LengthSquared().Sqrt();

        /// <summary>
        /// Calculates the length squared of the Quaternion. This operation is cheaper than Length().
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float LengthSquared()
            => X * X + Y * Y + Z * Z + W * W;

        /// <summary>
        /// Divides each component of the Quaternion by the length of the Quaternion.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Quaternion Normalize()
            => this * Length().Inverse();

        /// <summary>
        /// Returns the conjugate of the quaternion
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Quaternion Conjugate()
            => new Quaternion(-X, -Y, -Z, W);

        /// <summary>
        /// Returns the inverse of a Quaternion.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Quaternion Inverse()
            => Conjugate() * LengthSquared().Inverse();

        /// <summary>
        /// Creates a Quaternion from a normalized vector axis and an angle to rotate about the vector.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateFromAxisAngle(Vector3 axis, float angle)
            => new Quaternion(axis * (angle * 0.5f).Sin(), (angle * 0.5f).Cos());

        /// <summary>
        /// Creates a new Quaternion from the given yaw, pitch, and roll, in radians.
        /// TODO: should we have "Euler" as a separate input? I am not sure.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateFromYawPitchRoll(Vector3 v)
            => CreateFromYawPitchRoll(v.X, v.Y, v.Z);

        /// <summary>
        /// Creates a new Quaternion from the given yaw, pitch, and roll, in radians.
        /// </summary>
        /// <param name="yaw">The yaw angle, in radians, around the Y-axis.</param>
        /// <param name="pitch">The pitch angle, in radians, around the X-axis.</param>
        /// <param name="roll">The roll angle, in radians, around the Z-axis.</param>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateFromYawPitchRoll(float yaw, float pitch, float roll)
        {
            //  Roll first, about axis the object is facing, then
            //  pitch upward, then yaw to face into the new heading

            var halfRoll = roll * 0.5f;
            var sr = halfRoll.Sin();
            var cr = halfRoll.Cos();

            var halfPitch = pitch * 0.5f;
            var sp = halfPitch.Sin();
            var cp = halfPitch.Cos();

            var halfYaw = yaw * 0.5f;
            var sy = halfYaw.Sin();
            var cy = halfYaw.Cos();

            return new Quaternion(
                cy * sp * cr + sy * cp * sr,
                sy * cp * cr - cy * sp * sr,
                cy * cp * sr - sy * sp * cr,
                cy * cp * cr + sy * sp * sr);
        }

        /// <summary>
        /// Creates a Quaternion from the given rotation matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateFromRotationMatrix(Matrix4x4 matrix)
        {
            var trace = matrix.M11 + matrix.M22 + matrix.M33;

            if (trace > 0.0f)
            {
                var s = (trace + 1.0f).Sqrt();
                var w = s * 0.5f;
                s = 0.5f / s;
                return new Quaternion(
                    (matrix.M23 - matrix.M32) * s,
                    (matrix.M31 - matrix.M13) * s,
                    (matrix.M12 - matrix.M21) * s,
                    w);
            }
            if (matrix.M11 >= matrix.M22 && matrix.M11 >= matrix.M33)
            {
                var s = (1.0f + matrix.M11 - matrix.M22 - matrix.M33).Sqrt();
                var invS = 0.5f / s;
                return new Quaternion(0.5f * s,
                    (matrix.M12 + matrix.M21) * invS,
                    (matrix.M13 + matrix.M31) * invS,
                    (matrix.M23 - matrix.M32) * invS);
            }
            if (matrix.M22 > matrix.M33)
            {
                var s = (1.0f + matrix.M22 - matrix.M11 - matrix.M33).Sqrt();
                var invS = 0.5f / s;
                return new Quaternion(
                   (matrix.M21 + matrix.M12) * invS,
                   0.5f * s,
                   (matrix.M32 + matrix.M23) * invS,
                   (matrix.M31 - matrix.M13) * invS);
            }
            {
                var s = (1.0f + matrix.M33 - matrix.M11 - matrix.M22).Sqrt();
                var invS = 0.5f / s;
                return new Quaternion(
                    (matrix.M31 + matrix.M13) * invS, 
                    (matrix.M32 + matrix.M23) * invS, 
                    0.5f * s,
                    (matrix.M12 - matrix.M21) * invS);
            }
        }

        /// <summary>
        /// Calculates the dot product of two Quaternions.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static float Dot(Quaternion quaternion1, Quaternion quaternion2)
        {
            return quaternion1.X * quaternion2.X +
                   quaternion1.Y * quaternion2.Y +
                   quaternion1.Z * quaternion2.Z +
                   quaternion1.W * quaternion2.W;
        }

        /// <summary>
        /// Interpolates between two quaternions, using spherical linear interpolation.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion Slerp(Quaternion quaternion1, Quaternion quaternion2, float t)
        {
            const float epsilon = 1e-6f;

            var cosOmega = quaternion1.X * quaternion2.X + quaternion1.Y * quaternion2.Y +
                             quaternion1.Z * quaternion2.Z + quaternion1.W * quaternion2.W;

            var flip = false;

            if (cosOmega < 0.0f)
            {
                flip = true;
                cosOmega = -cosOmega;
            }

            float s1, s2;

            if (cosOmega > (1.0f - epsilon))
            {
                // Too close, do straight linear interpolation.
                s1 = 1.0f - t;
                s2 = (flip) ? -t : t;
            }
            else
            {
                var omega = cosOmega.Acos();
                var invSinOmega = 1 / omega.Sin();

                s1 = ((1.0f - t) * omega).Sin() * invSinOmega;
                s2 = (flip)
                    ? -(t * omega).Sin() * invSinOmega
                    : (t * omega).Sin() * invSinOmega;
            }

            return quaternion1 * s1 + quaternion2 * s2;
        }

        /// <summary>
        ///  Linearly interpolates between two quaternions.
        /// </summary>
        /// (1.0f - 1) 
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion Lerp(Quaternion q1, Quaternion q2, float t)
            => (Dot(q1, q2) >= 0.0f
                ? (q1 * (1.0f - t) + q2 * t)
                : (q1 * (1.0f - t) - q2 * t)).Normalize();

        /// <summary>
        /// Concatenates two Quaternions; the result represents the value1 rotation followed by the value2 rotation.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion Concatenate(Quaternion value1, Quaternion value2)
        {
            // Concatenate rotation is actually q2 * q1 instead of q1 * q2.
            // So that's why value2 goes q1 and value1 goes q2.
            var q1x = value2.X;
            var q1y = value2.Y;
            var q1z = value2.Z;
            var q1w = value2.W;

            var q2x = value1.X;
            var q2y = value1.Y;
            var q2z = value1.Z;
            var q2w = value1.W;

            // cross(av, bv)
            var cx = q1y * q2z - q1z * q2y;
            var cy = q1z * q2x - q1x * q2z;
            var cz = q1x * q2y - q1y * q2x;

            var dot = q1x * q2x + q1y * q2y + q1z * q2z;

            return new Quaternion(
                q1x * q2w + q2x * q1w + cx, 
                q1y * q2w + q2y * q1w + cy, 
                q1z * q2w + q2z * q1w + cz,
                q1w * q2w - dot);
        }

        /// <summary>
        /// Flips the sign of each component of the quaternion.
        /// </summary>
        public static Quaternion operator -(Quaternion value)
            => new Quaternion(-value.X, -value.Y, -value.Z, -value.W);

        /// <summary>
        /// Adds two Quaternions element-by-element.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion operator +(Quaternion value1, Quaternion value2)
            => new Quaternion(value1.X + value2.X, value1.Y + value2.Y, value1.Z + value2.Z, value1.W + value2.W);

        /// <summary>
        /// Subtracts one Quaternion from another.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion operator -(Quaternion value1, Quaternion value2)
            => new Quaternion(value1.X - value2.X, value1.Y - value2.Y, value1.Z - value2.Z, value1.W - value2.W);

        /// <summary>
        /// Multiplies two Quaternions together.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion operator *(Quaternion value1, Quaternion value2)
        {
            var q1x = value1.X;
            var q1y = value1.Y;
            var q1z = value1.Z;
            var q1w = value1.W;

            var q2x = value2.X;
            var q2y = value2.Y;
            var q2z = value2.Z;
            var q2w = value2.W;

            // cross(av, bv)
            var cx = q1y * q2z - q1z * q2y;
            var cy = q1z * q2x - q1x * q2z;
            var cz = q1x * q2y - q1y * q2x;

            var dot = q1x * q2x + q1y * q2y + q1z * q2z;

            return new Quaternion(
                q1x * q2w + q2x * q1w + cx, 
                q1y * q2w + q2y * q1w + cy, 
                q1z * q2w + q2z * q1w + cz,
                q1w * q2w - dot);
        }

        /// <summary>
        /// Multiplies a Quaternion by a scalar value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion operator *(Quaternion value1, float value2)
            => new Quaternion(value1.X * value2, value1.Y * value2, value1.Z * value2, value1.W * value2);

        /// <summary>
        /// Divides a Quaternion by another Quaternion.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion operator /(Quaternion value1, Quaternion value2)
            => value1 * value2.Inverse();
    }
}
