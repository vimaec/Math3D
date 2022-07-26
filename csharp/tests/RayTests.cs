using NUnit.Framework;
using System;
using System.Diagnostics;

namespace Vim.Math3d.Tests
{
    [TestFixture]
    public static class RayTests
    {
        [Test]
        public static void Ray_IntersectBox_IsFalse_OutsideBox()
        {
            var ray = new Ray(new Vector3(-2, 0, -2), new Vector3(0, 0, 1));
            var box = new AABox(new Vector3(-1, -1, -1), new Vector3(1, 1, 1));

            Assert.IsNull(ray.Intersects(box));
        }

        [Test]
        public static void Ray_IntersectBox_IsTrue_Through()
        {
            var front = new Ray(new Vector3(0, 0, -2), new Vector3(0, 0, 1));
            var back = new Ray(new Vector3(0, 0, 2), new Vector3(0, 0, -1));
            var left = new Ray(new Vector3(-2, 0, 0), new Vector3(1, 0, 0));
            var right = new Ray(new Vector3(2, 0, 0), new Vector3(-1, 0, 0));
            var top = new Ray(new Vector3(0, 2, 0), new Vector3(0, -1, 0));
            var under = new Ray(new Vector3(0, -2, 0), new Vector3(0, 1, 0));

            var sides = new (Ray ray, string msg, float min, float max)[]
            {
                (front, nameof(front), 1, 3),
                (back, nameof(back), 1, 3),
                (left, nameof(left), 1, 3),
                (right, nameof(right), 1, 3),
                (top, nameof(top), 1, 3),
                (under, nameof(under), 1, 3),
            };

            var box = new AABox(new Vector3(-1, -1, -1), new Vector3(1, 1, 1));

            foreach (var (ray, msg, min, max) in sides)
            {
                Assert.IsNotNull(ray.Intersects(box), msg);
            }
        }


        [Test]
        public static void Ray_IntersectBox_IsTrue_ThroughDiagonals()
        {
            var XYnZ = new Ray(new Vector3(2, 2, -2), new Vector3(-1, -1, 1));
            var nXYnZ = new Ray(new Vector3(-2, 2, -2), new Vector3(1, -1, 1));
            var nXnYnZ = new Ray(new Vector3(-2, -2, -2), new Vector3(1, 1, 1));
            var XnYnZ = new Ray(new Vector3(2, -2, -2), new Vector3(-1, 1, 1));

            var sides = new (Ray ray, string msg, float min, float max)[]
            {
                (XYnZ, nameof(XYnZ), 1, 3),
                (nXYnZ, nameof(nXYnZ), 1, 3),
                (nXnYnZ, nameof(nXnYnZ), 1, 3),
                (XnYnZ, nameof(XnYnZ), 1, 3),
            };

            var box = new AABox(new Vector3(-1, -1, -1), new Vector3(1, 1, 1));

            foreach (var (ray, msg, min, max) in sides)
            {
                Assert.IsNotNull(ray.Intersects(box), msg);
            }
        }


        [Test]
        public static void Ray_IntersectBox_IsFalse_AwayFromBox()
        {
            var front = new Ray(new Vector3(0, 0, -2), new Vector3(0, 0, -1));
            var back = new Ray(new Vector3(0, 0, 2), new Vector3(0, 0, 1));
            var left = new Ray(new Vector3(-2, 0, 0), new Vector3(-1, 0, 0));
            var right = new Ray(new Vector3(2, 0, 0), new Vector3(1, 0, 0));
            var top = new Ray(new Vector3(0, 2, 0), new Vector3(0, 1, 0));
            var under = new Ray(new Vector3(0, -2, 0), new Vector3(0, -1, 0));

            var sides = new (Ray, string)[]
            {
                (front, nameof(front)),
                (back, nameof(back)),
                (left, nameof(left)),
                (right, nameof(right)),
                (top, nameof(top)),
                (under, nameof(under)),
            };

            var box = new AABox(new Vector3(-1, -1, -1), new Vector3(1, 1, 1));

            foreach (var (ray, msg) in sides)
            {
                Assert.IsNull(ray.Intersects(box), msg);
            }
        }

        [Test]
        public static void Ray_IntersectBox_IsTrue_OnEdge()
        {
            var front = new Ray(new Vector3(0, 2, -1), new Vector3(0, -1, 0));
            var back = new Ray(new Vector3(0, 2, 1), new Vector3(0, -1, 0));
            var left = new Ray(new Vector3(-1, 0, -2), new Vector3(0, 0, 1));
            var right = new Ray(new Vector3(1, 0, -2), new Vector3(0, 0, 1));
            var top = new Ray(new Vector3(0, 1, -2), new Vector3(0, 0, 1));
            var under = new Ray(new Vector3(0, -1, -2), new Vector3(0, 0, 1));

            var sides = new (Ray, string)[]
            {
                (front, nameof(front)),
                (back, nameof(back)),
                (left, nameof(left)),
                (right, nameof(right)),
                (top, nameof(top)),
                (under, nameof(under)),
            };

            var box = new AABox(new Vector3(-1, -1, -1), new Vector3(1, 1, 1));

            foreach (var (ray, msg) in sides)
            {
                Assert.IsNotNull(ray.Intersects(box), msg);
            }
        }

        [Test]
        public static void Ray_IntersectBox_IsFalse_NearEdge()
        {
            var ray = new Ray(new Vector3(0, 0, -2), new Vector3(0, 1.1f, 1));
            var box = new AABox(new Vector3(-1, -1, -1), new Vector3(1, 1, 1));

            Assert.IsNull(ray.Intersects(box));
        }

        [Test]
        public static void Ray_IntersectBox_IsTrue_FlatBox()
        {
            var box = new AABox(new Vector3(-1, -1, 0), new Vector3(1, 1, 0));
            var ray = new Ray(new Vector3(0, 0, -1), new Vector3(0, 0, 1));

            Assert.IsNotNull(ray.Intersects(box));
        }

        [Test]
        public static void Ray_IntersectTriangle_IsTrue_Inside()
        {
            var ray = new Ray(new Vector3(0, 0, -1), new Vector3(0, 0, 1));

            var triangle = new Triangle(
                new Vector3(0, 1, 0),
                new Vector3(1, -1, 0),
                new Vector3(-1, -1, 0)
            );

            Assert.IsNotNull(ray.Intersects(triangle));
        }

        [Test]
        public static void Ray_IntersectTriangle_IsFalse_Parralel()
        {
            var ray = new Ray(new Vector3(0, 0, -1), new Vector3(0, 0, 1));

            var triangle = new Triangle(
                new Vector3(1, 0, 0),
                new Vector3(-1, 0, 0),
                new Vector3(0, 0, 1)
            );

            Assert.IsNull(ray.Intersects(triangle));
        }

        [Test]
        public static void Ray_IntersectTriangle_IsTrue_OnCorner()
        {
            var ray = new Ray(new Vector3(0, 1, -1), new Vector3(0, 0, 1));

            var triangle = new Triangle(
                new Vector3(0, 1, 0),
                new Vector3(1, -1, 0),
                new Vector3(-1, -1, 0)
            );

            Assert.IsNotNull(ray.Intersects(triangle));
        }

        [Test]
        public static void Ray_IntersectTriangle_IsFalse_InTrickyCorner()
        {
            var ray = new Ray(new Vector3(-0.1f, 0, -1), new Vector3(0, 0, 1));
            var triangle = new Triangle(new Vector3(0, 0, 0), new Vector3(-1, 1, 0), new Vector3(1, 0, 0));

            Assert.IsNull(ray.Intersects(triangle));
        }

        [Test, Explicit]
        public static void Ray_IntersectTriangle_PerfTest()
        {
            //IsFalse_InTrickyCorner
            var ray1 = new Ray(new Vector3(-0.1f, 0, -1), new Vector3(0, 0, 1));
            var triangle1 = new Triangle(new Vector3(0, 0, 0), new Vector3(-1, 1, 0), new Vector3(1, 0, 0));

            //IsTrue_OnCorner
            var ray2 = new Ray(new Vector3(0, 1, -1), new Vector3(0, 0, 1));
            var triangle2 = new Triangle(new Vector3(0, 1, 0), new Vector3(1, -1, 0), new Vector3(-1, -1, 0));

            //IsTrue_OnCorner
            var ray3 = new Ray(new Vector3(0, 0, -1), new Vector3(0, 0, 1));
            var triangle3 = new Triangle(new Vector3(1, 0, 0), new Vector3(-1, 0, 0), new Vector3(0, 0, 1));

            // IsFalse_Parralel
            var ray4 = new Ray(new Vector3(0, 0, -1), new Vector3(0, 0, 1));
            var triangle4 = new Triangle(new Vector3(1, 0, 0), new Vector3(-1, 0, 0), new Vector3(0, 0, 1));

            var watch = new Stopwatch();
            for (var j = 0; j < 10; j++)
            {
                watch.Restart();
                for (var i = 0; i < 1000000; i++)
                {
                    ray1.Intersects(triangle1);
                    ray2.Intersects(triangle2);
                    ray3.Intersects(triangle3);
                    ray4.Intersects(triangle4);
                }
                watch.Stop();
                var thombore = watch.ElapsedMilliseconds;

                Console.WriteLine($"TomboreMoller {thombore} ms");
            }
        }
    }
}
