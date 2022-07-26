// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System;

namespace Vim.Math3d
{
    public static class Constants
    {
        public static readonly Plane XYPlane = new Plane(Vector3.UnitZ, 0);
        public static readonly Plane XZPlane = new Plane(Vector3.UnitY, 0);
        public static readonly Plane YZPlane = new Plane(Vector3.UnitX, 0);

        public const float Pi = (float)Math.PI;
        public const float HalfPi = Pi / 2f;
        public const float TwoPi = Pi * 2f;
        public const float Tolerance = 0.0000001f;
        public const float Log10E = 0.4342945f;
        public const float Log2E = 1.442695f;
        public const float E = (float)Math.E;

        public const double RadiansToDegrees = 57.295779513082320876798154814105;
        public const double DegreesToRadians = 0.017453292519943295769236907684886;

        public const double OneTenthOfADegree = DegreesToRadians / 10;

        // TODO: BUG: these two values are inverted dumb-dumb
        public const double MmToFeet = 0.00328084;
        public const double FeetToMm = 1 / MmToFeet;
    }
}
