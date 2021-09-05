// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2018 Ara 3D. Inc
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;

namespace Vim.Math3d
{
    public partial struct AABox : ITransformable3D<AABox>
    {
        public int Count
            => 2;

        public Vector3 CenterBottom
            => Center.SetZ(Min.Z);

        public Vector3[] Corners
            => GetCorners();

        public bool IsEmpty
            => !IsValid;

        public bool IsValid
            => Min.X <= Max.X && Min.Y <= Max.Y && Min.Z < Max.Z;

        // Inspired by: https://stackoverflow.com/questions/5254838/calculating-distance-between-a-point-and-a-rectangular-box-nearest-point
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float Distance(Vector3 point)
            => Vector3.Zero.Max(Min - point).Max(point - Max).Length();

        /// <summary>
        /// Returns the distance of the point to the box center. 
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float CenterDistance(Vector3 point)
            => Center.Distance(point);

        /// <summary>
        /// Moves the box by the given vector offset
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public AABox Translate(Vector3 offset)
            => new AABox(Min + offset, Max + offset);

        public float DistanceToOrigin
            => Distance(Vector3.Zero);

        public float CenterDistanceToOrigin
            => CenterDistance(Vector3.Zero);

        public float Volume
            => IsEmpty ? 0 : Extent.ProductComponents();

        public Vector3 this[int n]
            => n == 0 ? Min : Max;

        public float MaxSide
            => Extent.MaxComponent();

        public float MaxFaceArea
            => Extent.X > Extent.Y
                ? Extent.X * Extent.Z.Max(Extent.Y)
                : Extent.Y * Extent.Z.Max(Extent.X);

        public float MinSide
            => Extent.MinComponent();

        public float Diagonal
            => Extent.Length();

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public ContainmentType Contains(AABox box)
        {
            //test if all corner is in the same side of a face by just checking min and max
            if (box.Max.X < Min.X
                || box.Min.X > Max.X
                || box.Max.Y < Min.Y
                || box.Min.Y > Max.Y
                || box.Max.Z < Min.Z
                || box.Min.Z > Max.Z)
            {
                return ContainmentType.Disjoint;
            }

            if (box.Min.X >= Min.X
                && box.Max.X <= Max.X
                && box.Min.Y >= Min.Y
                && box.Max.Y <= Max.Y
                && box.Min.Z >= Min.Z
                && box.Max.Z <= Max.Z)
            {
                return ContainmentType.Contains;
            }

            return ContainmentType.Intersects;
        }

        public ContainmentType Contains(Sphere sphere)
        {
            if (sphere.Center.X - Min.X >= sphere.Radius
                && sphere.Center.Y - Min.Y >= sphere.Radius
                && sphere.Center.Z - Min.Z >= sphere.Radius
                && Max.X - sphere.Center.X >= sphere.Radius
                && Max.Y - sphere.Center.Y >= sphere.Radius
                && Max.Z - sphere.Center.Z >= sphere.Radius)
            {
                return ContainmentType.Contains;
            }

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
                    return ContainmentType.Disjoint;
                dmin += e * e;
            }
            else
            {
                e = sphere.Center.Y - Max.Y;
                if (e > 0)
                {
                    if (e > sphere.Radius)
                        return ContainmentType.Disjoint;
                    dmin += e * e;
                }
            }

            e = sphere.Center.Z - Min.Z;
            if (e < 0)
            {
                if (e < -sphere.Radius)
                    return ContainmentType.Disjoint;
                dmin += e * e;
            }
            else
            {
                e = sphere.Center.Z - Max.Z;
                if (e > 0)
                {
                    if (e > sphere.Radius)
                        return ContainmentType.Disjoint;
                    dmin += e * e;
                }
            }

            if (dmin <= sphere.Radius * sphere.Radius)
                return ContainmentType.Intersects;

            return ContainmentType.Disjoint;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool Contains(Vector3 point)
            => !(point.X < Min.X
                || point.X > Max.X
                || point.Y < Min.Y
                || point.Y > Max.Y
                || point.Z < Min.Z
                || point.Z > Max.Z);

        /// <summary>
        /// Create a bounding box from the given list of points.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static AABox Create(IEnumerable<Vector3> points = null)
        {
            var minVec = Vector3.MaxValue;
            var maxVec = Vector3.MinValue;
            if (points != null)
            {
                foreach (var pt in points)
                {
                    minVec = minVec.Min(pt);
                    maxVec = maxVec.Max(pt);
                }
            }
            return new AABox(minVec, maxVec);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static AABox Create(params Vector3[] points)
            => Create(points.AsEnumerable());

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static AABox CreateFromSphere(Sphere sphere)
            => new AABox(sphere.Center - new Vector3(sphere.Radius), sphere.Center + new Vector3(sphere.Radius));

        /// <summary>
        /// This is the four front corners followed by the four back corners all as if looking from the front
        /// going in counter-clockwise order from bottom left. 
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3[] GetCorners(Vector3[] corners = null)
        {
            corners = corners ?? new Vector3[8];
            if (corners.Length < 8)
                throw new ArgumentOutOfRangeException(nameof(corners));
            // Bottom (looking down)
            corners[0] = new Vector3(Min.X, Min.Y, Min.Z);
            corners[1] = new Vector3(Max.X, Min.Y, Min.Z);
            corners[2] = new Vector3(Max.X, Max.Y, Min.Z);
            corners[3] = new Vector3(Min.X, Max.Y, Min.Z);
            // Top (looking down)
            corners[4] = new Vector3(Min.X, Min.Y, Max.Z);
            corners[5] = new Vector3(Max.X, Min.Y, Max.Z);
            corners[6] = new Vector3(Max.X, Max.Y, Max.Z);
            corners[7] = new Vector3(Min.X, Max.Y, Max.Z);
            return corners;
        }

        // CCW
        public static readonly int[] TopIndices = { 0, 1, 2, 3, };
        public static readonly int[] BottomIndices = { 7, 6, 5, 4 };
        public static readonly int[] FrontIndices = { 4, 5, 1, 0 };
        public static readonly int[] RightIndices = { 5, 6, 2, 1 };
        public static readonly int[] BackIndices = { 6, 7, 3, 2 };
        public static readonly int[] LeftIndices = { 7, 4, 0, 3 };

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool Intersects(AABox box)
        {
            Intersects(box, out var result);
            return result;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void Intersects(AABox box, out bool result)
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

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool Intersects(Sphere sphere)
        {
            if (sphere.Center.X - Min.X > sphere.Radius
                && sphere.Center.Y - Min.Y > sphere.Radius
                && sphere.Center.Z - Min.Z > sphere.Radius
                && Max.X - sphere.Center.X > sphere.Radius
                && Max.Y - sphere.Center.Y > sphere.Radius
                && Max.Z - sphere.Center.Z > sphere.Radius)
            {
                return true;
            }

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

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public PlaneIntersectionType Intersects(Plane plane)
        {
            // See http://zach.in.tu-clausthal.de/teaching/cg_literatur/lighthouse3d_view_frustum_culling/index.html

            float ax, ay, az, bx, by, bz;

            if (plane.Normal.X >= 0)
            {
                ax = Max.X;
                bx = Min.X;
            }
            else
            {
                ax = Min.X;
                bx = Max.X;
            }

            if (plane.Normal.Y >= 0)
            {
                ay = Max.Y;
                by = Min.Y;
            }
            else
            {
                ay = Min.Y;
                by = Max.Y;
            }

            if (plane.Normal.Z >= 0)
            {
                az = Max.Z;
                bz = Min.Z;
            }
            else
            {
                az = Min.Z;
                bz = Max.Z;
            }

            // Inline Vector3.Dot(plane.Normal, negativeVertex) + plane.D;
            var distance = plane.Normal.X * bx + plane.Normal.Y * by + plane.Normal.Z * bz + plane.D;
            if (distance > 0)
                return PlaneIntersectionType.Front;

            // Inline Vector3.Dot(plane.Normal, positiveVertex) + plane.D;
            distance = plane.Normal.X * ax + plane.Normal.Y * ay + plane.Normal.Z * az + plane.D;
            if (distance < 0)
                return PlaneIntersectionType.Back;

            return PlaneIntersectionType.Intersecting;
        }

        public static readonly AABox Unit
            = new AABox(Vector3.Zero, new Vector3(1));

        /// <summary>
        /// Returns where a point is relative to the bounding box on a scale of 0..1 
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 RelativePosition(Vector3 v)
            => v.InverseLerp(Min, Max);

        /// <summary>
        /// Moves the box so that it's origin is on the center
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public AABox Recenter()
            => Translate(-Center);

        /// <summary>
        /// Rescales the box
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public AABox Scale(float scale)
            => new AABox(Recenter().Min * scale, Recenter().Max * scale).Translate(Center);

        /// <summary>
        /// Returns the center of each face.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3[] FaceCenters()
        {
            var corners = GetCorners();
            return new[]
            {
                corners[FrontIndices[0]].Average(corners[FrontIndices[2]]),
                corners[RightIndices[0]].Average(corners[RightIndices[2]]),
                corners[BackIndices[0]].Average(corners[BackIndices[2]]),
                corners[LeftIndices[0]].Average(corners[LeftIndices[2]]),
                corners[TopIndices[0]].Average(corners[TopIndices[2]]),
                corners[BottomIndices[0]].Average(corners[BottomIndices[2]]),
            };
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public IEnumerable<Vector3> GetCornersAndFaceCenters()
            => Corners.Concat(FaceCenters());

        /// <summary>
        /// Returns the enclosing bounding sphere.
        /// </summary>
        /// <returns></returns>
        public Sphere ToSphere()
            => Sphere.Create(this);

        /// <summary>
        /// Given a normalized position in bounding box, returns the actual position. 
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector3 Lerp(Vector3 v)
            => Min + Extent * v;

        public AABox SetCenter(Vector3 v)
            => FromCenterAndExtent(v, Extent);

        public AABox SetExtent(Vector3 v)
            => FromCenterAndExtent(Center, v);

        public static AABox FromCenterAndExtent(Vector3 center, Vector3 extent)
            => new AABox(center - extent / 2f, center + extent / 2f);

        public AABox Transform(Matrix4x4 mat)
            => Create(Corners.Select(v => v.Transform(mat)));
    }
}
