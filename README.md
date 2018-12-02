# Math3D

*Math3D* is a portable high-performance 3D math library from [Ara3D](https://ara3d.com) in pure C#. It has only a dependency on the Microsoft library `System.Numerics.Vectors`. Math3D was started using code from [MonoGame][https://github.com/MonoGame/MonoGame] which is was a popular open-source version of the XNA game framework. The reason for forking the code, was to use the Microsoft system numerics, and to capture the core Math algorithms in one reusable library. This project targets .NET Standard 2.0, which means it is compatible with .NET 4.6, .NET Core 2.0, and recent versions of Unity.

## Design 

Math3D is intended to be used in soft real-time contexts and trades precision for performance, so all data structures and algorithms use 32 bit floating math. 

If you are looking for double precision floating point 3D math and geometry I suggest taking a look at [Geometry3Sharp](https://github.com/gradientspace/geometry3Sharp) by GradientSharp. 