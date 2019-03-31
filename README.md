# Ara3D.Math3D

**Ara3D.Math3D** is a portable and efficient 3D math library from [Ara3D](https://ara3d.com) written in pure safe C# 
with no dependencies. Math3D was forked from the core classes provided in the CoreFX implementation of 
[System.Numerics](https://github.com/dotnet/corefx/tree/master/src/System.Numerics.Vectors/src/System/Numerics) and 
[MonoGame](https://github.com/MonoGame/MonoGame) an open-source cross platform port of the XNA game development 
framework. 

## Motivation 

At Ara 3D we develop C# libraries for geometry processing that are used in command-line processing tools and Windows
desktop applications as well as exporters, importers, and plug-ins for various tools such as Unity, 3ds Max, Revit, 
and more. 

The foundation of all computational geometry are a common set of algorithms and data strctures that include vectors,
quaternions, matrices, rays, lines, bounding boxes and other structures. 

Ideally, we would have reused an open-source library, and have tried several different libraries before 
settling on managing our own. See the Appendix for a list of related libraries, and some of the rationale for not 
using them.

This library has a very similar API to System.Numerics and supports many of the same functions and signatures, plus 
a lot more. 

## Design Goals 

Our design goals were in order:

1. Portability
	* The library must be pure C# 
	* No unsafe code 
	* Fixed binary layout of structs in memory
	* Double and Single precision implementation of most structures 
2. Robust
	* Functions are well covered by unit tests 
	* Functions are easily read and understood 
3. Ease of Use
	* We don't have to pass arguments by reference
	* Can use object-oriented "dot" notation
	* Consistent with Microsoft coding styles
	* Consistent API with System.Numerics
4. Performance 
	* Good performance 

## Performance: Aggressive Method Inlining

One of the most effective compiler optimizations is method inlining. Unfortunately as soon as you pass a struct 
as a formal arg the [method will not be inlined](https://stackoverflow.com/a/55432110/184528).

Ara3D.Math3D uses the `[MethodImpl(MethodImplOptions.AggressiveInlining)]` attribute on methods to overcome the 
inefficiency of structs not-being inlined. 

## A Design Goal: Matching the System.Numerics API

Rather than presenting C# programmers with an unfamiliar interface in the library, we have attempted to 
match the System.Numerics API as closely as possible (with the exception of making the structs immutable). 
This has made it easier for us to adapt existing code bases to use `Ara3D.Math` and to reuse the rich 
set of tests provided by the CoreFX framework. 

One difference is that we opted to make all structs immutable.

## Immutable Structs

Microsoft's recommendations around [struct design](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/struct)
are to make structs immutable. Oddly enough this is violated by the System.Numerics library. 

By opting to make data types immutable by default eliminates large categories of bugs like race conditions, 
invariant violations after construction. 

## What Structs are Provided

The following is a list of data structures that are provide by Ara3D.Math

	* Ara3D.Vector2
	* Ara3D.Vector3
	* Ara3D.Vector4	
	* Ara3D.DVector2
	* Ara3D.DVector3
	* Ara3D.DVector4
	* Ara3D.Plane
	* Ara3D.DPlane
	* Ara3D.Quaternion
	* Ara3D.DQuaternion
	* Ara3D.Interval
	* Ara3D.Box2
	* Ara3D.Box
	* Ara3D.Box4
	* Ara3D.DInterval
	* Ara3D.DBox2
	* Ara3D.DBox3
	* Ara3D.DBox4
	* Ara3D.Ray
	* Ara3D.DRay
	* Ara3D.Sphere
	* Ara3D.DSphere
	* Ara3D.Line
	* Ara3D.Triangle
	* Ara3D.Triangle2
	* Ara3D.Quad
	* Ara3D.Int2
	* Ara3D.Int3
	* Ara3D.Int4

## System.Math as Extension Functions, 

All of the `System.Math` routines, and additional math routines, are reimplemented in `Ara3D.MathOps` as 
static extension functions for `float`, `double`, `Vector2`,`Vector3`, `Vector4`, `DVector2`,`DVector3`, 
and `DVector4`. This provides a convenient fluent syntax on all variables, making the Ara3D.Math3D API
easily discoverable using auto-complete.

## What are .TT Files

`Ara3D.Math3D` leverages the [T4 text template engine](https://docs.microsoft.com/en-us/visualstudio/modeling/code-generation-and-t4-text-templates?view=vs-2017) 
to auto-generate efficient boilerplate code for the different types of 
structs. This has proven for us to be an effective way to create generic code that is also very efficient for numerical types and 
reduce the overhead of maintainance.  

## Where are the Tests? 

Ara3D.Math3D is used in a number of different open-source libraries developed by Ara3D, inluding a Geometry library.
In order to facilitate development and testing all Ara3D open-source libraries are developed in a central 
repository at [github.com/ara3d/ara3d-dev](https://github.com/ara3d/ara3d-dev). 

You can find the [Math3D tests here](https://github.com/ara3d/ara3d-dev/tree/master/dotnet/Tests). We 
ported many of the tests used by CoreFX Numerics implementation to that library. At last measure we have over 50% 
code coverage, but most of the uncovered functions having trivial implementations that are auto-generated using 
the T4 templating engine. 

# Appendix 

## Related Libraries 

* [System.Numerics - Reference Source](https://referencesource.microsoft.com/#System.Numerics,namespaces)
* [System.Numerics - CoreFX](https://github.com/dotnet/corefx/tree/master/src/System.Numerics.Vectors/src/System/Numerics)
* [MonoGame](https://github.com/MonoGame/MonoGame)
* [Math.NET Numerics](https://github.com/mathnet/mathnet-numerics)
* [Geometry3Sharp](https://github.com/gradientspace/geometry3Sharp)
* [FNA-XNA](https://github.com/FNA-XNA/FNA/tree/master/src)
* [Xenko](https://github.com/xenko3d/xenko/blob/master/sources/core/Xenko.Core.Mathematics)
* [Unity.Mathematics](https://github.com/Unity-Technologies/Unity.Mathematics)
* [Unity Reference](https://github.com/Unity-Technologies/UnityCsReference/tree/master/Runtime/Export)
* [SharpDX Mathematics](https://github.com/sharpdx/SharpDX/tree/master/Source/SharpDX.Mathematics)
* [A Vector Type for C# - R Potter via Code Project](https://www.codeproject.com/Articles/17425/A-Vector-Type-for-C)

Because the `MonoGame` framework is an older code-base, it adopted an awkward coding of style which resulted from 
passing structs by `ref` to overcome the performance hit caused by non-inlining of methods.  

## Why not Library X

We evaluated all of the aforementioned libraries, and chose not to use them for a variety of reasons. Some of these
are listed here:

### Why not use MonoGame

MonoGame is a mature library with a rich set of 3D algorithms and data structures, a subset of which are very similar
to `System.Numerics`. 

* Layout in memory is not fixed 
* The API emphasizes usage of `out` and `ref` parameters, rather than using an object-oriented syntax 
* There are no double-precision versions of the functions and classes
* The API surface is incomplete 

## Why not use System.Numerics

Originally Ara3D used `System.Numerics` directly but we ran into several issues:

* The layout in memory of `System.Numerics.Vector3` is different between .NET Framework and .NET Core
* The structs are mutable, violating Microsoft's own best practices around [struct design](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/struct).
* There are no double precision versions of the structs, so we had to create our own
* Many useful functions were only available as static non-extension functions, forcing users to use a non-fluent API
* The number of structs and functions was limited, so we had to extend them anyway
* System.Numerics used some unsafe code in places 

Because System.Numerics is based on very well-known and proven algorithms that arent likely to change, we found it 
to be a reasonable approach to fork the code, and put it into a stsandalone library 

## Why not use SharpDX

The [SharpDX mathematics library](https://github.com/sharpdx/SharpDX/tree/master/Source/SharpDX.Mathematics) is closely related to MonoGame. 
It has many of the same data structures and algorithms, and follows a similar style. The main reason for not using it,
other than the same reasons we are not using MonoGame, is that library is no
longer being actively maintained.

## Why not use Unity.Mathematics

In the last year Unity released a prototype library called [`Unity.Mathematics`](https://github.com/Unity-Technologies/Unity.Mathematics).
The reasons this library are not used:

* Unity.Mathematics is licened under a non-standard open-source license 
* The API is a work in progress and we may introduce breaking changes
* The API supports a very limited set of types and operations (basically that of GLSL)
* The library nomenclature and coding style is based on GLSL rather than C# System Libraries
