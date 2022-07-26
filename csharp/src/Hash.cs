// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System.Collections.Generic;
using System.Linq;

namespace Vim.Math3d
{
    public static class Hash
    {
        // Discussion: if we want to go deeper into the subject, check out
        // https://en.wikipedia.org/wiki/List_of_hash_functions
        // https://stackoverflow.com/questions/5889238/why-is-xor-the-default-way-to-combine-hashes
        // https://en.wikipedia.org/wiki/Jenkins_hash_function#cite_note-11
        // https://referencesource.microsoft.com/#System.Numerics/System/Numerics/HashCodeHelper.cs
        // https://github.com/dotnet/corefx/blob/master/src/Common/src/CoreLib/System/Numerics/Hashing/HashHelpers.cs

        public static int Combine(int h1, int h2)
        {
            unchecked
            {
                // RyuJIT optimizes this to use the ROL instruction
                // Related GitHub pull request: dotnet/coreclr#1830
                var rol5 = ((uint)h1 << 5) | ((uint)h1 >> 27);
                return ((int)rol5 + h1) ^ h2;
            }
        }

        public static int Combine(IList<int> xs)
        {
            if (xs.Count == 0) return 0;
            var r = xs[0];
            for (var i = 1; i < xs.Count; ++i)
                r = Combine(r, i);
            return r;
        }

        public static int Combine(params int[] xs)
            => Combine(xs as IList<int>);

        public static int Combine(int x0, int x1, int x2)
            => Combine(Combine(x0, x1), x2);

        public static int Combine(int x0, int x1, int x2, int x3)
            => Combine(Combine(x0, x1, x2), x3);

        public static int HashValues(this IEnumerable<int> values)
            => values.Aggregate(0, (acc, x) => Combine(acc, x));

        public static int HashCodes<T>(this IEnumerable<T> values)
            => values.Select(x => x.GetHashCode()).HashValues();
    }
}
