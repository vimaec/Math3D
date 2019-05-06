using System.Collections.Generic;
using System.Linq;

namespace Ara3D.Experimental
{
    public interface ITransformable<T>
    {
        T Transform(Matrix4x4 mat);
    }

    public interface IPositionRotationScale
    {
        Vector3 Position { get; }
        Quaternion Rotation { get; }
        Vector3 Scale { get; }
    }

    public interface IPoints
    {
        IEnumerable<Vector3> Points { get; }
    }

    public interface IPolygon : IPoints
    {  }

    public interface IRange<T>
    {
        T Min { get; }
        T Max { set; }
    }
    
    public interface IField<T> 
    {
        T Sample(Vector3 point);
        Vector3 Domain { get; }
        // Could be null
        IRange<T> Range { get; }
        
        // To be considered 
        //bool PeriodicX { get; }
        //bool PeriodicY { get; }
        //bool PeriodicZ { get; }
    }

    public interface IVectorField : IField<Vector3>
    { }

    public interface ISignedDistanceField : IField<float>
    { }

    public interface ICurve
    {
        // This is what makes something a 3D curve: a parameterization on 1D
        Vector3 Query(float t);

        // Magnitude gives distance, note similar to an SDF 
        Vector3 ClosestPoint(Vector3 v);

        // Could also be called an "extent", and is also effectively the bounding box
        IRange<Vector3> Range { get; }
    }

    public interface ISurface
    {
        // This is what makes something a 3D surface: a parameterization on 2D
        Vector3 QuerySurface(Vector2 uv);

        // Magnitude gives distance, note similar to an SDF 
        Vector3 ClosestPoint(Vector3 v);

        // Could also be called an "extent", and is also effectively the bounding box
        IRange<Vector3> Range { get; }
    }

    // Closed shapes when they are extruded create volumes. 
    // 
    public interface IClosedShape : ICurve
    { }

    public interface IVolume
    {
        // This is what makes something a 3D volume: a distance function (which is effectively a boolean with extra info) 
        // Distance of "0" means inside of volume. 
        float Distance(Vector3 point);

        ISurface Surface { get; }

        // Magnitude gives distance, note similar to an SDF
        // Note: inside volume, the point is unchanged. 
        // This is like a "Clamp" or constraint 
        Vector3 ClosestPoint(Vector3 v);

        // Could also be called an "extent", and is also effectively the bounding box
        IRange<Vector3> Range { get; }
    }
   
    public interface IPrimitiveShape :
        IPolygon, IPositionRotationScale, ITransformable<IPrimitiveVolume>
    { }

    public interface IPrimitiveCurve : ICurve, IPositionRotationScale, ITransformable<IPrimitiveVolume>
    {
    }

    public interface IPrimitiveVolume : IVolume, IPositionRotationScale, ITransformable<IPrimitiveVolume>
    {
    }

    // This assumes a linear extrusion. This is a degenerate case of ILoftedCurve
    public interface IExtrudedCurve : ISurface
    {
        ICurve From { get; }
        ICurve To { get; }
    }

    // Sampling a curve along 0..1 gives us some interesting shapes. 
    public interface ILoftedCurve : ISurface
    {
        ICurve Sample(float t);
    }

    public static class PrimitiveShapes
    {
        // Not sure this should be a shape (it isn't closed)
        public static readonly IPrimitiveCurve LineSegment;   
        
        public static readonly IPrimitiveShape Circle;
        public static readonly IPrimitiveShape Triangle;
        public static readonly IPrimitiveShape Square;
        public static readonly IPrimitiveShape Hexagon;
        public static readonly IPrimitiveShape Pentagon;

        public static readonly IPrimitiveVolume Box;
        public static readonly IPrimitiveVolume Cone;
        public static readonly IPrimitiveVolume Capsule;
        public static readonly IPrimitiveVolume Cylinder;
        public static readonly IPrimitiveVolume Sphere;
        public static readonly IPrimitiveVolume Pyramid;
        public static readonly IPrimitiveVolume Prism;
        public static readonly IPrimitiveVolume Tetrahedron;
        public static readonly IPrimitiveVolume Octahedron;
        public static readonly IPrimitiveVolume Dodecahedron;
        public static readonly IPrimitiveVolume Icosahedron;

        // Other things: hollowed out / constrained / 
    }


    public static class Transformable
    {
        public static Matrix4x4 Multiply(params Matrix4x4[] matrices)
            => matrices.Aggregate(Matrix4x4.Identity, (m1, m2) => m1 * m2);

        public static T Transform<T>(this ITransformable<T> self, params Matrix4x4[] matrices) 
            => self.Transform(Multiply(matrices));

        public static T Translate<T>(this ITransformable<T> self, Vector3 offset)
            => self.Transform(Matrix4x4.CreateTranslation(offset));

        public static T Translate<T>(this ITransformable<T> self, float x, float y, float z)
            => self.Translate(new Vector3(x, y, z));

        public static T Rotate<T>(this ITransformable<T> self, Quaternion q)
            => self.Transform(Matrix4x4.CreateFromQuaternion(q));

        public static T Scale<T>(this ITransformable<T> self, Vector3 scales)
            => self.Transform(Matrix4x4.CreateScale(scales));

        public static T Scale<T>(this ITransformable<T> self, float x, float y, float z)
            => self.Scale(new Vector3(x, y, z));

        public static T ScaleX<T>(this ITransformable<T> self, float x)
            => self.Scale(x, 0, 0);

        public static T ScaleY<T>(this ITransformable<T> self, float y)
            => self.Scale(0, y, 0);

        public static T ScaleZ<T>(this ITransformable<T> self, float z)
            => self.Scale(0, 0, z);

        public static T LookAt<T>(this ITransformable<T> self, Vector3 cameraPosition, Vector3 cameraTarget, Vector3 cameraUpVector)
            => self.Transform(Matrix4x4.CreateLookAt(cameraPosition, cameraTarget, cameraUpVector));

        public static T RotateAround<T>(this ITransformable<T> self, Vector3 axis, float angle)
            => self.Transform(Matrix4x4.CreateFromAxisAngle(axis, angle));

        public static T Rotate<T>(this ITransformable<T> self, float yaw, float pitch, float roll)
            => self.Transform(Matrix4x4.CreateFromYawPitchRoll(yaw, pitch, roll));

        public static T Reflect<T>(this ITransformable<T> self, Plane plane)
            => self.Transform(Matrix4x4.CreateReflection(plane));

        public static T RotateX<T>(this ITransformable<T> self, float angle)
            => self.RotateAround(Vector3.UnitX, angle);

        public static T RotateY<T>(this ITransformable<T> self, float angle)
            => self.RotateAround(Vector3.UnitY, angle);

        public static T RotateZ<T>(this ITransformable<T> self, float angle)
            => self.RotateAround(Vector3.UnitZ, angle);

        public static T TranslateRotateScale<T>(this ITransformable<T> self, Vector3 pos, Quaternion rot, Vector3 scale) where T : ITransformable<T>
            => self.Translate(pos).Rotate(rot).Scale(scale);
    }
}
