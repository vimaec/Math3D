using System;
using NUnit.Framework;

namespace Vim.Math3d.Tests
{
    [TestFixture]
    public static class Line2DTests
    {
        // No intersection tests

        [Test]
        public static void TestNoIntersection1()
        {
            var a = new Line2D(new Vector2(0, 0), new Vector2(7, 7));
            var b = new Line2D(new Vector2(3, 4), new Vector2(4, 5));
            Assert.IsFalse(a.Intersects(b));
            Assert.IsFalse(b.Intersects(a));
        }

        [Test]
        public static void TestNoIntersection2()
        {
            var a = new Line2D(new Vector2(-4, 4), new Vector2(-2, 1));
            var b = new Line2D(new Vector2(-2, 3), new Vector2(0, 0));
            Assert.IsFalse(a.Intersects(b));
            Assert.IsFalse(b.Intersects(a));
        }

        [Test]
        public static void TestNoIntersection3()
        {
            var a = new Line2D(new Vector2(0, 0), new Vector2(0, 1));
            var b = new Line2D(new Vector2(2, 2), new Vector2(2, 3));
            Assert.IsFalse(a.Intersects(b));
            Assert.IsFalse(b.Intersects(a));
        }

        [Test]
        public static void TestNoIntersection4()
        {
            var a = new Line2D(new Vector2(0, 0), new Vector2(0, 1));
            var b = new Line2D(new Vector2(2, 2), new Vector2(3, 2));
            Assert.IsFalse(a.Intersects(b));
            Assert.IsFalse(b.Intersects(a));
        }

        [Test]
        public static void TestNoIntersection5()
        {
            var a = new Line2D(new Vector2(-1, -1), new Vector2(2, 2));
            var b = new Line2D(new Vector2(3, 3), new Vector2(5, 5));
            Assert.IsFalse(a.Intersects(b));
            Assert.IsFalse(b.Intersects(a));
        }

        [Test]
        public static void TestNoIntersection6()
        {
            var a = new Line2D(new Vector2(0, 0), new Vector2(1, 1));
            var b = new Line2D(new Vector2(2, 0), new Vector2(0.5f, 2));
            Assert.IsFalse(a.Intersects(b));
            Assert.IsFalse(b.Intersects(a));
        }

        [Test]
        public static void TestNoIntersection7()
        {
            var a = new Line2D(new Vector2(1, 1), new Vector2(4, 1));
            var b = new Line2D(new Vector2(2, 2), new Vector2(3, 2));
            Assert.IsFalse(a.Intersects(b));
            Assert.IsFalse(b.Intersects(a));
        }

        [Test]
        public static void TestNoIntersection8()
        {
            var a = new Line2D(new Vector2(0, 5), new Vector2(6, 0));
            var b = new Line2D(new Vector2(2, 1), new Vector2(2, 2));
            Assert.IsFalse(a.Intersects(b));
            Assert.IsFalse(b.Intersects(a));
        }

        // Intersection tests

        [Test]
        public static void TestIntersects1()
        {
            var a = new Line2D(new Vector2(0, -2), new Vector2(0, 2));
            var b = new Line2D(new Vector2(-2, 0), new Vector2(2, 0));
            Assert.IsTrue(a.Intersects(b));
            Assert.IsTrue(b.Intersects(a));
        }

        [Test]
        public static void TestIntersects2()
        {
            var a = new Line2D(new Vector2(5, 5), new Vector2(0, 0));
            var b = new Line2D(new Vector2(1, 1), new Vector2(8, 2));
            Assert.IsTrue(a.Intersects(b));
            Assert.IsTrue(b.Intersects(a));
        }

        [Test]
        public static void TestIntersects3()
        {
            var a = new Line2D(new Vector2(-1, 0), new Vector2(0, 0));
            var b = new Line2D(new Vector2(-1, -1), new Vector2(-1, 1));
            Assert.IsTrue(a.Intersects(b));
            Assert.IsTrue(b.Intersects(a));
        }

        [Test]
        public static void TestIntersects4()
        {
            var a = new Line2D(new Vector2(0, 2), new Vector2(2, 2));
            var b = new Line2D(new Vector2(2, 0), new Vector2(2, 4));
            Assert.IsTrue(a.Intersects(b));
            Assert.IsTrue(b.Intersects(a));
        }

        [Test]
        public static void TestIntersects5()
        {
            var a = new Line2D(new Vector2(0, 0), new Vector2(5, 5));
            var b = new Line2D(new Vector2(1, 1), new Vector2(3, 3));
            Assert.IsTrue(a.Intersects(b));
            Assert.IsTrue(b.Intersects(a));
        }

        [Test]
        public static void TestIntersects6()
        {
            for (var i = 0; i < 50; i++)
            {
                var rng = new Random();

                var ax = (float)rng.NextDouble();
                var ay = (float)rng.NextDouble();
                var bx = (float)rng.NextDouble();
                var by = (float)rng.NextDouble();
                var a = new Line2D(new Vector2(ax, ay), new Vector2(bx, by));
                var b = new Line2D(new Vector2(ax, ay), new Vector2(bx, by));
                Assert.IsTrue(a.Intersects(b));
                Assert.IsTrue(b.Intersects(a));
            }
        }
    }
}
