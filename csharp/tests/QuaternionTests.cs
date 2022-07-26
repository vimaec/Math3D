// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System;
using System.Runtime.InteropServices;
using NUnit.Framework;

namespace Vim.Math3d.Tests
{
    public class QuaternionTests
    {
        // A test for Dot (Quaternion, Quaternion)
        [Test]
        public void QuaternionDotTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = 70.0f;
            float actual;

            actual = Quaternion.Dot(a, b);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Dot did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Length ()
        [Test]
        public void QuaternionLengthTest()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);

            var w = 4.0f;

            var target = new Quaternion(v, w);

            var expected = 5.477226f;
            float actual;

            actual = target.Length();

            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Length did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for LengthSquared ()
        [Test]
        public void QuaternionLengthSquaredTest()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var w = 4.0f;

            var target = new Quaternion(v, w);

            var expected = 30.0f;
            float actual;

            actual = target.LengthSquared();

            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.LengthSquared did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Lerp (Quaternion, Quaternion, float)
        [Test]
        public void QuaternionLerpTest()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var a = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(10.0f));
            var b = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(30.0f));

            var t = 0.5f;

            var expected = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(20.0f));
            Quaternion actual;

            actual = Quaternion.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Lerp did not return the expected value: expected {expected} actual {actual}");

            // Case a and b are same.
            expected = a;
            actual = Quaternion.Lerp(a, a, t);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Lerp did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Lerp (Quaternion, Quaternion, float)
        // Lerp test when t = 0
        [Test]
        public void QuaternionLerpTest1()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var a = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(10.0f));
            var b = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(30.0f));

            var t = 0.0f;

            var expected = new Quaternion(a.X, a.Y, a.Z, a.W);
            var actual = Quaternion.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Lerp did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Lerp (Quaternion, Quaternion, float)
        // Lerp test when t = 1
        [Test]
        public void QuaternionLerpTest2()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var a = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(10.0f));
            var b = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(30.0f));

            var t = 1.0f;

            var expected = new Quaternion(b.X, b.Y, b.Z, b.W);
            var actual = Quaternion.Lerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Lerp did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Lerp (Quaternion, Quaternion, float)
        // Lerp test when the two quaternions are more than 90 degree (dot product <0)
        [Test]
        public void QuaternionLerpTest3()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var a = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(10.0f));
            var b = -a;

            var t = 1.0f;

            var actual = Quaternion.Lerp(a, b, t);
            // Note that in quaternion world, Q == -Q. In the case of quaternions dot product is zero, 
            // one of the quaternion will be flipped to compute the shortest distance. When t = 1, we
            // expect the result to be the same as quaternion b but flipped.
            Assert.True(actual == a, $"Quaternion.Lerp did not return the expected value: expected {a} actual {actual}");
        }

        // A test for Conjugate(Quaternion)
        [Test]
        public void QuaternionConjugateTest1()
        {
            var a = new Quaternion(1, 2, 3, 4);

            var expected = new Quaternion(-1, -2, -3, 4);
            Quaternion actual;

            actual = a.Conjugate();
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Conjugate did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Normalize (Quaternion)
        [Test]
        public void QuaternionNormalizeTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);

            var expected = new Quaternion(0.182574168f, 0.365148336f, 0.5477225f, 0.7302967f);
            Quaternion actual;

            actual = a.Normalize();
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Normalize did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Normalize (Quaternion)
        // Normalize zero length quaternion
        [Test]
        public void QuaternionNormalizeTest1()
        {
            var a = new Quaternion(0.0f, 0.0f, -0.0f, 0.0f);

            var actual = a.Normalize();
            Assert.True(float.IsNaN(actual.X) && float.IsNaN(actual.Y) && float.IsNaN(actual.Z) && float.IsNaN(actual.W)
                , $"Quaternion.Normalize did not return the expected value: expected {new Quaternion(float.NaN, float.NaN, float.NaN, float.NaN)} actual {actual}");
        }

        // A test for Concatenate(Quaternion, Quaternion)
        [Test]
        public void QuaternionConcatenateTest1()
        {
            var b = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var a = new Quaternion(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = new Quaternion(24.0f, 48.0f, 48.0f, -6.0f);
            Quaternion actual;

            actual = Quaternion.Concatenate(a, b);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Concatenate did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for operator - (Quaternion, Quaternion)
        [Test]
        public void QuaternionSubtractionTest()
        {
            var a = new Quaternion(1.0f, 6.0f, 7.0f, 4.0f);
            var b = new Quaternion(5.0f, 2.0f, 3.0f, 8.0f);

            var expected = new Quaternion(-4.0f, 4.0f, 4.0f, -4.0f);
            Quaternion actual;

            actual = a - b;

            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.operator - did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for operator * (Quaternion, float)
        [Test]
        public void QuaternionMultiplyTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var factor = 0.5f;

            var expected = new Quaternion(0.5f, 1.0f, 1.5f, 2.0f);
            Quaternion actual;

            actual = a * factor;

            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.operator * did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for operator * (Quaternion, Quaternion)
        [Test]
        public void QuaternionMultiplyTest1()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = new Quaternion(24.0f, 48.0f, 48.0f, -6.0f);
            Quaternion actual;

            actual = a * b;

            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.operator * did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for operator / (Quaternion, Quaternion)
        [Test]
        public void QuaternionDivisionTest1()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = new Quaternion(-0.045977015f, -0.09195402f, -7.450581E-9f, 0.402298868f);
            Quaternion actual;

            actual = a / b;

            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.operator / did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for operator + (Quaternion, Quaternion)
        [Test]
        public void QuaternionAdditionTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = new Quaternion(6.0f, 8.0f, 10.0f, 12.0f);
            Quaternion actual;

            actual = a + b;

            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.operator + did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Quaternion (float, float, float, float)
        [Test]
        public void QuaternionConstructorTest()
        {
            var x = 1.0f;
            var y = 2.0f;
            var z = 3.0f;
            var w = 4.0f;

            var target = new Quaternion(x, y, z, w);

            Assert.True(MathHelper.Equal(target.X, x) && MathHelper.Equal(target.Y, y) && MathHelper.Equal(target.Z, z) && MathHelper.Equal(target.W, w),
                "Quaternion.constructor (x,y,z,w) did not return the expected value.");
        }

        // A test for Quaternion (Vector3f, float)
        [Test]
        public void QuaternionConstructorTest1()
        {
            var v = new Vector3(1.0f, 2.0f, 3.0f);
            var w = 4.0f;

            var target = new Quaternion(v, w);
            Assert.True(MathHelper.Equal(target.X, v.X) && MathHelper.Equal(target.Y, v.Y) && MathHelper.Equal(target.Z, v.Z) && MathHelper.Equal(target.W, w),
                "Quaternion.constructor (Vector3f,w) did not return the expected value.");
        }

        // A test for CreateFromAxisAngle (Vector3f, float)
        [Test]
        public void QuaternionCreateFromAxisAngleTest()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var angle = MathHelper.ToRadians(30.0f);

            var expected = new Quaternion(0.0691723f, 0.1383446f, 0.207516879f, 0.9659258f);
            Quaternion actual;

            actual = Quaternion.CreateFromAxisAngle(axis, angle);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.CreateFromAxisAngle did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for CreateFromAxisAngle (Vector3f, float)
        // CreateFromAxisAngle of zero vector
        [Test]
        public void QuaternionCreateFromAxisAngleTest1()
        {
            var axis = new Vector3();
            var angle = MathHelper.ToRadians(-30.0f);

            var cos = (float)System.Math.Cos(angle / 2.0f);
            var actual = Quaternion.CreateFromAxisAngle(axis, angle);

            Assert.True(actual.X == 0.0f && actual.Y == 0.0f && actual.Z == 0.0f && MathHelper.Equal(cos, actual.W)
                , "Quaternion.CreateFromAxisAngle did not return the expected value.");
        }

        // A test for CreateFromAxisAngle (Vector3f, float)
        // CreateFromAxisAngle of angle = 30 && 750
        [Test]
        public void QuaternionCreateFromAxisAngleTest2()
        {
            var axis = new Vector3(1, 0, 0);
            var angle1 = MathHelper.ToRadians(30.0f);
            var angle2 = MathHelper.ToRadians(750.0f);

            var actual1 = Quaternion.CreateFromAxisAngle(axis, angle1);
            var actual2 = Quaternion.CreateFromAxisAngle(axis, angle2);
            Assert.True(MathHelper.Equal(actual1, actual2), $"Quaternion.CreateFromAxisAngle did not return the expected value: actual1 {actual1} actual2 {actual2}");
        }

        // A test for CreateFromAxisAngle (Vector3f, float)
        // CreateFromAxisAngle of angle = 30 && 390
        [Test]
        public void QuaternionCreateFromAxisAngleTest3()
        {
            var axis = new Vector3(1, 0, 0);
            var angle1 = MathHelper.ToRadians(30.0f);
            var angle2 = MathHelper.ToRadians(390.0f);

            var actual1 = Quaternion.CreateFromAxisAngle(axis, angle1);
            var actual2 = Quaternion.CreateFromAxisAngle(axis, angle2);
            actual1 = actual1.SetX(-actual1.X);
            actual1 = actual1.SetW(-actual1.W);

            Assert.True(MathHelper.Equal(actual1, actual2), $"Quaternion.CreateFromAxisAngle did not return the expected value: actual1 {actual1} actual2 {actual2}");
        }

        [Test]
        public void QuaternionCreateFromYawPitchRollTest1()
        {
            var yawAngle = MathHelper.ToRadians(30.0f);
            var pitchAngle = MathHelper.ToRadians(40.0f);
            var rollAngle = MathHelper.ToRadians(50.0f);

            var yaw = Quaternion.CreateFromAxisAngle(Vector3.UnitY, yawAngle);
            var pitch = Quaternion.CreateFromAxisAngle(Vector3.UnitX, pitchAngle);
            var roll = Quaternion.CreateFromAxisAngle(Vector3.UnitZ, rollAngle);

            var expected = yaw * pitch * roll;
            var actual = Quaternion.CreateFromYawPitchRoll(yawAngle, pitchAngle, rollAngle);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.QuaternionCreateFromYawPitchRollTest1 did not return the expected value: expected {expected} actual {actual}");
        }

        // Covers more numeric rigions
        [Test]
        public void QuaternionCreateFromYawPitchRollTest2()
        {
            const float step = 35.0f;

            for (var yawAngle = -720.0f; yawAngle <= 720.0f; yawAngle += step)
            {
                for (var pitchAngle = -720.0f; pitchAngle <= 720.0f; pitchAngle += step)
                {
                    for (var rollAngle = -720.0f; rollAngle <= 720.0f; rollAngle += step)
                    {
                        var yawRad = MathHelper.ToRadians(yawAngle);
                        var pitchRad = MathHelper.ToRadians(pitchAngle);
                        var rollRad = MathHelper.ToRadians(rollAngle);

                        var yaw = Quaternion.CreateFromAxisAngle(Vector3.UnitY, yawRad);
                        var pitch = Quaternion.CreateFromAxisAngle(Vector3.UnitX, pitchRad);
                        var roll = Quaternion.CreateFromAxisAngle(Vector3.UnitZ, rollRad);

                        var expected = yaw * pitch * roll;
                        var actual = Quaternion.CreateFromYawPitchRoll(yawRad, pitchRad, rollRad);
                        Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.QuaternionCreateFromYawPitchRollTest2 Yaw:{yawAngle} Pitch:{pitchAngle} Roll:{rollAngle} did not return the expected value: expected {expected} actual {actual}");
                    }
                }
            }
        }

        // A test for Slerp (Quaternion, Quaternion, float)
        [Test]
        public void QuaternionSlerpTest()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var a = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(10.0f));
            var b = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(30.0f));

            var t = 0.5f;

            var expected = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(20.0f));
            Quaternion actual;

            actual = Quaternion.Slerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Slerp did not return the expected value: expected {expected} actual {actual}");

            // Case a and b are same.
            expected = a;
            actual = Quaternion.Slerp(a, a, t);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Slerp did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Slerp (Quaternion, Quaternion, float)
        // Slerp test where t = 0
        [Test]
        public void QuaternionSlerpTest1()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var a = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(10.0f));
            var b = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(30.0f));

            var t = 0.0f;

            var expected = new Quaternion(a.X, a.Y, a.Z, a.W);
            var actual = Quaternion.Slerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Slerp did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Slerp (Quaternion, Quaternion, float)
        // Slerp test where t = 1
        [Test]
        public void QuaternionSlerpTest2()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var a = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(10.0f));
            var b = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(30.0f));

            var t = 1.0f;

            var expected = new Quaternion(b.X, b.Y, b.Z, b.W);
            var actual = Quaternion.Slerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Slerp did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Slerp (Quaternion, Quaternion, float)
        // Slerp test where dot product is < 0
        [Test]
        public void QuaternionSlerpTest3()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var a = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(10.0f));
            var b = -a;

            var t = 1.0f;

            var expected = a;
            var actual = Quaternion.Slerp(a, b, t);
            // Note that in quaternion world, Q == -Q. In the case of quaternions dot product is zero, 
            // one of the quaternion will be flipped to compute the shortest distance. When t = 1, we
            // expect the result to be the same as quaternion b but flipped.
            Assert.True(actual == expected, $"Quaternion.Slerp did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Slerp (Quaternion, Quaternion, float)
        // Slerp test where the quaternion is flipped
        [Test]
        public void QuaternionSlerpTest4()
        {
            var axis = MathOps.Normalize(new Vector3(1.0f, 2.0f, 3.0f));
            var a = Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(10.0f));
            var b = -Quaternion.CreateFromAxisAngle(axis, MathHelper.ToRadians(30.0f));

            var t = 0.0f;

            var expected = new Quaternion(a.X, a.Y, a.Z, a.W);
            var actual = Quaternion.Slerp(a, b, t);
            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.Slerp did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for operator - (Quaternion)
        [Test]
        public void QuaternionUnaryNegationTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);

            var expected = new Quaternion(-1.0f, -2.0f, -3.0f, -4.0f);
            Quaternion actual;

            actual = -a;

            Assert.True(MathHelper.Equal(expected, actual), $"Quaternion.operator - did not return the expected value: expected {expected} actual {actual}");
        }

        // A test for Inverse (Quaternion)
        [Test]
        public void QuaternionInverseTest()
        {
            var a = new Quaternion(5.0f, 6.0f, 7.0f, 8.0f);

            var expected = new Quaternion(-0.0287356321f, -0.03448276f, -0.0402298868f, 0.04597701f);
            Quaternion actual;

            actual = a.Inverse();
            Assert.AreEqual(expected, actual);
        }

        // A test for Inverse (Quaternion)
        // Invert zero length quaternion
        [Test]
        public void QuaternionInverseTest1()
        {
            var a = new Quaternion();
            var actual = a.Inverse();

            Assert.True(float.IsNaN(actual.X) && float.IsNaN(actual.Y) && float.IsNaN(actual.Z) && float.IsNaN(actual.W)
                , $"Quaternion.Inverse - did not return the expected value: expected {new Quaternion(float.NaN, float.NaN, float.NaN, float.NaN)} actual {actual}");
        }

        // A test for Add (Quaternion, Quaternion)
        [Test]
        public void QuaternionAddTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(5.0f, 6.0f, 7.0f, 8.0f);
            var expected = new Quaternion(6.0f, 8.0f, 10.0f, 12.0f);
            Assert.AreEqual(expected, a + b);
        }

        // A test for Divide (Quaternion, Quaternion)
        [Test]
        public void QuaternionDivideTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(5.0f, 6.0f, 7.0f, 8.0f);
            var expected = new Quaternion(-0.045977015f, -0.09195402f, -7.450581E-9f, 0.402298868f);
            Assert.IsTrue(MathHelper.Equal(expected, a / b));
        }

        // A test for Multiply (Quaternion, float)
        [Test]
        public void QuaternionMultiplyTest2()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var factor = 0.5f;
            var expected = new Quaternion(0.5f, 1.0f, 1.5f, 2.0f);
            Assert.AreEqual(expected, a * factor);
        }

        // A test for Multiply (Quaternion, Quaternion)
        [Test]
        public void QuaternionMultiplyTest3()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(5.0f, 6.0f, 7.0f, 8.0f);
            var expected = new Quaternion(24.0f, 48.0f, 48.0f, -6.0f);
            Assert.AreEqual(expected, a * b);
        }

        // A test for Negate (Quaternion)
        [Test]
        public void QuaternionNegateTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var expected = new Quaternion(-1.0f, -2.0f, -3.0f, -4.0f);
            Assert.AreEqual(expected, -a);
        }

        // A test for Subtract (Quaternion, Quaternion)
        [Test]
        public void QuaternionSubtractTest()
        {
            var a = new Quaternion(1.0f, 6.0f, 7.0f, 4.0f);
            var b = new Quaternion(5.0f, 2.0f, 3.0f, 8.0f);

            var expected = new Quaternion(-4.0f, 4.0f, 4.0f, -4.0f);
            Assert.AreEqual(expected, a - b);
        }

        // A test for operator != (Quaternion, Quaternion)
        [Test]
        public void QuaternionInequalityTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);

            // case 1: compare between same values
            var expected = false;
            var actual = a != b;
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            expected = true;
            actual = a != b.SetX(10.0f);
            Assert.AreEqual(expected, actual);
        }

        // A test for operator == (Quaternion, Quaternion)
        [Test]
        public void QuaternionEqualityTest()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);

            // case 1: compare between same values
            var expected = true;
            var actual = a == b;
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10.0f);
            expected = false;
            actual = a == b;
            Assert.AreEqual(expected, actual);
        }

        // A test for CreateFromRotationMatrix (Matrix4x4)
        // Convert Identity matrix test
        [Test]
        public void QuaternionFromRotationMatrixTest1()
        {
            var matrix = Matrix4x4.Identity;

            var expected = new Quaternion(0.0f, 0.0f, 0.0f, 1.0f);
            var actual = Quaternion.CreateFromRotationMatrix(matrix);
            Assert.True(MathHelper.Equal(expected, actual),
                $"Quaternion.CreateFromRotationMatrix did not return the expected value: expected {expected} actual {actual}");

            // make sure convert back to matrix is same as we passed matrix.
            var m2 = Matrix4x4.CreateFromQuaternion(actual);
            Assert.True(MathHelper.Equal(matrix, m2),
                $"Quaternion.CreateFromQuaternion did not return the expected value: matrix {matrix} m2 {m2}");
        }

        // A test for CreateFromRotationMatrix (Matrix4x4)
        // Convert X axis rotation matrix
        [Test]
        public void QuaternionFromRotationMatrixTest2()
        {
            for (var angle = 0.0f; angle < 720.0f; angle += 10.0f)
            {
                var matrix = Matrix4x4.CreateRotationX(angle);

                var expected = Quaternion.CreateFromAxisAngle(Vector3.UnitX, angle);
                var actual = Quaternion.CreateFromRotationMatrix(matrix);
                Assert.True(MathHelper.EqualRotation(expected, actual),
                    $"Quaternion.CreateFromRotationMatrix angle:{angle} did not return the expected value: expected {expected} actual {actual}");

                // make sure convert back to matrix is same as we passed matrix.
                var m2 = Matrix4x4.CreateFromQuaternion(actual);
                Assert.True(MathHelper.Equal(matrix, m2),
                    $"Quaternion.CreateFromQuaternion angle:{angle} did not return the expected value: matrix {matrix} m2 {m2}");
            }
        }

        // A test for CreateFromRotationMatrix (Matrix4x4)
        // Convert Y axis rotation matrix
        [Test]
        public void QuaternionFromRotationMatrixTest3()
        {
            for (var angle = 0.0f; angle < 720.0f; angle += 10.0f)
            {
                var matrix = Matrix4x4.CreateRotationY(angle);

                var expected = Quaternion.CreateFromAxisAngle(Vector3.UnitY, angle);
                var actual = Quaternion.CreateFromRotationMatrix(matrix);
                Assert.True(MathHelper.EqualRotation(expected, actual),
                    $"Quaternion.CreateFromRotationMatrix angle:{angle} did not return the expected value: expected {expected} actual {actual}");

                // make sure convert back to matrix is same as we passed matrix.
                var m2 = Matrix4x4.CreateFromQuaternion(actual);
                Assert.True(MathHelper.Equal(matrix, m2),
                    $"Quaternion.CreateFromQuaternion angle:{angle} did not return the expected value: matrix {matrix} m2 {m2}");
            }
        }

        // A test for CreateFromRotationMatrix (Matrix4x4)
        // Convert Z axis rotation matrix
        [Test]
        public void QuaternionFromRotationMatrixTest4()
        {
            for (var angle = 0.0f; angle < 720.0f; angle += 10.0f)
            {
                var matrix = Matrix4x4.CreateRotationZ(angle);

                var expected = Quaternion.CreateFromAxisAngle(Vector3.UnitZ, angle);
                var actual = Quaternion.CreateFromRotationMatrix(matrix);
                Assert.True(MathHelper.EqualRotation(expected, actual),
                    $"Quaternion.CreateFromRotationMatrix angle:{angle} did not return the expected value: expected {expected} actual {actual}");

                // make sure convert back to matrix is same as we passed matrix.
                var m2 = Matrix4x4.CreateFromQuaternion(actual);
                Assert.True(MathHelper.Equal(matrix, m2),
                    $"Quaternion.CreateFromQuaternion angle:{angle} did not return the expected value: matrix {matrix} m2 {m2}");
            }
        }

        // A test for CreateFromRotationMatrix (Matrix4x4)
        // Convert XYZ axis rotation matrix
        [Test]
        public void QuaternionFromRotationMatrixTest5()
        {
            for (var angle = 0.0f; angle < 720.0f; angle += 10.0f)
            {
                var matrix = Matrix4x4.CreateRotationX(angle) * Matrix4x4.CreateRotationY(angle) * Matrix4x4.CreateRotationZ(angle);

                var expected =
                    Quaternion.CreateFromAxisAngle(Vector3.UnitZ, angle) *
                    Quaternion.CreateFromAxisAngle(Vector3.UnitY, angle) *
                    Quaternion.CreateFromAxisAngle(Vector3.UnitX, angle);

                var actual = Quaternion.CreateFromRotationMatrix(matrix);
                Assert.True(MathHelper.EqualRotation(expected, actual),
                    $"Quaternion.CreateFromRotationMatrix angle:{angle} did not return the expected value: expected {expected} actual {actual}");

                // make sure convert back to matrix is same as we passed matrix.
                var m2 = Matrix4x4.CreateFromQuaternion(actual);
                Assert.True(MathHelper.Equal(matrix, m2),
                    $"Quaternion.CreateFromQuaternion angle:{angle} did not return the expected value: matrix {matrix} m2 {m2}");
            }
        }

        // A test for CreateFromRotationMatrix (Matrix4x4)
        // X axis is most large axis case
        [Test]
        public void QuaternionFromRotationMatrixWithScaledMatrixTest1()
        {
            var angle = MathHelper.ToRadians(180.0f);
            var matrix = Matrix4x4.CreateRotationY(angle) * Matrix4x4.CreateRotationZ(angle);

            var expected = Quaternion.CreateFromAxisAngle(Vector3.UnitZ, angle) * Quaternion.CreateFromAxisAngle(Vector3.UnitY, angle);
            var actual = Quaternion.CreateFromRotationMatrix(matrix);
            Assert.True(MathHelper.EqualRotation(expected, actual),
                $"Quaternion.CreateFromRotationMatrix did not return the expected value: expected {expected} actual {actual}");

            // make sure convert back to matrix is same as we passed matrix.
            var m2 = Matrix4x4.CreateFromQuaternion(actual);
            Assert.True(MathHelper.Equal(matrix, m2),
                $"Quaternion.CreateFromQuaternion did not return the expected value: matrix {matrix} m2 {m2}");
        }

        // A test for CreateFromRotationMatrix (Matrix4x4)
        // Y axis is most large axis case
        [Test]
        public void QuaternionFromRotationMatrixWithScaledMatrixTest2()
        {
            var angle = MathHelper.ToRadians(180.0f);
            var matrix = Matrix4x4.CreateRotationX(angle) * Matrix4x4.CreateRotationZ(angle);

            var expected = Quaternion.CreateFromAxisAngle(Vector3.UnitZ, angle) * Quaternion.CreateFromAxisAngle(Vector3.UnitX, angle);
            var actual = Quaternion.CreateFromRotationMatrix(matrix);
            Assert.True(MathHelper.EqualRotation(expected, actual),
                $"Quaternion.CreateFromRotationMatrix did not return the expected value: expected {expected} actual {actual}");

            // make sure convert back to matrix is same as we passed matrix.
            var m2 = Matrix4x4.CreateFromQuaternion(actual);
            Assert.True(MathHelper.Equal(matrix, m2),
                $"Quaternion.CreateFromQuaternion did not return the expected value: matrix {matrix} m2 {m2}");
        }

        // A test for CreateFromRotationMatrix (Matrix4x4)
        // Z axis is most large axis case
        [Test]
        public void QuaternionFromRotationMatrixWithScaledMatrixTest3()
        {
            var angle = MathHelper.ToRadians(180.0f);
            var matrix = Matrix4x4.CreateRotationX(angle) * Matrix4x4.CreateRotationY(angle);

            var expected = Quaternion.CreateFromAxisAngle(Vector3.UnitY, angle) * Quaternion.CreateFromAxisAngle(Vector3.UnitX, angle);
            var actual = Quaternion.CreateFromRotationMatrix(matrix);
            Assert.True(MathHelper.EqualRotation(expected, actual),
                $"Quaternion.CreateFromRotationMatrix did not return the expected value: expected {expected} actual {actual}");

            // make sure convert back to matrix is same as we passed matrix.
            var m2 = Matrix4x4.CreateFromQuaternion(actual);
            Assert.True(MathHelper.Equal(matrix, m2),
                $"Quaternion.CreateFromQuaternion did not return the expected value: matrix {matrix} m2 {m2}");
        }

        // A test for Equals (Quaternion)
        [Test]
        public void QuaternionEqualsTest1()
        {
            var a = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Quaternion(1.0f, 2.0f, 3.0f, 4.0f);

            // case 1: compare between same values
            var expected = true;
            var actual = a.Equals(b);
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = b.SetX(10.0f);
            expected = false;
            actual = a.Equals(b);
            Assert.AreEqual(expected, actual);
        }

        // A test for Identity
        [Test]
        public void QuaternionIdentityTest()
        {
            var val = new Quaternion(0, 0, 0, 1);
            Assert.AreEqual(val, Quaternion.Identity);
        }

        // A test for IsIdentity
        [Test]
        public void QuaternionIsIdentityTest()
        {
            Assert.True(Quaternion.Identity.IsIdentity);
            Assert.True(new Quaternion(0, 0, 0, 1).IsIdentity);
            Assert.False(new Quaternion(1, 0, 0, 1).IsIdentity);
            Assert.False(new Quaternion(0, 1, 0, 1).IsIdentity);
            Assert.False(new Quaternion(0, 0, 1, 1).IsIdentity);
            Assert.False(new Quaternion(0, 0, 0, 0).IsIdentity);
        }

        // A test for Quaternion comparison involving NaN values
        [Test]
        public void QuaternionEqualsNanTest()
        {
            var a = new Quaternion(float.NaN, 0, 0, 0);
            var b = new Quaternion(0, float.NaN, 0, 0);
            var c = new Quaternion(0, 0, float.NaN, 0);
            var d = new Quaternion(0, 0, 0, float.NaN);

            Assert.False(a == new Quaternion(0, 0, 0, 0));
            Assert.False(b == new Quaternion(0, 0, 0, 0));
            Assert.False(c == new Quaternion(0, 0, 0, 0));
            Assert.False(d == new Quaternion(0, 0, 0, 0));

            Assert.True(a != new Quaternion(0, 0, 0, 0));
            Assert.True(b != new Quaternion(0, 0, 0, 0));
            Assert.True(c != new Quaternion(0, 0, 0, 0));
            Assert.True(d != new Quaternion(0, 0, 0, 0));

            Assert.False(a.Equals(new Quaternion(0, 0, 0, 0)));
            Assert.False(b.Equals(new Quaternion(0, 0, 0, 0)));
            Assert.False(c.Equals(new Quaternion(0, 0, 0, 0)));
            Assert.False(d.Equals(new Quaternion(0, 0, 0, 0)));

            Assert.False(a.IsIdentity);
            Assert.False(b.IsIdentity);
            Assert.False(c.IsIdentity);
            Assert.False(d.IsIdentity);

            // Counterintuitive result - IEEE rules for NaN comparison are weird!
            Assert.False(a.Equals(a));
            Assert.False(b.Equals(b));
            Assert.False(c.Equals(c));
            Assert.False(d.Equals(d));
        }

        [StructLayout(LayoutKind.Sequential)]
        struct Quaternion_2x
        {
            private Quaternion _a;
            private Quaternion _b;
        }

        [StructLayout(LayoutKind.Sequential)]
        struct QuaternionPlusFloat
        {
            private Quaternion _v;
            private float _f;
        }

        [StructLayout(LayoutKind.Sequential)]
        struct QuaternionPlusFloat_2x
        {
            private QuaternionPlusFloat _a;
            private QuaternionPlusFloat _b;
        }

        [Test]
        public static void ToEulerAndBack()
        {
            var x = (float)Math.PI / 5f;
            var y = (float)Math.PI * 2f / 7f;
            var z = (float)Math.PI / 3f;
            var euler = new Vector3(x, y, z);
            var quat = Quaternion.CreateFromEulerAngles(euler);
            var euler2 = quat.ToEulerAngles();
            Assert.AreEqual(euler.X, euler2.X, 0.001f);
            Assert.AreEqual(euler.Y, euler2.Y, 0.001f);
            Assert.AreEqual(euler.Z, euler2.Z, 0.001f);
        }
    }
}
