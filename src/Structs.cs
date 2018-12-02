namespace Ara3D
{
    /*
    public struct Vector2 : IArray<float> {
        System.Numerics.Vector2 v;
        public int Count => 2;
        public float this[int n] { get { return n == 0 ? v.X : v.Y; } }
        public Vector2(IArray<int> xs) { v = new System.Numerics.Vector2(xs[0], xs[1]); }
        public Vector2(float x, float y) { v = new System.Numerics.Vector2(x, y); }
        public static Vector2 XAxis = new Vector2(1, 0);
    }

    public struct Vector3 : IArray<float> {
        System.Numerics.Vector3 v;
        public int Count => 3;
        public float this[int n] => n == 0 ? v.X : n == 1 ? v.Y : v.Z;
        public Vector3(IArray<int> xs) { v = new System.Numerics.Vector3(xs[0], xs[1], xs[2]); }
    }

    public struct Vector4 : IArray<float>
    {
        System.Numerics.Vector4 v;
        public int Count => 4;
        public float this[int n] => n == 0 ? v.X : n == 1 ? v.Y : n == 2 ? v.Z : v.W;
        public Vector4(IArray<int> xs) { v = new System.Numerics.Vector4(xs[0], xs[1], xs[2], xs[3]); }
    }*/


    public interface ILimits<T>
    {
        T Min { get; }
        T Max { get; }
    }
}
