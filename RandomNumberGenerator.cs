namespace Ara3D
{
    public static class Rng
    {
        public static uint RandomUInt(int index, int seed) 
        {
            return (uint)Hash.Combine(seed, index);
        }

        public static int RandomInt(int index, int seed)
        {
            return Hash.Combine(seed, index);
        }

        public static float RandomFloat(float min, float max, int index, int seed)
        {
            var range = max - min;
            var rnd = (float)RandomUInt(index, seed);
            return (float)rnd / uint.MaxValue * range + min;
        }

        public static float RandomNormalFloat(int index, int seed)
        {
            return RandomFloat(0, 1, index, seed);
        }
    }
}
