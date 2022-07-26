import 'dart:math' as math;
import 'package:vim_math3d/vim_math3d.dart';

double pi = math.pi;
double piOver2 = math.pi / 2.0;
double piOver4 = math.pi / 4.0;

double toRadians(double degrees) => degrees * math.pi / 180.0;
// Comparison helpers with small tolerance to allow for floating point rounding during computations.
bool equalDouble(double l, double r, [double delta = 1e-5]) =>
    (l - r).abs() < delta;
bool equalVector2(Vector2 a, Vector2 b) =>
    equalDouble(a.x, b.x) && equalDouble(a.y, b.y);
bool equalVector3(Vector3 a, Vector3 b) =>
    equalDouble(a.x, b.x) && equalDouble(a.y, b.y) && equalDouble(a.z, b.z);
bool equalVector4(Vector4 a, Vector4 b) =>
    equalDouble(a.x, b.x) &&
    equalDouble(a.y, b.y) &&
    equalDouble(a.z, b.z) &&
    equalDouble(a.w, b.w);
bool equalMatrix(Matrix4x4 a, Matrix4x4 b) =>
    equalDouble(a.m11, b.m11) &&
    equalDouble(a.m12, b.m12) &&
    equalDouble(a.m13, b.m13) &&
    equalDouble(a.m14, b.m14) &&
    equalDouble(a.m21, b.m21) &&
    equalDouble(a.m22, b.m22) &&
    equalDouble(a.m23, b.m23) &&
    equalDouble(a.m24, b.m24) &&
    equalDouble(a.m31, b.m31) &&
    equalDouble(a.m32, b.m32) &&
    equalDouble(a.m33, b.m33) &&
    equalDouble(a.m34, b.m34) &&
    equalDouble(a.m41, b.m41) &&
    equalDouble(a.m42, b.m42) &&
    equalDouble(a.m43, b.m43) &&
    equalDouble(a.m44, b.m44);
bool equalPlane(Plane a, Plane b) =>
    equalVector3(a.normal, b.normal) && equalDouble(a.d, b.d);
bool equalQuaternion(Quaternion a, Quaternion b) =>
    equalDouble(a.x, b.x) &&
    equalDouble(a.y, b.y) &&
    equalDouble(a.z, b.z) &&
    equalDouble(a.w, b.w);
bool equalRotation(Quaternion a, Quaternion b) =>
    equalQuaternion(a, b) || equalQuaternion(a, -b);
