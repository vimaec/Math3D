# Math3D

This is a portable high-performance 3D math library written in C# built using code taken from proven open-source libraries:

* (CoreFX .NET Reference Library)[https://github.com/dotnet/corefx] - System.Numerics.Vectors
* (MonoGame)[https://github.com/MonoGame/MonoGame] - MonoGame Framework 

At its core, Math3D is primarily a library for working with 3 dimensional vectors, quaternions, 4x4 matrices, and arrays of numerical types. Additionally it provides supports for common data-structures such as rays, planes, bounding boxes, and more.

This project targets .NET Standard 2.0 and depends on the very lightweight (and useful) (LinqArray library)[https://github.com/ara3d/LinqArray].

# Design Rationale

For the purpose of near real-time 3D geometry processing, from various 3D math libraries in C# examined, the `System.Numerics.Vector` class from Microsoft seemed like the best choice. It offered an excellent mix of performance, stability, and portability. It also was similar to the XNA and MonoGame libraries. However, the API footprint is very small and targeted.

We wanted to integrate support for more types (e.g. bounding boxes, boudning spheres, lines, rays, triangles, and quadrilaterals), provide a more object-oriented syntax, better integration with the system math routines, and support for the LinqArray library. Since the API is very stable, we chose to fork the System.Numerics.Vector code base and integrate missing elements from other proven libraries. 

# Plans

We are also looking into creating a bridge project to facilitate conversion between data-structures from various popular 3D libraries:

* Unity
* (MonoGame)[https://github.com/MonoGame/MonoGame] - MonoGame Framework 
* (geometry3Sharp)[geometrySharp]
* System.Numerics
* WPF
* BulletSharp

We encourage and welcome suggestions and feedback for how to make this a library that can be useful for a larger audience. 
