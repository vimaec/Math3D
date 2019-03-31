# Writing a High Performance Portable 3D Math Library in C# 

If anyone told me that they wrote their own 3D Math library in C#, I would be rolling my eyes and assume it was just an other example of "not invented here" (NIH) syndrome. This is the story about why at Ara3D we nonetheless felt compelled to write and maintain our own library, and how we went about making sure it was the best possible library. 

## My First C# 3D Math Library: MonoGame 

While working as a Principal Software Engineer at Autodesk on the 3ds Max team I had the mandate to build a geometry library in C# for the MCG feature. Obviously, we wanted to use a mature and robust math library as the basis, so we opted to use MonoGame. MonoGame is an open-source port of the XNA library, and satisfied our needs. 

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