// MIT License
// Copyright (C) 2019 VIMaec LLC.
// Copyright (C) 2019 Ara 3D. Inc
// https://ara3d.com
// Copyright (C) The Mono.Xna Team
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

namespace Vim.Math3d
{
    /// <summary>
    /// Defines the intersection between a Plane and a bounding volume.
    /// </summary>
    public enum PlaneIntersectionType
    {
        /// <summary>
        /// There is no intersection, the bounding volume is in the negative half space of the plane.
        /// </summary>
        Front,
        /// <summary>
        /// There is no intersection, the bounding volume is in the positive half space of the plane.
        /// </summary>
        Back,
        /// <summary>
        /// The plane is intersected.
        /// </summary>
        Intersecting
    }
}