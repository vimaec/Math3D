# Math3D

**Math3D** is a portable high-performance 3D math library from [Ara3D](https://ara3d.com) in pure C#. Math3D was started using code from [MonoGame][https://github.com/MonoGame/MonoGame], an open-source version of XNA, and modified to use the core classes provided in `System.Numerics`. This project targets .NET Standard 2.0, which means it is compatible with .NET 4.6, .NET Core 2.0, and recent versions of Unity.

## Design 

Math3D is intended to be used in soft real-time contexts and trades precision for performance, so all data structures and algorithms use 32 bit floating math. 

## Related Projects

If you are looking for double precision floating point 3D math and geometry I suggest taking a look at [Geometry3Sharp](https://github.com/gradientspace/geometry3Sharp) by GradientSharp.

If you are looking for more intensive numerical methods see [Math.NET Numerics](https://github.com/mathnet/mathnet-numerics).

Other 3D Math libraries:

* [Xenko](https://github.com/xenko3d/xenko/blob/master/sources/core/Xenko.Core.Mathematics)
* [Crazy Core Game Engine](https://github.com/mellinoe/ge/tree/master/src/Engine)
* [MonoGame](https://github.com/MonoGame/MonoGame)
* [FNA-XNA](https://github.com/FNA-XNA/FNA/tree/master/src)