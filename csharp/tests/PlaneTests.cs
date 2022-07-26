// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System.Runtime.InteropServices;
using NUnit.Framework;
using System;

namespace Vim.Math3d.Tests
{
    public class PlaneTests
    {
        // A test for Equals (Plane)
        [Test]
        public void PlaneEqualsTest1()
        {
            var a = new Plane(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Plane(1.0f, 2.0f, 3.0f, 4.0f);

            // case 1: compare between same values
            Assert.AreEqual(true, a.Equals(b));
            Assert.AreEqual(true, ((object)a).Equals(b));

            // case 2: compare between different values
            var c = new Plane(new Vector3(10.0f, b.Normal.Y, b.Normal.Z), b.D);
            Assert.AreEqual(false, b.Equals(c));
            Assert.AreEqual(false, b.Equals(c));
        }

        // A test for operator == (Plane, Plane)
        [Test]
        public void PlaneEqualityTest()
        {
            var a = new Plane(1.0f, 2.0f, 3.0f, 4.0f);
            var b = new Plane(1.0f, 2.0f, 3.0f, 4.0f);

            // case 1: compare between same values
            var expected = true;
            var actual = a == b;
            Assert.AreEqual(expected, actual);

            // case 2: compare between different values
            b = new Plane(new Vector3(10.0f, b.Normal.Y, b.Normal.Z), b.D);
            expected = false;
            actual = a == b;
            Assert.AreEqual(expected, actual);
        }

        // A test for Plane (float, float, float, float)
        [Test]
        public void PlaneConstructorTest1()
        {
            float a = 1.0f, b = 2.0f, c = 3.0f, d = 4.0f;
            var target = new Plane(a, b, c, d);

            Assert.True(
                target.Normal.X == a && target.Normal.Y == b && target.Normal.Z == c && target.D == d,
                "Plane.cstor did not return the expected value.");
        }

        // A test for Plane.CreateFromVertices
        [Test]
        public void PlaneCreateFromVerticesTest()
        {
            var point1 = new Vector3(0.0f, 1.0f, 1.0f);
            var point2 = new Vector3(0.0f, 0.0f, 1.0f);
            var point3 = new Vector3(1.0f, 0.0f, 1.0f);

            var target = Plane.CreateFromVertices(point1, point2, point3);
            var expected = new Plane(new Vector3(0, 0, 1), -1.0f);
            Assert.AreEqual(target, expected);
        }

        // A test for Plane.CreateFromVertices
        [Test]
        public void PlaneCreateFromVerticesTest2()
        {
            var point1 = new Vector3(0.0f, 0.0f, 1.0f);
            var point2 = new Vector3(1.0f, 0.0f, 0.0f);
            var point3 = new Vector3(1.0f, 1.0f, 0.0f);

            var target = Plane.CreateFromVertices(point1, point2, point3);
            var invRoot2 = (float)(1 / Math.Sqrt(2));

            var expected = new Plane(new Vector3(invRoot2, 0, invRoot2), -invRoot2);
            Assert.True(MathHelper.Equal(target, expected), "Plane.cstor did not return the expected value.");
        }

        // A test for Plane (Vector3f, float)
        [Test]
        public void PlaneConstructorTest3()
        {
            var normal = new Vector3(1, 2, 3);
            float d = 4;

            var target = new Plane(normal, d);
            Assert.True(
                target.Normal == normal && target.D == d,
                "Plane.cstor did not return the expected value.");
        }

        // A test for Plane (Vector4f)
        [Test]
        public void PlaneConstructorTest()
        {
            var value = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
            var target = new Plane(value);

            Assert.True(
                target.Normal.X == value.X && target.Normal.Y == value.Y && target.Normal.Z == value.Z && target.D == value.W,
                "Plane.cstor did not return the expected value.");
        }

        [Test]
        public void PlaneDotTest()
        {
            var target = new Plane(2, 3, 4, 5);
            var value = new Vector4(5, 4, 3, 2);

            float expected = 10 + 12 + 12 + 10;
            var actual = Plane.Dot(target, value);
            Assert.True(MathHelper.Equal(expected, actual), "Plane.Dot returns unexpected value.");
        }

        [Test]
        public void PlaneDotCoordinateTest()
        {
            var target = new Plane(2, 3, 4, 5);
            var value = new Vector3(5, 4, 3);

            float expected = 10 + 12 + 12 + 5;
            var actual = Plane.DotCoordinate(target, value);
            Assert.True(MathHelper.Equal(expected, actual), "Plane.DotCoordinate returns unexpected value.");
        }

        [Test]
        public void PlaneDotNormalTest()
        {
            var target = new Plane(2, 3, 4, 5);
            var value = new Vector3(5, 4, 3);

            float expected = 10 + 12 + 12;
            var actual = Plane.DotNormal(target, value);
            Assert.True(MathHelper.Equal(expected, actual), "Plane.DotCoordinate returns unexpected value.");
        }

        [Test]
        public void PlaneNormalizeTest()
        {
            var target = new Plane(1, 2, 3, 4);

            var f = target.Normal.LengthSquared();
            var invF = 1.0f / f.Sqrt();
            var expected = new Plane(target.Normal * invF, target.D * invF);

            var actual = Plane.Normalize(target);
            Assert.True(MathHelper.Equal(expected, actual), "Plane.Normalize returns unexpected value.");

            // normalize, normalized normal.
            actual = Plane.Normalize(actual);
            Assert.True(MathHelper.Equal(expected, actual), "Plane.Normalize returns unexpected value.");
        }

        [Test]
        // Transform by matrix
        public void PlaneTransformTest1()
        {
            var target = new Plane(1, 2, 3, 4);
            target = Plane.Normalize(target);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            m.M41 = 10.0f;
            m.M42 = 20.0f;
            m.M43 = 30.0f;

            Matrix4x4 inv;
            Matrix4x4.Invert(m, out inv);
            var itm = Matrix4x4.Transpose(inv);
            float x = target.Normal.X, y = target.Normal.Y, z = target.Normal.Z, w = target.D;
            var Normal = new Vector3(
                x * itm.M11 + y * itm.M21 + z * itm.M31 + w * itm.M41,
                x * itm.M12 + y * itm.M22 + z * itm.M32 + w * itm.M42,
                x * itm.M13 + y * itm.M23 + z * itm.M33 + w * itm.M43);
            var D = x * itm.M14 + y * itm.M24 + z * itm.M34 + w * itm.M44;
            var expected = new Plane(Normal, D);
            var actual = target.Transform(m);
            Assert.True(MathHelper.Equal(expected, actual), "Plane.Transform did not return the expected value.");
        }

        [Test]
        // Transform by quaternion
        public void PlaneTransformTest2()
        {
            var target = new Plane(1, 2, 3, 4);
            target = Plane.Normalize(target);

            var m =
                Matrix4x4.CreateRotationX(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationY(MathHelper.ToRadians(30.0f)) *
                Matrix4x4.CreateRotationZ(MathHelper.ToRadians(30.0f));
            var q = Quaternion.CreateFromRotationMatrix(m);

            float x = target.Normal.X, y = target.Normal.Y, z = target.Normal.Z, w = target.D;
            var Normal = new Vector3(
                x * m.M11 + y * m.M21 + z * m.M31 + w * m.M41,
                x * m.M12 + y * m.M22 + z * m.M32 + w * m.M42,
                x * m.M13 + y * m.M23 + z * m.M33 + w * m.M43);
            var D = x * m.M14 + y * m.M24 + z * m.M34 + w * m.M44;
            var expected = new Plane(Normal, D);
            var actual = target.Transform(q);
            Assert.True(MathHelper.Equal(expected, actual), "Plane.Transform did not return the expected value.");
        }

        // A test for Plane comparison involving NaN values
        [Test]
        public void PlaneEqualsNanTest()
        {
            var a = new Plane(float.NaN, 0, 0, 0);
            var b = new Plane(0, float.NaN, 0, 0);
            var c = new Plane(0, 0, float.NaN, 0);
            var d = new Plane(0, 0, 0, float.NaN);

            Assert.False(a == new Plane(0, 0, 0, 0));
            Assert.False(b == new Plane(0, 0, 0, 0));
            Assert.False(c == new Plane(0, 0, 0, 0));
            Assert.False(d == new Plane(0, 0, 0, 0));

            Assert.True(a != new Plane(0, 0, 0, 0));
            Assert.True(b != new Plane(0, 0, 0, 0));
            Assert.True(c != new Plane(0, 0, 0, 0));
            Assert.True(d != new Plane(0, 0, 0, 0));

            Assert.False(a.Equals(new Plane(0, 0, 0, 0)));
            Assert.False(b.Equals(new Plane(0, 0, 0, 0)));
            Assert.False(c.Equals(new Plane(0, 0, 0, 0)));
            Assert.False(d.Equals(new Plane(0, 0, 0, 0)));

            // Counterintuitive result - IEEE rules for NaN comparison are weird!
            Assert.False(a.Equals(a));
            Assert.False(b.Equals(b));
            Assert.False(c.Equals(c));
            Assert.False(d.Equals(d));
        }

        /* Enable when size of Vector3 is correct
        // A test to make sure these types are blittable directly into GPU buffer memory layouts
        [Test]
        public unsafe void PlaneSizeofTest()
        {
            Assert.AreEqual(16, sizeof(Plane));
            Assert.AreEqual(32, sizeof(Plane_2x));
            Assert.AreEqual(20, sizeof(PlanePlusFloat));
            Assert.AreEqual(40, sizeof(PlanePlusFloat_2x));
        }
        */

        [StructLayout(LayoutKind.Sequential)]
        struct Plane_2x
        {
            private Plane _a;
            private Plane _b;
        }

        [StructLayout(LayoutKind.Sequential)]
        struct PlanePlusFloat
        {
            private Plane _v;
            private float _f;
        }

        [StructLayout(LayoutKind.Sequential)]
        struct PlanePlusFloat_2x
        {
            private PlanePlusFloat _a;
            private PlanePlusFloat _b;
        }
    }
}
