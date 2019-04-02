// MIT License 
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com

namespace Ara3D
{
    public static class StatelessRandom
    {
        public static uint RandomUInt(int index, int seed) 
            => (uint)Hash.Combine(seed, index);        

        public static int RandomInt(int index, int seed) 
            => Hash.Combine(seed, index);

        public static float RandomFloat(float min, float max, int index, int seed)
            => (float)RandomUInt(index, seed) / uint.MaxValue * (max - min)+ min;        

        public static float RandomNormalFloat(int index, int seed)
            => RandomFloat(0, 1, index, seed);        
    }
}
