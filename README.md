# Math3D

**Math3D** is a portable high-performance 3D math library from [Ara3D](https://ara3d.com) in pure C#. 
Math3D was originally forked from [MonoGame](https://github.com/MonoGame/MonoGame) an open-source version of XNA, and modified to use the core 
classes provided in `System.Numerics`. 

## Related Libraries 

* [Math.NET Numerics](https://github.com/mathnet/mathnet-numerics)
* [Geometry3Sharp](https://github.com/gradientspace/geometry3Sharp)
* [MonoGame](https://github.com/MonoGame/MonoGame)
* [FNA-XNA](https://github.com/FNA-XNA/FNA/tree/master/src)
* [Xenko](https://github.com/xenko3d/xenko/blob/master/sources/core/Xenko.Core.Mathematics)

## Todo 

* Creating double precision versions of many of the data structures and algorithms
* Investigate integrating code from [Geometry3Sharp](https://github.com/gradientspace/geometry3Sharp) by Ryan Schmidt.
* I have the feeling that there are some possibilities for intersection interfaces
* I want to have an IAlmostEquals interface
* I may want to write serializers for the basic types, so that we can write them to a Bytes efficiently
* I need to add MethodImplOptions.AggressiveInlining because passing of structs prevents inlining
	* See it used here: https://referencesource.microsoft.com/#System.Numerics/System/Numerics/Vector3.cs
	* See this article here: https://docs.microsoft.com/en-us/previous-versions/dotnet/articles/ms973858(v=msdn.10)#highperfmanagedapps_topic10
* We need some performance tests 
* Write a "Parse" function for each of the structs
* Test various serializer / deserializers. (JSON, XML, Binary, DataContract, SOAP).