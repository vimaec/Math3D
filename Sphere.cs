// MIT License 
// Copyright (C) 2018 Ara 3D. Inc
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;

namespace Ara3D
{
    /// <summary>
    /// Describes a sphere in 3D-space for bounding operations.
    /// </summary>
    public partial struct Sphere 
    {        
        /// <summary>
        /// Test if a bounding box is fully inside, outside, or just intersecting the sphere.
        /// </summary>
        /// <param name="box">The box for testing.</param>
        /// <returns>The containment type.</returns>
        public ContainmentType Contains(Box box)
        {
            //check if all corner is in sphere
            bool inside = true;
            foreach (var corner in box.Corners)
            {
                if (Contains(corner) == ContainmentType.Disjoint)
                {
                    inside = false;
                    break;
                }
            }

            if (inside)
                return ContainmentType.Contains;

            //check if the distance from sphere center to cube face < radius
            double dmin = 0;

            if (Center.X < box.Min.X)
				dmin += (Center.X - box.Min.X) * (Center.X - box.Min.X);

			else if (Center.X > box.Max.X)
					dmin += (Center.X - box.Max.X) * (Center.X - box.Max.X);

			if (Center.Y < box.Min.Y)
				dmin += (Center.Y - box.Min.Y) * (Center.Y - box.Min.Y);

			else if (Center.Y > box.Max.Y)
				dmin += (Center.Y - box.Max.Y) * (Center.Y - box.Max.Y);

			if (Center.Z < box.Min.Z)
				dmin += (Center.Z - box.Min.Z) * (Center.Z - box.Min.Z);

			else if (Center.Z > box.Max.Z)
				dmin += (Center.Z - box.Max.Z) * (Center.Z - box.Max.Z);

			if (dmin <= Radius * Radius) 
				return ContainmentType.Intersects;
            
            //else disjoint
            return ContainmentType.Disjoint;
        }

        /// <summary>
        /// Test if a sphere is fully inside, outside, or just intersecting the sphere.
        /// </summary>
        public ContainmentType Contains(Sphere sphere)
        {
            var sqDistance = Vector3.DistanceSquared(sphere.Center, Center);

            if (sqDistance > (sphere.Radius + Radius) * (sphere.Radius + Radius))
                return  ContainmentType.Disjoint;

            if (sqDistance <= (Radius - sphere.Radius) * (Radius - sphere.Radius))
                return ContainmentType.Contains;

            return ContainmentType.Intersects;
        }

        /// <summary>
        /// Test if a point is fully inside, outside, or just intersecting the sphere.
        /// </summary>
        public ContainmentType Contains(Vector3 point)
        {
            Contains(point, out ContainmentType result);
            return result;
        }

        /// <summary>
        /// Test if a point is fully inside, outside, or just intersecting the sphere.
        /// </summary>
        public void Contains(Vector3 point, out ContainmentType result)
        {
            float sqRadius = Radius * Radius;
            float sqDistance = Vector3.DistanceSquared(point, Center);
            
            if (sqDistance > sqRadius)
                result = ContainmentType.Disjoint;

            else if (sqDistance < sqRadius)
                result = ContainmentType.Contains;

            else 
                result = ContainmentType.Intersects;
        }

        /// <summary>
        /// Creates the smallest sphere that contains the box. 
        /// </summary>
        public static Sphere CreateFromBoundingBox(Box box)
        {
            var center = box.Center;
            float radius = Vector3.Distance(center, box.Max);
            return new Sphere(center, radius);
        }

        /// <summary>
        /// Creates the smallest Sphere that contains the given points 
        /// </summary>
        public static Sphere Create(IEnumerable<Vector3> points)
        {
            if (points == null )
                throw new ArgumentNullException(nameof(points));

            // From "Real-Time Collision Detection" (Page 89)

            var minx = new Vector3(float.MaxValue, float.MaxValue, float.MaxValue);
            var maxx = -minx;
            var miny = minx;
            var maxy = -minx;
            var minz = minx;
            var maxz = -minx;

            // Find the most extreme points along the principle axis.
            var numPoints = 0;           
            foreach (var pt in points)
            {
                ++numPoints;

                if (pt.X < minx.X) 
                    minx = pt;
                if (pt.X > maxx.X) 
                    maxx = pt;
                if (pt.Y < miny.Y) 
                    miny = pt;
                if (pt.Y > maxy.Y) 
                    maxy = pt;
                if (pt.Z < minz.Z) 
                    minz = pt;
                if (pt.Z > maxz.Z) 
                    maxz = pt;
            }

            if (numPoints == 0)
                throw new ArgumentException("You should have at least one point in points.");

            var sqDistX = Vector3.DistanceSquared(maxx, minx);
            var sqDistY = Vector3.DistanceSquared(maxy, miny);
            var sqDistZ = Vector3.DistanceSquared(maxz, minz);

            // Pick the pair of most distant points.
            var min = minx;
            var max = maxx;
            if (sqDistY > sqDistX && sqDistY > sqDistZ) 
            {
                max = maxy;
                min = miny;
            }
            if (sqDistZ > sqDistX && sqDistZ > sqDistY) 
            {
                max = maxz;
                min = minz;
            }
            
            var center = (min + max) * 0.5f;
            var radius = Vector3.Distance(max, center);
            
            // Test every point and expand the sphere.
            // The current bounding sphere is just a good approximation and may not enclose all points.            
            // From: Mathematics for 3D Game Programming and Computer Graphics, Eric Lengyel, Third Edition.
            // Page 218
            float sqRadius = radius * radius;
            foreach (var pt in points)
            {
                Vector3 diff = (pt-center);
                float sqDist = diff.LengthSquared();
                if (sqDist > sqRadius)
                {
                    float distance = (float)Math.Sqrt(sqDist); // equal to diff.Length();
                    Vector3 direction = diff / distance;
                    Vector3 G = center - radius * direction;
                    center = (G + pt) / 2;
                    radius = Vector3.Distance(pt, center);
                    sqRadius = radius * radius;
                }
            }

            return new Sphere(center, radius);
        }

        /// <summary>
        /// Creates a sphere from the given points
        /// </summary>
        public static Sphere Create(params Vector3[] points)
        {
            return Create(points.AsEnumerable());
        }
        
        /// <summary>
        /// Creates a sphere merging it with another 
        /// </summary>
        public Sphere Merge(Sphere additional)
        {
            var ocenterToaCenter = Vector3.Subtract(additional.Center, Center);
            var distance = ocenterToaCenter.Length();
            if (distance <= Radius + additional.Radius)//intersect
            {
                if (distance <= Radius - additional.Radius)//original contain additional
                {
                    return this;
                }
                if (distance <= additional.Radius - Radius)//additional contain original
                {
                    return additional;
                }
            }
            //else find center of new sphere and radius
            float leftRadius = Math.Max(Radius - distance, additional.Radius);
            float Rightradius = Math.Max(Radius + distance, additional.Radius);
            ocenterToaCenter = ocenterToaCenter + (((leftRadius - Rightradius) / (2 * ocenterToaCenter.Length())) * ocenterToaCenter);
            return new Sphere(Center + ocenterToaCenter, (leftRadius + Rightradius) / 2);
        }

        /// <summary>
        /// Gets whether or not a specified <see cref="Box"/> intersects with this sphere.
        /// </summary>
        public bool Intersects(Box box)
        {
			return box.Intersects(this);
        }

        /// <summary>
        /// <summary>
        /// Gets whether or not the other <see cref="Sphere"/> intersects with this sphere.
        /// </summary>
        public bool Intersects(Sphere sphere)
        {
            var sqDistance = Vector3.DistanceSquared(sphere.Center, Center);
            return !(sqDistance > (sphere.Radius + Radius) * (sphere.Radius + Radius));
        }

        /// <summary>
        /// Gets whether or not a specified <see cref="Plane"/> intersects with this sphere.
        /// </summary>
        public PlaneIntersectionType Intersects(Plane plane)
        {
            var distance = Vector3.Dot(plane.Normal, Center);
            distance += plane.D;
            if (distance > Radius)
                return PlaneIntersectionType.Front;
            if (distance < -Radius)
                return PlaneIntersectionType.Back;
            return PlaneIntersectionType.Intersecting;
        }

        /// <summary>
        /// Gets whether or not a specified <see cref="Ray"/> intersects with this sphere.
        /// </summary>
        public float? Intersects(Ray ray)
        {
            return ray.Intersects(this);
        }

        public Sphere Transform(Matrix4x4 matrix)
        {
            // TODO: simplify this expression
            return new Sphere(Center.Transform(matrix), Radius * ((float)Math.Sqrt((double)Math.Max(((matrix.M11 * matrix.M11) + (matrix.M12 * matrix.M12)) + (matrix.M13 * matrix.M13), Math.Max(((matrix.M21 * matrix.M21) + (matrix.M22 * matrix.M22)) + (matrix.M23 * matrix.M23), ((matrix.M31 * matrix.M31) + (matrix.M32 * matrix.M32)) + (matrix.M33 * matrix.M33))))));
        }
    }
}
