namespace Ara3D
{
    public interface IAlmostEquatable<T>
    {
        bool AlmostEquals(T other, float tolerance);
    }
}
