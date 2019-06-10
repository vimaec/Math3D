using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ara3D.Experimental
{
    // ISliceable? 
    // IRayHittable? 
    // ISignedDistanceField?
    // http://jamie-wong.com/2016/07/15/ray-marching-signed-distance-functions/

    public interface IPositionRotationScale
        {
            Vector3 Position { get; }
            Quaternion Rotation { get; }
            Vector3 Scale { get; }
        }

        public interface IPoints<T> : ITransformable3D<T>
        {
            IEnumerable<Vector3> Points { get; }
            T SetPoints(IEnumerable<Vector3> points);
        }

        public interface IPolygon : IPoints
        { }

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
            IPolygon, IPositionRotationScale, ITransformable3D<IPrimitiveVolume>
        { }

        public interface IPrimitiveCurve : ICurve, IPositionRotationScale, ITransformable3D<IPrimitiveVolume>
        {
        }

        public interface IPrimitiveVolume : IVolume, IPositionRotationScale, ITransformable3D<IPrimitiveVolume>
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
}
