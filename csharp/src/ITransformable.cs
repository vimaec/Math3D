using System.Linq;

namespace Vim.Math3d
{
    public interface ITransformable3D<TSelf>
    {
        TSelf Transform(Matrix4x4 mat);
    }

    public static class Transformable3D
    {
        public static Matrix4x4 Multiply(params Matrix4x4[] matrices)
            => matrices.Aggregate(Matrix4x4.Identity, (m1, m2) => m1 * m2);

        public static T Transform<T>(this ITransformable3D<T> self, params Matrix4x4[] matrices)
            => self.Transform(Multiply(matrices));

        public static T Translate<T>(this ITransformable3D<T> self, Vector3 offset)
            => self.Transform(Matrix4x4.CreateTranslation(offset));

        public static T Translate<T>(this ITransformable3D<T> self, float x, float y, float z)
            => self.Translate(new Vector3(x, y, z));

        public static T Rotate<T>(this ITransformable3D<T> self, Quaternion q)
            => self.Transform(Matrix4x4.CreateRotation(q));

        public static T Scale<T>(this ITransformable3D<T> self, float scale)
            => self.Scale(new Vector3(scale, scale, scale));

        public static T Scale<T>(this ITransformable3D<T> self, Vector3 scales)
            => self.Transform(Matrix4x4.CreateScale(scales));

        public static T Scale<T>(this ITransformable3D<T> self, float x, float y, float z)
            => self.Scale(new Vector3(x, y, z));

        public static T ScaleX<T>(this ITransformable3D<T> self, float x)
            => self.Scale(x, 0, 0);

        public static T ScaleY<T>(this ITransformable3D<T> self, float y)
            => self.Scale(0, y, 0);

        public static T ScaleZ<T>(this ITransformable3D<T> self, float z)
            => self.Scale(0, 0, z);

        public static T LookAt<T>(this ITransformable3D<T> self, Vector3 cameraPosition, Vector3 cameraTarget, Vector3 cameraUpVector)
            => self.Transform(Matrix4x4.CreateLookAt(cameraPosition, cameraTarget, cameraUpVector));

        public static T RotateAround<T>(this ITransformable3D<T> self, Vector3 axis, float angle)
            => self.Transform(Matrix4x4.CreateFromAxisAngle(axis, angle));

        public static T Rotate<T>(this ITransformable3D<T> self, float yaw, float pitch, float roll)
            => self.Transform(Matrix4x4.CreateFromYawPitchRoll(yaw, pitch, roll));

        public static T Reflect<T>(this ITransformable3D<T> self, Plane plane)
            => self.Transform(Matrix4x4.CreateReflection(plane));

        public static T RotateX<T>(this ITransformable3D<T> self, float angle)
            => self.RotateAround(Vector3.UnitX, angle);

        public static T RotateY<T>(this ITransformable3D<T> self, float angle)
            => self.RotateAround(Vector3.UnitY, angle);

        public static T RotateZ<T>(this ITransformable3D<T> self, float angle)
            => self.RotateAround(Vector3.UnitZ, angle);

        public static T TranslateRotateScale<T>(this ITransformable3D<T> self, Vector3 pos, Quaternion rot, Vector3 scale) where T : ITransformable3D<T>
            => self.Translate(pos).Rotate(rot).Scale(scale);
    }
}
