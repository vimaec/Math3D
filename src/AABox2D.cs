using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;

namespace Vim.Math3d
{
    public partial struct AABox2D
    {
        public int Count
            => 2;

        public Vector2 CenterBottom
            => Center.SetY(Min.Y);

        public Vector2[] Corners
            => GetCorners();

        public bool IsEmpty
            => !IsValid;

        public bool IsValid
            => Min.X <= Max.X && Min.Y <= Max.Y;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float Distance(Vector2 point)
            => Vector2.Zero.Max(Min - point).Max(point - Max).Length();

        /// <summary>
        /// Returns the distance of the point to the box center. 
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public float CenterDistance(Vector2 point)
            => Center.Distance(point);

        /// <summary>
        /// Moves the box by the given vector offset
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public AABox2D Translate(Vector2 offset)
            => new AABox2D(Min + offset, Max + offset);

        public float DistanceToOrigin
            => Distance(Vector2.Zero);

        public float CenterDistanceToOrigin
            => CenterDistance(Vector2.Zero);

        public float Area
            => IsEmpty ? 0 : Extent.ProductComponents();

        public Vector2 this[int n]
            => n == 0 ? Min : Max;

        public float MaxSide
            => Extent.MaxComponent();

        public float MinSide
            => Extent.MinComponent();

        public float Diagonal
            => Extent.Length();

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public ContainmentType Contains(AABox2D box)
        {
            //test if all corner is in the same side of a face by just checking min and max
            if (box.Max.X < Min.X
                || box.Min.X > Max.X
                || box.Max.Y < Min.Y
                || box.Min.Y > Max.Y)
            {
                return ContainmentType.Disjoint;
            }

            if (box.Min.X >= Min.X
                && box.Max.X <= Max.X
                && box.Min.Y >= Min.Y
                && box.Max.Y <= Max.Y)
            {
                return ContainmentType.Contains;
            }

            return ContainmentType.Intersects;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool Contains(Vector2 point)
            => !(point.X < Min.X
                || point.X > Max.X
                || point.Y < Min.Y
                || point.Y > Max.Y);

        /// <summary>
        /// Create a bounding box from the given list of points.
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static AABox2D CreateFromPoints(IEnumerable<Vector2> points)
            => points?.Aggregate(Empty, (box, point) => box + point) ?? Empty;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static AABox2D CreateFromPoints(params Vector2[] points)
            => CreateFromPoints(points.AsEnumerable());

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector2[] GetCorners(Vector2[] corners = null)
        {
            corners = corners ?? new Vector2[4];
            if (corners.Length < 4)
                throw new ArgumentOutOfRangeException(nameof(corners));

            corners[0] = new Vector2(Min.X, Min.Y);
            corners[1] = new Vector2(Max.X, Min.Y);
            corners[2] = new Vector2(Max.X, Max.Y);
            corners[3] = new Vector2(Min.X, Max.Y);

            return corners;
        }

        // CCW
        public static readonly int[] Indices = { 0, 1, 2, 3, };

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool Intersects(AABox2D box1, AABox2D box2)
            => box1.Min.X <= box2.Max.X
               && box1.Max.X >= box2.Min.X
               && box1.Min.Y <= box2.Max.Y
               && box1.Max.Y >= box2.Min.Y;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool Intersects(AABox2D box)
            => Intersects(this, box);

        public static readonly AABox2D Unit
            = new AABox2D(Vector2.Zero, new Vector2(1));

        /// <summary>
        /// Returns where a point is relative to the bounding box on a scale of 0..1 
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Vector2 RelativePosition(Vector2 v)
            => v.InverseLerp(Min, Max);

        /// <summary>
        /// Moves the box so that it's origin is on the center
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public AABox2D Recenter()
            => Translate(-Center);

        /// <summary>
        /// Rescales the box
        /// </summary>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public AABox2D Scale(float scale)
            => new AABox2D(Recenter().Min * scale, Recenter().Max * scale).Translate(Center);
    }
}
