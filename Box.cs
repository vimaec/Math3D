// MIT License - Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Numerics;
using System.Runtime.Serialization;

namespace Ara3D
{
    [DataContract]
    [DebuggerDisplay("{DebugDisplayString,nq}")]
    public struct Box : IEquatable<Box>, IArray<Vector3>
    {
        [DataMember]
        public Vector3 Min;
      
        [DataMember]
        public Vector3 Max;

        public const int CornerCount = 8;

        public int Count { get { return 2;  } }

        public Vector3 this[int n] { get { return n == 0 ? Min : Max; } }

        public Box(Vector3 min, Vector3 max)
        {
            Min = min;
            Max = max;
        }

        public ContainmentType Contains(Box box)
        {
            //test if all corner is in the same side of a face by just checking min and max
            if (box.Max.X < Min.X
                || box.Min.X > Max.X
                || box.Max.Y < Min.Y
                || box.Min.Y > Max.Y
                || box.Max.Z < Min.Z
                || box.Min.Z > Max.Z)
                return ContainmentType.Disjoint;

            if (box.Min.X >= Min.X
                && box.Max.X <= Max.X
                && box.Min.Y >= Min.Y
                && box.Max.Y <= Max.Y
                && box.Min.Z >= Min.Z
                && box.Max.Z <= Max.Z)
                return ContainmentType.Contains;

            return ContainmentType.Intersects;
        }

        public void Contains(ref Box box, out ContainmentType result)
        {
            result = Contains(box);
        }

        public ContainmentType Contains(Sphere sphere)
        {
            if (sphere.Center.X - Min.X >= sphere.Radius
                && sphere.Center.Y - Min.Y >= sphere.Radius
                && sphere.Center.Z - Min.Z >= sphere.Radius
                && Max.X - sphere.Center.X >= sphere.Radius
                && Max.Y - sphere.Center.Y >= sphere.Radius
                && Max.Z - sphere.Center.Z >= sphere.Radius)
                return ContainmentType.Contains;

            double dmin = 0;

            double e = sphere.Center.X - Min.X;
            if (e < 0)
            {
                if (e < -sphere.Radius)
                {
                    return ContainmentType.Disjoint;
                }
                dmin += e * e;
            }
            else
            {
                e = sphere.Center.X - Max.X;
                if (e > 0)
                {
                    if (e > sphere.Radius)
                    {
                        return ContainmentType.Disjoint;
                    }
                    dmin += e * e;
                }
            }

            e = sphere.Center.Y - Min.Y;
            if (e < 0)
            {
                if (e < -sphere.Radius)
                {
                    return ContainmentType.Disjoint;
                }
                dmin += e * e;
            }
            else
            {
                e = sphere.Center.Y - Max.Y;
                if (e > 0)
                {
                    if (e > sphere.Radius)
                    {
                        return ContainmentType.Disjoint;
                    }
                    dmin += e * e;
                }
            }

            e = sphere.Center.Z - Min.Z;
            if (e < 0)
            {
                if (e < -sphere.Radius)
                {
                    return ContainmentType.Disjoint;
                }
                dmin += e * e;
            }
            else
            {
                e = sphere.Center.Z - Max.Z;
                if (e > 0)
                {
                    if (e > sphere.Radius)
                    {
                        return ContainmentType.Disjoint;
                    }
                    dmin += e * e;
                }
            }

            if (dmin <= sphere.Radius * sphere.Radius)
                return ContainmentType.Intersects;

            return ContainmentType.Disjoint;
        }

        public void Contains(ref Sphere sphere, out ContainmentType result)
        {
            result = Contains(sphere);
        }

        public ContainmentType Contains(Vector3 point)
        {
            Contains(ref point, out ContainmentType result);
            return result;
        }

        public void Contains(ref Vector3 point, out ContainmentType result)
        {
            //first we get if point is out of box
            if (point.X < Min.X
                || point.X > Max.X
                || point.Y < Min.Y
                || point.Y > Max.Y
                || point.Z < Min.Z
                || point.Z > Max.Z)
            {
                result = ContainmentType.Disjoint;
            }
            else
            {
                result = ContainmentType.Contains;
            }
        }

        public static readonly Vector3 MaxVector3 = new Vector3(float.MaxValue);
        public static readonly Vector3 MinVector3 = new Vector3(float.MinValue);

        /// <summary>
        /// Create a bounding box from the given list of points.
        /// </summary>
        /// <param name="points">The list of Vector3 instances defining the point cloud to bound</param>
        /// <returns>A bounding box that encapsulates the given point cloud.</returns>
        /// <exception cref="ArgumentException">Thrown if the given list has no points.</exception>
        public static Box CreateFromPoints(IEnumerable<Vector3> points)
        {
            var minVec = MaxVector3;
            var maxVec = MinVector3;
            foreach (var ptVector in points)
            {
                minVec.X = (minVec.X < ptVector.X) ? minVec.X : ptVector.X;
                minVec.Y = (minVec.Y < ptVector.Y) ? minVec.Y : ptVector.Y;
                minVec.Z = (minVec.Z < ptVector.Z) ? minVec.Z : ptVector.Z;
                maxVec.X = (maxVec.X > ptVector.X) ? maxVec.X : ptVector.X;
                maxVec.Y = (maxVec.Y > ptVector.Y) ? maxVec.Y : ptVector.Y;
                maxVec.Z = (maxVec.Z > ptVector.Z) ? maxVec.Z : ptVector.Z;
            }
            return new Box(minVec, maxVec);
        }

        public static Box CreateFromSphere(Sphere sphere)
        {
            CreateFromSphere(ref sphere, out Box result);
            return result;
        }

        public static void CreateFromSphere(ref Sphere sphere, out Box result)
        {
            var corner = new Vector3(sphere.Radius);
            result.Min = sphere.Center - corner;
            result.Max = sphere.Center + corner;
        }

        public static Box CreateMerged(Box original, Box additional)
        {
            CreateMerged(ref original, ref additional, out Box result);
            return result;
        }

        public static void CreateMerged(ref Box original, ref Box additional, out Box result)
        {
            result.Min.X = Math.Min(original.Min.X, additional.Min.X);
            result.Min.Y = Math.Min(original.Min.Y, additional.Min.Y);
            result.Min.Z = Math.Min(original.Min.Z, additional.Min.Z);
            result.Max.X = Math.Max(original.Max.X, additional.Max.X);
            result.Max.Y = Math.Max(original.Max.Y, additional.Max.Y);
            result.Max.Z = Math.Max(original.Max.Z, additional.Max.Z);
        }

        public bool Equals(Box other)
        {
            return (Min == other.Min) && (Max == other.Max);
        }

        public override bool Equals(object obj)
        {
            return (obj is Box) && Equals((Box)obj);
        }

        public Vector3[] GetCorners()
        {
            return new Vector3[] {
                new Vector3(Min.X, Max.Y, Max.Z), 
                new Vector3(Max.X, Max.Y, Max.Z),
                new Vector3(Max.X, Min.Y, Max.Z), 
                new Vector3(Min.X, Min.Y, Max.Z), 
                new Vector3(Min.X, Max.Y, Min.Z),
                new Vector3(Max.X, Max.Y, Min.Z),
                new Vector3(Max.X, Min.Y, Min.Z),
                new Vector3(Min.X, Min.Y, Min.Z)
            };
        }

        public void GetCorners(Vector3[] corners)
        {
            if (corners == null)
            {
                throw new ArgumentNullException(nameof(corners));
            }
            if (corners.Length < 8)
            {
                throw new ArgumentOutOfRangeException(nameof(corners));
            }
            corners[0].X = Min.X;
            corners[0].Y = Max.Y;
            corners[0].Z = Max.Z;
            corners[1].X = Max.X;
            corners[1].Y = Max.Y;
            corners[1].Z = Max.Z;
            corners[2].X = Max.X;
            corners[2].Y = Min.Y;
            corners[2].Z = Max.Z;
            corners[3].X = Min.X;
            corners[3].Y = Min.Y;
            corners[3].Z = Max.Z;
            corners[4].X = Min.X;
            corners[4].Y = Max.Y;
            corners[4].Z = Min.Z;
            corners[5].X = Max.X;
            corners[5].Y = Max.Y;
            corners[5].Z = Min.Z;
            corners[6].X = Max.X;
            corners[6].Y = Min.Y;
            corners[6].Z = Min.Z;
            corners[7].X = Min.X;
            corners[7].Y = Min.Y;
            corners[7].Z = Min.Z;
        }

        public override int GetHashCode()
        {
            return Min.GetHashCode() + Max.GetHashCode();
        }

        public bool Intersects(Box box)
        {
            Intersects(ref box, out bool result);
            return result;
        }

        public void Intersects(ref Box box, out bool result)
        {
            if ((Max.X >= box.Min.X) && (Min.X <= box.Max.X))
            {
                if ((Max.Y < box.Min.Y) || (Min.Y > box.Max.Y))
                {
                    result = false;
                    return;
                }

                result = (Max.Z >= box.Min.Z) && (Min.Z <= box.Max.Z);
                return;
            }

            result = false;
            return;
        }

        public bool Intersects(Frustum frustum)
        {
            return frustum.Intersects(this);
        }

        public bool Intersects(Sphere sphere)
        {
            if (sphere.Center.X - Min.X > sphere.Radius
                && sphere.Center.Y - Min.Y > sphere.Radius
                && sphere.Center.Z - Min.Z > sphere.Radius
                && Max.X - sphere.Center.X > sphere.Radius
                && Max.Y - sphere.Center.Y > sphere.Radius
                && Max.Z - sphere.Center.Z > sphere.Radius)
                return true;

            double dmin = 0;

            if (sphere.Center.X - Min.X <= sphere.Radius)
                dmin += (sphere.Center.X - Min.X) * (sphere.Center.X - Min.X);
            else if (Max.X - sphere.Center.X <= sphere.Radius)
                dmin += (sphere.Center.X - Max.X) * (sphere.Center.X - Max.X);

            if (sphere.Center.Y - Min.Y <= sphere.Radius)
                dmin += (sphere.Center.Y - Min.Y) * (sphere.Center.Y - Min.Y);
            else if (Max.Y - sphere.Center.Y <= sphere.Radius)
                dmin += (sphere.Center.Y - Max.Y) * (sphere.Center.Y - Max.Y);

            if (sphere.Center.Z - Min.Z <= sphere.Radius)
                dmin += (sphere.Center.Z - Min.Z) * (sphere.Center.Z - Min.Z);
            else if (Max.Z - sphere.Center.Z <= sphere.Radius)
                dmin += (sphere.Center.Z - Max.Z) * (sphere.Center.Z - Max.Z);

            if (dmin <= sphere.Radius * sphere.Radius)
                return true;

            return false;
        }

        public void Intersects(ref Sphere sphere, out bool result)
        {
            result = Intersects(sphere);
        }

        public PlaneIntersectionType Intersects(Plane plane)
        {
            Intersects(ref plane, out PlaneIntersectionType result);
            return result;
        }

        public void Intersects(ref Plane plane, out PlaneIntersectionType result)
        {
            // See http://zach.in.tu-clausthal.de/teaching/cg_literatur/lighthouse3d_view_frustum_culling/index.html

            Vector3 positiveVertex;
            Vector3 negativeVertex;

            if (plane.Normal.X >= 0)
            {
                positiveVertex.X = Max.X;
                negativeVertex.X = Min.X;
            }
            else
            {
                positiveVertex.X = Min.X;
                negativeVertex.X = Max.X;
            }

            if (plane.Normal.Y >= 0)
            {
                positiveVertex.Y = Max.Y;
                negativeVertex.Y = Min.Y;
            }
            else
            {
                positiveVertex.Y = Min.Y;
                negativeVertex.Y = Max.Y;
            }

            if (plane.Normal.Z >= 0)
            {
                positiveVertex.Z = Max.Z;
                negativeVertex.Z = Min.Z;
            }
            else
            {
                positiveVertex.Z = Min.Z;
                negativeVertex.Z = Max.Z;
            }

            // Inline Vector3.Dot(plane.Normal, negativeVertex) + plane.D;
            var distance = plane.Normal.X * negativeVertex.X + plane.Normal.Y * negativeVertex.Y + plane.Normal.Z * negativeVertex.Z + plane.D;
            if (distance > 0)
            {
                result = PlaneIntersectionType.Front;
                return;
            }

            // Inline Vector3.Dot(plane.Normal, positiveVertex) + plane.D;
            distance = plane.Normal.X * positiveVertex.X + plane.Normal.Y * positiveVertex.Y + plane.Normal.Z * positiveVertex.Z + plane.D;
            if (distance < 0)
            {
                result = PlaneIntersectionType.Back;
                return;
            }

            result = PlaneIntersectionType.Intersecting;
        }

        public float? Intersects(Ray ray)
        {
            // TODO: finish this
            throw new NotImplementedException();
            // return ray.Intersects(this);
        }
        
        public void Intersects(ref Ray ray, out float? result)
        {
            result = Intersects(ray);
        }

        public static bool operator ==(Box a, Box b)
        {
            return a.Equals(b);
        }

        public static bool operator !=(Box a, Box b)
        {
            return !a.Equals(b);
        }

        internal string DebugDisplayString => string.Concat(
                    "Min( ", Min.ToString(), " )  \r\n",
                    "Max( ", Max.ToString(), " )"
                    );

        public override string ToString()
        {
            return "{{Min:" + Min.ToString() + " Max:" + Max.ToString() + "}}";
        }

        /// <summary>
        /// Deconstruction method for <see cref="Box"/>.
        /// </summary>
        /// <param name="min"></param>
        /// <param name="max"></param>
        public void Deconstruct(out Vector3 min, out Vector3 max)
        {
            min = Min;
            max = Max;
        }
    }
}
