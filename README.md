# Vim.Math3D

[<img src="https://img.shields.io/nuget/v/Vim.Math3D.svg">](https://github.com/Vim/Math3D)

**Vim.Math3D** is a portable and efficient 3D math library from [VIM AEC](https://vimaec.com) written in pure safe C# 
with no dependencies. Math3D was forked from the core classes provided in the CoreFX implementation of 
[System.Numerics](https://github.com/dotnet/corefx/tree/master/src/System.Numerics.Vectors/src/System/Numerics) and 
[MonoGame](https://github.com/MonoGame/MonoGame) an open-source cross platform port of the XNA game development 
framework. 

The main goal of Math 3D was to extend the functionality of System.Numerics and assure that the base types
that can be reliably serialized across different platforms. 

## Motivation 

At VIM AEC we develop C# libraries for geometry processing that are used in command-line processing tools and Windows
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

Vim.Math3D uses the `[MethodImpl(MethodImplOptions.AggressiveInlining)]` attribute on methods to overcome the 
inefficiency of structs not-being inlined. This is the approach used by System.Numerics and allows
a more discoverable object-oriented syntax.

Without this attribute libraries often resort to pass the structs as `ref` parameters (e.g. MonoGame and SharpDX)
which makes for a less readable syntax, and an API that is less discoverable because auto-complete doesn't work 
as well.

## Matching the System.Numerics API

Rather than presenting C# programmers with an unfamiliar interface in the library, we have attempted to 
match the System.Numerics API as closely as possible (with the exception of making the structs immutable). 
This has made it easier for us to adapt existing code bases to use `Vim.Math3D` and to reuse the rich 
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

The following is a [list of data structures](https://github.com/Vim/Math3D/blob/master/Structs.cs) that are provided by Vim.Math

	* Vim.Vector2
	* Vim.Vector3
	* Vim.Vector4	
	* Vim.DVector2
	* Vim.DVector3
	* Vim.DVector4
	* Vim.Plane
	* Vim.DPlane
	* Vim.Quaternion
	* Vim.DQuaternion
	* Vim.Interval
	* Vim.Box2
	* Vim.Box
	* Vim.Box4
	* Vim.DInterval
	* Vim.DBox2
	* Vim.DBox3
	* Vim.DBox4
	* Vim.Ray
	* Vim.DRay
	* Vim.Sphere
	* Vim.DSphere
	* Vim.Line
	* Vim.Triangle
	* Vim.Triangle2
	* Vim.Quad
	* Vim.Int2
	* Vim.Int3
	* Vim.Int4

## System.Math as Extension Functions, 

All of the `System.Math` routines, and additional math routines, are reimplemented in 
[`Vim.MathOps`](https://github.com/Vim/Math3D/blob/master/MathOps.cs). 
and as static extension functions for `float`, `double`, `Vector2`,`Vector3`, `Vector4`, `DVector2`,`DVector3`, 
and `DVector4`. This provides a convenient object oriented syntax on all variables, making the Vim.Math3D API
easily discoverable using auto-complete.

## What are .TT Files

`Vim.Math3D` leverages the [T4 text template engine](https://docs.microsoft.com/en-us/visualstudio/modeling/code-generation-and-t4-text-templates?view=vs-2017) 
to auto-generate efficient boilerplate code for the different types of 
structs. This has proven for us to be an effective way to create generic code that is also very efficient for numerical types and 
reduce the overhead of maintainance.  

## About the Tests

Vim.Math3D uses NUnit for the tests, which many were ported from the CoreFX Numerics implementation of System.Numerics. 
At last measure we have approximately 50% code coverage, with most of the uncovered functions having trivial implementations 
that are auto-generated using the T4 templating engine. 

## Targetted Frameworks and Language

The main project targets .NET Framework 4.7.1, but a .NET Standard 2.0 project also references the same code, but which consumes
the generated output of the T4 files. The .NET Standard project is the one we post to NuGet, but active development is done 
on the .NET 4.7.1 branch. We are currently using C# 7.2. 

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
