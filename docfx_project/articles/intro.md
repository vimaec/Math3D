# Introduction to Vim.Math3D

Vim.Math3d is a C# library that exposes several types and algorithms to help develop 2D and 3D computer graphics software.

# Immutability of Structs 

All structs in Math3D are immutable, meaning that fields are readonly and can only be set once upon construction. 

# Vector3 Struct 

The most commonly used type in the Vim.Math3d library is the Vector3 struct which consists of 3 readonly floats: 
X, Y, and Z. A Vector3 can be used to express a position in 3-dimensional space, or a vector representing a direction
and magnitude (e.g. velocity). 

The length or magnitude of a Vector is determined by computing the square root of the sum of each component squared.

In other words:

```
float Length => SumSqrComponents().Sqrt();
```

# Floating Point Extension Functions
