// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace Vim.Math3d
{
    /// <summary>
    /// Contains basic statistics that can be computed in a single pass over a collection.
    /// </summary>
	[DataContract]
    [StructLayout(LayoutKind.Sequential, Pack = 4)]
    public struct Stats<T>
    {
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public Stats(int count, T min, T max, T sum)
            => (Count, Min, Max, Sum) = (count, min, max, sum);

        [DataMember] public readonly int Count;
        [DataMember] public readonly T Min;
        [DataMember] public readonly T Max;
        [DataMember] public readonly T Sum;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override bool Equals(object obj)
            => obj is Stats<T> && Equals((Stats<T>)obj);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public bool Equals(Stats<T> other)
            => other.Count == Count && other.Min.Equals(Min) && other.Max.Equals(Max) && other.Sum.Equals(Sum);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override int GetHashCode()
            => Hash.Combine(Count.GetHashCode(), Min.GetHashCode(), Max.GetHashCode(), Sum.GetHashCode());

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool operator ==(Stats<T> left, Stats<T> right)
            => left.Equals(right);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool operator !=(Stats<T> left, Stats<T> right)
            => !(left == right);

        public static readonly Stats<T> Default
            = new Stats<T>(default, default, default, default);

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override string ToString()
            => $"Stats<{typeof(T)}(Count = {Count}, Min = {Min}, Max = {Max}, Sum = {Sum})";
    }
}
