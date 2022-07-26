// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com

namespace Vim.Math3d
{
    public static class StatelessRandom
    {
        public static uint RandomUInt(int index, int seed = 0)
            => (uint)Hash.Combine(seed, index);

        public static int RandomInt(int index, int seed = 0)
            => Hash.Combine(seed, index);

        public static float RandomFloat(float min, float max, int index, int seed)
            => (float)RandomUInt(index, seed) / uint.MaxValue * (max - min) + min;

        public static float RandomFloat(int index, int seed = 0)
            => RandomFloat(0, 1, index, seed);

        public static Vector2 RandomVector2(int index, int seed = 0)
            => new Vector2(
                RandomFloat(index * 2, seed),
                RandomFloat(index * 2 + 1, seed));

        public static Vector3 RandomVector3(int index, int seed = 0)
            => new Vector3(
                RandomFloat(index * 3, seed),
                RandomFloat(index * 3 + 1, seed),
                RandomFloat(index * 3 + 2, seed));

        public static Vector4 RandomVector4(int index, int seed = 0)
            => new Vector4(
                RandomFloat(index * 4, seed),
                RandomFloat(index * 4 + 1, seed),
                RandomFloat(index * 4 + 2, seed),
                RandomFloat(index * 4 + 3, seed));
    }
}
