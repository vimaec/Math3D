// MIT License - Copyright (C) Ara 3D, Inc.
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.

using System.Numerics;
using System.Collections.Generic;
using System.Linq;

namespace Ara3D 
{
	public static class MathOps {

        public static int Add (this int v1, int v2) { return v1 + v2; }
        public static int Sub (this int v1, int v2) { return v1 - v2; }
        public static int Mul (this int v1, int v2) { return v1 * v2; }
        public static int Div (this int v1, int v2) { return v1 / v2; }
        //public static int Mod (this int v1, int v2) { return v1 % v2; }
		public static int Neg (this int v) { return -v; }
        public static float Add (this float v1, float v2) { return v1 + v2; }
        public static float Sub (this float v1, float v2) { return v1 - v2; }
        public static float Mul (this float v1, float v2) { return v1 * v2; }
        public static float Div (this float v1, float v2) { return v1 / v2; }
        //public static float Mod (this float v1, float v2) { return v1 % v2; }
		public static float Neg (this float v) { return -v; }
        public static Vector3 Add (this Vector3 v1, Vector3 v2) { return v1 + v2; }
        public static Vector3 Sub (this Vector3 v1, Vector3 v2) { return v1 - v2; }
        public static Vector3 Mul (this Vector3 v1, Vector3 v2) { return v1 * v2; }
        public static Vector3 Div (this Vector3 v1, Vector3 v2) { return v1 / v2; }
        //public static Vector3 Mod (this Vector3 v1, Vector3 v2) { return v1 % v2; }
		public static Vector3 Neg (this Vector3 v) { return -v; }
        public static Vector4 Add (this Vector4 v1, Vector4 v2) { return v1 + v2; }
        public static Vector4 Sub (this Vector4 v1, Vector4 v2) { return v1 - v2; }
        public static Vector4 Mul (this Vector4 v1, Vector4 v2) { return v1 * v2; }
        public static Vector4 Div (this Vector4 v1, Vector4 v2) { return v1 / v2; }
        //public static Vector4 Mod (this Vector4 v1, Vector4 v2) { return v1 % v2; }
		public static Vector4 Neg (this Vector4 v) { return -v; }

        public static int Min (this int v1, int v2) { return System.Math.Min(v1, v2); }
        public static int Max (this int v1, int v2) { return System.Math.Max(v1, v2); }

		        public static double Atan2 (this int v1, int v2) { return System.Math.Atan2(v1, v2); }
		        public static double Log (this int v1, int v2) { return System.Math.Log(v1, v2); }
		        public static double Pow (this int v1, int v2) { return System.Math.Pow(v1, v2); }
		        public static double Abs (this int v) { return System.Math.Abs(v); }
		        public static double Acos (this int v) { return System.Math.Acos(v); }
		        public static double Asin (this int v) { return System.Math.Asin(v); }
		        public static double Atan (this int v) { return System.Math.Atan(v); }
		        public static double Cos (this int v) { return System.Math.Cos(v); }
		        public static double Cosh (this int v) { return System.Math.Cosh(v); }
		        public static double Exp (this int v) { return System.Math.Exp(v); }
		        public static double Log (this int v) { return System.Math.Log(v); }
		        public static double Log10 (this int v) { return System.Math.Log10(v); }
		        public static double Sin (this int v) { return System.Math.Sin(v); }
		        public static double Sinh (this int v) { return System.Math.Sinh(v); }
		        public static double Sqrt (this int v) { return System.Math.Sqrt(v); }
		        public static double Tan (this int v) { return System.Math.Tan(v); }
		        public static double Tanh (this int v) { return System.Math.Tanh(v); }
		
        public static float Min (this float v1, float v2) { return System.Math.Min(v1, v2); }
        public static float Max (this float v1, float v2) { return System.Math.Max(v1, v2); }

		        public static double Atan2 (this float v1, float v2) { return System.Math.Atan2(v1, v2); }
		        public static double Log (this float v1, float v2) { return System.Math.Log(v1, v2); }
		        public static double Pow (this float v1, float v2) { return System.Math.Pow(v1, v2); }
		        public static double Abs (this float v) { return System.Math.Abs(v); }
		        public static double Acos (this float v) { return System.Math.Acos(v); }
		        public static double Asin (this float v) { return System.Math.Asin(v); }
		        public static double Atan (this float v) { return System.Math.Atan(v); }
		        public static double Cos (this float v) { return System.Math.Cos(v); }
		        public static double Cosh (this float v) { return System.Math.Cosh(v); }
		        public static double Exp (this float v) { return System.Math.Exp(v); }
		        public static double Log (this float v) { return System.Math.Log(v); }
		        public static double Log10 (this float v) { return System.Math.Log10(v); }
		        public static double Sin (this float v) { return System.Math.Sin(v); }
		        public static double Sinh (this float v) { return System.Math.Sinh(v); }
		        public static double Sqrt (this float v) { return System.Math.Sqrt(v); }
		        public static double Tan (this float v) { return System.Math.Tan(v); }
		        public static double Tanh (this float v) { return System.Math.Tanh(v); }
		        public static bool Gt (this int v1, int v2) { return v1 > v2; }
        public static bool Lt (this int v1, int v2) { return v1 < v2; }
        public static bool GtEq (this int v1, int v2) { return v1 >= v2; }
        public static bool LtEq (this int v1, int v2) { return v1 <= v2; }
        public static bool Eq (this int v1, int v2) { return v1 == v2; }
        public static bool NEq (this int v1, int v2) { return v1 != v2; }
        public static bool Gt (this float v1, float v2) { return v1 > v2; }
        public static bool Lt (this float v1, float v2) { return v1 < v2; }
        public static bool GtEq (this float v1, float v2) { return v1 >= v2; }
        public static bool LtEq (this float v1, float v2) { return v1 <= v2; }
        public static bool Eq (this float v1, float v2) { return v1 == v2; }
        public static bool NEq (this float v1, float v2) { return v1 != v2; }

		public static bool And (this bool a, bool b) { return a && b; }
		public static bool Or (this bool a, bool b) { return a || b; }
		public static bool NAnd (this bool a, bool b) { return !(a && b); }
		public static bool XOr (this bool a, bool b) { return a || b && !(a && b); }
		public static bool NOr (this bool a, bool b) { return !(a || b); }
		public static bool Not (this bool a) { return !a; }

		// TODO: parameterize over all of the integer types
		public static int And (this int a, int b) { return a & b; }
		public static int Or (this int a, int b) { return a | b; }
		public static int NAnd (this int a, int b) { return ~(a & b); }
		public static int XOr (this int a, int b) { return a | b & ~(a & b); }
		public static int NOr (this int a, int b) { return ~(a | b); }
		public static int Not (this int a) { return ~a; }
		public static long And (this long a, long b) { return a & b; }
		public static long Or (this long a, long b) { return a | b; }
		public static long NAnd (this long a, long b) { return ~(a & b); }
		public static long XOr (this long a, long b) { return a | b & ~(a & b); }
		public static long NOr (this long a, long b) { return ~(a | b); }
		public static long Not (this long a) { return ~a; }

		public static IArray<int> Add( this IArray<int> v1s, IArray<int> v2s) { return v1s.Zip(v2s, Add); }
		public static IArray<int> Add( this IArray<int> v1s, int v2) { return v1s.Select(v1 => Add(v1, v2)); }
		public static IEnumerable<int> Add( this IEnumerable<int> v1s, IEnumerable<int> v2s) { return v1s.Zip(v2s, Add); }
		public static IEnumerable<int> Add( this IEnumerable<int> v1s, int v2) { return v1s.Select(v1 => Add(v1, v2)); }
		public static IArray<int> Sub( this IArray<int> v1s, IArray<int> v2s) { return v1s.Zip(v2s, Sub); }
		public static IArray<int> Sub( this IArray<int> v1s, int v2) { return v1s.Select(v1 => Sub(v1, v2)); }
		public static IEnumerable<int> Sub( this IEnumerable<int> v1s, IEnumerable<int> v2s) { return v1s.Zip(v2s, Sub); }
		public static IEnumerable<int> Sub( this IEnumerable<int> v1s, int v2) { return v1s.Select(v1 => Sub(v1, v2)); }
		public static IArray<int> Mul( this IArray<int> v1s, IArray<int> v2s) { return v1s.Zip(v2s, Mul); }
		public static IArray<int> Mul( this IArray<int> v1s, int v2) { return v1s.Select(v1 => Mul(v1, v2)); }
		public static IEnumerable<int> Mul( this IEnumerable<int> v1s, IEnumerable<int> v2s) { return v1s.Zip(v2s, Mul); }
		public static IEnumerable<int> Mul( this IEnumerable<int> v1s, int v2) { return v1s.Select(v1 => Mul(v1, v2)); }
		public static IArray<int> Div( this IArray<int> v1s, IArray<int> v2s) { return v1s.Zip(v2s, Div); }
		public static IArray<int> Div( this IArray<int> v1s, int v2) { return v1s.Select(v1 => Div(v1, v2)); }
		public static IEnumerable<int> Div( this IEnumerable<int> v1s, IEnumerable<int> v2s) { return v1s.Zip(v2s, Div); }
		public static IEnumerable<int> Div( this IEnumerable<int> v1s, int v2) { return v1s.Select(v1 => Div(v1, v2)); }
		public static IArray<float> Add( this IArray<float> v1s, IArray<float> v2s) { return v1s.Zip(v2s, Add); }
		public static IArray<float> Add( this IArray<float> v1s, float v2) { return v1s.Select(v1 => Add(v1, v2)); }
		public static IEnumerable<float> Add( this IEnumerable<float> v1s, IEnumerable<float> v2s) { return v1s.Zip(v2s, Add); }
		public static IEnumerable<float> Add( this IEnumerable<float> v1s, float v2) { return v1s.Select(v1 => Add(v1, v2)); }
		public static IArray<float> Sub( this IArray<float> v1s, IArray<float> v2s) { return v1s.Zip(v2s, Sub); }
		public static IArray<float> Sub( this IArray<float> v1s, float v2) { return v1s.Select(v1 => Sub(v1, v2)); }
		public static IEnumerable<float> Sub( this IEnumerable<float> v1s, IEnumerable<float> v2s) { return v1s.Zip(v2s, Sub); }
		public static IEnumerable<float> Sub( this IEnumerable<float> v1s, float v2) { return v1s.Select(v1 => Sub(v1, v2)); }
		public static IArray<float> Mul( this IArray<float> v1s, IArray<float> v2s) { return v1s.Zip(v2s, Mul); }
		public static IArray<float> Mul( this IArray<float> v1s, float v2) { return v1s.Select(v1 => Mul(v1, v2)); }
		public static IEnumerable<float> Mul( this IEnumerable<float> v1s, IEnumerable<float> v2s) { return v1s.Zip(v2s, Mul); }
		public static IEnumerable<float> Mul( this IEnumerable<float> v1s, float v2) { return v1s.Select(v1 => Mul(v1, v2)); }
		public static IArray<float> Div( this IArray<float> v1s, IArray<float> v2s) { return v1s.Zip(v2s, Div); }
		public static IArray<float> Div( this IArray<float> v1s, float v2) { return v1s.Select(v1 => Div(v1, v2)); }
		public static IEnumerable<float> Div( this IEnumerable<float> v1s, IEnumerable<float> v2s) { return v1s.Zip(v2s, Div); }
		public static IEnumerable<float> Div( this IEnumerable<float> v1s, float v2) { return v1s.Select(v1 => Div(v1, v2)); }
		public static IArray<Vector3> Add( this IArray<Vector3> v1s, IArray<Vector3> v2s) { return v1s.Zip(v2s, Add); }
		public static IArray<Vector3> Add( this IArray<Vector3> v1s, Vector3 v2) { return v1s.Select(v1 => Add(v1, v2)); }
		public static IEnumerable<Vector3> Add( this IEnumerable<Vector3> v1s, IEnumerable<Vector3> v2s) { return v1s.Zip(v2s, Add); }
		public static IEnumerable<Vector3> Add( this IEnumerable<Vector3> v1s, Vector3 v2) { return v1s.Select(v1 => Add(v1, v2)); }
		public static IArray<Vector3> Sub( this IArray<Vector3> v1s, IArray<Vector3> v2s) { return v1s.Zip(v2s, Sub); }
		public static IArray<Vector3> Sub( this IArray<Vector3> v1s, Vector3 v2) { return v1s.Select(v1 => Sub(v1, v2)); }
		public static IEnumerable<Vector3> Sub( this IEnumerable<Vector3> v1s, IEnumerable<Vector3> v2s) { return v1s.Zip(v2s, Sub); }
		public static IEnumerable<Vector3> Sub( this IEnumerable<Vector3> v1s, Vector3 v2) { return v1s.Select(v1 => Sub(v1, v2)); }
		public static IArray<Vector3> Mul( this IArray<Vector3> v1s, IArray<Vector3> v2s) { return v1s.Zip(v2s, Mul); }
		public static IArray<Vector3> Mul( this IArray<Vector3> v1s, Vector3 v2) { return v1s.Select(v1 => Mul(v1, v2)); }
		public static IEnumerable<Vector3> Mul( this IEnumerable<Vector3> v1s, IEnumerable<Vector3> v2s) { return v1s.Zip(v2s, Mul); }
		public static IEnumerable<Vector3> Mul( this IEnumerable<Vector3> v1s, Vector3 v2) { return v1s.Select(v1 => Mul(v1, v2)); }
		public static IArray<Vector3> Div( this IArray<Vector3> v1s, IArray<Vector3> v2s) { return v1s.Zip(v2s, Div); }
		public static IArray<Vector3> Div( this IArray<Vector3> v1s, Vector3 v2) { return v1s.Select(v1 => Div(v1, v2)); }
		public static IEnumerable<Vector3> Div( this IEnumerable<Vector3> v1s, IEnumerable<Vector3> v2s) { return v1s.Zip(v2s, Div); }
		public static IEnumerable<Vector3> Div( this IEnumerable<Vector3> v1s, Vector3 v2) { return v1s.Select(v1 => Div(v1, v2)); }
		public static IArray<Vector4> Add( this IArray<Vector4> v1s, IArray<Vector4> v2s) { return v1s.Zip(v2s, Add); }
		public static IArray<Vector4> Add( this IArray<Vector4> v1s, Vector4 v2) { return v1s.Select(v1 => Add(v1, v2)); }
		public static IEnumerable<Vector4> Add( this IEnumerable<Vector4> v1s, IEnumerable<Vector4> v2s) { return v1s.Zip(v2s, Add); }
		public static IEnumerable<Vector4> Add( this IEnumerable<Vector4> v1s, Vector4 v2) { return v1s.Select(v1 => Add(v1, v2)); }
		public static IArray<Vector4> Sub( this IArray<Vector4> v1s, IArray<Vector4> v2s) { return v1s.Zip(v2s, Sub); }
		public static IArray<Vector4> Sub( this IArray<Vector4> v1s, Vector4 v2) { return v1s.Select(v1 => Sub(v1, v2)); }
		public static IEnumerable<Vector4> Sub( this IEnumerable<Vector4> v1s, IEnumerable<Vector4> v2s) { return v1s.Zip(v2s, Sub); }
		public static IEnumerable<Vector4> Sub( this IEnumerable<Vector4> v1s, Vector4 v2) { return v1s.Select(v1 => Sub(v1, v2)); }
		public static IArray<Vector4> Mul( this IArray<Vector4> v1s, IArray<Vector4> v2s) { return v1s.Zip(v2s, Mul); }
		public static IArray<Vector4> Mul( this IArray<Vector4> v1s, Vector4 v2) { return v1s.Select(v1 => Mul(v1, v2)); }
		public static IEnumerable<Vector4> Mul( this IEnumerable<Vector4> v1s, IEnumerable<Vector4> v2s) { return v1s.Zip(v2s, Mul); }
		public static IEnumerable<Vector4> Mul( this IEnumerable<Vector4> v1s, Vector4 v2) { return v1s.Select(v1 => Mul(v1, v2)); }
		public static IArray<Vector4> Div( this IArray<Vector4> v1s, IArray<Vector4> v2s) { return v1s.Zip(v2s, Div); }
		public static IArray<Vector4> Div( this IArray<Vector4> v1s, Vector4 v2) { return v1s.Select(v1 => Div(v1, v2)); }
		public static IEnumerable<Vector4> Div( this IEnumerable<Vector4> v1s, IEnumerable<Vector4> v2s) { return v1s.Zip(v2s, Div); }
		public static IEnumerable<Vector4> Div( this IEnumerable<Vector4> v1s, Vector4 v2) { return v1s.Select(v1 => Div(v1, v2)); }
    }
}