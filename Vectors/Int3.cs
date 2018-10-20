using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace Ara3D.Vectors
{    
    public struct Int3 : IArray<int>, IEnumerable<int>
    {
        public int X { get; }
        public int Y { get; }
        public int Z { get; }

        public Int3(int x, int y, int z)
        {
            X = x; Y = y; Z = z;
        }

        public int this[int n] => n == 0 ? X : n == 1 ? Y : Z;

        public int Count => 3;

        public IEnumerator<int> GetEnumerator()
        {
            return this.ToEnumerable().GetEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return this.ToEnumerable().GetEnumerator();
        }
    }
}
