## 3D Math Programming in C# 

Performing arithmetic on 3D data structures is the basis of computer graphics programming. 

# Why I wrote an Open-Source 3D Math Library in C# 

If anyone told me that they wrote their own 3D Math library in C#, I would be rolling my eyes and assume it was just an other example of "not invented here" (NIH) syndrome. This is the story about why at Ara3D I decided to write and maintain our own 3D Math library. 

## What to Expect in a 3D Math Library 

When working with computer graphics there are a number of low-level data structures and subroutines that are ubiquitous. 


for representing and manipulating the building blocks of 3D graphics: points, lines, and triangles. 

### Vector3 

The first level that everyone needs is a way to represent a 3D point or vector. Sometimes these are two separate structures (e.g. in the WPF framework)
are usued but commonly it is just one structure with an X, Y, and Z floating point members. Some of the common operations in addition to 
the component wise arithmetic operators include length (aka magnitude),
cross product, dot product, normalize, among others.

### Transforms: Scale, Rotation, and Translation

A point or vector in space can be transformed in a number of ways, the most common types of transformations are scale, rotation, and translation.  

### 3D Transforms and Matrix4x4

The building block for representing transformations in 3D space is the affine transformation matrix: a 4x4 (or sometimes 3x4 matrix) which can be used to represent 
a combination of scale, rotation, and translation. 


# History 

## My First C# 3D Math Library: MonoGame 

While working as a Principal Software Engineer at Autodesk on the 3ds Max team we had the mandate to build a geometry library in C# for the Max Creation Graph. Obviously, we wanted to use a mature and robust math library as the basis, so we opted to use MonoGame. MonoGame is an open-source port of the XNA library, and satisfied our needs. 

## Next Attempt: System.Numerics 

When I started Ara3D we had similar needs, but instead this time we decided to go with a more actively supported library with purpotedly better performance as the basis: System.Numerics. Another motivation was that System.Numerics carried the promise of optimization by recent .NET run-times by compiling to SIMD instruction sets. 

System.Numerics worked well enough when only targetting .NET Framework but I ran into some issues: 

* Memory layout was not the same between .NET Framework (aligned vector3 into 12bytes) and .NET Core (aligned vector3 on 16 bytes).
* I had trouble creating and using .NET Standard libraries that referenced System.Numerics (seemed to be a reference issue)

There were a number of other things I wasn't crazy about:

* I had no double versions of the API
* The API surface was quite small compared to MonoGame
* The structs were mutable 
* Some functions were only defined as static functions (e.g. Vector3.Cross)

I did like several aspect of the API though compared to MonoGame:

* users are not required to pass structs by reference functions are annotated using the `[MethodImpl(MethodImplOptions.AggressiveInlining)]`
* the hash code implementation was better 

## Ara3D.Math3D: Combining the Best of System.Numerics and MonoGame 

Luckily the CoreFX libraries and MonoGame are both released under the MIT License, so I decided to take my favorite parts of both libraries and put them 
together in a single library: Ara3D.Math. Lucky for me, Vector3 math is something that doesn't change much. 

## Performance 

How good is good? 

# How to make a good open-source library?

So if you want to make an open-source library:

1. the API is easy to learn and discover - the best way is to map it some
2. have a well-defined motivating reason to exist among the alternatives 
3. an open-source license that is we 
4. easy to validate and debug - reading the source code should be pleasant 
5. does one well-defined thing and does it well 
6. is not incomplete 
7. has good test coverage
8. is well-documented 
9. Follows modern best-practices 

## Tests 

...

## Choosing an API and Coding Style to Emulate 

There are a lot of options for how to code an API if we want .... 
* GLSL 
* WPF 
* System.Numerics
* MonoGame 