// MIT License 
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;

namespace Ara3D
{
    public partial struct Ray : ITransformable3D<Ray>
    {
        // adapted from http://www.scratchapixel.com/lessons/3d-basic-lessons/lesson-7-intersecting-simple-shapes/ray-box-intersection/
        public float? Intersects(AABox box)
        {
            const float Epsilon = 1e-6f;

            float? tMin = null, tMax = null;

            if (Math.Abs(Direction.X) < Epsilon)
            {
                if (Position.X < box.Min.X || Position.X > box.Max.X)
                    return null;
            }
            else
            {
                tMin = (box.Min.X - Position.X) / Direction.X;
                tMax = (box.Max.X - Position.X) / Direction.X;

                if (tMin > tMax)
                {
                    var temp = tMin;
                    tMin = tMax;
                    tMax = temp;
                }
            }

            if (Math.Abs(Direction.Y) < Epsilon)
            {
                if (Position.Y < box.Min.Y || Position.Y > box.Max.Y)
                    return null;
            }
            else
            {
                var tMinY = (box.Min.Y - Position.Y) / Direction.Y;
                var tMaxY = (box.Max.Y - Position.Y) / Direction.Y;

                if (tMinY > tMaxY)
                {
                    var temp = tMinY;
                    tMinY = tMaxY;
                    tMaxY = temp;
                }

                if ((tMin.HasValue && tMin > tMaxY) || (tMax.HasValue && tMinY > tMax))
                    return null;

                if (!tMin.HasValue || tMinY > tMin) tMin = tMinY;
                if (!tMax.HasValue || tMaxY < tMax) tMax = tMaxY;
            }

            if (Math.Abs(Direction.Z) < Epsilon)
            {
                if (Position.Z < box.Min.Z || Position.Z > box.Max.Z)
                    return null;
            }
            else
            {
                var tMinZ = (box.Min.Z - Position.Z) / Direction.Z;
                var tMaxZ = (box.Max.Z - Position.Z) / Direction.Z;

                if (tMinZ > tMaxZ)
                {
                    var temp = tMinZ;
                    tMinZ = tMaxZ;
                    tMaxZ = temp;
                }

                if ((tMin.HasValue && tMin > tMaxZ) || (tMax.HasValue && tMinZ > tMax))
                    return null;

                if (!tMin.HasValue || tMinZ > tMin) tMin = tMinZ;
                if (!tMax.HasValue || tMaxZ < tMax) tMax = tMaxZ;
            }

            // having a positive tMin and a negative tMax means the ray is inside the box
            // we expect the intesection distance to be 0 in that case
            if (tMin.HasValue && tMin < 0 && tMax > 0) return 0;

            // a negative tMin means that the intersection point is behind the ray's origin
            // we discard these as not hitting the AABB
            if (tMin < 0) return null;

            return tMin;
        }

        public float? Intersects(Plane plane, float tolerance = Constants.Tolerance)
        {
            var den = Vector3.Dot(Direction, plane.Normal);
            if (den.Abs() < tolerance)
                return null;

            var result = (-plane.D - Vector3.Dot(plane.Normal, Position)) / den;

            if (result < 0.0f)
            {
                if (result < -tolerance)
                {
                    return null;
                }

                result = 0.0f;
            }
            return result;
        }

        public float? Intersects(Sphere sphere)
        {
            // Find the vector between where the ray starts the the sphere's centre
            var difference = sphere.Center - Position;
            var differenceLengthSquared = difference.LengthSquared();
            var sphereRadiusSquared = sphere.Radius * sphere.Radius;

            // If the distance between the ray start and the sphere's centre is less than
            // the radius of the sphere, it means we've intersected. N.B. checking the LengthSquared is faster.
            if (differenceLengthSquared < sphereRadiusSquared)
                return 0.0f;

            var distanceAlongRay = Vector3.Dot(Direction, difference);

            // If the ray is pointing away from the sphere then we don't ever intersect
            if (distanceAlongRay < 0)
                return null;

            // Next we kinda use Pythagoras to check if we are within the bounds of the sphere
            // if x = radius of sphere
            // if y = distance between ray position and sphere centre
            // if z = the distance we've travelled along the ray
            // if x^2 + z^2 - y^2 < 0, we do not intersect
            var dist = sphereRadiusSquared + distanceAlongRay.Sqr() - differenceLengthSquared;
            return (dist < 0) ? null : distanceAlongRay - (float?)Math.Sqrt(dist);
        }

        public Ray Transform(Matrix4x4 mat)
            => new Ray(Position.Transform(mat), Direction.TransformNormal(mat));
    }
}
