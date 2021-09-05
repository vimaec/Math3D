using NUnit.Framework;

namespace Vim.Math3d.Tests
{
    [TestFixture]
    public static class AABox2DTests
    {
        // No intersection tests

        [Test]
        public static void TestNoIntersection1()
        {
            var box1 = new AABox2D(new Vector2(0, 0), new Vector2(3, 3));
            var box2 = new AABox2D(new Vector2(4, 4), new Vector2(5, 5));
            Assert.IsFalse(box1.Intersects(box2));
            Assert.IsFalse(box2.Intersects(box1));
        }

        [Test]
        public static void TestNoIntersection2()
        {
            var box1 = new AABox2D(new Vector2(0, 0), new Vector2(3, 3));
            var box2 = new AABox2D(new Vector2(-5, -5), new Vector2(-4, -4));
            Assert.IsFalse(box1.Intersects(box2));
            Assert.IsFalse(box2.Intersects(box1));
        }

        // Intersection tests

        [Test]
        public static void TestIntersects1()
        {
            var box1 = new AABox2D(new Vector2(0, 0), new Vector2(5, 5));
            var box2 = new AABox2D(new Vector2(1, 1), new Vector2(2, 2));
            Assert.IsTrue(box1.Intersects(box2));
            Assert.IsTrue(box2.Intersects(box1));
        }

        [Test]
        public static void TestIntersects2()
        {
            var box1 = new AABox2D(new Vector2(0, 0), new Vector2(3, 3));
            var box2 = new AABox2D(new Vector2(1, -1), new Vector2(2, 7));
            Assert.IsTrue(box1.Intersects(box2));
            Assert.IsTrue(box2.Intersects(box1));
        }

        [Test]
        public static void TestIntersects3()
        {
            var box1 = new AABox2D(new Vector2(0, 0), new Vector2(3, 3));
            var box2 = new AABox2D(new Vector2(1, -1), new Vector2(2, 2));
            Assert.IsTrue(box1.Intersects(box2));
            Assert.IsTrue(box2.Intersects(box1));
        }

        [Test]
        public static void TestIntersects4()
        {
            var box1 = new AABox2D(new Vector2(0, 0), new Vector2(3, 3));
            var box2 = new AABox2D(new Vector2(3, 3), new Vector2(5, 5));
            Assert.IsTrue(box1.Intersects(box2));
            Assert.IsTrue(box2.Intersects(box1));
        }
    }
}
