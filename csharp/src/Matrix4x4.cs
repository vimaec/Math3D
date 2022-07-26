// MIT License 
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace Vim.Math3d
{
    /// <summary>
    /// A structure encapsulating a 4x4 matrix.
    /// </summary>
    [StructLayout(LayoutKind.Sequential), DataContract]
    public struct Matrix4x4 : IEquatable<Matrix4x4>, ITransformable3D<Matrix4x4>
    {
        public Vector3 Col0 => new Vector3(M11, M21, M31);
        public Vector3 Col1 => new Vector3(M12, M22, M32);
        public Vector3 Col2 => new Vector3(M13, M23, M33);
        public Vector3 Col3 => new Vector3(M14, M24, M34);

        public Vector3 Row0 => new Vector3(M11, M12, M13);
        public Vector3 Row1 => new Vector3(M21, M22, M23);
        public Vector3 Row2 => new Vector3(M31, M32, M33);
        public Vector3 Row3 => new Vector3(M41, M42, M43);

        public Vector3 GetRow(int row)
            => row == 0 ? Row0 : row == 1 ? Row1 : row == 2 ? Row2 : Row3;

        public Vector3 GetCol(int col)
            => col == 0 ? Col0 : col == 1 ? Col1 : col == 2 ? Col2 : Col3;

        /// <summary>
        /// Value at row 1, column 1 of the matrix.
        /// </summary>
        [DataMember] public float M11;
        /// <summary>
        /// Value at row 1, column 2 of the matrix.
        /// </summary>
        [DataMember] public float M12;
        /// <summary>
        /// Value at row 1, column 3 of the matrix.
        /// </summary>
        [DataMember] public float M13;
        /// <summary>
        /// Value at row 1, column 4 of the matrix.
        /// </summary>
        [DataMember] public float M14;

        /// <summary>
        /// Value at row 2, column 1 of the matrix.
        /// </summary>
        [DataMember] public float M21;
        /// <summary>
        /// Value at row 2, column 2 of the matrix.
        /// </summary>
        [DataMember] public float M22;
        /// <summary>
        /// Value at row 2, column 3 of the matrix.
        /// </summary>
        [DataMember] public float M23;
        /// <summary>
        /// Value at row 2, column 4 of the matrix.
        /// </summary>
        [DataMember] public float M24;

        /// <summary>
        /// Value at row 3, column 1 of the matrix.
        /// </summary>
        [DataMember] public float M31;
        /// <summary>
        /// Value at row 3, column 2 of the matrix.
        /// </summary>
        [DataMember] public float M32;
        /// <summary>
        /// Value at row 3, column 3 of the matrix.
        /// </summary>
        [DataMember] public float M33;
        /// <summary>
        /// Value at row 3, column 4 of the matrix.
        /// </summary>
        [DataMember] public float M34;

        /// <summary>
        /// Value at row 4, column 1 of the matrix.
        /// </summary>
        [DataMember] public float M41;
        /// <summary>
        /// Value at row 4, column 2 of the matrix.
        /// </summary>
        [DataMember] public float M42;
        /// <summary>
        /// Value at row 4, column 3 of the matrix.
        /// </summary>
        [DataMember] public float M43;
        /// <summary>
        /// Value at row 4, column 4 of the matrix.
        /// </summary>
        [DataMember] public float M44;

        /// <summary>
        /// Returns the multiplicative identity matrix.
        /// </summary>
        public static Matrix4x4 Identity = new Matrix4x4
        (
            1f, 0f, 0f, 0f,
            0f, 1f, 0f, 0f,
            0f, 0f, 1f, 0f,
            0f, 0f, 0f, 1f
        );

        /// <summary>
        /// Returns whether the matrix is the identity matrix.
        /// </summary>
        public bool IsIdentity =>
            M11 == 1f && M22 == 1f && M33 == 1f && M44 == 1f && // Check diagonal element first for early out.
            M12 == 0f && M13 == 0f && M14 == 0f &&
            M21 == 0f && M23 == 0f && M24 == 0f &&
            M31 == 0f && M32 == 0f && M34 == 0f &&
            M41 == 0f && M42 == 0f && M43 == 0f;

        /// <summary>
        /// Gets the translation component of this matrix.
        /// </summary>
        public Vector3 Translation
            => new Vector3(M41, M42, M43);

        /// <summary>
        /// Sets the translation component of this matrix, returning a new Matrix
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Matrix4x4 SetTranslation(Vector3 v)
            => CreateFromRows(Row0, Row1, Row2, v);

        /// <summary>
        /// Constructs a Matrix4x4 from the given components.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Matrix4x4(float m11, float m12, float m13, float m14,
                         float m21, float m22, float m23, float m24,
                         float m31, float m32, float m33, float m34,
                         float m41, float m42, float m43, float m44)
        {
            M11 = m11;
            M12 = m12;
            M13 = m13;
            M14 = m14;

            M21 = m21;
            M22 = m22;
            M23 = m23;
            M24 = m24;

            M31 = m31;
            M32 = m32;
            M33 = m33;
            M34 = m34;

            M41 = m41;
            M42 = m42;
            M43 = m43;
            M44 = m44;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateFromRows(Vector3 row0, Vector3 row1, Vector3 row2)
            => CreateFromRows(row0.ToVector4(), row1.ToVector4(), row2.ToVector4(), new Vector4(0, 0, 0, 1));

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateFromRows(Vector3 row0, Vector3 row1, Vector3 row2, Vector3 row3)
            => CreateFromRows(row0.ToVector4(), row1.ToVector4(), row2.ToVector4(), new Vector4(row3.X, row3.Y, row3.Z, 1));

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateFromRows(Vector4 row0, Vector4 row1, Vector4 row2)
            => CreateFromRows(row0.ToVector3(), row1.ToVector3(), row2.ToVector3(), Vector3.Zero);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateFromRows(Vector4 row0, Vector4 row1, Vector4 row2, Vector4 row3)
            => new Matrix4x4(row0.X, row0.Y, row0.Z, row0.W,
                row1.X, row1.Y, row1.Z, row1.W,
                row2.X, row2.Y, row2.Z, row2.W,
                row3.X, row3.Y, row3.Z, row3.W);

        /// <summary>
        /// Creates a spherical billboard that rotates around a specified object position.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateBillboard(Vector3 objectPosition, Vector3 cameraPosition, Vector3 cameraUpVector, Vector3 cameraForwardVector)
        {
            const float epsilon = 1e-4f;

            var zaxis = new Vector3(
                objectPosition.X - cameraPosition.X,
                objectPosition.Y - cameraPosition.Y,
                objectPosition.Z - cameraPosition.Z);

            var norm = zaxis.LengthSquared();

            if (norm < epsilon)
            {
                zaxis = -cameraForwardVector;
            }
            else
            {
                zaxis = zaxis * (1.0f / norm.Sqrt());
            }

            var xaxis = cameraUpVector.Cross(zaxis).Normalize();
            var yaxis = zaxis.Cross(xaxis);

            Matrix4x4 result;

            result.M11 = xaxis.X;
            result.M12 = xaxis.Y;
            result.M13 = xaxis.Z;
            result.M14 = 0.0f;
            result.M21 = yaxis.X;
            result.M22 = yaxis.Y;
            result.M23 = yaxis.Z;
            result.M24 = 0.0f;
            result.M31 = zaxis.X;
            result.M32 = zaxis.Y;
            result.M33 = zaxis.Z;
            result.M34 = 0.0f;

            result.M41 = objectPosition.X;
            result.M42 = objectPosition.Y;
            result.M43 = objectPosition.Z;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a cylindrical billboard that rotates around a specified axis.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateConstrainedBillboard(Vector3 objectPosition, Vector3 cameraPosition, Vector3 rotateAxis, Vector3 cameraForwardVector, Vector3 objectForwardVector)
        {
            const float epsilon = 1e-4f;
            const float minAngle = 1.0f - (0.1f * (Constants.Pi / 180.0f)); // 0.1 degrees

            // Treat the case when object and camera positions are too close.
            var faceDir = new Vector3(
                objectPosition.X - cameraPosition.X,
                objectPosition.Y - cameraPosition.Y,
                objectPosition.Z - cameraPosition.Z);

            var norm = faceDir.LengthSquared();

            if (norm < epsilon)
            {
                faceDir = -cameraForwardVector;
            }
            else
            {
                faceDir = faceDir * 1.0f / norm.Sqrt();
            }

            var yaxis = rotateAxis;
            Vector3 xaxis;
            Vector3 zaxis;

            // Treat the case when angle between faceDir and rotateAxis is too close to 0.
            var dot = Vector3.Dot(rotateAxis, faceDir);

            if (dot.Abs() > minAngle)
            {
                zaxis = objectForwardVector;

                // Make sure passed values are useful for compute.
                dot = Vector3.Dot(rotateAxis, zaxis);

                if (dot.Abs() > minAngle)
                {
                    zaxis = (rotateAxis.Z.Abs() > minAngle) ? new Vector3(1, 0, 0) : new Vector3(0, 0, -1);
                }

                xaxis = rotateAxis.Cross(zaxis).Normalize();
                zaxis = xaxis.Cross(rotateAxis).Normalize();
            }
            else
            {
                xaxis = rotateAxis.Cross(faceDir).Normalize();
                zaxis = xaxis.Cross(yaxis).Normalize();
            }

            Matrix4x4 result;

            result.M11 = xaxis.X;
            result.M12 = xaxis.Y;
            result.M13 = xaxis.Z;
            result.M14 = 0.0f;
            result.M21 = yaxis.X;
            result.M22 = yaxis.Y;
            result.M23 = yaxis.Z;
            result.M24 = 0.0f;
            result.M31 = zaxis.X;
            result.M32 = zaxis.Y;
            result.M33 = zaxis.Z;
            result.M34 = 0.0f;

            result.M41 = objectPosition.X;
            result.M42 = objectPosition.Y;
            result.M43 = objectPosition.Z;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a translation matrix.
        /// </summary>
        /// <param name="position">The amount to translate in each axis.</param>
        /// <returns>The translation matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateTranslation(Vector3 position)
        {
            Matrix4x4 result;

            result.M11 = 1.0f;
            result.M12 = 0.0f;
            result.M13 = 0.0f;
            result.M14 = 0.0f;
            result.M21 = 0.0f;
            result.M22 = 1.0f;
            result.M23 = 0.0f;
            result.M24 = 0.0f;
            result.M31 = 0.0f;
            result.M32 = 0.0f;
            result.M33 = 1.0f;
            result.M34 = 0.0f;

            result.M41 = position.X;
            result.M42 = position.Y;
            result.M43 = position.Z;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a translation matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateTranslation(float x, float y, float z)
            => CreateTranslation(new Vector3(x, y, z));

        /// <summary>
        /// Creates a scaling matrix.
        /// </summary>
        /// <param name="xScale">Value to scale by on the X-axis.</param>
        /// <param name="yScale">Value to scale by on the Y-axis.</param>
        /// <param name="zScale">Value to scale by on the Z-axis.</param>
        /// <returns>The scaling matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateScale(float xScale, float yScale, float zScale)
        {
            Matrix4x4 result;

            result.M11 = xScale;
            result.M12 = 0.0f;
            result.M13 = 0.0f;
            result.M14 = 0.0f;
            result.M21 = 0.0f;
            result.M22 = yScale;
            result.M23 = 0.0f;
            result.M24 = 0.0f;
            result.M31 = 0.0f;
            result.M32 = 0.0f;
            result.M33 = zScale;
            result.M34 = 0.0f;
            result.M41 = 0.0f;
            result.M42 = 0.0f;
            result.M43 = 0.0f;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a scaling matrix with a center point.
        /// </summary>
        /// <param name="xScale">Value to scale by on the X-axis.</param>
        /// <param name="yScale">Value to scale by on the Y-axis.</param>
        /// <param name="zScale">Value to scale by on the Z-axis.</param>
        /// <param name="centerPoint">The center point.</param>
        /// <returns>The scaling matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateScale(float xScale, float yScale, float zScale, Vector3 centerPoint)
        {
            Matrix4x4 result;

            var tx = centerPoint.X * (1 - xScale);
            var ty = centerPoint.Y * (1 - yScale);
            var tz = centerPoint.Z * (1 - zScale);

            result.M11 = xScale;
            result.M12 = 0.0f;
            result.M13 = 0.0f;
            result.M14 = 0.0f;
            result.M21 = 0.0f;
            result.M22 = yScale;
            result.M23 = 0.0f;
            result.M24 = 0.0f;
            result.M31 = 0.0f;
            result.M32 = 0.0f;
            result.M33 = zScale;
            result.M34 = 0.0f;
            result.M41 = tx;
            result.M42 = ty;
            result.M43 = tz;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a scaling matrix.
        /// </summary>
        /// <param name="scales">The vector containing the amount to scale by on each axis.</param>
        /// <returns>The scaling matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateScale(Vector3 scales)
            => CreateScale(scales.X, scales.Y, scales.Z);

        /// <summary>
        /// Creates a scaling matrix with a center point.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateScale(Vector3 scales, Vector3 centerPoint)
            => CreateScale(scales.X, scales.Y, scales.Z, centerPoint);

        /// <summary>
        /// Creates a uniform scaling matrix that scales equally on each axis.
        /// </summary>
        /// <param name="scale">The uniform scaling factor.</param>
        /// <returns>The scaling matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateScale(float scale)
            => CreateScale(scale, scale, scale);

        /// <summary>
        /// Creates a uniform scaling matrix that scales equally on each axis with a center point.
        /// </summary>
        /// <param name="scale">The uniform scaling factor.</param>
        /// <param name="centerPoint">The center point.</param>
        /// <returns>The scaling matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateScale(float scale, Vector3 centerPoint)
            => CreateScale(scale, scale, scale, centerPoint);

        /// <summary>
        /// Creates a matrix for rotating points around the X-axis.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateRotationX(float radians)
        {
            Matrix4x4 result;

            var c = radians.Cos();
            var s = radians.Sin();

            // [  1  0  0  0 ]
            // [  0  c  s  0 ]
            // [  0 -s  c  0 ]
            // [  0  0  0  1 ]
            result.M11 = 1.0f;
            result.M12 = 0.0f;
            result.M13 = 0.0f;
            result.M14 = 0.0f;
            result.M21 = 0.0f;
            result.M22 = c;
            result.M23 = s;
            result.M24 = 0.0f;
            result.M31 = 0.0f;
            result.M32 = -s;
            result.M33 = c;
            result.M34 = 0.0f;
            result.M41 = 0.0f;
            result.M42 = 0.0f;
            result.M43 = 0.0f;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a matrix for rotating points around the X-axis, from a center point.
        /// </summary>
        /// <param name="radians">The amount, in radians, by which to rotate around the X-axis.</param>
        /// <param name="centerPoint">The center point.</param>
        /// <returns>The rotation matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateRotationX(float radians, Vector3 centerPoint)
        {
            Matrix4x4 result;

            var c = radians.Cos();
            var s = radians.Sin();

            var y = centerPoint.Y * (1 - c) + centerPoint.Z * s;
            var z = centerPoint.Z * (1 - c) - centerPoint.Y * s;

            // [  1  0  0  0 ]
            // [  0  c  s  0 ]
            // [  0 -s  c  0 ]
            // [  0  y  z  1 ]
            result.M11 = 1.0f;
            result.M12 = 0.0f;
            result.M13 = 0.0f;
            result.M14 = 0.0f;
            result.M21 = 0.0f;
            result.M22 = c;
            result.M23 = s;
            result.M24 = 0.0f;
            result.M31 = 0.0f;
            result.M32 = -s;
            result.M33 = c;
            result.M34 = 0.0f;
            result.M41 = 0.0f;
            result.M42 = y;
            result.M43 = z;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a matrix for rotating points around the Y-axis.
        /// </summary>
        /// <param name="radians">The amount, in radians, by which to rotate around the Y-axis.</param>
        /// <returns>The rotation matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateRotationY(float radians)
        {
            Matrix4x4 result;

            var c = radians.Cos();
            var s = radians.Sin();

            // [  c  0 -s  0 ]
            // [  0  1  0  0 ]
            // [  s  0  c  0 ]
            // [  0  0  0  1 ]
            result.M11 = c;
            result.M12 = 0.0f;
            result.M13 = -s;
            result.M14 = 0.0f;
            result.M21 = 0.0f;
            result.M22 = 1.0f;
            result.M23 = 0.0f;
            result.M24 = 0.0f;
            result.M31 = s;
            result.M32 = 0.0f;
            result.M33 = c;
            result.M34 = 0.0f;
            result.M41 = 0.0f;
            result.M42 = 0.0f;
            result.M43 = 0.0f;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a matrix for rotating points around the Y-axis, from a center point.
        /// </summary>
        /// <param name="radians">The amount, in radians, by which to rotate around the Y-axis.</param>
        /// <param name="centerPoint">The center point.</param>
        /// <returns>The rotation matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateRotationY(float radians, Vector3 centerPoint)
        {
            Matrix4x4 result;

            var c = radians.Cos();
            var s = radians.Sin();

            var x = centerPoint.X * (1 - c) - centerPoint.Z * s;
            var z = centerPoint.Z * (1 - c) + centerPoint.X * s;

            // [  c  0 -s  0 ]
            // [  0  1  0  0 ]
            // [  s  0  c  0 ]
            // [  x  0  z  1 ]
            result.M11 = c;
            result.M12 = 0.0f;
            result.M13 = -s;
            result.M14 = 0.0f;
            result.M21 = 0.0f;
            result.M22 = 1.0f;
            result.M23 = 0.0f;
            result.M24 = 0.0f;
            result.M31 = s;
            result.M32 = 0.0f;
            result.M33 = c;
            result.M34 = 0.0f;
            result.M41 = x;
            result.M42 = 0.0f;
            result.M43 = z;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a matrix for rotating points around the Z-axis.
        /// </summary>
        /// <param name="radians">The amount, in radians, by which to rotate around the Z-axis.</param>
        /// <returns>The rotation matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateRotationZ(float radians)
        {
            Matrix4x4 result;

            var c = radians.Cos();
            var s = radians.Sin();

            // [  c  s  0  0 ]
            // [ -s  c  0  0 ]
            // [  0  0  1  0 ]
            // [  0  0  0  1 ]
            result.M11 = c;
            result.M12 = s;
            result.M13 = 0.0f;
            result.M14 = 0.0f;
            result.M21 = -s;
            result.M22 = c;
            result.M23 = 0.0f;
            result.M24 = 0.0f;
            result.M31 = 0.0f;
            result.M32 = 0.0f;
            result.M33 = 1.0f;
            result.M34 = 0.0f;
            result.M41 = 0.0f;
            result.M42 = 0.0f;
            result.M43 = 0.0f;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a matrix for rotating points around the Z-axis, from a center point.
        /// </summary>
        /// <param name="radians">The amount, in radians, by which to rotate around the Z-axis.</param>
        /// <param name="centerPoint">The center point.</param>
        /// <returns>The rotation matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateRotationZ(float radians, Vector3 centerPoint)
        {
            Matrix4x4 result;

            var c = radians.Cos();
            var s = radians.Sin();

            var x = centerPoint.X * (1 - c) + centerPoint.Y * s;
            var y = centerPoint.Y * (1 - c) - centerPoint.X * s;

            // [  c  s  0  0 ]
            // [ -s  c  0  0 ]
            // [  0  0  1  0 ]
            // [  x  y  0  1 ]
            result.M11 = c;
            result.M12 = s;
            result.M13 = 0.0f;
            result.M14 = 0.0f;
            result.M21 = -s;
            result.M22 = c;
            result.M23 = 0.0f;
            result.M24 = 0.0f;
            result.M31 = 0.0f;
            result.M32 = 0.0f;
            result.M33 = 1.0f;
            result.M34 = 0.0f;
            result.M41 = x;
            result.M42 = y;
            result.M43 = 0.0f;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a matrix that rotates around an arbitrary vector.
        /// </summary>
        /// <param name="axis">The axis to rotate around.</param>
        /// <param name="angle">The angle to rotate around the given axis, in radians.</param>
        /// <returns>The rotation matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateFromAxisAngle(Vector3 axis, float angle)
        {
            // a: angle
            // x, y, z: unit vector for axis.
            //
            // Rotation matrix M can compute by using below equation.
            //
            //        T               T
            //  M = uu + (cos a)( I-uu ) + (sin a)S
            //
            // Where:
            //
            //  u = ( x, y, z )
            //
            //      [  0 -z  y ]
            //  S = [  z  0 -x ]
            //      [ -y  x  0 ]
            //
            //      [ 1 0 0 ]
            //  I = [ 0 1 0 ]
            //      [ 0 0 1 ]
            //
            //
            //     [  xx+cosa*(1-xx)   yx-cosa*yx-sina*z zx-cosa*xz+sina*y ]
            // M = [ xy-cosa*yx+sina*z    yy+cosa(1-yy)  yz-cosa*yz-sina*x ]
            //     [ zx-cosa*zx-sina*y zy-cosa*zy+sina*x   zz+cosa*(1-zz)  ]
            //
            float x = axis.X, y = axis.Y, z = axis.Z;
            float sa = angle.Sin(), ca = angle.Cos();
            float xx = x * x, yy = y * y, zz = z * z;
            float xy = x * y, xz = x * z, yz = y * z;

            Matrix4x4 result;

            result.M11 = xx + ca * (1.0f - xx);
            result.M12 = xy - ca * xy + sa * z;
            result.M13 = xz - ca * xz - sa * y;
            result.M14 = 0.0f;
            result.M21 = xy - ca * xy - sa * z;
            result.M22 = yy + ca * (1.0f - yy);
            result.M23 = yz - ca * yz + sa * x;
            result.M24 = 0.0f;
            result.M31 = xz - ca * xz + sa * y;
            result.M32 = yz - ca * yz - sa * x;
            result.M33 = zz + ca * (1.0f - zz);
            result.M34 = 0.0f;
            result.M41 = 0.0f;
            result.M42 = 0.0f;
            result.M43 = 0.0f;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a perspective projection matrix based on a field of view, aspect ratio, and near and far view plane distances. 
        /// </summary>
        /// <param name="fieldOfView">Field of view in the y direction, in radians.</param>
        /// <param name="aspectRatio">Aspect ratio, defined as view space width divided by height.</param>
        /// <param name="nearPlaneDistance">Distance to the near view plane.</param>
        /// <param name="farPlaneDistance">Distance to the far view plane.</param>
        /// <returns>The perspective projection matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreatePerspectiveFieldOfView(float fieldOfView, float aspectRatio, float nearPlaneDistance, float farPlaneDistance)
        {
            if (fieldOfView <= 0.0f || fieldOfView >= Constants.Pi)
                throw new ArgumentOutOfRangeException(nameof(fieldOfView));

            if (nearPlaneDistance <= 0.0f)
                throw new ArgumentOutOfRangeException(nameof(nearPlaneDistance));

            if (farPlaneDistance <= 0.0f)
                throw new ArgumentOutOfRangeException(nameof(farPlaneDistance));

            if (nearPlaneDistance >= farPlaneDistance)
                throw new ArgumentOutOfRangeException(nameof(nearPlaneDistance));

            var yScale = 1.0f / (fieldOfView * 0.5f).Tan();
            var xScale = yScale / aspectRatio;

            Matrix4x4 result;

            result.M11 = xScale;
            result.M12 = result.M13 = result.M14 = 0.0f;

            result.M22 = yScale;
            result.M21 = result.M23 = result.M24 = 0.0f;

            result.M31 = result.M32 = 0.0f;
            var negFarRange = float.IsPositiveInfinity(farPlaneDistance) ? -1.0f : farPlaneDistance / (nearPlaneDistance - farPlaneDistance);
            result.M33 = negFarRange;
            result.M34 = -1.0f;

            result.M41 = result.M42 = result.M44 = 0.0f;
            result.M43 = nearPlaneDistance * negFarRange;

            return result;
        }

        /// <summary>
        /// Creates a perspective projection matrix from the given view volume dimensions.
        /// </summary>
        /// <param name="width">Width of the view volume at the near view plane.</param>
        /// <param name="height">Height of the view volume at the near view plane.</param>
        /// <param name="nearPlaneDistance">Distance to the near view plane.</param>
        /// <param name="farPlaneDistance">Distance to the far view plane.</param>
        /// <returns>The perspective projection matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreatePerspective(float width, float height, float nearPlaneDistance, float farPlaneDistance)
        {
            if (nearPlaneDistance <= 0.0f)
                throw new ArgumentOutOfRangeException(nameof(nearPlaneDistance));

            if (farPlaneDistance <= 0.0f)
                throw new ArgumentOutOfRangeException(nameof(farPlaneDistance));

            if (nearPlaneDistance >= farPlaneDistance)
                throw new ArgumentOutOfRangeException(nameof(nearPlaneDistance));

            Matrix4x4 result;

            result.M11 = 2.0f * nearPlaneDistance / width;
            result.M12 = result.M13 = result.M14 = 0.0f;

            result.M22 = 2.0f * nearPlaneDistance / height;
            result.M21 = result.M23 = result.M24 = 0.0f;

            var negFarRange = float.IsPositiveInfinity(farPlaneDistance) ? -1.0f : farPlaneDistance / (nearPlaneDistance - farPlaneDistance);
            result.M33 = negFarRange;
            result.M31 = result.M32 = 0.0f;
            result.M34 = -1.0f;

            result.M41 = result.M42 = result.M44 = 0.0f;
            result.M43 = nearPlaneDistance * negFarRange;

            return result;
        }

        /// <summary>
        /// Creates a customized, perspective projection matrix.
        /// </summary>
        /// <param name="left">Minimum x-value of the view volume at the near view plane.</param>
        /// <param name="right">Maximum x-value of the view volume at the near view plane.</param>
        /// <param name="bottom">Minimum y-value of the view volume at the near view plane.</param>
        /// <param name="top">Maximum y-value of the view volume at the near view plane.</param>
        /// <param name="nearPlaneDistance">Distance to the near view plane.</param>
        /// <param name="farPlaneDistance">Distance to of the far view plane.</param>
        /// <returns>The perspective projection matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreatePerspectiveOffCenter(float left, float right, float bottom, float top, float nearPlaneDistance, float farPlaneDistance)
        {
            if (nearPlaneDistance <= 0.0f)
                throw new ArgumentOutOfRangeException(nameof(nearPlaneDistance));

            if (farPlaneDistance <= 0.0f)
                throw new ArgumentOutOfRangeException(nameof(farPlaneDistance));

            if (nearPlaneDistance >= farPlaneDistance)
                throw new ArgumentOutOfRangeException(nameof(nearPlaneDistance));

            Matrix4x4 result;

            result.M11 = 2.0f * nearPlaneDistance / (right - left);
            result.M12 = result.M13 = result.M14 = 0.0f;

            result.M22 = 2.0f * nearPlaneDistance / (top - bottom);
            result.M21 = result.M23 = result.M24 = 0.0f;

            result.M31 = (left + right) / (right - left);
            result.M32 = (top + bottom) / (top - bottom);
            var negFarRange = float.IsPositiveInfinity(farPlaneDistance) ? -1.0f : farPlaneDistance / (nearPlaneDistance - farPlaneDistance);
            result.M33 = negFarRange;
            result.M34 = -1.0f;

            result.M43 = nearPlaneDistance * negFarRange;
            result.M41 = result.M42 = result.M44 = 0.0f;

            return result;
        }

        /// <summary>
        /// Creates an orthographic perspective matrix from the given view volume dimensions.
        /// </summary>
        /// <param name="width">Width of the view volume.</param>
        /// <param name="height">Height of the view volume.</param>
        /// <param name="zNearPlane">Minimum Z-value of the view volume.</param>
        /// <param name="zFarPlane">Maximum Z-value of the view volume.</param>
        /// <returns>The orthographic projection matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateOrthographic(float width, float height, float zNearPlane, float zFarPlane)
        {
            Matrix4x4 result;

            result.M11 = 2.0f / width;
            result.M12 = result.M13 = result.M14 = 0.0f;

            result.M22 = 2.0f / height;
            result.M21 = result.M23 = result.M24 = 0.0f;

            result.M33 = 1.0f / (zNearPlane - zFarPlane);
            result.M31 = result.M32 = result.M34 = 0.0f;

            result.M41 = result.M42 = 0.0f;
            result.M43 = zNearPlane / (zNearPlane - zFarPlane);
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Builds a customized, orthographic projection matrix.
        /// </summary>
        /// <param name="left">Minimum X-value of the view volume.</param>
        /// <param name="right">Maximum X-value of the view volume.</param>
        /// <param name="bottom">Minimum Y-value of the view volume.</param>
        /// <param name="top">Maximum Y-value of the view volume.</param>
        /// <param name="zNearPlane">Minimum Z-value of the view volume.</param>
        /// <param name="zFarPlane">Maximum Z-value of the view volume.</param>
        /// <returns>The orthographic projection matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateOrthographicOffCenter(float left, float right, float bottom, float top, float zNearPlane, float zFarPlane)
        {
            Matrix4x4 result;

            result.M11 = 2.0f / (right - left);
            result.M12 = result.M13 = result.M14 = 0.0f;

            result.M22 = 2.0f / (top - bottom);
            result.M21 = result.M23 = result.M24 = 0.0f;

            result.M33 = 1.0f / (zNearPlane - zFarPlane);
            result.M31 = result.M32 = result.M34 = 0.0f;

            result.M41 = (left + right) / (left - right);
            result.M42 = (top + bottom) / (bottom - top);
            result.M43 = zNearPlane / (zNearPlane - zFarPlane);
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a view matrix.
        /// </summary>
        /// <param name="cameraPosition">The position of the camera.</param>
        /// <param name="cameraTarget">The target towards which the camera is pointing.</param>
        /// <param name="cameraUpVector">The direction that is "up" from the camera's point of view.</param>
        /// <returns>The view matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateLookAt(Vector3 cameraPosition, Vector3 cameraTarget, Vector3 cameraUpVector)
        {
            var zaxis = (cameraPosition - cameraTarget).Normalize();
            var xaxis = cameraUpVector.Cross(zaxis).Normalize();
            var yaxis = zaxis.Cross(xaxis);

            Matrix4x4 result;

            result.M11 = xaxis.X;
            result.M12 = yaxis.X;
            result.M13 = zaxis.X;
            result.M14 = 0.0f;
            result.M21 = xaxis.Y;
            result.M22 = yaxis.Y;
            result.M23 = zaxis.Y;
            result.M24 = 0.0f;
            result.M31 = xaxis.Z;
            result.M32 = yaxis.Z;
            result.M33 = zaxis.Z;
            result.M34 = 0.0f;
            result.M41 = -Vector3.Dot(xaxis, cameraPosition);
            result.M42 = -Vector3.Dot(yaxis, cameraPosition);
            result.M43 = -Vector3.Dot(zaxis, cameraPosition);
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a world matrix with the specified parameters.
        /// </summary>
        /// <param name="position">The position of the object; used in translation operations.</param>
        /// <param name="forward">Forward direction of the object.</param>
        /// <param name="up">Upward direction of the object; usually [0, 1, 0].</param>
        /// <returns>The world matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateWorld(Vector3 position, Vector3 forward, Vector3 up)
        {
            var zaxis = (-forward).Normalize();
            var xaxis = up.Cross(zaxis).Normalize();
            var yaxis = zaxis.Cross(xaxis);

            Matrix4x4 result;

            result.M11 = xaxis.X;
            result.M12 = xaxis.Y;
            result.M13 = xaxis.Z;
            result.M14 = 0.0f;
            result.M21 = yaxis.X;
            result.M22 = yaxis.Y;
            result.M23 = yaxis.Z;
            result.M24 = 0.0f;
            result.M31 = zaxis.X;
            result.M32 = zaxis.Y;
            result.M33 = zaxis.Z;
            result.M34 = 0.0f;
            result.M41 = position.X;
            result.M42 = position.Y;
            result.M43 = position.Z;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a rotation matrix from the given Quaternion rotation value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateFromQuaternion(Quaternion quaternion)
            => CreateRotation(quaternion);

        /// <summary>
        /// Creates a rotation matrix from the given Quaternion rotation value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateRotation(Quaternion quaternion)
        {
            Matrix4x4 result;

            var xx = quaternion.X * quaternion.X;
            var yy = quaternion.Y * quaternion.Y;
            var zz = quaternion.Z * quaternion.Z;

            var xy = quaternion.X * quaternion.Y;
            var wz = quaternion.Z * quaternion.W;
            var xz = quaternion.Z * quaternion.X;
            var wy = quaternion.Y * quaternion.W;
            var yz = quaternion.Y * quaternion.Z;
            var wx = quaternion.X * quaternion.W;

            result.M11 = 1.0f - 2.0f * (yy + zz);
            result.M12 = 2.0f * (xy + wz);
            result.M13 = 2.0f * (xz - wy);
            result.M14 = 0.0f;
            result.M21 = 2.0f * (xy - wz);
            result.M22 = 1.0f - 2.0f * (zz + xx);
            result.M23 = 2.0f * (yz + wx);
            result.M24 = 0.0f;
            result.M31 = 2.0f * (xz + wy);
            result.M32 = 2.0f * (yz - wx);
            result.M33 = 1.0f - 2.0f * (yy + xx);
            result.M34 = 0.0f;
            result.M41 = 0.0f;
            result.M42 = 0.0f;
            result.M43 = 0.0f;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Creates a rotation matrix from the specified yaw, pitch, and roll.
        /// </summary>
        /// <param name="yaw">Angle of rotation, in radians, around the Y-axis.</param>
        /// <param name="pitch">Angle of rotation, in radians, around the X-axis.</param>
        /// <param name="roll">Angle of rotation, in radians, around the Z-axis.</param>
        /// <returns>The rotation matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateFromYawPitchRoll(float yaw, float pitch, float roll)
            => CreateRotation(Quaternion.CreateFromYawPitchRoll(yaw, pitch, roll));

        /// <summary>
        /// Creates a Matrix that flattens geometry into a specified Plane as if casting a shadow from a specified light source.
        /// </summary>
        /// <param name="lightDirection">The direction from which the light that will cast the shadow is coming.</param>
        /// <param name="plane">The Plane onto which the new matrix should flatten geometry so as to cast a shadow.</param>
        /// <returns>A new Matrix that can be used to flatten geometry onto the specified plane from the specified direction.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateShadow(Vector3 lightDirection, Plane plane)
        {
            var p = Plane.Normalize(plane);

            var dot = p.Normal.X * lightDirection.X + p.Normal.Y * lightDirection.Y + p.Normal.Z * lightDirection.Z;
            var a = -p.Normal.X;
            var b = -p.Normal.Y;
            var c = -p.Normal.Z;
            var d = -p.D;

            Matrix4x4 result;

            result.M11 = a * lightDirection.X + dot;
            result.M21 = b * lightDirection.X;
            result.M31 = c * lightDirection.X;
            result.M41 = d * lightDirection.X;

            result.M12 = a * lightDirection.Y;
            result.M22 = b * lightDirection.Y + dot;
            result.M32 = c * lightDirection.Y;
            result.M42 = d * lightDirection.Y;

            result.M13 = a * lightDirection.Z;
            result.M23 = b * lightDirection.Z;
            result.M33 = c * lightDirection.Z + dot;
            result.M43 = d * lightDirection.Z;

            result.M14 = 0.0f;
            result.M24 = 0.0f;
            result.M34 = 0.0f;
            result.M44 = dot;

            return result;
        }

        /// <summary>
        /// Creates a Matrix that reflects the coordinate system about a specified Plane.
        /// </summary>
        /// <param name="value">The Plane about which to create a reflection.</param>
        /// <returns>A new matrix expressing the reflection.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateReflection(Plane value)
        {
            value = Plane.Normalize(value);

            var a = value.Normal.X;
            var b = value.Normal.Y;
            var c = value.Normal.Z;

            var fa = -2.0f * a;
            var fb = -2.0f * b;
            var fc = -2.0f * c;

            Matrix4x4 result;

            result.M11 = fa * a + 1.0f;
            result.M12 = fb * a;
            result.M13 = fc * a;
            result.M14 = 0.0f;

            result.M21 = fa * b;
            result.M22 = fb * b + 1.0f;
            result.M23 = fc * b;
            result.M24 = 0.0f;

            result.M31 = fa * c;
            result.M32 = fb * c;
            result.M33 = fc * c + 1.0f;
            result.M34 = 0.0f;

            result.M41 = fa * value.D;
            result.M42 = fb * value.D;
            result.M43 = fc * value.D;
            result.M44 = 1.0f;

            return result;
        }

        /// <summary>
        /// Calculates the determinant of the 3x3 rotational component of the matrix.
        /// </summary>
        /// <returns>The determinant of the 3x3 rotational component matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float Get3x3RotationDeterminant()
        {
            // | a b c |
            // | d e f | = a | e f | - b | d f | + c | d e |
            // | g h i |     | h i |     | g i |     | g h |
            //
            // a | e f | = a ( ei - fh )
            //   | h i | 
            //
            // b | d f | = b ( di - gf )
            //   | g i |
            //
            // c | d e | = c ( dh - eg )
            //   | g h |

            float a = M11, b = M12, c = M13;
            float d = M21, e = M22, f = M23;
            float g = M31, h = M32, i = M33;

            var ei_fh = e * i - f * h;
            var di_gf = d * i - g * f;
            var dh_eg = d * h - e * g;

            return a * ei_fh -
                   b * di_gf +
                   c * dh_eg;
        }

        /// <summary>
        /// Returns true if the 3x3 rotation determinant of the matrix is less than 0. This assumes the matrix represents
        /// an affine transform.
        /// </summary>
        // From: https://math.stackexchange.com/a/1064759
        // "If your matrix is the augmented matrix representing an affine transformation in 3D, then yes,
        // the proper thing to do to see if it switches orientation is checking the sign of the top 3×3 determinant.
        // This is easy to see: if your transformation is Ax+b, then the +b part is a translation and does not
        // affect orientation, and x->Ax switches orientation iff detA < 0."
        public bool IsReflection
            => Get3x3RotationDeterminant() < 0;

        /// <summary>
        /// Calculates the determinant of the matrix.
        /// </summary>
        /// <returns>The determinant of the matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float GetDeterminant()
        {
            // | a b c d |     | f g h |     | e g h |     | e f h |     | e f g |
            // | e f g h | = a | j k l | - b | i k l | + c | i j l | - d | i j k |
            // | i j k l |     | n o p |     | m o p |     | m n p |     | m n o |
            // | m n o p |
            //
            //   | f g h |
            // a | j k l | = a ( f ( kp - lo ) - g ( jp - ln ) + h ( jo - kn ) )
            //   | n o p |
            //
            //   | e g h |     
            // b | i k l | = b ( e ( kp - lo ) - g ( ip - lm ) + h ( io - km ) )
            //   | m o p |     
            //
            //   | e f h |
            // c | i j l | = c ( e ( jp - ln ) - f ( ip - lm ) + h ( in - jm ) )
            //   | m n p |
            //
            //   | e f g |
            // d | i j k | = d ( e ( jo - kn ) - f ( io - km ) + g ( in - jm ) )
            //   | m n o |
            //
            // Cost of operation
            // 17 adds and 28 muls.
            //
            // add: 6 + 8 + 3 = 17
            // mul: 12 + 16 = 28

            float a = M11, b = M12, c = M13, d = M14;
            float e = M21, f = M22, g = M23, h = M24;
            float i = M31, j = M32, k = M33, l = M34;
            float m = M41, n = M42, o = M43, p = M44;

            var kp_lo = k * p - l * o;
            var jp_ln = j * p - l * n;
            var jo_kn = j * o - k * n;
            var ip_lm = i * p - l * m;
            var io_km = i * o - k * m;
            var in_jm = i * n - j * m;

            return a * (f * kp_lo - g * jp_ln + h * jo_kn) -
                   b * (e * kp_lo - g * ip_lm + h * io_km) +
                   c * (e * jp_ln - f * ip_lm + h * in_jm) -
                   d * (e * jo_kn - f * io_km + g * in_jm);
        }

        /// <summary>
        /// Attempts to calculate the inverse of the given matrix. If successful, result will contain the inverted matrix.
        /// </summary>
        /// <param name="matrix">The source matrix to invert.</param>
        /// <param name="result">If successful, contains the inverted matrix.</param>
        /// <returns>True if the source matrix could be inverted; False otherwise.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool Invert(Matrix4x4 matrix, out Matrix4x4 result)
        {
            //                                       -1
            // If you have matrix M, inverse Matrix M   can compute
            //
            //     -1       1      
            //    M   = --------- A
            //            det(M)
            //
            // A is adjugate (adjoint) of M, where,
            //
            //      T
            // A = C
            //
            // C is Cofactor matrix of M, where,
            //           i + j
            // C   = (-1)      * det(M  )
            //  ij                    ij
            //
            //     [ a b c d ]
            // M = [ e f g h ]
            //     [ i j k l ]
            //     [ m n o p ]
            //
            // First Row
            //           2 | f g h |
            // C   = (-1)  | j k l | = + ( f ( kp - lo ) - g ( jp - ln ) + h ( jo - kn ) )
            //  11         | n o p |
            //
            //           3 | e g h |
            // C   = (-1)  | i k l | = - ( e ( kp - lo ) - g ( ip - lm ) + h ( io - km ) )
            //  12         | m o p |
            //
            //           4 | e f h |
            // C   = (-1)  | i j l | = + ( e ( jp - ln ) - f ( ip - lm ) + h ( in - jm ) )
            //  13         | m n p |
            //
            //           5 | e f g |
            // C   = (-1)  | i j k | = - ( e ( jo - kn ) - f ( io - km ) + g ( in - jm ) )
            //  14         | m n o |
            //
            // Second Row
            //           3 | b c d |
            // C   = (-1)  | j k l | = - ( b ( kp - lo ) - c ( jp - ln ) + d ( jo - kn ) )
            //  21         | n o p |
            //
            //           4 | a c d |
            // C   = (-1)  | i k l | = + ( a ( kp - lo ) - c ( ip - lm ) + d ( io - km ) )
            //  22         | m o p |
            //
            //           5 | a b d |
            // C   = (-1)  | i j l | = - ( a ( jp - ln ) - b ( ip - lm ) + d ( in - jm ) )
            //  23         | m n p |
            //
            //           6 | a b c |
            // C   = (-1)  | i j k | = + ( a ( jo - kn ) - b ( io - km ) + c ( in - jm ) )
            //  24         | m n o |
            //
            // Third Row
            //           4 | b c d |
            // C   = (-1)  | f g h | = + ( b ( gp - ho ) - c ( fp - hn ) + d ( fo - gn ) )
            //  31         | n o p |
            //
            //           5 | a c d |
            // C   = (-1)  | e g h | = - ( a ( gp - ho ) - c ( ep - hm ) + d ( eo - gm ) )
            //  32         | m o p |
            //
            //           6 | a b d |
            // C   = (-1)  | e f h | = + ( a ( fp - hn ) - b ( ep - hm ) + d ( en - fm ) )
            //  33         | m n p |
            //
            //           7 | a b c |
            // C   = (-1)  | e f g | = - ( a ( fo - gn ) - b ( eo - gm ) + c ( en - fm ) )
            //  34         | m n o |
            //
            // Fourth Row
            //           5 | b c d |
            // C   = (-1)  | f g h | = - ( b ( gl - hk ) - c ( fl - hj ) + d ( fk - gj ) )
            //  41         | j k l |
            //
            //           6 | a c d |
            // C   = (-1)  | e g h | = + ( a ( gl - hk ) - c ( el - hi ) + d ( ek - gi ) )
            //  42         | i k l |
            //
            //           7 | a b d |
            // C   = (-1)  | e f h | = - ( a ( fl - hj ) - b ( el - hi ) + d ( ej - fi ) )
            //  43         | i j l |
            //
            //           8 | a b c |
            // C   = (-1)  | e f g | = + ( a ( fk - gj ) - b ( ek - gi ) + c ( ej - fi ) )
            //  44         | i j k |
            //
            // Cost of operation
            // 53 adds, 104 muls, and 1 div.
            float a = matrix.M11, b = matrix.M12, c = matrix.M13, d = matrix.M14;
            float e = matrix.M21, f = matrix.M22, g = matrix.M23, h = matrix.M24;
            float i = matrix.M31, j = matrix.M32, k = matrix.M33, l = matrix.M34;
            float m = matrix.M41, n = matrix.M42, o = matrix.M43, p = matrix.M44;

            var kp_lo = k * p - l * o;
            var jp_ln = j * p - l * n;
            var jo_kn = j * o - k * n;
            var ip_lm = i * p - l * m;
            var io_km = i * o - k * m;
            var in_jm = i * n - j * m;

            var a11 = +(f * kp_lo - g * jp_ln + h * jo_kn);
            var a12 = -(e * kp_lo - g * ip_lm + h * io_km);
            var a13 = +(e * jp_ln - f * ip_lm + h * in_jm);
            var a14 = -(e * jo_kn - f * io_km + g * in_jm);

            var det = a * a11 + b * a12 + c * a13 + d * a14;

            if (det.Abs() < float.Epsilon)
            {
                result = new Matrix4x4(float.NaN, float.NaN, float.NaN, float.NaN,
                                       float.NaN, float.NaN, float.NaN, float.NaN,
                                       float.NaN, float.NaN, float.NaN, float.NaN,
                                       float.NaN, float.NaN, float.NaN, float.NaN);
                return false;
            }

            var invDet = 1.0f / det;

            result.M11 = a11 * invDet;
            result.M21 = a12 * invDet;
            result.M31 = a13 * invDet;
            result.M41 = a14 * invDet;

            result.M12 = -(b * kp_lo - c * jp_ln + d * jo_kn) * invDet;
            result.M22 = +(a * kp_lo - c * ip_lm + d * io_km) * invDet;
            result.M32 = -(a * jp_ln - b * ip_lm + d * in_jm) * invDet;
            result.M42 = +(a * jo_kn - b * io_km + c * in_jm) * invDet;

            var gp_ho = g * p - h * o;
            var fp_hn = f * p - h * n;
            var fo_gn = f * o - g * n;
            var ep_hm = e * p - h * m;
            var eo_gm = e * o - g * m;
            var en_fm = e * n - f * m;

            result.M13 = +(b * gp_ho - c * fp_hn + d * fo_gn) * invDet;
            result.M23 = -(a * gp_ho - c * ep_hm + d * eo_gm) * invDet;
            result.M33 = +(a * fp_hn - b * ep_hm + d * en_fm) * invDet;
            result.M43 = -(a * fo_gn - b * eo_gm + c * en_fm) * invDet;

            var gl_hk = g * l - h * k;
            var fl_hj = f * l - h * j;
            var fk_gj = f * k - g * j;
            var el_hi = e * l - h * i;
            var ek_gi = e * k - g * i;
            var ej_fi = e * j - f * i;

            result.M14 = -(b * gl_hk - c * fl_hj + d * fk_gj) * invDet;
            result.M24 = +(a * gl_hk - c * el_hi + d * ek_gi) * invDet;
            result.M34 = -(a * fl_hj - b * el_hi + d * ej_fi) * invDet;
            result.M44 = +(a * fk_gj - b * ek_gi + c * ej_fi) * invDet;

            return true;
        }

        /// <summary>
        /// Transforms the given matrix by applying the given Quaternion rotation.
        /// </summary>
        /// <param name="value">The source matrix to transform.</param>
        /// <param name="rotation">The rotation to apply.</param>
        /// <returns>The transformed matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 Transform(Matrix4x4 value, Quaternion rotation)
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

            var q11 = 1.0f - yy2 - zz2;
            var q21 = xy2 - wz2;
            var q31 = xz2 + wy2;

            var q12 = xy2 + wz2;
            var q22 = 1.0f - xx2 - zz2;
            var q32 = yz2 - wx2;

            var q13 = xz2 - wy2;
            var q23 = yz2 + wx2;
            var q33 = 1.0f - xx2 - yy2;

            Matrix4x4 result;

            // First row
            result.M11 = value.M11 * q11 + value.M12 * q21 + value.M13 * q31;
            result.M12 = value.M11 * q12 + value.M12 * q22 + value.M13 * q32;
            result.M13 = value.M11 * q13 + value.M12 * q23 + value.M13 * q33;
            result.M14 = value.M14;

            // Second row
            result.M21 = value.M21 * q11 + value.M22 * q21 + value.M23 * q31;
            result.M22 = value.M21 * q12 + value.M22 * q22 + value.M23 * q32;
            result.M23 = value.M21 * q13 + value.M22 * q23 + value.M23 * q33;
            result.M24 = value.M24;

            // Third row
            result.M31 = value.M31 * q11 + value.M32 * q21 + value.M33 * q31;
            result.M32 = value.M31 * q12 + value.M32 * q22 + value.M33 * q32;
            result.M33 = value.M31 * q13 + value.M32 * q23 + value.M33 * q33;
            result.M34 = value.M34;

            // Fourth row
            result.M41 = value.M41 * q11 + value.M42 * q21 + value.M43 * q31;
            result.M42 = value.M41 * q12 + value.M42 * q22 + value.M43 * q32;
            result.M43 = value.M41 * q13 + value.M42 * q23 + value.M43 * q33;
            result.M44 = value.M44;

            return result;
        }

        /// <summary>
        /// Transposes the rows and columns of a matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 Transpose(Matrix4x4 matrix)
        {
            Matrix4x4 result;
            result.M11 = matrix.M11;
            result.M12 = matrix.M21;
            result.M13 = matrix.M31;
            result.M14 = matrix.M41;
            result.M21 = matrix.M12;
            result.M22 = matrix.M22;
            result.M23 = matrix.M32;
            result.M24 = matrix.M42;
            result.M31 = matrix.M13;
            result.M32 = matrix.M23;
            result.M33 = matrix.M33;
            result.M34 = matrix.M43;
            result.M41 = matrix.M14;
            result.M42 = matrix.M24;
            result.M43 = matrix.M34;
            result.M44 = matrix.M44;
            return result;
        }

        /// <summary>
        /// Transposes the rows and columns of a matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Matrix4x4 Transpose()
            => Transpose(this);

        /// <summary>
        /// Linearly interpolates between the corresponding values of two matrices.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 Lerp(Matrix4x4 matrix1, Matrix4x4 matrix2, float amount)
        {
            Matrix4x4 result;

            // First row
            result.M11 = matrix1.M11 + (matrix2.M11 - matrix1.M11) * amount;
            result.M12 = matrix1.M12 + (matrix2.M12 - matrix1.M12) * amount;
            result.M13 = matrix1.M13 + (matrix2.M13 - matrix1.M13) * amount;
            result.M14 = matrix1.M14 + (matrix2.M14 - matrix1.M14) * amount;

            // Second row
            result.M21 = matrix1.M21 + (matrix2.M21 - matrix1.M21) * amount;
            result.M22 = matrix1.M22 + (matrix2.M22 - matrix1.M22) * amount;
            result.M23 = matrix1.M23 + (matrix2.M23 - matrix1.M23) * amount;
            result.M24 = matrix1.M24 + (matrix2.M24 - matrix1.M24) * amount;

            // Third row
            result.M31 = matrix1.M31 + (matrix2.M31 - matrix1.M31) * amount;
            result.M32 = matrix1.M32 + (matrix2.M32 - matrix1.M32) * amount;
            result.M33 = matrix1.M33 + (matrix2.M33 - matrix1.M33) * amount;
            result.M34 = matrix1.M34 + (matrix2.M34 - matrix1.M34) * amount;

            // Fourth row
            result.M41 = matrix1.M41 + (matrix2.M41 - matrix1.M41) * amount;
            result.M42 = matrix1.M42 + (matrix2.M42 - matrix1.M42) * amount;
            result.M43 = matrix1.M43 + (matrix2.M43 - matrix1.M43) * amount;
            result.M44 = matrix1.M44 + (matrix2.M44 - matrix1.M44) * amount;

            return result;
        }

        /// <summary>
        /// Returns a new matrix with the negated elements of the given matrix.
        /// </summary>
        /// <param name="value">The source matrix.</param>
        /// <returns>The negated matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 Negate(Matrix4x4 value) => -value;

        /// <summary>
        /// Adds two matrices together.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 Add(Matrix4x4 value1, Matrix4x4 value2) => value1 + value2;

        /// <summary>
        /// Subtracts the second matrix from the first.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 Subtract(Matrix4x4 value1, Matrix4x4 value2) => value1 - value2;

        /// <summary>
        /// Multiplies a matrix by another matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 Multiply(Matrix4x4 value1, Matrix4x4 value2) => value1 * value2;

        /// <summary>
        /// Multiplies a matrix by a scalar value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 Multiply(Matrix4x4 value1, float value2) => value1 * value2;

        /// <summary>
        /// Returns a new matrix with the negated elements of the given matrix.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 operator -(Matrix4x4 value)
        {
            Matrix4x4 m;

            m.M11 = -value.M11;
            m.M12 = -value.M12;
            m.M13 = -value.M13;
            m.M14 = -value.M14;
            m.M21 = -value.M21;
            m.M22 = -value.M22;
            m.M23 = -value.M23;
            m.M24 = -value.M24;
            m.M31 = -value.M31;
            m.M32 = -value.M32;
            m.M33 = -value.M33;
            m.M34 = -value.M34;
            m.M41 = -value.M41;
            m.M42 = -value.M42;
            m.M43 = -value.M43;
            m.M44 = -value.M44;

            return m;
        }

        /// <summary>
        /// Adds two matrices together.
        /// </summary>
        /// <param name="value1">The first source matrix.</param>
        /// <param name="value2">The second source matrix.</param>
        /// <returns>The resulting matrix.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 operator +(Matrix4x4 value1, Matrix4x4 value2)
        {
            Matrix4x4 m;

            m.M11 = value1.M11 + value2.M11;
            m.M12 = value1.M12 + value2.M12;
            m.M13 = value1.M13 + value2.M13;
            m.M14 = value1.M14 + value2.M14;
            m.M21 = value1.M21 + value2.M21;
            m.M22 = value1.M22 + value2.M22;
            m.M23 = value1.M23 + value2.M23;
            m.M24 = value1.M24 + value2.M24;
            m.M31 = value1.M31 + value2.M31;
            m.M32 = value1.M32 + value2.M32;
            m.M33 = value1.M33 + value2.M33;
            m.M34 = value1.M34 + value2.M34;
            m.M41 = value1.M41 + value2.M41;
            m.M42 = value1.M42 + value2.M42;
            m.M43 = value1.M43 + value2.M43;
            m.M44 = value1.M44 + value2.M44;

            return m;
        }

        /// <summary>
        /// Subtracts the second matrix from the first.
        /// </summary>
        /// <param name="value1">The first source matrix.</param>
        /// <param name="value2">The second source matrix.</param>
        /// <returns>The result of the subtraction.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 operator -(Matrix4x4 value1, Matrix4x4 value2)
        {
            Matrix4x4 m;

            m.M11 = value1.M11 - value2.M11;
            m.M12 = value1.M12 - value2.M12;
            m.M13 = value1.M13 - value2.M13;
            m.M14 = value1.M14 - value2.M14;
            m.M21 = value1.M21 - value2.M21;
            m.M22 = value1.M22 - value2.M22;
            m.M23 = value1.M23 - value2.M23;
            m.M24 = value1.M24 - value2.M24;
            m.M31 = value1.M31 - value2.M31;
            m.M32 = value1.M32 - value2.M32;
            m.M33 = value1.M33 - value2.M33;
            m.M34 = value1.M34 - value2.M34;
            m.M41 = value1.M41 - value2.M41;
            m.M42 = value1.M42 - value2.M42;
            m.M43 = value1.M43 - value2.M43;
            m.M44 = value1.M44 - value2.M44;

            return m;
        }

        /// <summary>
        /// Multiplies a matrix by another matrix.
        /// </summary>
        /// <param name="value1">The first source matrix.</param>
        /// <param name="value2">The second source matrix.</param>
        /// <returns>The result of the multiplication.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 operator *(Matrix4x4 value1, Matrix4x4 value2)
        {

            Matrix4x4 m;

            // First row
            m.M11 = value1.M11 * value2.M11 + value1.M12 * value2.M21 + value1.M13 * value2.M31 + value1.M14 * value2.M41;
            m.M12 = value1.M11 * value2.M12 + value1.M12 * value2.M22 + value1.M13 * value2.M32 + value1.M14 * value2.M42;
            m.M13 = value1.M11 * value2.M13 + value1.M12 * value2.M23 + value1.M13 * value2.M33 + value1.M14 * value2.M43;
            m.M14 = value1.M11 * value2.M14 + value1.M12 * value2.M24 + value1.M13 * value2.M34 + value1.M14 * value2.M44;

            // Second row
            m.M21 = value1.M21 * value2.M11 + value1.M22 * value2.M21 + value1.M23 * value2.M31 + value1.M24 * value2.M41;
            m.M22 = value1.M21 * value2.M12 + value1.M22 * value2.M22 + value1.M23 * value2.M32 + value1.M24 * value2.M42;
            m.M23 = value1.M21 * value2.M13 + value1.M22 * value2.M23 + value1.M23 * value2.M33 + value1.M24 * value2.M43;
            m.M24 = value1.M21 * value2.M14 + value1.M22 * value2.M24 + value1.M23 * value2.M34 + value1.M24 * value2.M44;

            // Third row
            m.M31 = value1.M31 * value2.M11 + value1.M32 * value2.M21 + value1.M33 * value2.M31 + value1.M34 * value2.M41;
            m.M32 = value1.M31 * value2.M12 + value1.M32 * value2.M22 + value1.M33 * value2.M32 + value1.M34 * value2.M42;
            m.M33 = value1.M31 * value2.M13 + value1.M32 * value2.M23 + value1.M33 * value2.M33 + value1.M34 * value2.M43;
            m.M34 = value1.M31 * value2.M14 + value1.M32 * value2.M24 + value1.M33 * value2.M34 + value1.M34 * value2.M44;

            // Fourth row
            m.M41 = value1.M41 * value2.M11 + value1.M42 * value2.M21 + value1.M43 * value2.M31 + value1.M44 * value2.M41;
            m.M42 = value1.M41 * value2.M12 + value1.M42 * value2.M22 + value1.M43 * value2.M32 + value1.M44 * value2.M42;
            m.M43 = value1.M41 * value2.M13 + value1.M42 * value2.M23 + value1.M43 * value2.M33 + value1.M44 * value2.M43;
            m.M44 = value1.M41 * value2.M14 + value1.M42 * value2.M24 + value1.M43 * value2.M34 + value1.M44 * value2.M44;

            return m;
        }

        /// <summary>
        /// Multiplies a matrix by a scalar value.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 operator *(Matrix4x4 value1, float value2)
        {
            Matrix4x4 m;

            m.M11 = value1.M11 * value2;
            m.M12 = value1.M12 * value2;
            m.M13 = value1.M13 * value2;
            m.M14 = value1.M14 * value2;
            m.M21 = value1.M21 * value2;
            m.M22 = value1.M22 * value2;
            m.M23 = value1.M23 * value2;
            m.M24 = value1.M24 * value2;
            m.M31 = value1.M31 * value2;
            m.M32 = value1.M32 * value2;
            m.M33 = value1.M33 * value2;
            m.M34 = value1.M34 * value2;
            m.M41 = value1.M41 * value2;
            m.M42 = value1.M42 * value2;
            m.M43 = value1.M43 * value2;
            m.M44 = value1.M44 * value2;
            return m;
        }

        /// <summary>
        /// Returns a boolean indicating whether the given two matrices are equal.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool operator ==(Matrix4x4 value1, Matrix4x4 value2)
            => (value1.M11 == value2.M11 && value1.M22 == value2.M22 && value1.M33 == value2.M33 && value1.M44 == value2.M44 && // Check diagonal element first for early out.
                value1.M12 == value2.M12 && value1.M13 == value2.M13 && value1.M14 == value2.M14 && value1.M21 == value2.M21 &&
                value1.M23 == value2.M23 && value1.M24 == value2.M24 && value1.M31 == value2.M31 && value1.M32 == value2.M32 &&
                value1.M34 == value2.M34 && value1.M41 == value2.M41 && value1.M42 == value2.M42 && value1.M43 == value2.M43);

        /// <summary>
        /// Returns a boolean indicating whether the given two matrices are not equal.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool operator !=(Matrix4x4 value1, Matrix4x4 value2)
            => (value1.M11 != value2.M11 || value1.M12 != value2.M12 || value1.M13 != value2.M13 || value1.M14 != value2.M14 ||
                value1.M21 != value2.M21 || value1.M22 != value2.M22 || value1.M23 != value2.M23 || value1.M24 != value2.M24 ||
                value1.M31 != value2.M31 || value1.M32 != value2.M32 || value1.M33 != value2.M33 || value1.M34 != value2.M34 ||
                value1.M41 != value2.M41 || value1.M42 != value2.M42 || value1.M43 != value2.M43 || value1.M44 != value2.M44);

        /// <summary>
        /// Returns a boolean indicating whether this matrix instance is equal to the other given matrix.
        /// </summary>
        /// <param name="other">The matrix to compare this instance to.</param>
        /// <returns>True if the matrices are equal; False otherwise.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool Equals(Matrix4x4 other) => this == other;

        /// <summary>
        /// Returns a boolean indicating whether the given Object is equal to this matrix instance.
        /// </summary>
        /// <param name="obj">The Object to compare against.</param>
        /// <returns>True if the Object is equal to this matrix; False otherwise.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override bool Equals(object obj) => (obj is Matrix4x4 other) && (this == other);

        /// <summary>
        /// Returns a String representing this matrix instance.
        /// </summary>
        /// <returns>The string representation.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override string ToString()
        {
            var ci = CultureInfo.CurrentCulture;

            return string.Format(ci, "{{ {{M11:{0} M12:{1} M13:{2} M14:{3}}} {{M21:{4} M22:{5} M23:{6} M24:{7}}} {{M31:{8} M32:{9} M33:{10} M34:{11}}} {{M41:{12} M42:{13} M43:{14} M44:{15}}} }}",
                                 M11.ToString(ci), M12.ToString(ci), M13.ToString(ci), M14.ToString(ci),
                                 M21.ToString(ci), M22.ToString(ci), M23.ToString(ci), M24.ToString(ci),
                                 M31.ToString(ci), M32.ToString(ci), M33.ToString(ci), M34.ToString(ci),
                                 M41.ToString(ci), M42.ToString(ci), M43.ToString(ci), M44.ToString(ci));
        }

        /// <summary>
        /// Returns the hash code for this instance.
        /// </summary>
        /// <returns>The hash code.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override int GetHashCode()
        {
            unchecked
            {
                return M11.GetHashCode() + M12.GetHashCode() + M13.GetHashCode() + M14.GetHashCode() +
                       M21.GetHashCode() + M22.GetHashCode() + M23.GetHashCode() + M24.GetHashCode() +
                       M31.GetHashCode() + M32.GetHashCode() + M33.GetHashCode() + M34.GetHashCode() +
                       M41.GetHashCode() + M42.GetHashCode() + M43.GetHashCode() + M44.GetHashCode();
            }
        }

        /// <summary>
        /// Attempts to extract the scale, translation, and rotation components from the given scale/rotation/translation matrix.
        /// If successful, the out parameters will contained the extracted values.
        /// https://referencesource.microsoft.com/#System.Numerics/System/Numerics/Matrix4x4.cs
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool Decompose(out Vector3 scale, out Quaternion rotation, out Vector3 translation)
            => Decompose(this, out scale, out rotation, out translation);

        /// <summary>
        /// Attempts to extract the scale, translation, and rotation components from the given scale/rotation/translation matrix.
        /// If successful, the out parameters will contained the extracted values.
        /// https://referencesource.microsoft.com/#System.Numerics/System/Numerics/Matrix4x4.cs
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool Decompose(Matrix4x4 matrix, out Vector3 scale, out Quaternion rotation,
            out Vector3 translation)
        {
            var result = true;

            var pfScales = new float[3];
            const float EPSILON = 0.0001f;

            var pCanonicalBasis = new[] {
                Vector3.UnitX,
                Vector3.UnitY,
                Vector3.UnitZ,
            };

            var pVectorBasis = new[] {
                matrix.Row0,
                matrix.Row1,
                matrix.Row2
            };

            pfScales[0] = pVectorBasis[0].Length();
            pfScales[1] = pVectorBasis[1].Length();
            pfScales[2] = pVectorBasis[2].Length();

            uint a, b, c;
            float x = pfScales[0], y = pfScales[1], z = pfScales[2];
            if (x < y)
            {
                if (y < z)
                {
                    a = 2; b = 1; c = 0;
                }
                else
                {
                    a = 1;
                    if (x < z)
                    {
                        b = 2; c = 0;
                    }
                    else
                    {
                        b = 0; c = 2;
                    }
                }
            }
            else
            {
                if (x < z)
                {
                    a = 2; b = 0; c = 1;
                }
                else
                {
                    a = 0;

                    if (y < z)
                    {
                        b = 2; c = 1;
                    }
                    else
                    {
                        b = 1; c = 2;
                    }
                }
            }

            if (pfScales[a] < EPSILON)
                pVectorBasis[a] = pCanonicalBasis[a];

            pVectorBasis[a] = pVectorBasis[a].Normalize();

            if (pfScales[b] < EPSILON)
            {
                var fAbsX = pVectorBasis[a].X.Abs();
                var fAbsY = pVectorBasis[a].Y.Abs();
                var fAbsZ = pVectorBasis[a].Z.Abs();

                var cc = 0;
                if (fAbsX < fAbsY)
                {
                    if (fAbsY < fAbsZ)
                    {
                        cc = 0;
                    }
                    else
                    {
                        if (fAbsX < fAbsZ)
                        {
                            cc = 0;
                        }
                        else
                        {
                            cc = 2;
                        }
                    }
                }
                else
                {
                    if (fAbsX < fAbsZ)
                    {
                        cc = 1;
                    }
                    else
                    {
                        if (fAbsY < fAbsZ)
                        {
                            cc = 1;
                        }
                        else
                        {
                            cc = 2;
                        }
                    }
                }
                pVectorBasis[b] = pVectorBasis[a].Cross(pCanonicalBasis[cc]);
            }

            pVectorBasis[b] = pVectorBasis[b].Normalize();

            if (pfScales[c] < EPSILON)
            {
                pVectorBasis[c] = pVectorBasis[a].Cross(pVectorBasis[b]);
            }

            pVectorBasis[c] = pVectorBasis[c].Normalize();

            // Update mat tmp;
            var det = CreateFromRows(pVectorBasis[0], pVectorBasis[1], pVectorBasis[2])
                .GetDeterminant();

            // use Kramer's rule to check for handedness of coordinate system
            if (det < 0.0f)
            {
                // switch coordinate system by negating the scale and inverting the basis vector on the x-axis
                pfScales[a] = -pfScales[a];
                pVectorBasis[a] = -pVectorBasis[a];
                det = -det;
            }

            det -= 1.0f;
            det *= det;

            if (EPSILON < det)
            {
                // Non-SRT matrix encountered
                rotation = Quaternion.Identity;
                result = false;
            }
            else
            {
                // generate the quaternion from the matrix
                var matTemp = CreateFromRows(pVectorBasis[0], pVectorBasis[1], pVectorBasis[2]);
                rotation = Quaternion.CreateFromRotationMatrix(matTemp);
            }

            translation = matrix.Translation;
            scale = new Vector3(pfScales[0], pfScales[1], pfScales[2]);
            return result;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Matrix4x4 Transform(Matrix4x4 mat)
            => this * mat;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static Matrix4x4 CreateTRS(Vector3 translation, Quaternion rotation, Vector3 scale)
            => CreateTranslation(translation) * CreateRotation(rotation) * CreateScale(scale);

        /// <summary>
        /// Get's the scale factor of each axis.  This implementation extracts the scale exclusively,
        /// so it attempts to ignore rotation.  This is contrary to most math libraries
        /// that use decompose, so a negation on Y becomes a 90 degree rotation and a negation on X.
        /// We have implemented this extraction to be able to quickly remove scaling from matrices.
        /// Multiplying a matrix by the inverse of it's direct scale will preserve it's current rotation.
        /// It's implemented this way mostly so we can get easy testing on unit tests, and because this
        /// implementation is equally valid.
        /// NOTE: This could probably be improved to handle more generic cases by using
        /// CrossProduct to determine axis flipping: (X Cross Y) Dot Z < 0 == Flip
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 ExtractDirectScale()
        => new Vector3(
                Row0.Length() * (M11 > 0 ? 1 : -1),
                Row1.Length() * (M22 > 0 ? 1 : -1),
                Row2.Length() * (M33 > 0 ? 1 : -1)
            );

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Matrix4x4 ScaleTranslation(float amount)
            => SetTranslation(Translation * amount);
    }
}
