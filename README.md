**This repository is a public mirror of the Math3D code being maintained within the [vim-format](https://github.com/vimaec/vim-format/tree/develop/src/cs/math3d/Vim.Math3D) repository.**

# Vim.Math3D

[<img src="https://img.shields.io/nuget/v/Vim.Math3D.svg">](https://www.nuget.org/packages/Vim.Math3D/)

[Read the API Documentation](https://vimaec.github.io/Math3D) | [Browse the Source](https://github.com/vimaec/Math3D/tree/dev/src) | [Get the Nuget](https://www.nuget.org/packages/Vim.Math3D/)

**Vim.Math3D** is a portable, safe, and efficient 3D math library from [VIM](https://vimaec.com) written in C# 
targeting .NET Standard 2.0 without any dependencies. 

It is intended primarily as a feature rich drop-in replacement for System.Numerics that assures consistent serialization
across platforms, enforces immutability, and offers many additional structures and functionality. 

Math3D is compatible with Unity and has been used in production on many different platforms including Windows, 
Android, iOS, WebGL, and Magic Leap. 

## Design Goals

In rough order, the Math3D design goals are:

1. Portability
	* The library must be pure C# 
	* No unsafe code 
	* Fixed binary layout of structs in memory
	* Double and Single precision implementation of most structures 
2. Robustness
	* Functions are well covered by unit tests 
	* Functions are easy to read, understand, and verify
3. Ease of Use and Discoverability
	* Consistent with Microsoft coding styles
	* Consistent API with System.Numerics
	* Can use fluent syntax (object-oriented "dot" notation)
	* We don't have to pass arguments by reference
4. Performance 
	* Excellent performance, but not at cost of readability and discoverability

## History 

VIM is a company that develops high-performance 3D applications for multiple platforms. Our core development language
is C#, so we had a need for a robust, efficient, and productive 3D library. We originally started using 
System.Numerics, but we ran into some problems. The first issue was that with System.Numerics different implementations could 
have different binary layouts of the structures. For example a Vector3 might be aligned on either 12 or 16 byte boundaries 
depending on the platform. 

Microsoft's recommendations around [struct design](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/struct)
are to make structs immutable. Oddly enough this is violated by the System.Numerics library. 

By opting to make data types immutable by default eliminates large categories of bugs like race conditions, 
invariant violations after construction. This is another reason we decided to fork the System.Numerics library. 

So we decided to start Math3D by forking from the core classes provided in the CoreFX implementation of 
[System.Numerics](https://github.com/dotnet/corefx/tree/master/src/System.Numerics.Vectors/src/System/Numerics) with 
additional algorithms and structures taken from [MonoGame](https://github.com/MonoGame/MonoGame), 
an open-source cross platform port of the XNA game development framework. 

## What Structs are Provided

The following is a list of data structures provided by Vim.Math. 

* **Vectors**
	* `Vector2` - Single precision X, Y
	* `Vector3` - Single precision X, Y, Z
	* `Vector4` - Single precision X, Y, Z, W
	* `DVector2` - Double precision X, Y
	* `DVector3` - Double precision X, Y, Z
	* `DVector4` - Double precision X, Y, Z, W
	* `Int2` - Integer X, Y
	* `Int3` - Integer X, Y, Z
	* `Int4` - Integer X, Y, Z, W
	* `Complex` - Double precision Imaginary, Real 
* **Pseudo-Vectors** - the following classes lack some of the operations of Vectors 
	* `Byte2` - Byte X, Y
	* `Byte3` - Byte X, Y, Z
	* `Byte4` - Byte X, Y, Z, W
	* `ColorRGB` - Byte representation of color R, G, B
	* `ColorRGBA` - Byte representation of color with Alpha R, G, B, A
 	* `ColorHDR` - High Defintion Range color representation, 4 floats, R, G, B, A 
* **Rotations and Transformations**
	* `Quaternion` - Single precision quaternion rotation X, Y, Z, W
	* `DQuaternion` - Double precision quaternion rotation X, Y, Z, W
	* `AxisAngle` - Single precison rotation as Axis (Vector3) and Angle in radians 
	* `Matrix4x4` - 4 x 4 Single Precision matrix in Row-Column - corder
	* `Transform` - Single precision Position (Vector3) and Orientation (Quaternion)
	* `Euler` - Single precision Euler engle rotation as Yaw (Z rotation), Pitch (X rotation), Roll (y rotation)
* **Geometric structures and shapes**
	* `Plane` - Single precision plane stored Normal (Vector3) and D (distance along normal from Origin)
	* `DPlane` - Double precision plane stored Normal (Vector3) and D (distance along normal from Origin)
	* `Triangle` - Single precision representation of triangle in 3 dimension as 3 Vector3 Points, A, B, and C
	* `Triangle2` - Single precision representation of triangle in 3 dimension as 3 Vector3 Points, A, B, and C
	* `Quad` - Single precision representation of quadrilateral in 3 dimension as 4 Vector3 Points, A, B, C, and D
	* `DQuad` - Double precision representation of quadrilateral in 3 dimension as 4 Vector3 Points, A, B, C, and D
* **Lines**
	* `Line` - Single precision line segment A and B
	* `Ray` - Single precision Point and Direction in 3 dimensional space
	* `DRay` - Double precision Point and Direction in 3 dimensional space
* **Interval and Bounding Structure**		
	* `Interval` - Single precision float interval (float Min, float Max)
	* `AABox` - Single precision 3 dimensional axis-aligned bouncing box (Vector3 Min, Vector3 Max)
	* `AABox2D` - Single precision 2 dimensional axis-aligned bouncing box (Vector2 Min, Vector2 Max)
	* `AABox4D` - Single precision 4 dimensional axis-aligned bouncing box (Vector4 Min, Vector4 Max)
	* `DInterval` - Double precision float interval (double Min, double Max)
	* `DAABox` - Double precision 3 dimensional axis-aligned bouncing box (DVector3 Min, DVector3 Max)
	* `DAABox2D` - Double precision 2 dimensional axis-aligned bouncing box (DVector2 Min, DVector2 Max)
	* `DAABox4D` - Double precision 4 dimensional axis-aligned bouncing box (DVector4 Min, DVector4 Max)
	* `Sphere` - Bounding sphere (Vector3 Center, float Radius)
	* `DSphere` - Double precision bounding spehere (DVector3 Center, double Radius)
* **Alternative Coordinate Representations**
	* `SphericalCoordinate` - Radius, Azimuth (bearing), and Inclination (elevation angle)
	* `PolarCoordinate` - Radius and Azimuth (bearing)
	* `LogPolarCoordinate` - Rho (log of radial distance) and Azimuth
	* `CylindricalCoordinate` - Radius, Azimuth (bearing) and Height
	* `HorizontalCoordinate` - Azimuth (bearing) and Inclination
	* `GeoCoordinate` - Latitude and Longitude
* **Motion** 
	* `LinearMotion` - Velocity, Acceleration, and Scalar Friction 
	* `AngularMotion` - Velocity, Acceleration, and Scalar Friction 
	* `Motion` - LinearMotion and AngularMotion
	
## Common Functions

In addition to many specialized functions for the various data types 
all structs provide the following functionality:

* Constructor from value tuple
* `bool Equals(object other)`
* `bool AlmostEquals(T other, float tolerance)`
* `int GetHashCode()`
* `string ToString()`
* `static T Create(...)`
* `Deconstruct()`
* `==` and `!=` operator implementation
* implicit cast operator to and from value tuples
* `static T Zero` property
* `static T MinValue` property
* `static T MaxValue` property

Every vector struct also provides the additional functionality:

* Unary negation operator 
* Arithmetic operators: `+`, `-`, `*`, `/`
* Comparison operators based on Magnitude: `<`, `<=`, `>=`, `>`, 
* `Dot(T x)` 
* `AlmostZero()`
* `AnyComponentNegative()`
* `MinComponent()`
* `MaxComponent()`
* `SumComponents()`
* `SumSqrComponents()`
* `ProductComponents()`
* `GetComponent(int n)`
* `double MagnitudeSquared()`
* `double Magnitude()`
* `int NumComponents`
* `CompareTo(T x)`

Every interval struct contains the following:

* `T Extent()`
* `Merge()`
* `Intersection()`
* Operators + and -

## System.Math as Extension Functions, 

In addition All of the `System.Math` routines are implemented as static extension functions 
for `float`, `double`, `Vector2`,`Vector3`, `Vector4`, `DVector2`,`DVector3`, 
and `DVector4`. This provides a convenient fluent syntax on all variables making the Vim.Math3D API
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

# Appendix 

## Related Libraries 

* [System.Numerics](https://referencesource.microsoft.com/#System.Numerics,namespaces)
* [SharpDX Mathematics](https://github.com/sharpdx/SharpDX/tree/master/Source/SharpDX.Mathematics)
* [MonoGame](https://github.com/MonoGame/MonoGame)
* [Math.NET Spatial](https://github.com/mathnet/mathnet-spatial)
* [Math.NET Numerics](https://github.com/mathnet/mathnet-numerics)
* [Unity.Mathematics](https://github.com/Unity-Technologies/Unity.Mathematics)
* [Unity Reference](https://github.com/Unity-Technologies/UnityCsReference/tree/master/Runtime/Export)
* [Abacus](https://github.com/sungiant/abacus)
* [Geometry3Sharp](https://github.com/gradientspace/geometry3Sharp)
* [FNA-XNA](https://github.com/FNA-XNA/FNA/tree/master/src)
* [Stride](https://github.com/stride3d/stride/tree/master/sources/core/Stride.Core.Mathematics)
* [A Vector Type for C# - R Potter via Code Project](https://www.codeproject.com/Articles/17425/A-Vector-Type-for-C)
* [Godot Engine C# Libraries](https://github.com/godotengine/godot/tree/master/modules/mono/glue/GodotSharp/GodotSharp/Core)
* [GeometRi - Simple and lightweight computational geometry library for .Net](https://github.com/RiSearcher/GeometRi.CSharp)
* [Veldrid ](https://github.com/mellinoe/veldrid/tree/master/src/Veldrid.Utilities)
