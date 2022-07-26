// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System.Runtime.InteropServices;
using NUnit.Framework;

namespace Vim.Math3d.Tests
{
    public class Vector4Tests
    {
        [Test]
        public void Vector4MarshalSizeTest()
        {
            Assert.AreEqual(16, Marshal.SizeOf<Vector4>());
            Assert.AreEqual(16, Marshal.SizeOf<Vector4>(new Vector4()));
        }

        [Test]
        public void Vector4GetHashCodeTest()
        {
            var v1 = new Vector4(2.5f, 2.0f, 3.0f, 3.3f);
            var v2 = new Vector4(2.5f, 2.0f, 3.0f, 3.3f);
            var v3 = new Vector4(2.5f, 2.0f, 3.0f, 3.3f);
            var v5 = new Vector4(3.3f, 3.0f, 2.0f, 2.5f);
            Assert.AreEqual(v1.GetHashCode(), v1.GetHashCode());
            Assert.AreEqual(v1.GetHashCode(), v2.GetHashCode());
            Assert.AreNotEqual(v1.GetHashCode(), v5.GetHashCode());
            Assert.AreEqual(v1.GetHashCode(), v3.GetHashCode());
            var v4 = new Vector4(0.0f, 0.0f, 0.0f, 0.0f);
            var v6 = new Vector4(1.0f, 0.0f, 0.0f, 0.0f);
            var v7 = new Vector4(0.0f, 1.0f, 0.0f, 0.0f);
            var v8 = new Vector4(1.0f, 1.0f, 1.0f, 1.0f);
            var v9 = new Vector4(1.0f, 1.0f, 0.0f, 0.0f);
            Assert.AreNotEqual(v4.GetHashCode(), v6.GetHashCode());
            Assert.AreNotEqual(v4.GetHashCode(), v7.GetHashCode());
            Assert.AreNotEqual(v4.GetHashCode(), v8.GetHashCode());
            Assert.AreNotEqual(v7.GetHashCode(), v6.GetHashCode());
            Assert.AreNotEqual(v8.GetHashCode(), v6.GetHashCode());
            Assert.AreNotEqual(v8.GetHashCode(), v7.GetHashCode());
            Assert.AreNotEqual(v9.GetHashCode(), v7.GetHashCode());
        }

        // A test for DistanceSquared (Vector4f, Vector4f)
        [Test]
        public void Vector4DistanceSquaredTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = 64.0f;
            float actual;

            actual = MathOps.DistanceSquared(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.DistanceSquared did not return the expected value.");
        }

        // A test for Distance (Vector4f, Vector4f)
        [Test]
        public void Vector4DistanceTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = 8.0f;
            float actual;

            actual = MathOps.Distance(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Distance did not return the expected value.");
        }

        // A test for Distance (Vector4f, Vector4f)
        // Distance from the same point
        [Test]
        public void Vector4DistanceTest1()
        {
            var a = new Vector4(new Vector2(1.051f, 2.05f), 3.478f, 1.0f);
            var b = new Vector4(new Vector3(1.051f, 2.05f, 3.478f), 0.0f);
            b = b.SetW(1f);

            var actual = MathOps.Distance(a, b);
            Assert.AreEqual(0.0f, actual);
        }

        // A test for Dot (Vector4f, Vector4f)
        [Test]
        public void Vector4DotTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = 70.0f;
            float actual;

            actual = MathOps.Dot(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Dot did not return the expected value.");
        }

        // A test for Dot (Vector4f, Vector4f)
        // Dot test for perpendicular vector
        [Test]
        public void Vector4DotTest1()
        {
            var a = new Vector3(1.55f, 1.55f, 1);
            var b = new Vector3(2.5f, 3, 1.5f);
            var c = MathOps.Cross(a, b);

            var d = new Vector4(a, 0);
            var e = new Vector4(c, 0);

            var actual = MathOps.Dot(d, e);
            Assert.True(MathHelper.Equal(0.0f, actual), "Vector4f.Dot did not return the expected value.");
        }

        // A test for Length ()
        [Test]
        public void Vector4LengthTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var w = 4.0f;

            var target = new Vector4(a, w);

            var expected = (float)System.Math.Sqrt(30.0f);
            float actual;

            actual = target.Length();

            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Length did not return the expected value.");
        }

        // A test for Length ()
        // Length test where length is zero
        [Test]
        public void Vector4LengthTest1()
        {
            var target = new Vector4();

            var expected = 0.0f;
            var actual = target.Length();

            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Length did not return the expected value.");
        }

        // A test for LengthSquared ()
        [Test]
        public void Vector4LengthSquaredTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var w = 4.0f;

            var target = new Vector4(a, w);

            float expected = 30;
            float actual;

            actual = target.LengthSquared();

            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.LengthSquared did not return the expected value.");
        }

        // A test for Min (Vector4f, Vector4f)
        [Test]
        public void Vector4MinTest()
        {
            var a = new Vector4(-1.0f, 4.0f, -3.0f, 1000.0f);
            var b = new Vector4(2.0f, 1.0f, -1.0f, 0.0f);

            var expected = new Vector4(-1.0f, 1.0f, -3.0f, 0.0f);
            Vector4 actual;
            actual = MathOps.Min(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Min did not return the expected value.");
        }

        // A test for Max (Vector4f, Vector4f)
        [Test]
        public void Vector4MaxTest()
        {
            var a = new Vector4(-1.0f, 4.0f, -3.0f, 1000.0f);
            var b = new Vector4(2.0f, 1.0f, -1.0f, 0.0f);

            var expected = new Vector4(2.0f, 4.0f, -1.0f, 1000.0f);
            Vector4 actual;
            actual = MathOps.Max(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Max did not return the expected value.");
        }

        [Test]
        public void Vector4MinMaxCodeCoverageTest()
        {
            var min = Vector4.Zero;
            var max = Vector4.One;
            Vector4 actual;

            // Min.
            actual = MathOps.Min(min, max);
            Assert.AreEqual(actual, min);

            actual = MathOps.Min(max, min);
            Assert.AreEqual(actual, min);

            // Max.
            actual = MathOps.Max(min, max);
            Assert.AreEqual(actual, max);

            actual = MathOps.Max(max, min);
            Assert.AreEqual(actual, max);
        }

        // A test for Clamp (Vector4f, Vector4f, Vector4f)
        [Test]
        public void Vector4ClampTest()
        {
            var a = new Vector4(0.5f, 0.3f, 0.33f, 0.44f);
            var min = new Vector4(0.0f, 0.1f, 0.13f, 0.14f);
            var max = new Vector4(1.0f, 1.1f, 1.13f, 1.14f);

            // Normal case.
            // Case N1: specified value is in the range.
            var expected = new Vector4(0.5f, 0.3f, 0.33f, 0.44f);
            var actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Clamp did not return the expected value.");

            // Normal case.
            // Case N2: specified value is bigger than max value.
            a = new Vector4(2.0f, 3.0f, 4.0f, 5.0f);
            expected = max;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Clamp did not return the expected value.");

            // Case N3: specified value is smaller than max value.
            a = new Vector4(-2.0f, -3.0f, -4.0f, -5.0f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Clamp did not return the expected value.");

            // Case N4: combination case.
            a = new Vector4(-2.0f, 0.5f, 4.0f, -5.0f);
            expected = new Vector4(min.X, a.Y, max.Z, min.W);
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Clamp did not return the expected value.");

            // User specified min value is bigger than max value.
            max = new Vector4(0.0f, 0.1f, 0.13f, 0.14f);
            min = new Vector4(1.0f, 1.1f, 1.13f, 1.14f);

            // Case W1: specified value is in the range.
            a = new Vector4(0.5f, 0.3f, 0.33f, 0.44f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Clamp did not return the expected value.");

            // Normal case.
            // Case W2: specified value is bigger than max and min value.
            a = new Vector4(2.0f, 3.0f, 4.0f, 5.0f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Clamp did not return the expected value.");

            // Case W3: specified value is smaller than min and max value.
            a = new Vector4(-2.0f, -3.0f, -4.0f, -5.0f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Clamp did not return the expected value.");
        }

        // A test for Lerp (Vector4f, Vector4f, float)
        [Test]
        public void Vector4LerpTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 6.0f, 7.0f, 8.0f);

            var t = 0.5f;

            var expected = new Vector4(3.0f, 4.0f, 5.0f, 6.0f);
            Vector4 actual;

            actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector4f, Vector4f, float)
        // Lerp test with factor zero
        [Test]
        public void Vector4LerpTest1()
        {
            var a = new Vector4(new Vector3(1.0f, 2.0f, 3.0f), 4.0f);
            var b = new Vector4(4.0f, 5.0f, 6.0f, 7.0f);

            var t = 0.0f;
            var expected = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector4f, Vector4f, float)
        // Lerp test with factor one
        [Test]
        public void Vector4LerpTest2()
        {
            var a = new Vector4(new Vector3(1.0f, 2.0f, 3.0f), 4.0f);
            var b = new Vector4(4.0f, 5.0f, 6.0f, 7.0f);

            var t = 1.0f;
            var expected = new Vector4(4.0f, 5.0f, 6.0f, 7.0f);
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector4f, Vector4f, float)
        // Lerp test with factor > 1
        [Test]
        public void Vector4LerpTest3()
        {
            var a = new Vector4(new Vector3(0.0f, 0.0f, 0.0f), 0.0f);
            var b = new Vector4(4.0f, 5.0f, 6.0f, 7.0f);

            var t = 2.0f;
            var expected = new Vector4(8.0f, 10.0f, 12.0f, 14.0f);
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector4f, Vector4f, float)
        // Lerp test with factor < 0
        [Test]
        public void Vector4LerpTest4()
        {
            var a = new Vector4(new Vector3(0.0f, 0.0f, 0.0f), 0.0f);
            var b = new Vector4(4.0f, 5.0f, 6.0f, 7.0f);

            var t = -2.0f;
            var expected = -(b * 2);
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector4f, Vector4f, float)
        // Lerp test from the same point
        [Test]
        public void Vector4LerpTest5()
        {
            var a = new Vector4(4.0f, 5.0f, 6.0f, 7.0f);
            var b = new Vector4(4.0f, 5.0f, 6.0f, 7.0f);

            var t = 0.85f;
            var expected = a;
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Lerp did not return the expected value.");
        }

        // A test for Transform (Vector2f, Matrix4x4)
        [Test]
        public void Vector4TransformTest1()
        {
            var v = new Vector2(1.0f, 2.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            var expected = new Vector4(10.316987f, 22.183012f, 30.3660259f, 1.0f);
            Vector4 actual;

            actual = MathOps.TransformToVector4(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Matrix4x4)
        [Test]
        public void Vector4TransformTest2()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            var expected = new Vector4(12.19198728f, 21.53349376f, 32.61602545f, 1.0f);
            Vector4 actual;

            actual = MathOps.TransformToVector4(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "MathOps.Transform did not return the expected value.");
        }

        // A test for Transform (Vector4f, Matrix4x4)
        [Test]
        public void Vector4TransformVector4Test()
        {
            var v = new Vector4(1.0f, 2.0f, 3.0f, 0.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            var expected = new Vector4(2.19198728f, 1.53349376f, 2.61602545f, 0.0f);
            Vector4 actual;

            actual = MathOps.Transform(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");

            // 
            v = v.SetW(1f);

            expected = new Vector4(12.19198728f, 21.53349376f, 32.61602545f, 1.0f);
            actual = MathOps.Transform(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector4f, Matrix4x4)
        // Transform vector4 with zero matrix
        [Test]
        public void Vector4TransformVector4Test1()
        {
            var v = new Vector4(1.0f, 2.0f, 3.0f, 0.0f);
            var m = new Matrix4x4();
            var expected = new Vector4(0, 0, 0, 0);

            var actual = MathOps.Transform(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector4f, Matrix4x4)
        // Transform vector4 with identity matrix
        [Test]
        public void Vector4TransformVector4Test2()
        {
            var v = new Vector4(1.0f, 2.0f, 3.0f, 0.0f);
            var m = Matrix4x4.Identity;
            var expected = new Vector4(1.0f, 2.0f, 3.0f, 0.0f);

            var actual = MathOps.Transform(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Matrix4x4)
        // Transform Vector3f test
        [Test]
        public void Vector4TransformVector3Test()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            var expected = MathOps.Transform(new Vector4(v, 1.0f), m);
            var actual = MathOps.TransformToVector4(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Matrix4x4)
        // Transform vector3 with zero matrix
        [Test]
        public void Vector4TransformVector3Test1()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var m = new Matrix4x4();
            var expected = new Vector4(0, 0, 0, 0);

            var actual = MathOps.TransformToVector4(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Matrix4x4)
        // Transform vector3 with identity matrix
        [Test]
        public void Vector4TransformVector3Test2()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var m = Matrix4x4.Identity;
            var expected = new Vector4(1.0f, 2.0f, 3.0f, 1.0f);

            var actual = MathOps.TransformToVector4(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector2f, Matrix4x4)
        // Transform Vector2f test
        [Test]
        public void Vector4TransformVector2Test()
        {
            var v = new Vector2(1.0f, 2.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            var expected = MathOps.Transform(new Vector4(v, 0.0f, 1.0f), m);
            var actual = MathOps.TransformToVector4(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector2f, Matrix4x4)
        // Transform Vector2f with zero matrix
        [Test]
        public void Vector4TransformVector2Test1()
        {
            var v = new Vector2(1.0f, 2.0f);
            var m = new Matrix4x4();
            var expected = new Vector4(0, 0, 0, 0);

            var actual = MathOps.TransformToVector4(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector2f, Matrix4x4)
        // Transform vector2 with identity matrix
        [Test]
        public void Vector4TransformVector2Test2()
        {
            var v = new Vector2(1.0f, 2.0f);
            var m = Matrix4x4.Identity;
            var expected = new Vector4(1.0f, 2.0f, 0, 1.0f);

            var actual = MathOps.TransformToVector4(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector2f, Quaternion)
        [Test]
        public void Vector4TransformVector2QuatanionTest()
        {
            var v = new Vector2(1.0f, 2.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));

            var q = Quaternion.CreateFromRotationMatrix(m);

            var expected = MathOps.TransformToVector4(v, m);
            Vector4 actual;

            actual = MathOps.TransformToVector4(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Quaternion)
        [Test]
        public void Vector4TransformVector3Quaternion()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            var q = Quaternion.CreateFromRotationMatrix(m);

            var expected = MathOps.TransformToVector4(v, m);
            Vector4 actual;

            actual = MathOps.TransformToVector4(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "MathOps.Transform did not return the expected value.");
        }

        // A test for Transform (Vector4f, Quaternion)
        [Test]
        public void Vector4TransformVector4QuaternionTest()
        {
            var v = new Vector4(1.0f, 2.0f, 3.0f, 0.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            var q = Quaternion.CreateFromRotationMatrix(m);

            var expected = MathOps.Transform(v, m);
            Vector4 actual;

            actual = MathOps.Transform(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");

            // 
            v = v.SetW(1f);
            expected = expected.SetW(1f);
            actual = MathOps.Transform(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector4f, Quaternion)
        // Transform vector4 with zero quaternion
        [Test]
        public void Vector4TransformVector4QuaternionTest1()
        {
            var v = new Vector4(1.0f, 2.0f, 3.0f, 0.0f);
            var q = new Quaternion();
            var expected = v;

            var actual = MathOps.Transform(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector4f, Quaternion)
        // Transform vector4 with identity matrix
        [Test]
        public void Vector4TransformVector4QuaternionTest2()
        {
            var v = new Vector4(1.0f, 2.0f, 3.0f, 0.0f);
            var q = Quaternion.Identity;
            var expected = new Vector4(1.0f, 2.0f, 3.0f, 0.0f);

            var actual = MathOps.Transform(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Quaternion)
        // Transform Vector3f test
        [Test]
        public void Vector4TransformVector3QuaternionTest()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            var q = Quaternion.CreateFromRotationMatrix(m);

            var expected = MathOps.TransformToVector4(v, m);
            var actual = MathOps.TransformToVector4(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Quaternion)
        // Transform vector3 with zero quaternion
        [Test]
        public void Vector4TransformVector3QuaternionTest1()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var q = new Quaternion();
            var expected = new Vector4(v, 1.0f);

            var actual = MathOps.TransformToVector4(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Quaternion)
        // Transform vector3 with identity quaternion
        [Test]
        public void Vector4TransformVector3QuaternionTest2()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var q = Quaternion.Identity;
            var expected = new Vector4(1.0f, 2.0f, 3.0f, 1.0f);

            var actual = MathOps.TransformToVector4(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector2f, Quaternion)
        // Transform Vector2f by quaternion test
        [Test]
        public void Vector4TransformVector2QuaternionTest()
        {
            var v = new Vector2(1.0f, 2.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            var q = Quaternion.CreateFromRotationMatrix(m);

            var expected = MathOps.TransformToVector4(v, m);
            var actual = MathOps.TransformToVector4(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector2f, Quaternion)
        // Transform Vector2f with zero quaternion
        [Test]
        public void Vector4TransformVector2QuaternionTest1()
        {
            var v = new Vector2(1.0f, 2.0f);
            var q = new Quaternion();
            var expected = new Vector4(1.0f, 2.0f, 0, 1.0f);

            var actual = MathOps.TransformToVector4(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector2f, Matrix4x4)
        // Transform vector2 with identity Quaternion
        [Test]
        public void Vector4TransformVector2QuaternionTest2()
        {
            var v = new Vector2(1.0f, 2.0f);
            var q = Quaternion.Identity;
            var expected = new Vector4(1.0f, 2.0f, 0, 1.0f);

            var actual = MathOps.TransformToVector4(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Transform did not return the expected value.");
        }

        // A test for Normalize (Vector4f)
        [Test]
        public void Vector4NormalizeTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            var expected = new Vector4(
                0.1825741858350553711523232609336f,
                0.3651483716701107423046465218672f,
                0.5477225575051661134569697828008f,
                0.7302967433402214846092930437344f);
            Vector4 actual;

            actual = MathOps.Normalize(a);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Normalize did not return the expected value.");
        }

        // A test for Normalize (Vector4f)
        // Normalize vector of length one
        [Test]
        public void Vector4NormalizeTest1()
        {
            var a = new Vector4(1.0f, 0.0f, 0.0f, 0.0f);

            var expected = new Vector4(1.0f, 0.0f, 0.0f, 0.0f);
            var actual = MathOps.Normalize(a);
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.Normalize did not return the expected value.");
        }

        // A test for Normalize (Vector4f)
        // Normalize vector of length zero
        [Test]
        public void Vector4NormalizeTest2()
        {
            var a = new Vector4(0.0f, 0.0f, 0.0f, 0.0f);

            var expected = new Vector4(0.0f, 0.0f, 0.0f, 0.0f);
            var actual = MathOps.Normalize(a);
            Assert.True(float.IsNaN(actual.X) && float.IsNaN(actual.Y) && float.IsNaN(actual.Z) && float.IsNaN(actual.W), "Vector4f.Normalize did not return the expected value.");
        }

        // A test for operator - (Vector4f)
        [Test]
        public void Vector4UnaryNegationTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            var expected = new Vector4(-1.0f, -2.0f, -3.0f, -4.0f);
            Vector4 actual;

            actual = -a;

            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.operator - did not return the expected value.");
        }

        // A test for operator - (Vector4f, Vector4f)
        [Test]
        public void Vector4SubtractionTest()
        {
            var a = new Vector4(1.0f, 6.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 2.0f, 3.0f, 9.0f);

            var expected = new Vector4(-4.0f, 4.0f, 0.0f, -5.0f);
            Vector4 actual;

            actual = a - b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.operator - did not return the expected value.");
        }

        // A test for operator * (Vector4f, float)
        [Test]
        public void Vector4MultiplyOperatorTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            const float factor = 2.0f;

            var expected = new Vector4(2.0f, 4.0f, 6.0f, 8.0f);
            Vector4 actual;

            actual = a * factor;
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.operator * did not return the expected value.");
        }

        // A test for operator * (float, Vector4f)
        [Test]
        public void Vector4MultiplyOperatorTest2()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            const float factor = 2.0f;
            var expected = new Vector4(2.0f, 4.0f, 6.0f, 8.0f);
            Vector4 actual;

            actual = factor * a;
            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.operator * did not return the expected value.");
        }

        // A test for operator * (Vector4f, Vector4f)
        [Test]
        public void Vector4MultiplyOperatorTest3()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = new Vector4(5.0f, 12.0f, 21.0f, 32.0f);
            Vector4 actual;

            actual = a * b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.operator * did not return the expected value.");
        }

        // A test for operator / (Vector4f, float)
        [Test]
        public void Vector4DivisionTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            var div = 2.0f;

            var expected = new Vector4(0.5f, 1.0f, 1.5f, 2.0f);
            Vector4 actual;

            actual = a / div;

            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.operator / did not return the expected value.");
        }

        // A test for operator / (Vector4f, Vector4f)
        [Test]
        public void Vector4DivisionTest1()
        {
            var a = new Vector4(1.0f, 6.0f, 7.0f, 4.0f);
            var b = new Vector4(5.0f, 2.0f, 3.0f, 8.0f);

            var expected = new Vector4(1.0f / 5.0f, 6.0f / 2.0f, 7.0f / 3.0f, 4.0f / 8.0f);
            Vector4 actual;

            actual = a / b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.operator / did not return the expected value.");
        }

        // A test for operator / (Vector4f, Vector4f)
        // Divide by zero
        [Test]
        public void Vector4DivisionTest2()
        {
            var a = new Vector4(-2.0f, 3.0f, float.MaxValue, float.NaN);

            var div = 0.0f;

            var actual = a / div;

            Assert.True(float.IsNegativeInfinity(actual.X), "Vector4f.operator / did not return the expected value.");
            Assert.True(float.IsPositiveInfinity(actual.Y), "Vector4f.operator / did not return the expected value.");
            Assert.True(float.IsPositiveInfinity(actual.Z), "Vector4f.operator / did not return the expected value.");
            Assert.True(float.IsNaN(actual.W), "Vector4f.operator / did not return the expected value.");
        }

        // A test for operator / (Vector4f, Vector4f)
        // Divide by zero
        [Test]
        public void Vector4DivisionTest3()
        {
            var a = new Vector4(0.047f, -3.0f, float.NegativeInfinity, float.MinValue);
            var b = new Vector4();

            var actual = a / b;

            Assert.True(float.IsPositiveInfinity(actual.X), "Vector4f.operator / did not return the expected value.");
            Assert.True(float.IsNegativeInfinity(actual.Y), "Vector4f.operator / did not return the expected value.");
            Assert.True(float.IsNegativeInfinity(actual.Z), "Vector4f.operator / did not return the expected value.");
            Assert.True(float.IsNegativeInfinity(actual.W), "Vector4f.operator / did not return the expected value.");
        }

        // A test for operator + (Vector4f, Vector4f)
        [Test]
        public void Vector4AdditionTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = new Vector4(6.0f, 8.0f, 10.0f, 12.0f);
            Vector4 actual;

            actual = a + b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector4f.operator + did not return the expected value.");
        }

        [Test]
        public void OperatorAddTest()
        {
            var v1 = new Vector4(2.5f, 2.0f, 3.0f, 3.3f);
            var v2 = new Vector4(5.5f, 4.5f, 6.5f, 7.5f);

            var v3 = v1 + v2;
            var v5 = new Vector4(-1.0f, 0.0f, 0.0f, float.NaN);
            var v4 = v1 + v5;
            Assert.AreEqual(8.0f, v3.X);
            Assert.AreEqual(6.5f, v3.Y);
            Assert.AreEqual(9.5f, v3.Z);
            Assert.AreEqual(10.8f, v3.W);
            Assert.AreEqual(1.5f, v4.X);
            Assert.AreEqual(2.0f, v4.Y);
            Assert.AreEqual(3.0f, v4.Z);
            Assert.AreEqual(float.NaN, v4.W);
        }

        // A test for Vector4f (float, float, float, float)
        [Test]
        public void Vector4ConstructorTest()
        {
            var x = 1.0f;
            var y = 2.0f;
            var z = 3.0f;
            var w = 4.0f;

            var target = new Vector4(x, y, z, w);

            Assert.True(MathHelper.Equal(target.X, x) && MathHelper.Equal(target.Y, y) && MathHelper.Equal(target.Z, z) && MathHelper.Equal(target.W, w),
                "Vector4f constructor(x,y,z,w) did not return the expected value.");
        }

        // A test for Vector4f (Vector2f, float, float)
        [Test]
        public void Vector4ConstructorTest1()
        {
            var a = new Vector2(1.0f, 2.0f);
            var z = 3.0f;
            var w = 4.0f;

            var target = new Vector4(a, z, w);
            Assert.True(MathHelper.Equal(target.X, a.X) && MathHelper.Equal(target.Y, a.Y) && MathHelper.Equal(target.Z, z) && MathHelper.Equal(target.W, w),
                "Vector4f constructor(Vector2f,z,w) did not return the expected value.");
        }

        // A test for Vector4f (Vector3f, float)
        [Test]
        public void Vector4ConstructorTest2()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var w = 4.0f;

            var target = new Vector4(a, w);

            Assert.True(MathHelper.Equal(target.X, a.X) && MathHelper.Equal(target.Y, a.Y) && MathHelper.Equal(target.Z, a.Z) && MathHelper.Equal(target.W, w),
                "Vector4f constructor(Vector3f,w) did not return the expected value.");
        }

        // A test for Vector4f ()
        // Constructor with no parameter
        [Test]
        public void Vector4ConstructorTest4()
        {
            var a = new Vector4();

            Assert.AreEqual(a.X, 0.0f);
            Assert.AreEqual(a.Y, 0.0f);
            Assert.AreEqual(a.Z, 0.0f);
            Assert.AreEqual(a.W, 0.0f);
        }

        // A test for Vector4f ()
        // Constructor with special floating values
        [Test]
        public void Vector4ConstructorTest5()
        {
            var target = new Vector4(float.NaN, float.MaxValue, float.PositiveInfinity, float.Epsilon);

            Assert.True(float.IsNaN(target.X), "Vector4f.constructor (float, float, float, float) did not return the expected value.");
            Assert.True(float.Equals(float.MaxValue, target.Y), "Vector4f.constructor (float, float, float, float) did not return the expected value.");
            Assert.True(float.IsPositiveInfinity(target.Z), "Vector4f.constructor (float, float, float, float) did not return the expected value.");
            Assert.True(float.Equals(float.Epsilon, target.W), "Vector4f.constructor (float, float, float, float) did not return the expected value.");
        }

        // A test for Add (Vector4f, Vector4f)
        [Test]
        public void Vector4AddTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = new Vector4(6.0f, 8.0f, 10.0f, 12.0f);
            Vector4 actual;

            actual = MathOps.Add(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Divide (Vector4f, float)
        [Test]
        public void Vector4DivideTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var div = 2.0f;
            var expected = new Vector4(0.5f, 1.0f, 1.5f, 2.0f);
            Assert.AreEqual(expected, a / div);
        }

        // A test for Divide (Vector4f, Vector4f)
        [Test]
        public void Vector4DivideTest1()
        {
            var a = new Vector4(1.0f, 6.0f, 7.0f, 4.0f);
            var b = new Vector4(5.0f, 2.0f, 3.0f, 8.0f);

            var expected = new Vector4(1.0f / 5.0f, 6.0f / 2.0f, 7.0f / 3.0f, 4.0f / 8.0f);
            Vector4 actual;

            actual = MathOps.Divide(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Equals (object)
        [Test]
        public void Vector4EqualsTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            // case 1: compare between same values
            object obj = b;

            var expected = true;
            var actual = a.Equals(obj);
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10f);
            obj = b;
            expected = false;
            actual = a.Equals(obj);
            Assert.AreEqual(expected, actual);

            // case 3: compare between different types.
            obj = new Quaternion();
            expected = false;
            actual = a.Equals(obj);
            Assert.AreEqual(expected, actual);

            // case 3: compare against null.
            obj = null;
            expected = false;
            actual = a.Equals(obj);
            Assert.AreEqual(expected, actual);
        }

        // A test for Multiply (float, Vector4f)
        [Test]
        public void Vector4MultiplyTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            const float factor = 2.0f;
            var expected = new Vector4(2.0f, 4.0f, 6.0f, 8.0f);
            Assert.AreEqual(expected, factor * a);
        }

        // A test for Multiply (Vector4f, float)
        [Test]
        public void Vector4MultiplyTest2()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            const float factor = 2.0f;
            var expected = new Vector4(2.0f, 4.0f, 6.0f, 8.0f);
            Assert.AreEqual(expected, a * factor);
        }

        // A test for Multiply (Vector4f, Vector4f)
        [Test]
        public void Vector4MultiplyTest3()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = new Vector4(5.0f, 12.0f, 21.0f, 32.0f);
            Vector4 actual;

            actual = MathOps.Multiply(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Negate (Vector4f)
        [Test]
        public void Vector4NegateTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            var expected = new Vector4(-1.0f, -2.0f, -3.0f, -4.0f);
            Vector4 actual;

            actual = MathOps.Negate(a);
            Assert.AreEqual(expected, actual);
        }

        // A test for operator != (Vector4f, Vector4f)
        [Test]
        public void Vector4InequalityTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            // case 1: compare between same values
            var expected = false;
            var actual = a != b;
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10f);
            expected = true;
            actual = a != b;
            Assert.AreEqual(expected, actual);
        }

        // A test for operator == (Vector4f, Vector4f)
        [Test]
        public void Vector4EqualityTest()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            // case 1: compare between same values
            var expected = true;
            var actual = a == b;
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10f);
            expected = false;
            actual = a == b;
            Assert.AreEqual(expected, actual);
        }

        // A test for Subtract (Vector4f, Vector4f)
        [Test]
        public void Vector4SubtractTest()
        {
            var a = new Vector4(1.0f, 6.0f, 3.0f, 4.0f);
            var b = new Vector4(5.0f, 2.0f, 3.0f, 9.0f);

            var expected = new Vector4(-4.0f, 4.0f, 0.0f, -5.0f);
            Vector4 actual;

            actual = MathOps.Subtract(a, b);

            Assert.AreEqual(expected, actual);
        }

        // A test for UnitW
        [Test]
        public void Vector4UnitWTest()
        {
            var val = new Vector4(0.0f, 0.0f, 0.0f, 1.0f);
            Assert.AreEqual(val, Vector4.UnitW);
        }

        // A test for UnitX
        [Test]
        public void Vector4UnitXTest()
        {
            var val = new Vector4(1.0f, 0.0f, 0.0f, 0.0f);
            Assert.AreEqual(val, Vector4.UnitX);
        }

        // A test for UnitY
        [Test]
        public void Vector4UnitYTest()
        {
            var val = new Vector4(0.0f, 1.0f, 0.0f, 0.0f);
            Assert.AreEqual(val, Vector4.UnitY);
        }

        // A test for UnitZ
        [Test]
        public void Vector4UnitZTest()
        {
            var val = new Vector4(0.0f, 0.0f, 1.0f, 0.0f);
            Assert.AreEqual(val, Vector4.UnitZ);
        }

        // A test for One
        [Test]
        public void Vector4OneTest()
        {
            var val = new Vector4(1.0f, 1.0f, 1.0f, 1.0f);
            Assert.AreEqual(val, Vector4.One);
        }

        // A test for Zero
        [Test]
        public void Vector4ZeroTest()
        {
            var val = new Vector4(0.0f, 0.0f, 0.0f, 0.0f);
            Assert.AreEqual(val, Vector4.Zero);
        }

        // A test for Equals (Vector4f)
        [Test]
        public void Vector4EqualsTest1()
        {
            var a = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);

            // case 1: compare between same values
            Assert.True(a.Equals(b));

            // case 2: compare between different values
            b = b.SetX(10.0f);
            Assert.False(a.Equals(b));
        }

        // A test for Vector4f (float)
        [Test]
        public void Vector4ConstructorTest6()
        {
            var value = 1.0f;
            var target = new Vector4(value);

            var expected = new Vector4(value, value, value, value);
            Assert.AreEqual(expected, target);

            value = 2.0f;
            target = new Vector4(value);
            expected = new Vector4(value, value, value, value);
            Assert.AreEqual(expected, target);
        }

        // A test for Vector4f comparison involving NaN values
        [Test]
        public void Vector4EqualsNanTest()
        {
            var a = new Vector4(float.NaN, 0, 0, 0);
            var b = new Vector4(0, float.NaN, 0, 0);
            var c = new Vector4(0, 0, float.NaN, 0);
            var d = new Vector4(0, 0, 0, float.NaN);

            Assert.False(a == Vector4.Zero);
            Assert.False(b == Vector4.Zero);
            Assert.False(c == Vector4.Zero);
            Assert.False(d == Vector4.Zero);

            Assert.True(a != Vector4.Zero);
            Assert.True(b != Vector4.Zero);
            Assert.True(c != Vector4.Zero);
            Assert.True(d != Vector4.Zero);

            Assert.False(a.Equals(Vector4.Zero));
            Assert.False(b.Equals(Vector4.Zero));
            Assert.False(c.Equals(Vector4.Zero));
            Assert.False(d.Equals(Vector4.Zero));

            // Counterintuitive result - IEEE rules for NaN comparison are weird!
            Assert.False(a.Equals(a));
            Assert.False(b.Equals(b));
            Assert.False(c.Equals(c));
            Assert.False(d.Equals(d));
        }

        [Test]
        public void Vector4AbsTest()
        {
            var v1 = new Vector4(-2.5f, 2.0f, 3.0f, 3.3f);
            var v3 = MathOps.Abs(new Vector4(float.PositiveInfinity, 0.0f, float.NegativeInfinity, float.NaN));
            var v = MathOps.Abs(v1);
            Assert.AreEqual(2.5f, v.X);
            Assert.AreEqual(2.0f, v.Y);
            Assert.AreEqual(3.0f, v.Z);
            Assert.AreEqual(3.3f, v.W);
            Assert.AreEqual(float.PositiveInfinity, v3.X);
            Assert.AreEqual(0.0f, v3.Y);
            Assert.AreEqual(float.PositiveInfinity, v3.Z);
            Assert.AreEqual(float.NaN, v3.W);
        }

        [Test]
        public void Vector4SqrtTest()
        {
            var v1 = new Vector4(-2.5f, 2.0f, 3.0f, 3.3f);
            var v2 = new Vector4(5.5f, 4.5f, 6.5f, 7.5f);
            Assert.AreEqual(2, (int)MathOps.SquareRoot(v2).X);
            Assert.AreEqual(2, (int)MathOps.SquareRoot(v2).Y);
            Assert.AreEqual(2, (int)MathOps.SquareRoot(v2).Z);
            Assert.AreEqual(2, (int)MathOps.SquareRoot(v2).W);
            Assert.AreEqual(float.NaN, MathOps.SquareRoot(v1).X);
        }

        [StructLayout(LayoutKind.Sequential)]
        struct Vector4_2x
        {
            private Vector4 _a;
            private Vector4 _b;
        }

        [StructLayout(LayoutKind.Sequential)]
        struct Vector4PlusFloat
        {
            private Vector4 _v;
            private float _f;
        }

        // Contrived test for strangely-sized and shaped embedded structures, with unused buffer fields.
#pragma warning disable 0169
        private struct DeeplyEmbeddedStruct
        {
            public static DeeplyEmbeddedStruct Create()
            {
                var obj = new DeeplyEmbeddedStruct();
                obj.L0 = new Level0();
                obj.L0.L1 = new Level0.Level1();
                obj.L0.L1.L2 = new Level0.Level1.Level2();
                obj.L0.L1.L2.L3 = new Level0.Level1.Level2.Level3();
                obj.L0.L1.L2.L3.L4 = new Level0.Level1.Level2.Level3.Level4();
                obj.L0.L1.L2.L3.L4.L5 = new Level0.Level1.Level2.Level3.Level4.Level5();
                obj.L0.L1.L2.L3.L4.L5.L6 = new Level0.Level1.Level2.Level3.Level4.Level5.Level6();
                obj.L0.L1.L2.L3.L4.L5.L6.L7 = new Level0.Level1.Level2.Level3.Level4.Level5.Level6.Level7();
                obj.L0.L1.L2.L3.L4.L5.L6.L7.EmbeddedVector = new Vector4(1, 5, 1, -5);

                return obj;
            }

            public Level0 L0;
            public Vector4 RootEmbeddedObject => L0.L1.L2.L3.L4.L5.L6.L7.EmbeddedVector;

            public struct Level0
            {
                private float _buffer0, _buffer1;
                public Level1 L1;
                private float _buffer2;
                public struct Level1
                {
                    private float _buffer0, _buffer1;
                    public Level2 L2;
                    private byte _buffer2;
                    public struct Level2
                    {
                        public Level3 L3;
                        private float _buffer0;
                        private byte _buffer1;
                        public struct Level3
                        {
                            public Level4 L4;
                            public struct Level4
                            {
                                private float _buffer0;
                                public Level5 L5;
                                private long _buffer1;
                                private byte _buffer2;
                                private double _buffer3;
                                public struct Level5
                                {
                                    private byte _buffer0;
                                    public Level6 L6;
                                    public struct Level6
                                    {
                                        private byte _buffer0;
                                        public Level7 L7;
                                        private byte _buffer1, _buffer2;
                                        public struct Level7
                                        {
                                            public Vector4 EmbeddedVector;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
#pragma warning restore 0169
    }
}
