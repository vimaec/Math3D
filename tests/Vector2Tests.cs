// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System.Globalization;
using System.Runtime.InteropServices;
using NUnit.Framework;

namespace Vim.Tests
{
    public class Vector2Tests
    {
        [Test]
        public void Vector2MarshalSizeTest()
        {
            Assert.AreEqual(8, Marshal.SizeOf<Vector2>());
            Assert.AreEqual(8, Marshal.SizeOf<Vector2>(new Vector2()));
        }

        [Test]
        public void Vector2GetHashCodeTest()
        {
            Vector2 v1 = new Vector2(2.0f, 3.0f);
            Vector2 v2 = new Vector2(2.0f, 3.0f);
            Vector2 v3 = new Vector2(3.0f, 2.0f);
            Assert.AreEqual(v1.GetHashCode(), v1.GetHashCode());
            Assert.AreEqual(v1.GetHashCode(), v2.GetHashCode());
            Assert.AreNotEqual(v1.GetHashCode(), v3.GetHashCode());
            Vector2 v4 = new Vector2(0.0f, 0.0f);
            Vector2 v6 = new Vector2(1.0f, 0.0f);
            Vector2 v7 = new Vector2(0.0f, 1.0f);
            Vector2 v8 = new Vector2(1.0f, 1.0f);
            Assert.AreNotEqual(v4.GetHashCode(), v6.GetHashCode());
            Assert.AreNotEqual(v4.GetHashCode(), v7.GetHashCode());
            Assert.AreNotEqual(v4.GetHashCode(), v8.GetHashCode());
            Assert.AreNotEqual(v7.GetHashCode(), v6.GetHashCode());
            Assert.AreNotEqual(v8.GetHashCode(), v6.GetHashCode());
            Assert.AreNotEqual(v8.GetHashCode(), v7.GetHashCode());
        }

        // A test for Distance (Vector2f, Vector2f)
        [Test]
        public void Vector2DistanceTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(3.0f, 4.0f);

            float expected = (float)System.Math.Sqrt(8);
            float actual;

            actual = MathOps.Distance(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Distance did not return the expected value.");
        }

        // A test for Distance (Vector2f, Vector2f)
        // Distance from the same point
        [Test]
        public void Vector2DistanceTest2()
        {
            Vector2 a = new Vector2(1.051f, 2.05f);
            Vector2 b = new Vector2(1.051f, 2.05f);

            float actual = MathOps.Distance(a, b);
            Assert.AreEqual(0.0f, actual);
        }

        // A test for DistanceSquared (Vector2f, Vector2f)
        [Test]
        public void Vector2DistanceSquaredTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(3.0f, 4.0f);

            float expected = 8.0f;
            float actual;

            actual = MathOps.DistanceSquared(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.DistanceSquared did not return the expected value.");
        }

        // A test for Dot (Vector2f, Vector2f)
        [Test]
        public void Vector2DotTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(3.0f, 4.0f);

            float expected = 11.0f;
            float actual;

            actual = MathOps.Dot(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Dot did not return the expected value.");
        }

        // A test for Dot (Vector2f, Vector2f)
        // Dot test for perpendicular vector
        [Test]
        public void Vector2DotTest1()
        {
            Vector2 a = new Vector2(1.55f, 1.55f);
            Vector2 b = new Vector2(-1.55f, 1.55f);

            float expected = 0.0f;
            float actual = MathOps.Dot(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Dot (Vector2f, Vector2f)
        // Dot test with specail float values
        [Test]
        public void Vector2DotTest2()
        {
            Vector2 a = new Vector2(float.MinValue, float.MinValue);
            Vector2 b = new Vector2(float.MaxValue, float.MaxValue);

            float actual = MathOps.Dot(a, b);
            Assert.True(float.IsNegativeInfinity(actual), "Vector2f.Dot did not return the expected value.");
        }

        // A test for Length ()
        [Test]
        public void Vector2LengthTest()
        {
            Vector2 a = new Vector2(2.0f, 4.0f);

            Vector2 target = a;

            float expected = (float)System.Math.Sqrt(20);
            float actual;

            actual = target.Length();

            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Length did not return the expected value.");
        }

        // A test for Length ()
        // Length test where length is zero
        [Test]
        public void Vector2LengthTest1()
        {
            Vector2 target = new Vector2(0.0f, 0.0f);

            float expected = 0.0f;
            float actual;

            actual = target.Length();

            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Length did not return the expected value.");
        }

        // A test for LengthSquared ()
        [Test]
        public void Vector2LengthSquaredTest()
        {
            Vector2 a = new Vector2(2.0f, 4.0f);

            Vector2 target = a;

            float expected = 20.0f;
            float actual;

            actual = target.LengthSquared();

            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.LengthSquared did not return the expected value.");
        }

        // A test for LengthSquared ()
        // LengthSquared test where the result is zero
        [Test]
        public void Vector2LengthSquaredTest1()
        {
            Vector2 a = new Vector2(0.0f, 0.0f);

            float expected = 0.0f;
            float actual = a.LengthSquared();

            Assert.AreEqual(expected, actual);
        }

        // A test for Min (Vector2f, Vector2f)
        [Test]
        public void Vector2MinTest()
        {
            Vector2 a = new Vector2(-1.0f, 4.0f);
            Vector2 b = new Vector2(2.0f, 1.0f);

            Vector2 expected = new Vector2(-1.0f, 1.0f);
            Vector2 actual;
            actual = MathOps.Min(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Min did not return the expected value.");
        }

        [Test]
        public void Vector2MinMaxCodeCoverageTest()
        {
            Vector2 min = new Vector2(0, 0);
            Vector2 max = new Vector2(1, 1);
            Vector2 actual;

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

        // A test for Max (Vector2f, Vector2f)
        [Test]
        public void Vector2MaxTest()
        {
            Vector2 a = new Vector2(-1.0f, 4.0f);
            Vector2 b = new Vector2(2.0f, 1.0f);

            Vector2 expected = new Vector2(2.0f, 4.0f);
            Vector2 actual;
            actual = MathOps.Max(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Max did not return the expected value.");
        }

        // A test for Clamp (Vector2f, Vector2f, Vector2f)
        [Test]
        public void Vector2ClampTest()
        {
            Vector2 a = new Vector2(0.5f, 0.3f);
            Vector2 min = new Vector2(0.0f, 0.1f);
            Vector2 max = new Vector2(1.0f, 1.1f);

            // Normal case.
            // Case N1: specified value is in the range.
            Vector2 expected = new Vector2(0.5f, 0.3f);
            Vector2 actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Clamp did not return the expected value.");
            // Normal case.
            // Case N2: specified value is bigger than max value.
            a = new Vector2(2.0f, 3.0f);
            expected = max;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Clamp did not return the expected value.");
            // Case N3: specified value is smaller than max value.
            a = new Vector2(-1.0f, -2.0f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Clamp did not return the expected value.");
            // Case N4: combination case.
            a = new Vector2(-2.0f, 4.0f);
            expected = new Vector2(min.X, max.Y);
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Clamp did not return the expected value.");
            // User specified min value is bigger than max value.
            max = new Vector2(0.0f, 0.1f);
            min = new Vector2(1.0f, 1.1f);

            // Case W1: specified value is in the range.
            a = new Vector2(0.5f, 0.3f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Clamp did not return the expected value.");

            // Normal case.
            // Case W2: specified value is bigger than max and min value.
            a = new Vector2(2.0f, 3.0f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Clamp did not return the expected value.");

            // Case W3: specified value is smaller than min and max value.
            a = new Vector2(-1.0f, -2.0f);
            expected = min;
            actual = MathOps.Clamp(a, min, max);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Clamp did not return the expected value.");
        }

        // A test for Lerp (Vector2f, Vector2f, float)
        [Test]
        public void Vector2LerpTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(3.0f, 4.0f);

            float t = 0.5f;

            Vector2 expected = new Vector2(2.0f, 3.0f);
            Vector2 actual;
            actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector2f, Vector2f, float)
        // Lerp test with factor zero
        [Test]
        public void Vector2LerpTest1()
        {
            Vector2 a = new Vector2(0.0f, 0.0f);
            Vector2 b = new Vector2(3.18f, 4.25f);

            float t = 0.0f;
            Vector2 expected = Vector2.Zero;
            Vector2 actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector2f, Vector2f, float)
        // Lerp test with factor one
        [Test]
        public void Vector2LerpTest2()
        {
            Vector2 a = new Vector2(0.0f, 0.0f);
            Vector2 b = new Vector2(3.18f, 4.25f);

            float t = 1.0f;
            Vector2 expected = new Vector2(3.18f, 4.25f);
            Vector2 actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector2f, Vector2f, float)
        // Lerp test with factor > 1
        [Test]
        public void Vector2LerpTest3()
        {
            Vector2 a = new Vector2(0.0f, 0.0f);
            Vector2 b = new Vector2(3.18f, 4.25f);

            float t = 2.0f;
            Vector2 expected = b * 2.0f;
            Vector2 actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector2f, Vector2f, float)
        // Lerp test with factor < 0
        [Test]
        public void Vector2LerpTest4()
        {
            Vector2 a = new Vector2(0.0f, 0.0f);
            Vector2 b = new Vector2(3.18f, 4.25f);

            float t = -2.0f;
            Vector2 expected = -(b * 2.0f);
            Vector2 actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector2f, Vector2f, float)
        // Lerp test with special float value
        [Test]
        public void Vector2LerpTest5()
        {
            Vector2 a = new Vector2(45.67f, 90.0f);
            Vector2 b = new Vector2(float.PositiveInfinity, float.NegativeInfinity);

            float t = 0.408f;
            Vector2 actual = MathOps.Lerp(a, b, t);
            Assert.True(float.IsPositiveInfinity(actual.X), "Vector2f.Lerp did not return the expected value.");
            Assert.True(float.IsNegativeInfinity(actual.Y), "Vector2f.Lerp did not return the expected value.");
        }

        // A test for Lerp (Vector2f, Vector2f, float)
        // Lerp test from the same point
        [Test]
        public void Vector2LerpTest6()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(1.0f, 2.0f);

            float t = 0.5f;

            Vector2 expected = new Vector2(1.0f, 2.0f);
            Vector2 actual = MathOps.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Lerp did not return the expected value.");
        }

        // A test for Transform(Vector2f, Matrix4x4)
        [Test]
        public void Vector2TransformTest()
        {
            Vector2 v = new Vector2(1.0f, 2.0f);
            Matrix4x4 m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            Vector2 expected = new Vector2(10.316987f, 22.183012f);
            Vector2 actual;

            actual = MathOps.Transform(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Transform did not return the expected value.");
        }

        // A test for TransformNormal (Vector2f, Matrix4x4)
        [Test]
        public void Vector2TransformNormalTest()
        {
            Vector2 v = new Vector2(1.0f, 2.0f);
            Matrix4x4 m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            Vector2 expected = new Vector2(0.3169873f, 2.18301272f);
            Vector2 actual;

            actual = MathOps.TransformNormal(v, m);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Tranform did not return the expected value.");
        }

        // A test for Transform (Vector2f, Quaternion)
        [Test]
        public void Vector2TransformByQuaternionTest()
        {
            Vector2 v = new Vector2(1.0f, 2.0f);

            Matrix4x4 m =
                Matrix4x4.CreateRotationX(30f.ToRadians()) *
                Matrix4x4.CreateRotationY(30f.ToRadians()) *
                Matrix4x4.CreateRotationZ(30f.ToRadians());
            Quaternion q = Quaternion.CreateFromRotationMatrix(m);

            Vector2 expected = MathOps.Transform(v, m);
            Vector2 actual = MathOps.Transform(v, q);
            Assert.True(expected.AlmostEquals(actual));
        }

        // A test for Transform (Vector2f, Quaternion)
        // Transform Vector2f with zero quaternion
        [Test]
        public void Vector2TransformByQuaternionTest1()
        {
            Vector2 v = new Vector2(1.0f, 2.0f);
            Quaternion q = new Quaternion();
            Vector2 expected = v;

            Vector2 actual = MathOps.Transform(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Transform did not return the expected value.");
        }

        // A test for Transform (Vector2f, Quaternion)
        // Transform Vector2f with identity quaternion
        [Test]
        public void Vector2TransformByQuaternionTest2()
        {
            Vector2 v = new Vector2(1.0f, 2.0f);
            Quaternion q = Quaternion.Identity;
            Vector2 expected = v;

            Vector2 actual = MathOps.Transform(v, q);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Transform did not return the expected value.");
        }

        // A test for Normalize (Vector2f)
        [Test]
        public void Vector2NormalizeTest()
        {
            Vector2 a = new Vector2(2.0f, 3.0f);
            Vector2 expected = new Vector2(0.554700196225229122018341733457f, 0.8320502943378436830275126001855f);
            Assert.AreEqual(a.Normalize(), expected);
        }

        // A test for Normalize (Vector2f)
        // Normalize zero length vector
        [Test]
        public void Vector2NormalizeTest1()
        {
            Vector2 a = new Vector2(); // no parameter, default to 0.0f
            Vector2 actual = MathOps.Normalize(a);
            Assert.True(float.IsNaN(actual.X) && float.IsNaN(actual.Y), "Vector2f.Normalize did not return the expected value.");
        }

        // A test for Normalize (Vector2f)
        // Normalize infinite length vector
        [Test]
        public void Vector2NormalizeTest2()
        {
            Vector2 a = new Vector2(float.MaxValue, float.MaxValue);
            Vector2 actual = MathOps.Normalize(a);
            Vector2 expected = new Vector2(0, 0);
            Assert.AreEqual(expected, actual);
        }

        // A test for operator - (Vector2f)
        [Test]
        public void Vector2UnaryNegationTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);

            Vector2 expected = new Vector2(-1.0f, -2.0f);
            Vector2 actual;

            actual = -a;

            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.operator - did not return the expected value.");
        }



        // A test for operator - (Vector2f)
        // Negate test with special float value
        [Test]
        public void Vector2UnaryNegationTest1()
        {
            Vector2 a = new Vector2(float.PositiveInfinity, float.NegativeInfinity);

            Vector2 actual = -a;

            Assert.True(float.IsNegativeInfinity(actual.X), "Vector2f.operator - did not return the expected value.");
            Assert.True(float.IsPositiveInfinity(actual.Y), "Vector2f.operator - did not return the expected value.");
        }

        // A test for operator - (Vector2f)
        // Negate test with special float value
        [Test]
        public void Vector2UnaryNegationTest2()
        {
            Vector2 a = new Vector2(float.NaN, 0.0f);
            Vector2 actual = -a;

            Assert.True(float.IsNaN(actual.X), "Vector2f.operator - did not return the expected value.");
            Assert.True(float.Equals(0.0f, actual.Y), "Vector2f.operator - did not return the expected value.");
        }

        // A test for operator - (Vector2f, Vector2f)
        [Test]
        public void Vector2SubtractionTest()
        {
            Vector2 a = new Vector2(1.0f, 3.0f);
            Vector2 b = new Vector2(2.0f, 1.5f);

            Vector2 expected = new Vector2(-1.0f, 1.5f);
            Vector2 actual;

            actual = a - b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.operator - did not return the expected value.");
        }

        // A test for operator * (Vector2f, float)
        [Test]
        public void Vector2MultiplyOperatorTest()
        {
            Vector2 a = new Vector2(2.0f, 3.0f);
            const float factor = 2.0f;

            Vector2 expected = new Vector2(4.0f, 6.0f);
            Vector2 actual;

            actual = a * factor;
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.operator * did not return the expected value.");
        }

        // A test for operator * (float, Vector2f)
        [Test]
        public void Vector2MultiplyOperatorTest2()
        {
            Vector2 a = new Vector2(2.0f, 3.0f);
            const float factor = 2.0f;

            Vector2 expected = new Vector2(4.0f, 6.0f);
            Vector2 actual;

            actual = factor * a;
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.operator * did not return the expected value.");
        }

        // A test for operator * (Vector2f, Vector2f)
        [Test]
        public void Vector2MultiplyOperatorTest3()
        {
            Vector2 a = new Vector2(2.0f, 3.0f);
            Vector2 b = new Vector2(4.0f, 5.0f);

            Vector2 expected = new Vector2(8.0f, 15.0f);
            Vector2 actual;

            actual = a * b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.operator * did not return the expected value.");
        }

        // A test for operator / (Vector2f, float)
        [Test]
        public void Vector2DivisionTest()
        {
            Vector2 a = new Vector2(2.0f, 3.0f);

            float div = 2.0f;

            Vector2 expected = new Vector2(1.0f, 1.5f);
            Vector2 actual;

            actual = a / div;

            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.operator / did not return the expected value.");
        }

        // A test for operator / (Vector2f, Vector2f)
        [Test]
        public void Vector2DivisionTest1()
        {
            Vector2 a = new Vector2(2.0f, 3.0f);
            Vector2 b = new Vector2(4.0f, 5.0f);

            Vector2 expected = new Vector2(2.0f / 4.0f, 3.0f / 5.0f);
            Vector2 actual;

            actual = a / b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.operator / did not return the expected value.");
        }

        // A test for operator / (Vector2f, float)
        // Divide by zero
        [Test]
        public void Vector2DivisionTest2()
        {
            Vector2 a = new Vector2(-2.0f, 3.0f);

            float div = 0.0f;

            Vector2 actual = a / div;

            Assert.True(float.IsNegativeInfinity(actual.X), "Vector2f.operator / did not return the expected value.");
            Assert.True(float.IsPositiveInfinity(actual.Y), "Vector2f.operator / did not return the expected value.");
        }

        // A test for operator / (Vector2f, Vector2f)
        // Divide by zero
        [Test]
        public void Vector2DivisionTest3()
        {
            Vector2 a = new Vector2(0.047f, -3.0f);
            Vector2 b = new Vector2();

            Vector2 actual = a / b;

            Assert.True(float.IsInfinity(actual.X), "Vector2f.operator / did not return the expected value.");
            Assert.True(float.IsInfinity(actual.Y), "Vector2f.operator / did not return the expected value.");
        }

        // A test for operator + (Vector2f, Vector2f)
        [Test]
        public void Vector2AdditionTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(3.0f, 4.0f);

            Vector2 expected = new Vector2(4.0f, 6.0f);
            Vector2 actual;

            actual = a + b;

            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.operator + did not return the expected value.");
        }

        // A test for Vector2f (float, float)
        [Test]
        public void Vector2ConstructorTest()
        {
            float x = 1.0f;
            float y = 2.0f;

            Vector2 target = new Vector2(x, y);
            Assert.True(MathHelper.Equal(target.X, x) && MathHelper.Equal(target.Y, y), "Vector2f(x,y) constructor did not return the expected value.");
        }

        // A test for Vector2f ()
        // Constructor with no parameter
        [Test]
        public void Vector2ConstructorTest2()
        {
            Vector2 target = new Vector2();
            Assert.AreEqual(target.X, 0.0f);
            Assert.AreEqual(target.Y, 0.0f);
        }

        // A test for Vector2f (float, float)
        // Constructor with special floating values
        [Test]
        public void Vector2ConstructorTest3()
        {
            Vector2 target = new Vector2(float.NaN, float.MaxValue);
            Assert.AreEqual(target.X, float.NaN);
            Assert.AreEqual(target.Y, float.MaxValue);
        }

        // A test for Vector2f (float)
        [Test]
        public void Vector2ConstructorTest4()
        {
            float value = 1.0f;
            Vector2 target = new Vector2(value);

            Vector2 expected = new Vector2(value, value);
            Assert.AreEqual(expected, target);

            value = 2.0f;
            target = new Vector2(value);
            expected = new Vector2(value, value);
            Assert.AreEqual(expected, target);
        }

        // A test for Add (Vector2f, Vector2f)
        [Test]
        public void Vector2AddTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(5.0f, 6.0f);

            Vector2 expected = new Vector2(6.0f, 8.0f);
            Vector2 actual;

            actual = MathOps.Add(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Divide (Vector2f, float)
        [Test]
        public void Vector2DivideTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            float div = 2.0f;
            Vector2 expected = new Vector2(0.5f, 1.0f);
            Assert.AreEqual(expected, a / div);
        }

        // A test for Divide (Vector2f, Vector2f)
        [Test]
        public void Vector2DivideTest1()
        {
            Vector2 a = new Vector2(1.0f, 6.0f);
            Vector2 b = new Vector2(5.0f, 2.0f);

            Vector2 expected = new Vector2(1.0f / 5.0f, 6.0f / 2.0f);
            Vector2 actual;

            actual = MathOps.Divide(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Equals (object)
        [Test]
        public void Vector2EqualsTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(1.0f, 2.0f);

            // case 1: compare between same values
            object obj = b;

            bool expected = true;
            bool actual = a.Equals(obj);
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10.0f);
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

        // A test for Multiply (Vector2f, float)
        [Test]
        public void Vector2MultiplyTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            const float factor = 2.0f;
            Vector2 expected = new Vector2(2.0f, 4.0f);
            Assert.AreEqual(expected, a * factor);
        }

        // A test for Multiply (float, Vector2f)
        [Test]
        public void Vector2MultiplyTest2()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            const float factor = 2.0f;
            Vector2 expected = new Vector2(2.0f, 4.0f);
            Assert.AreEqual(expected, factor * a);
        }

        // A test for Multiply (Vector2f, Vector2f)
        [Test]
        public void Vector2MultiplyTest3()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(5.0f, 6.0f);

            Vector2 expected = new Vector2(5.0f, 12.0f);
            Vector2 actual;

            actual = MathOps.Multiply(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Negate (Vector2f)
        [Test]
        public void Vector2NegateTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);

            Vector2 expected = new Vector2(-1.0f, -2.0f);
            Vector2 actual;

            actual = MathOps.Negate(a);
            Assert.AreEqual(expected, actual);
        }

        // A test for operator != (Vector2f, Vector2f)
        [Test]
        public void Vector2InequalityTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(1.0f, 2.0f);

            // case 1: compare between same values
            bool expected = false;
            bool actual = a != b;
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10f);
            expected = true;
            actual = a != b;
            Assert.AreEqual(expected, actual);
        }

        // A test for operator == (Vector2f, Vector2f)
        [Test]
        public void Vector2EqualityTest()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(1.0f, 2.0f);

            // case 1: compare between same values
            bool expected = true;
            bool actual = a == b;
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10f);
            expected = false;
            actual = a == b;
            Assert.AreEqual(expected, actual);
        }

        // A test for Subtract (Vector2f, Vector2f)
        [Test]
        public void Vector2SubtractTest()
        {
            Vector2 a = new Vector2(1.0f, 6.0f);
            Vector2 b = new Vector2(5.0f, 2.0f);

            Vector2 expected = new Vector2(-4.0f, 4.0f);
            Vector2 actual;

            actual = MathOps.Subtract(a, b);
            Assert.AreEqual(expected, actual);
        }

        // A test for UnitX
        [Test]
        public void Vector2UnitXTest()
        {
            Vector2 val = new Vector2(1.0f, 0.0f);
            Assert.AreEqual(val, Vector2.UnitX);
        }

        // A test for UnitY
        [Test]
        public void Vector2UnitYTest()
        {
            Vector2 val = new Vector2(0.0f, 1.0f);
            Assert.AreEqual(val, Vector2.UnitY);
        }

        // A test for One
        [Test]
        public void Vector2OneTest()
        {
            Vector2 val = new Vector2(1.0f, 1.0f);
            Assert.AreEqual(val, Vector2.One);
        }

        // A test for Zero
        [Test]
        public void Vector2ZeroTest()
        {
            Vector2 val = new Vector2(0.0f, 0.0f);
            Assert.AreEqual(val, Vector2.Zero);
        }

        // A test for Equals (Vector2f)
        [Test]
        public void Vector2EqualsTest1()
        {
            Vector2 a = new Vector2(1.0f, 2.0f);
            Vector2 b = new Vector2(1.0f, 2.0f);

            // case 1: compare between same values
            bool expected = true;
            bool actual = a.Equals(b);
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10f);
            expected = false;
            actual = a.Equals(b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Vector2f comparison involving NaN values
        [Test]
        public void Vector2EqualsNanTest()
        {
            Vector2 a = new Vector2(float.NaN, 0);
            Vector2 b = new Vector2(0, float.NaN);

            Assert.False(a == Vector2.Zero);
            Assert.False(b == Vector2.Zero);

            Assert.True(a != Vector2.Zero);
            Assert.True(b != Vector2.Zero);

            Assert.False(a.Equals(Vector2.Zero));
            Assert.False(b.Equals(Vector2.Zero));

            // Counterintuitive result - IEEE rules for NaN comparison are weird!
            Assert.False(a.Equals(a));
            Assert.False(b.Equals(b));
        }

        // A test for Reflect (Vector2f, Vector2f)
        [Test]
        public void Vector2ReflectTest()
        {
            Vector2 a = MathOps.Normalize(new Vector2(1.0f, 1.0f));

            // Reflect on XZ plane.
            Vector2 n = new Vector2(0.0f, 1.0f);
            Vector2 expected = new Vector2(a.X, -a.Y);
            Vector2 actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Reflect did not return the expected value.");

            // Reflect on XY plane.
            n = new Vector2(0.0f, 0.0f);
            expected = new Vector2(a.X, a.Y);
            actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Reflect did not return the expected value.");

            // Reflect on YZ plane.
            n = new Vector2(1.0f, 0.0f);
            expected = new Vector2(-a.X, a.Y);
            actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Reflect did not return the expected value.");
        }

        // A test for Reflect (Vector2f, Vector2f)
        // Reflection when normal and source are the same
        [Test]
        public void Vector2ReflectTest1()
        {
            Vector2 n = new Vector2(0.45f, 1.28f);
            n = MathOps.Normalize(n);
            Vector2 a = n;

            Vector2 expected = -n;
            Vector2 actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Reflect did not return the expected value.");
        }

        // A test for Reflect (Vector2f, Vector2f)
        // Reflection when normal and source are negation
        [Test]
        public void Vector2ReflectTest2()
        {
            Vector2 n = new Vector2(0.45f, 1.28f);
            n = MathOps.Normalize(n);
            Vector2 a = -n;

            Vector2 expected = n;
            Vector2 actual = MathOps.Reflect(a, n);
            Assert.True(MathHelper.Equal(expected, actual), "Vector2f.Reflect did not return the expected value.");
        }

        [Test]
        public void Vector2AbsTest()
        {
            Vector2 v1 = new Vector2(-2.5f, 2.0f);
            Vector2 v3 = MathOps.Abs(new Vector2(0.0f, float.NegativeInfinity));
            Vector2 v = MathOps.Abs(v1);
            Assert.AreEqual(2.5f, v.X);
            Assert.AreEqual(2.0f, v.Y);
            Assert.AreEqual(0.0f, v3.X);
            Assert.AreEqual(float.PositiveInfinity, v3.Y);
        }

        [Test]
        public void Vector2SqrtTest()
        {
            Vector2 v1 = new Vector2(-2.5f, 2.0f);
            Vector2 v2 = new Vector2(5.5f, 4.5f);
            Assert.AreEqual(2, (int)MathOps.SquareRoot(v2).X);
            Assert.AreEqual(2, (int)MathOps.SquareRoot(v2).Y);
            Assert.AreEqual(float.NaN, MathOps.SquareRoot(v1).X);
        }

        [StructLayout(LayoutKind.Sequential)]
        struct Vector2_2x
        {
            private Vector2 _a;
            private Vector2 _b;
        }

        [StructLayout(LayoutKind.Sequential)]
        struct Vector2PlusFloat
        {
            private Vector2 _v;
            private float _f;
        }

        [StructLayout(LayoutKind.Sequential)]
        struct Vector2PlusFloat_2x
        {
            private Vector2PlusFloat _a;
            private Vector2PlusFloat _b;
        }
    }
}
