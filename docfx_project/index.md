# Vim.Math3D

[<img src="https://img.shields.io/nuget/v/Vim.Math3D.svg">](https://github.com/Vim/Math3D)

**Vim.Math3D** is a portable, safe, and efficient 3D math library from [VIM AEC](https://vimaec.com) written in C# 
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
    * Serializable
	* Double and Single precision implementation of most structures 
2. Robustness
	* Functions are well covered by unit tests 
	* Functions are easy to read, understand, and verify
    * All structs are immutable
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

The following is a list of data structures provided by Vim.Math

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
