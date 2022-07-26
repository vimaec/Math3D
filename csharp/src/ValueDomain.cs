namespace Vim.Math3d
{
    public class ValueDomain
    {
        public readonly double Lower;
        public readonly double Upper;

        public ValueDomain(double lower, double upper)
            => (Lower, Upper) = (lower, upper);

        public double Normalize(double value)
            => value.Clamp(Lower, Upper) / Upper;
    }
}
