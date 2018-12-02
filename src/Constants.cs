using System;
using System.Numerics;

namespace Ara3D
{
    public static class Constants
    {
        public readonly static Plane XYPlane = new Plane(Vector3.UnitZ, 0);
        public readonly static Plane XZPlane = new Plane(Vector3.UnitY, 0);
        public readonly static Plane YZPlane = new Plane(Vector3.UnitX, 0);

        public const float PI = (float)Math.PI;
        public const float PI2 = PI * 2f;


    }
}
