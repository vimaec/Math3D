# Vim.Math3D

[<img src="https://img.shields.io/nuget/v/Vim.Math3D.svg">](https://github.com/Vim/Math3D)

**Vim.Math3D** is a portable, safe, and efficient 3D math library from [VIM AEC](https://vimaec.com) written in C# 
targeting .NET Standard 2.0 without any dependencies. 

It is intended primarily as a feature rich drop-in replacement for System.Numerics that assures consistent serialization
across platforms, enforces immutability, and offers many additional structures and functionality. 

Math3D is compatible with Unity and has been used in production on many different platforms including Windows, 
Android, iOS, WebGL, and Magic Leap. 

## History 

Originally Math3D was forked from the core classes provided in the CoreFX implementation of 
[System.Numerics](https://github.com/dotnet/corefx/tree/master/src/System.Numerics.Vectors/src/System/Numerics) with 
additional algorithms and structures taken from [MonoGame](https://github.com/MonoGame/MonoGame), 
an open-source cross platform port of the XNA game development framework. 

The original motivation was to assure that the numerical types binary layout was consistent across platforms. 
We found that with System.Numerics different implementations could have different binary layouts of the structures.  
Further to this we found that that many useful algorithms were lacking.

Microsoft's recommendations around [struct design](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/struct)
are to make structs immutable. Oddly enough this is violated by the System.Numerics library. 

By opting to make data types immutable by default eliminates large categories of bugs like race conditions, 
invariant violations after construction. This is another reason we decided to fork the System.Numerics library. 

The MonoGame algorithms taken into this library previously relied heavily on `ref` parameters which prevented 
the usage of fluent syntax and made the algorithms less readable, so in Math 3D we rewrote many of the
algorithms as functions.

## What Structs are Provided

The following is a [list of data structures](https://github.com/Vim/Math3D/blob/master/Structs.cs) that are provided by Vim.Math

	* Vectors
		* Vector2
		* Vector3
		* Vector4	
		* DVector2
		* DVector3
		* DVector4
		* Int2
		* Int3
		* Int4
		* Complex 
	* Pseudo-Vectors - the following classes lack some of the operations of Vectors 
		* Byte2
		* Byte3
		* Byte4
		* ColorRGB - Three byte representation of colors
		* ColorRGBA
		* ColorHDR - High Defintion Range, 4 floating points 
	* Rotations and Transformations
		* Quaternion
		* DQuaternion
		* AxisAngle 
		* Matrix4x4
		* Transform - Position and Orientation
		* Euler (Tait-Bryan)
	* Geometric structures and shapes
		* Plane
		* DPlane
		* Triangle
		* Triangle2
		* Quad
	* Lines
		* Line
		* Ray
		* DRay
	* Interval Structures and Bounding			
		* Interval
		* AABox
		* AABox2D
		* AABox4D
		* DInterval
		* DAABox
		* DAABox2D
		* DAABox4D
		* Sphere
		* DSphere
	* Alternative Coordinate Representations
		* SphericalCoordinate - Radius, Azimuth (bearing), and Inclination (elevation angle)
		* PolarCoordinate - Radius and Azimuth (bearing)
		* LogPolarCoordinate - Rho (log of radial distance) and Azimuth
		* CylindricalCoordinate - Radius, Azimuth (bearing) and Height
		* HorizontalCoordinate - Azimuth (bearing) and Inclination
		* GeoCoordinate - Latitude and Longitude
	* Motion 
		* LinearMotion - Velocity, Acceleration, and Scalar Friction 
		* AngularMotion - Velocity, Acceleration, and Scalar Friction 
		* Motion - LinearMotion and AngularMotion
	
## Common Functions

In addition to many specialized functions for the various data type 
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
	* operators: `<`, `<=`, `>=`, `>`, `+`, `-`, `*`, `/`
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

