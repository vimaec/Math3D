// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System.Runtime.InteropServices;
using NUnit.Framework;

namespace Vim.Math3d.Tests
{
    public class Vector3Tests
    {
        [Test]
        public void Vector3MarshalSizeTest()
        {
            Assert.AreEqual(12, Marshal.SizeOf<Vector3>());
            Assert.AreEqual(12, Marshal.SizeOf<Vector3>(new Vector3()));
        }

        [Test]
        public void Vector3GetHashCodeTest()
        {
            var v1 = new Vector3(2.0f, 3.0f, 3.3f);
            var v2 = new Vector3(2.0f, 3.0f, 3.3f);
            var v3 = new Vector3(2.0f, 3.0f, 3.3f);
            var v5 = new Vector3(3.0f, 2.0f, 3.3f);
            Assert.AreEqual(v1.GetHashCode(), v1.GetHashCode());
            Assert.AreEqual(v1.GetHashCode(), v2.GetHashCode());
            Assert.AreNotEqual(v1.GetHashCode(), v5.GetHashCode());
            Assert.AreEqual(v1.GetHashCode(), v3.GetHashCode());
            var v4 = new Vector3(0.0f, 0.0f, 0.0f);
            var v6 = new Vector3(1.0f, 0.0f, 0.0f);
            var v7 = new Vector3(0.0f, 1.0f, 0.0f);
            var v8 = new Vector3(1.0f, 1.0f, 1.0f);
            var v9 = new Vector3(1.0f, 1.0f, 0.0f);
            Assert.AreNotEqual(v4.GetHashCode(), v6.GetHashCode());
            Assert.AreNotEqual(v4.GetHashCode(), v7.GetHashCode());
            Assert.AreNotEqual(v4.GetHashCode(), v8.GetHashCode());
            Assert.AreNotEqual(v7.GetHashCode(), v6.GetHashCode());
            Assert.AreNotEqual(v8.GetHashCode(), v6.GetHashCode());
            Assert.AreNotEqual(v8.GetHashCode(), v9.GetHashCode());
            Assert.AreNotEqual(v7.GetHashCode(), v9.GetHashCode());
        }

        // A test for Cross (Vector3f, Vector3f)
        [Test]
        public void Vector3CrossTest()
        {
            var a = new Vector3(1.0f, 0.0f, 0.0f);
            var b = new Vector3(0.0f, 1.0f, 0.0f);

            var expected = new Vector3(0.0f, 0.0f, 1.0f);
            Vector3 actual;

            actual = MathOps.Cross(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Cross did not return the expected value.");
        }

        // A test for Cross (Vector3f, Vector3f)
        // Cross test of the same vector
        [Test]
        public void Vector3CrossTest1()
        {
            var a = new Vector3(0.0f, 1.0f, 0.0f);
            var b = new Vector3(0.0f, 1.0f, 0.0f);

            var expected = new Vector3(0.0f, 0.0f, 0.0f);
            var actual = MathOps.Cross(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Cross did not return the expected value.");
        }

        // A test for Distance (Vector3f, Vector3f)
        [Test]
        public void Vector3DistanceTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var expected = (float)System.Math.Sqrt(27);
            float actual;

            actual = MathOps.Distance(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Distance did not return the expected value.");
        }

        // A test for Distance (Vector3f, Vector3f)
        // Distance from the same point
        [Test]
        public void Vector3DistanceTest1()
        {
            var a = new Vector3(1.051f, 2.05f, 3.478f);
            var b = new Vector3(1.051f, 2.05f, 3.478f);

            var actual = MathOps.Distance(a, b);
            Assert.AreEqual(0.0f, actual);
        }

        // A test for DistanceSquared (Vector3f, Vector3f)
        [Test]
        public void Vector3DistanceSquaredTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var expected = 27.0f;
            float actual;

            actual = MathOps.DistanceSquared(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.DistanceSquared did not return the expected value.");
        }

        // A test for Dot (Vector3f, Vector3f)
        [Test]
        public void Vector3DotTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var expected = 32.0f;
            float actual;

            actual = MathOps.Dot(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Dot did not return the expected value.");
        }

        // A test for Dot (Vector3f, Vector3f)
        // Dot test for perpendicular vector
        [Test]
        public void Vector3DotTest1()
        {
            var a = new Vector3(1.55f, 1.55f, 1);
            var b = new Vector3(2.5f, 3, 1.5f);
            var c = MathOps.Cross(a, b);

            var expected = 0.0f;
            var actual1 = MathOps.Dot(a, c);
            var actual2 = MathOps.Dot(b, c);
            Assert.True(MathHelper.Equal(expected, actual1), "Vector3f.Dot did not return the expected value.");
            Assert.True(MathHelper.Equal(expected, actual2), "Vector3f.Dot did not return the expected value.");
        }

        // A test for Length ()
        [Test]
        public void Vector3LengthTest()
        {
            var a = new Vector2(1.0f, 2.0f);

            var z = 3.0f;

            var target = new Vector3(a, z);

            var expected = (float)System.Math.Sqrt(14.0f);
            float actual;

            actual = target.Length();
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Length did not return the expected value.");
        }

        // A test for Length ()
        // Length test where length is zero
        [Test]
        public void Vector3LengthTest1()
        {
            var target = new Vector3();

            var expected = 0.0f;
            var actual = target.Length();
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Length did not return the expected value.");
        }

        // A test for LengthSquared ()
        [Test]
        public void Vector3LengthSquaredTest()
        {
            var a = new Vector2(1.0f, 2.0f);

            var z = 3.0f;

            var target = new Vector3(a, z);

            var expected = 14.0f;
            float actual;

            actual = target.LengthSquared();
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.LengthSquared did not return the expected value.");
        }

        // A test for Min (Vector3f, Vector3f)
        [Test]
        public void Vector3MinTest()
        {
            var a = new Vector3(-1.0f, 4.0f, -3.0f);
            var b = new Vector3(2.0f, 1.0f, -1.0f);

            var expected = new Vector3(-1.0f, 1.0f, -3.0f);
            Vector3 actual;
            actual = MathOps.Min(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Min did not return the expected value.");
        }

        // A test for Max (Vector3f, Vector3f)
        [Test]
        public void Vector3MaxTest()
        {
            var a = new Vector3(-1.0f, 4.0f, -3.0f);
            var b = new Vector3(2.0f, 1.0f, -1.0f);

            var expected = new Vector3(2.0f, 4.0f, -1.0f);
            Vector3 actual;
            actual = MathOps.Max(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "MathOps.Max did not return the expected value.");
        }

        [Test]
        public void Vector3MinMaxCodeCoverageTest()
        {
            var min = Vector3.Zero;
            var max = Vector3.One;
            Vector3 actual;

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

        // A test for Lerp (Vector3f, Vector3f, float)
        [Test]
        public void Vector3LerpTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var t = 0.5f;

            var expected = new Vector3(2.5f, 3.5f, 4.5f);
            Vector3 actual;

            actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector3f, Vector3f, float)
        // Lerp test with factor zero
        [Test]
        public void Vector3LerpTest1()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var t = 0.0f;
            var expected = new Vector3(1.0f, 2.0f, 3.0f);
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector3f, Vector3f, float)
        // Lerp test with factor one
        [Test]
        public void Vector3LerpTest2()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var t = 1.0f;
            var expected = new Vector3(4.0f, 5.0f, 6.0f);
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector3f, Vector3f, float)
        // Lerp test with factor > 1
        [Test]
        public void Vector3LerpTest3()
        {
            var a = new Vector3(0.0f, 0.0f, 0.0f);
            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var t = 2.0f;
            var expected = new Vector3(8.0f, 10.0f, 12.0f);
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector3f, Vector3f, float)
        // Lerp test with factor < 0
        [Test]
        public void Vector3LerpTest4()
        {
            var a = new Vector3(0.0f, 0.0f, 0.0f);
            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var t = -2.0f;
            var expected = new Vector3(-8.0f, -10.0f, -12.0f);
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector3f, Vector3f, float)
        // Lerp test from the same point
        [Test]
        public void Vector3LerpTest5()
        {
            var a = new Vector3(1.68f, 2.34f, 5.43f);
            var b = a;

            var t = 0.18f;
            var expected = new Vector3(1.68f, 2.34f, 5.43f);
            var actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Lerp did not return the expected value.");
        }

        // A test for Reflect (Vector3f, Vector3f)
        [Test]
        public void Vector3ReflectTest()
        {
            var a = MathOps.Normalize(new Vector3(1.0f, 1.0f, 1.0f));

            // Reflect on XZ plane.
            var n = new Vector3(0.0f, 1.0f, 0.0f);
            var expected = new Vector3(a.X, -a.Y, a.Z);
            var actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Reflect did not return the expected value.");

            // Reflect on XY plane.
            n = new Vector3(0.0f, 0.0f, 1.0f);
            expected = new Vector3(a.X, a.Y, -a.Z);
            actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Reflect did not return the expected value.");

            // Reflect on YZ plane.
            n = new Vector3(1.0f, 0.0f, 0.0f);
            expected = new Vector3(-a.X, a.Y, a.Z);
            actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Reflect did not return the expected value.");
        }

        // A test for Reflect (Vector3f, Vector3f)
        // Reflection when normal and source are the same
        [Test]
        public void Vector3ReflectTest1()
        {
            var n = new Vector3(0.45f, 1.28f, 0.86f);
            n = MathOps.Normalize(n);
            var a = n;

            var expected = -n;
            var actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Reflect did not return the expected value.");
        }

        // A test for Reflect (Vector3f, Vector3f)
        // Reflection when normal and source are negation
        [Test]
        public void Vector3ReflectTest2()
        {
            var n = new Vector3(0.45f, 1.28f, 0.86f);
            n = MathOps.Normalize(n);
            var a = -n;

            var expected = n;
            var actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Reflect did not return the expected value.");
        }

        // A test for Reflect (Vector3f, Vector3f)
        // Reflection when normal and source are perpendicular (a dot n = 0)
        [Test]
        public void Vector3ReflectTest3()
        {
            var n = new Vector3(0.45f, 1.28f, 0.86f);
            var temp = new Vector3(1.28f, 0.45f, 0.01f);
            // find a perpendicular vector of n
            var a = MathOps.Cross(temp, n);

            var expected = a;
            var actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Reflect did not return the expected value.");
        }

        // A test for Transform(Vector3f, Matrix4x4)
        [Test]
        public void Vector3TransformTest()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            var expected = new Vector3(12.191987f, 21.533493f, 32.616024f);
            Vector3 actual;

            actual = v.Transform(m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Transform did not return the expected value.");
        }

        // A test for Clamp (Vector3f, Vector3f, Vector3f)
        [Test]
        public void Vector3ClampTest()
        {
            var a = new Vector3(0.5f, 0.3f, 0.33f);
            var min = new Vector3(0.0f, 0.1f, 0.13f);
            var max = new Vector3(1.0f, 1.1f, 1.13f);

            // Normal case.
            // Case N1: specified value is in the range.
            var expected = new Vector3(0.5f, 0.3f, 0.33f);
            var actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Clamp did not return the expected value.");

            // Normal case.
            // Case N2: specified value is bigger than max value.
            a = new Vector3(2.0f, 3.0f, 4.0f);
            expected = max;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Clamp did not return the expected value.");

            // Case N3: specified value is smaller than max value.
            a = new Vector3(-2.0f, -3.0f, -4.0f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Clamp did not return the expected value.");

            // Case N4: combination case.
            a = new Vector3(-2.0f, 0.5f, 4.0f);
            expected = new Vector3(min.X, a.Y, max.Z);
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Clamp did not return the expected value.");

            // User specified min value is bigger than max value.
            max = new Vector3(0.0f, 0.1f, 0.13f);
            min = new Vector3(1.0f, 1.1f, 1.13f);

            // Case W1: specified value is in the range.
            a = new Vector3(0.5f, 0.3f, 0.33f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Clamp did not return the expected value.");

            // Normal case.
            // Case W2: specified value is bigger than max and min value.
            a = new Vector3(2.0f, 3.0f, 4.0f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Clamp did not return the expected value.");

            // Case W3: specified value is smaller than min and max value.
            a = new Vector3(-2.0f, -3.0f, -4.0f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Clamp did not return the expected value.");
        }

        // A test for TransformNormal (Vector3f, Matrix4x4)
        [Test]
        public void Vector3TransformNormalTest()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            var expected = new Vector3(2.19198728f, 1.53349364f, 2.61602545f);
            Vector3 actual;

            actual = MathOps.TransformNormal(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.TransformNormal did not return the expected value.");
        }

        // A test for Transform (Vector3f, Quaternion)
        [Test]
        public void Vector3TransformByQuaternionTest()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            var q = Quaternion.CreateFromRotationMatrix(m);

            var expected = v.Transform(m);
            var actual = v.Transform(q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Quaternion)
        // Transform vector3 with zero quaternion
        [Test]
        public void Vector3TransformByQuaternionTest1()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var q = new Quaternion();
            var expected = v;

            var actual = MathOps.Transform(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector3f, Quaternion)
        // Transform vector3 with identity quaternion
        [Test]
        public void Vector3TransformByQuaternionTest2()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var q = Quaternion.Identity;
            var expected = v;

            var actual = MathOps.Transform(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Transform did not return the expected value.");
        }

        // A test for Normalize (Vector3f)
        [Test]
        public void Vector3NormalizeTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);

            var expected = new Vector3(
                0.26726124191242438468455348087975f,
                0.53452248382484876936910696175951f,
                0.80178372573727315405366044263926f);
            Vector3 actual;

            actual = MathOps.Normalize(a);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Normalize did not return the expected value.");
        }

        // A test for Normalize (Vector3f)
        // Normalize vector of length one
        [Test]
        public void Vector3NormalizeTest1()
        {
            var a = new Vector3(1.0f, 0.0f, 0.0f);

            var expected = new Vector3(1.0f, 0.0f, 0.0f);
            var actual = MathOps.Normalize(a);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Normalize did not return the expected value.");
        }

        // A test for Normalize (Vector3f)
        // Normalize vector of length zero
        [Test]
        public void Vector3NormalizeTest2()
        {
            var a = new Vector3(0.0f, 0.0f, 0.0f);

            var expected = new Vector3(0.0f, 0.0f, 0.0f);
            var actual = MathOps.Normalize(a);
            Assert.True(float.IsNaN(actual.X) && float.IsNaN(actual.Y) && float.IsNaN(actual.Z), "Vector3f.Normalize did not return the expected value.");
        }

        // A test for operator - (Vector3f)
        [Test]
        public void Vector3UnaryNegationTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);

            var expected = new Vector3(-1.0f, -2.0f, -3.0f);
            Vector3 actual;

            actual = -a;

            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.operator - did not return the expected value.");
        }

        [Test]
        public void Vector3UnaryNegationTest1()
        {
            var a = -new Vector3(float.NaN, float.PositiveInfinity, float.NegativeInfinity);
            var b = -new Vector3(0.0f, 0.0f, 0.0f);
            Assert.AreEqual(float.NaN, a.X);
            Assert.AreEqual(float.NegativeInfinity, a.Y);
            Assert.AreEqual(float.PositiveInfinity, a.Z);
            Assert.AreEqual(0.0f, b.X);
            Assert.AreEqual(0.0f, b.Y);
            Assert.AreEqual(0.0f, b.Z);
        }

        // A test for operator - (Vector3f, Vector3f)
        [Test]
        public void Vector3SubtractionTest()
        {
            var a = new Vector3(4.0f, 2.0f, 3.0f);

            var b = new Vector3(1.0f, 5.0f, 7.0f);

            var expected = new Vector3(3.0f, -3.0f, -4.0f);
            Vector3 actual;

            actual = a - b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.operator - did not return the expected value.");
        }

        // A test for operator * (Vector3f, float)
        [Test]
        public void Vector3MultiplyOperatorTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);

            var factor = 2.0f;

            var expected = new Vector3(2.0f, 4.0f, 6.0f);
            Vector3 actual;

            actual = a * factor;

            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.operator * did not return the expected value.");
        }

        // A test for operator * (float, Vector3f)
        [Test]
        public void Vector3MultiplyOperatorTest2()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);

            const float factor = 2.0f;

            var expected = new Vector3(2.0f, 4.0f, 6.0f);
            Vector3 actual;

            actual = factor * a;

            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.operator * did not return the expected value.");
        }

        // A test for operator * (Vector3f, Vector3f)
        [Test]
        public void Vector3MultiplyOperatorTest3()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);

            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var expected = new Vector3(4.0f, 10.0f, 18.0f);
            Vector3 actual;

            actual = a * b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.operator * did not return the expected value.");
        }

        // A test for operator / (Vector3f, float)
        [Test]
        public void Vector3DivisionTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);

            var div = 2.0f;

            var expected = new Vector3(0.5f, 1.0f, 1.5f);
            Vector3 actual;

            actual = a / div;

            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.operator / did not return the expected value.");
        }

        // A test for operator / (Vector3f, Vector3f)
        [Test]
        public void Vector3DivisionTest1()
        {
            var a = new Vector3(4.0f, 2.0f, 3.0f);

            var b = new Vector3(1.0f, 5.0f, 6.0f);

            var expected = new Vector3(4.0f, 0.4f, 0.5f);
            Vector3 actual;

            actual = a / b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.operator / did not return the expected value.");
        }

        // A test for operator / (Vector3f, Vector3f)
        // Divide by zero
        [Test]
        public void Vector3DivisionTest2()
        {
            var a = new Vector3(-2.0f, 3.0f, float.MaxValue);

            var div = 0.0f;

            var actual = a / div;

            Assert.True(float.IsNegativeInfinity(actual.X), "Vector3f.operator / did not return the expected value.");
            Assert.True(float.IsPositiveInfinity(actual.Y), "Vector3f.operator / did not return the expected value.");
            Assert.True(float.IsPositiveInfinity(actual.Z), "Vector3f.operator / did not return the expected value.");
        }

        // A test for operator / (Vector3f, Vector3f)
        // Divide by zero
        [Test]
        public void Vector3DivisionTest3()
        {
            var a = new Vector3(0.047f, -3.0f, float.NegativeInfinity);
            var b = new Vector3();

            var actual = a / b;

            Assert.True(float.IsPositiveInfinity(actual.X), "Vector3f.operator / did not return the expected value.");
            Assert.True(float.IsNegativeInfinity(actual.Y), "Vector3f.operator / did not return the expected value.");
            Assert.True(float.IsNegativeInfinity(actual.Z), "Vector3f.operator / did not return the expected value.");
        }

        // A test for operator + (Vector3f, Vector3f)
        [Test]
        public void Vector3AdditionTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(4.0f, 5.0f, 6.0f);

            var expected = new Vector3(5.0f, 7.0f, 9.0f);
            Vector3 actual;

            actual = a + b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.operator + did not return the expected value.");
        }

        // A test for Vector3f (float, float, float)
        [Test]
        public void Vector3ConstructorTest()
        {
            var x = 1.0f;
            var y = 2.0f;
            var z = 3.0f;

            var target = new Vector3(x, y, z);
            Assert.True(MathHelper.Equal(target.X, x) && MathHelper.Equal(target.Y, y) && MathHelper.Equal(target.Z, z), "Vector3f.constructor (x,y,z) did not return the expected value.");
        }

        // A test for Vector3f (Vector2f, float)
        [Test]
        public void Vector3ConstructorTest1()
        {
            var a = new Vector2(1.0f, 2.0f);

            var z = 3.0f;

            var target = new Vector3(a, z);
            Assert.True(MathHelper.Equal(target.X, a.X) && MathHelper.Equal(target.Y, a.Y) && MathHelper.Equal(target.Z, z), "Vector3f.constructor (Vector2f,z) did not return the expected value.");
        }

        // A test for Vector3f ()
        // Constructor with no parameter
        [Test]
        public void Vector3ConstructorTest3()
        {
            var a = new Vector3();

            Assert.AreEqual(a.X, 0.0f);
            Assert.AreEqual(a.Y, 0.0f);
            Assert.AreEqual(a.Z, 0.0f);
        }

        // A test for Vector2f (float, float)
        // Constructor with special floating values
        [Test]
        public void Vector3ConstructorTest4()
        {
            var target = new Vector3(float.NaN, float.MaxValue, float.PositiveInfinity);

            Assert.True(float.IsNaN(target.X), "Vector3f.constructor (Vector3f) did not return the expected value.");
            Assert.True(float.Equals(float.MaxValue, target.Y), "Vector3f.constructor (Vector3f) did not return the expected value.");
            Assert.True(float.IsPositiveInfinity(target.Z), "Vector3f.constructor (Vector3f) did not return the expected value.");
        }

        // A test for Add (Vector3f, Vector3f)
        [Test]
        public void Vector3AddTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(5.0f, 6.0f, 7.0f);

            var expected = new Vector3(6.0f, 8.0f, 10.0f);
            Vector3 actual;

            actual = MathOps.Add(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Divide (Vector3f, float)
        [Test]
        public void Vector3DivideTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var div = 2.0f;
            var expected = new Vector3(0.5f, 1.0f, 1.5f);
            Assert.AreEqual(expected, a / div);
        }

        // A test for Divide (Vector3f, Vector3f)
        [Test]
        public void Vector3DivideTest1()
        {
            var a = new Vector3(1.0f, 6.0f, 7.0f);
            var b = new Vector3(5.0f, 2.0f, 3.0f);

            var expected = new Vector3(1.0f / 5.0f, 6.0f / 2.0f, 7.0f / 3.0f);
            Vector3 actual;

            actual = MathOps.Divide(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Equals (object)
        [Test]
        public void Vector3EqualsTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(1.0f, 2.0f, 3.0f);

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

        // A test for Multiply (Vector3f, float)
        [Test]
        public void Vector3MultiplyTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            const float factor = 2.0f;
            var expected = new Vector3(2.0f, 4.0f, 6.0f);
            Assert.AreEqual(expected, a * factor);
        }

        // A test for Multiply (float, Vector3f)
        [Test]
        public static void Vector3MultiplyTest2()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            const float factor = 2.0f;
            var expected = new Vector3(2.0f, 4.0f, 6.0f);
            Assert.AreEqual(expected, factor * a);
        }

        // A test for Multiply (Vector3f, Vector3f)
        [Test]
        public void Vector3MultiplyTest3()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(5.0f, 6.0f, 7.0f);

            var expected = new Vector3(5.0f, 12.0f, 21.0f);
            Vector3 actual;

            actual = MathOps.Multiply(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Negate (Vector3f)
        [Test]
        public void Vector3NegateTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);

            var expected = new Vector3(-1.0f, -2.0f, -3.0f);
            Vector3 actual;

            actual = MathOps.Negate(a);
            Assert.AreEqual(expected, actual);
        }

        // A test for operator != (Vector3f, Vector3f)
        [Test]
        public void Vector3InequalityTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(1.0f, 2.0f, 3.0f);

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

        // A test for operator == (Vector3f, Vector3f)
        [Test]
        public void Vector3EqualityTest()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(1.0f, 2.0f, 3.0f);

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

        // A test for Subtract (Vector3f, Vector3f)
        [Test]
        public void Vector3SubtractTest()
        {
            var a = new Vector3(1.0f, 6.0f, 3.0f);
            var b = new Vector3(5.0f, 2.0f, 3.0f);

            var expected = new Vector3(-4.0f, 4.0f, 0.0f);
            Vector3 actual;

            actual = MathOps.Subtract(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for One
        [Test]
        public void Vector3OneTest()
        {
            var val = new Vector3(1.0f, 1.0f, 1.0f);
            Assert.AreEqual(val, Vector3.One);
        }

        // A test for UnitX
        [Test]
        public void Vector3UnitXTest()
        {
            var val = new Vector3(1.0f, 0.0f, 0.0f);
            Assert.AreEqual(val, Vector3.UnitX);
        }

        // A test for UnitY
        [Test]
        public void Vector3UnitYTest()
        {
            var val = new Vector3(0.0f, 1.0f, 0.0f);
            Assert.AreEqual(val, Vector3.UnitY);
        }

        // A test for UnitZ
        [Test]
        public void Vector3UnitZTest()
        {
            var val = new Vector3(0.0f, 0.0f, 1.0f);
            Assert.AreEqual(val, Vector3.UnitZ);
        }

        // A test for Zero
        [Test]
        public void Vector3ZeroTest()
        {
            var val = new Vector3(0.0f, 0.0f, 0.0f);
            Assert.AreEqual(val, Vector3.Zero);
        }

        // A test for Equals (Vector3f)
        [Test]
        public void Vector3EqualsTest1()
        {
            var a = new Vector3(1.0f, 2.0f, 3.0f);
            var b = new Vector3(1.0f, 2.0f, 3.0f);

            // case 1: compare between same values
            var expected = true;
            var actual = a.Equals(b);
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10f);
            expected = false;
            actual = a.Equals(b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Vector3f (float)
        [Test]
        public void Vector3ConstructorTest5()
        {
            var value = 1.0f;
            var target = new Vector3(value);

            var expected = new Vector3(value, value, value);
            Assert.AreEqual(expected, target);

            value = 2.0f;
            target = new Vector3(value);
            expected = new Vector3(value, value, value);
            Assert.AreEqual(expected, target);
        }

        // A test for Vector3f comparison involving NaN values
        [Test]
        public void Vector3EqualsNanTest()
        {
            var a = new Vector3(float.NaN, 0, 0);
            var b = new Vector3(0, float.NaN, 0);
            var c = new Vector3(0, 0, float.NaN);

            Assert.False(a == Vector3.Zero);
            Assert.False(b == Vector3.Zero);
            Assert.False(c == Vector3.Zero);

            Assert.True(a != Vector3.Zero);
            Assert.True(b != Vector3.Zero);
            Assert.True(c != Vector3.Zero);

            Assert.False(a.Equals(Vector3.Zero));
            Assert.False(b.Equals(Vector3.Zero));
            Assert.False(c.Equals(Vector3.Zero));

            // Counterintuitive result - IEEE rules for NaN comparison are weird!
            Assert.False(a.Equals(a));
            Assert.False(b.Equals(b));
            Assert.False(c.Equals(c));
        }

        [Test]
        public void Vector3AbsTest()
        {
            var v1 = new Vector3(-2.5f, 2.0f, 0.5f);
            var v3 = MathOps.Abs(new Vector3(0.0f, float.NegativeInfinity, float.NaN));
            var v = MathOps.Abs(v1);
            Assert.AreEqual(2.5f, v.X);
            Assert.AreEqual(2.0f, v.Y);
            Assert.AreEqual(0.5f, v.Z);
            Assert.AreEqual(0.0f, v3.X);
            Assert.AreEqual(float.PositiveInfinity, v3.Y);
            Assert.AreEqual(float.NaN, v3.Z);
        }

        [Test]
        public void Vector3SqrtTest()
        {
            var a = new Vector3(-2.5f, 2.0f, 0.5f);
            var b = new Vector3(5.5f, 4.5f, 16.5f);
            Assert.AreEqual(2, (int)MathOps.SquareRoot(b).X);
            Assert.AreEqual(2, (int)MathOps.SquareRoot(b).Y);
            Assert.AreEqual(4, (int)MathOps.SquareRoot(b).Z);
            Assert.AreEqual(float.NaN, MathOps.SquareRoot(a).X);
        }

        [StructLayout(LayoutKind.Sequential)]
        struct Vector3_2x
        {
            private Vector3 _a;
            private Vector3 _b;
        }

        [StructLayout(LayoutKind.Sequential)]
        struct Vector3PlusFloat
        {
            private Vector3 _v;
            private float _f;
        }

        [StructLayout(LayoutKind.Sequential)]
        struct Vector3PlusFloat_2x
        {
            private Vector3PlusFloat _a;
            private Vector3PlusFloat _b;
        }
    }
}
