# Math3D

**Math3D** is a portable high-performance 3D math library from [Ara3D](https://ara3d.com) in pure C#. 
Math3D was forked from [MonoGame][https://github.com/MonoGame/MonoGame], an open-source version of XNA, and modified to use the core 
classes provided in `System.Numerics`.

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

## To-do

* The Vector2, Vector3, and Vector4 static functions need to be integrated into MathOps as extension methods. 
	* Some of the mathops should be using them
	* There are some extension methods in "VectorHelper"
* Possibly implement some System.Array extension functions (or System.Vector<T> ?)
* 