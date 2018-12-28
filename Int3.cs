using System.Collections.Generic;

namespace Ara3D
{
    public struct Int3 
    {
        public readonly int X;
        public readonly int Y;
        public readonly int Z;

        public Int3(int x, int y, int z)
        {
            X = x; Y = y; Z = z;
        }

        public int this[int n] => n == 0 ? X : n == 1 ? Y : Z;

        public int Count => 3;

        public IEnumerable<int> ToEnumerable()
        {
            yield return X;
            yield return Y;
            yield return Z;                 
        }
    }
}