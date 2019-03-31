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

The foundation of computational geometry is a common set of algorithms and data strctures that include vectors,
quaternions, matrices, rays, lines, bounding boxes and other structures. 

Ideally, we would have reused an open-source library, and have tried several different libraries before 
settling on writing and maintaining our own. See the Appendix for a list of related libraries. 

## Design Goals 

In rough order, the Math3D design goals are:

1. Portability
	* The library must be pure C# 
	* No unsafe code 
	* Fixed binary layout of structs in memory
	* Double and Single precision implementation of most structures 
2. Robustness
	* Functions are well covered by unit tests 
	* Functions are easily read and understood 
3. Ease of Use
	* We don't have to pass arguments by reference
	* Can use object-oriented "dot" notation
	* Consistent with Microsoft coding styles
	* Consistent API with System.Numerics
4. Performance 
	* Good-enough performance 

## Performance: Aggressive Method Inlining

One of the most effective compiler optimizations is method inlining. Unfortunately as soon as you pass a struct 
as a formal arg the [method will not be inlined](https://stackoverflow.com/a/55432110/184528).

Ara3D.Math3D uses the `[MethodImpl(MethodImplOptions.AggressiveInlining)]` attribute on methods to overcome the 
inefficiency of structs not-being inlined. This is the approach used by System.Numerics and allows
a more discoverable object-oriented syntax.

Without this attribute libraries often resort to pass the structs as `ref` parameters (e.g. MonoGame and SharpDX)
which makes for a less readable syntax, and an API that is less discoverable because auto-complete doesn't work 
as well.

## Matching the System.Numerics API

Rather than presenting C# programmers with an unfamiliar interface in the library, we have attempted to 
match the System.Numerics API as closely as possible (with the exception of making the structs immutable). 
This has made it easier for us to adapt existing code bases to use `Ara3D.Math` and to reuse the rich 
set of tests provided by the CoreFX framework. 

Related to this topic last year Unity released a prototype library called [`Unity.Mathematics`](https://github.com/Unity-Technologies/Unity.Mathematics),
this library opted to emulate the math library of GLSL, which we feel makes the API harder to learn 
for C# programmers, though it does make it easier to learn for shader programmers. 

One difference from System.Numerics is that we opted to make virtually all structs immutable (with the 
temporary exception of `Matrix4x4`)

## Immutable Structs

Microsoft's recommendations around [struct design](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/struct)
are to make structs immutable. Oddly enough this is violated by the System.Numerics library. This is one of the reasons 
we decided to fork the System.Numerics library. 

By opting to make data types immutable by default eliminates large categories of bugs like race conditions, 
invariant violations after construction. 

## What Structs are Provided

The following is a [list of data structures](https://github.com/ara3d/Math3D/blob/master/Structs.cs) that are provided by Ara3D.Math

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

All of the `System.Math` routines, and additional math routines, are reimplemented in [`Ara3D.MathOps`](https://github.com/ara3d/Math3D/blob/master/MathOps.cs) 
and as 
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

