// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System;
using System.Runtime.CompilerServices;

namespace Vim.Math3d
{
    // TODO: many of these functions are static and should be member functions.
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
        { }

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
        /// Creates a new Quaternion from the given rotation around X, Y, and Z
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateFromEulerAngles(Vector3 v)
        {
            var c1 = Math.Cos(v.X / 2);
            var s1 = Math.Sin(v.X / 2);
            var c2 = Math.Cos(v.Y / 2);
            var s2 = Math.Sin(v.Y / 2);
            var c3 = Math.Cos(v.Z / 2);
            var s3 = Math.Sin(v.Z / 2);

            var qw = c1 * c2 * c3 - s1 * s2 * s3;
            var qx = s1 * c2 * c3 + c1 * s2 * s3;
            var qy = c1 * s2 * c3 - s1 * c2 * s3;
            var qz = c1 * c2 * s3 + s1 * s2 * c3;
            return new Quaternion((float)qx, (float)qy, (float)qz, (float)qw);
        }

        /// <summary>
        /// Creates a new Quaternion from the given rotation around the X axis
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateXRotation(float theta)
            => new Quaternion((float)Math.Sin(theta * 0.5f), 0.0f, 0.0f, (float)Math.Cos(theta * 0.5f));

        /// <summary>
        /// Creates a new Quaternion from the given rotation around the Y axis
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateYRotation(float theta)
            => new Quaternion(0.0f, (float)Math.Sin(theta * 0.5f), 0.0f, (float)Math.Cos(theta * 0.5f));

        /// <summary>
        /// Creates a new Quaternion from the given rotation around the Z axis
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateZRotation(float theta)
            => new Quaternion(0.0f, 0.0f, (float)Math.Sin(theta * 0.5f), (float)Math.Cos(theta * 0.5f));

        /// <summary>
        /// Creates a new look-at Quaternion
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion LookAt(Vector3 position, Vector3 targetPosition, Vector3 up, Vector3 forward)
        {
            var plane = Plane.CreateFromNormalAndPoint(up, position);

            var projectedTarget = Plane.ProjectPointOntoPlane(plane, targetPosition);
            var projectedDirection = (projectedTarget - position).Normalize();

            var q1 = CreateRotationFromAToB(forward, projectedDirection, up);
            var q2 = CreateRotationFromAToB(projectedDirection, (targetPosition - position).Normalize(), up);

            return q2 * q1;
        }

        /// <summary>
        /// Creates a new Quaternion rotating vector 'fromA' to 'toB'.<br/>
        /// Precondition: fromA and toB are normalized.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateRotationFromAToB(Vector3 fromA, Vector3 toB, Vector3? up = null)
        {
            var axis = fromA.Cross(toB);
            var lengthSquared = axis.LengthSquared();
            if (lengthSquared > 0.0f)
            {
                return CreateFromAxisAngle(axis / (float)Math.Sqrt(lengthSquared), (float)Math.Acos(MathOps.Clamp(fromA.Dot(toB), -1, 1)));
            }
            else
            {
                // The vectors are parallel to each other
                if ((fromA + toB).AlmostZero())
                {
                    // The vectors are in opposite directions so rotate by half a circle.
                    return CreateFromAxisAngle(up ?? Vector3.UnitZ, (float) Math.PI);
                }
                else
                {
                    // The vectors are in the same direction so no rotation is required.
                    return Identity;
                }
            }
        }

        /// <summary>
        /// Creates a new Quaternion from the given yaw, pitch, and roll, in radians.
        ///  Roll first, about axis the object is facing, then
        ///  pitch upward, then yaw to face into the new heading
        ///  1. Z(roll), 2. X (pitch), 3. Y (yaw)  
        /// </summary>
        /// <param name="yaw">The yaw angle, in radians, around the Y-axis.</param>
        /// <param name="pitch">The pitch angle, in radians, around the X-axis.</param>
        /// <param name="roll">The roll angle, in radians, around the Z-axis.</param>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion CreateFromYawPitchRoll(float yaw, float pitch, float roll)
        {

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
            => quaternion1.X * quaternion2.X +
                   quaternion1.Y * quaternion2.Y +
                   quaternion1.Z * quaternion2.Z +
                   quaternion1.W * quaternion2.W;

        /// <summary>
        /// Interpolates between two quaternions, using spherical linear interpolation.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Quaternion Slerp(Quaternion q1, Quaternion q2, float t)
        {
            const float epsilon = 1e-6f;

            var cosOmega = q1.X * q2.X + q1.Y * q2.Y +
                             q1.Z * q2.Z + q1.W * q2.W;

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

            return q1 * s1 + q2 * s2;
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
            // 9 muls, 27 adds
            var tmp_00 = (value1.Z - value1.Y) * (value2.Y - value2.Z);
            var tmp_01 = (value1.W + value1.X) * (value2.W + value2.X);
            var tmp_02 = (value1.W - value1.X) * (value2.Y + value2.Z);
            var tmp_03 = (value1.Y + value1.Z) * (value2.W - value2.X);
            var tmp_04 = (value1.Z - value1.X) * (value2.X - value2.Y);
            var tmp_05 = (value1.Z + value1.X) * (value2.X + value2.Y);
            var tmp_06 = (value1.W + value1.Y) * (value2.W - value2.Z);
            var tmp_07 = (value1.W - value1.Y) * (value2.W + value2.Z);
            var tmp_08 = tmp_05 + tmp_06 + tmp_07;
            var tmp_09 = (tmp_04 + tmp_08) * 0.5f;

            return new Quaternion(
                tmp_01 + tmp_09 - tmp_08,
                tmp_02 + tmp_09 - tmp_07,
                tmp_03 + tmp_09 - tmp_06,
                tmp_00 + tmp_09 - tmp_05
                );
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

        /// <summary>
        /// Returns Euler123 angles (rotate around, X, then Y, then Z).
        /// </summary>
        /// <returns></returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 ToEulerAngles()
        {
            /*
            // https://stackoverflow.com/questions/5782658/extracting-yaw-from-a-quaternion
            // This should fit for intrinsic tait-bryan rotation of xyz-order.
            var yaw = (float)Math.Atan2(2.0 * (Y * Z + W * X), W * W - X * X - Y * Y + Z * Z);
            var pitch = (float)Math.Asin(-2.0 * (X * Z - W * Y));
            var roll = (float)Math.Atan2(2.0 * (X * Y + W * Z), W * W + X * X - Y * Y - Z * Z);
            */

            /*
            // https://community.monogame.net/t/solved-reverse-createfromyawpitchroll-or-how-to-get-the-vector-that-would-produce-the-matrix-given-only-the-matrix/9054/3
            var matrix = Matrix4x4.CreateFromQuaternion(this);
            var yaw = (float)System.Math.Atan2(matrix.M13, matrix.M33);
            var pitch = (float)System.Math.Asin(-matrix.M23);
            var roll = (float)System.Math.Atan2(matrix.M21, matrix.M22);
            */

            /*
            // https://stackoverflow.com/questions/11492299/quaternion-to-euler-angles-algorithm-how-to-convert-to-y-up-and-between-ha
            var yaw = (float)Math.Atan2(2f * q.X * q.W + 2f * q.Y * q.Z, 1 - 2f * (sqz + sqw));     // Yaw 
            var pitch = (float)Math.Asin(2f * (q.X * q.Z - q.W * q.Y));                             // Pitch 
            var roll = (float)Math.Atan2(2f * q.X * q.Y + 2f * q.Z * q.W, 1 - 2f * (sqy + sqz));      // Roll
            */

            /*
            //This is the code from  http://www.mawsoft.com/blog/?p=197
            var yaw = (float)Math.Atan2(2 * (W * X + Y * Z), 1 - 2 * (Math.Pow(X, 2) + Math.Pow(Y, 2)));
            var pitch = (float)Math.Asin(2 * (W * Y - Z * X));
            var roll = (float)Math.Atan2(2 * (W * Z + X * Y), 1 - 2 * (Math.Pow(Y, 2) + Math.Pow(Z, 2)));
            */

            //return new Vector3(pitch, yaw, roll);

            //https://www.gamedev.net/forums/topic/597324-quaternion-to-euler-angles-and-back-why-is-the-rotation-changing/
            var x = (float)Math.Atan2(-2 * (Y * Z - W * X), W * W - X * X - Y * Y + Z * Z);
            var y = (float)Math.Asin(2 * (X * Z + W * Y));
            var z = (float)Math.Atan2(-2 * (X * Y - W * Z), W * W + X * X - Y * Y - Z * Z);
            return new Vector3(x, y, z);
        }

        public Vector4 Vector4
            => new Vector4(X, Y, Z, W);

        public HorizontalCoordinate ToSphericalAngle()
            => ToSphericalAngle(Vector3.UnitY);

        public HorizontalCoordinate ToSphericalAngle(Vector3 forwardVector)
        {
            var newForward = forwardVector.Transform(this);
            var forwardXY = new Vector3(newForward.X, newForward.Y, 0.0f).Normalize();
            var angle = forwardXY.Y.Acos();
            var azimuth = forwardXY.X < 0.0f ? angle : -angle;
            var inclination = -newForward.Z.Acos() + Constants.HalfPi;
            return (azimuth, inclination);
        }

        public static Quaternion Create(HorizontalCoordinate angle)
            => CreateZRotation((float)angle.Azimuth) * CreateXRotation((float)angle.Inclination);

        public static implicit operator Quaternion(HorizontalCoordinate angle)
            => Create(angle);

        public static implicit operator HorizontalCoordinate(Quaternion q)
            => q.ToSphericalAngle();
    }
}
