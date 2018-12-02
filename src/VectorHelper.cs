using System;
using System.Numerics;

namespace Ara3D
{
    public static class VectorHelper
    {
        public static Vector2 Select(this Vector2 self, Func<float, float> f)
        {
            return new Vector2(f(self.X), f(self.Y));
        }

        public static Vector3 Select(this Vector3 self, Func<float, float> f)
        {
            return new Vector3(f(self.X), f(self.Y), f(self.Y));
        }

        public static Vector4 Select(this Vector4 self, Func<float, float> f)
        {
            return new Vector4(f(self.X), f(self.Y), f(self.Z), f(self.W));
        }

        public static Vector2 Zip(this Vector2 self, Vector2 v, Func<float, float, float> f)
        {
            return new Vector2(f(self.X, v.X), f(self.Y, v.Y));
        }

        public static Vector3 Zip(this Vector3 self, Vector3 v, Func<float, float, float> f)
        {
            return new Vector3(f(self.X, v.X), f(self.Y, v.Y), f(self.Z, v.Z));
        }

        public static Vector4 Zip(this Vector4 self, Vector4 v, Func<float, float, float> f)
        {
            return new Vector4(f(self.X, v.X), f(self.Y, v.Y), f(self.Z, v.Z), f(self.W, v.W));
        }

        public static float DistanceTo(this Vector3 a, Vector3 b)
        {
            return Vector3.Distance(a, b);
        }

        public static float DistanceTo(this Vector2 a, Vector2 b)
        {
            return Vector2.Distance(a, b);
        }

        public static float Dot(this Vector3 a, Vector3 b)
        {
            return Vector3.Dot(a, b);
        }

        public static float Dot(this Vector2 a, Vector2 b)
        {
            return Vector2.Dot(a, b);
        }

        public static Vector3 Cross(this Vector3 a, Vector3 b)
        {
            return Vector3.Cross(a, b);
        }

        public static Vector3 Normal(this Vector3 self)
        {
            return Vector3.Normalize(self);
        }

        public static Vector3 Transform(this Vector3 self, Matrix4x4 matrix)
        {
            return Vector3.Transform(self, matrix);
        }

        public static Vector3 Transform(this Vector3 self, Quaternion quat)
        {
            return Vector3.Transform(self, quat);
        }

        public static Vector3 Transform(this Vector2 self, Matrix4x4 matrix)
        {
            return self.To3D().Transform(matrix);
        }

        public static Vector3 Transform(this Vector2 self, Quaternion quat)
        {
            return self.To3D().Transform(quat);
        }

        public static Vector3 To3D(this Vector2 self)
        {
            return new Vector3(self.X, self.Y, 0);
        }
    }
}
