namespace Ara3D
{
    public interface IPoints
    {
        int NumPoints { get; }
        Vector3 GetPoint(int n);
    }
}
