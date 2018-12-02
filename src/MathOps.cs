// MIT License - Copyright (C) Ara 3D, Inc.
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.


using System.Numerics;

namespace Ara3D 
{
	public static class MathOps
	{
	
        public static int Add (this int v1, int v2) { return v1 + v2; }
        public static int Sub (this int v1, int v2) { return v1 - v2; }
        public static int Mul (this int v1, int v2) { return v1 * v2; }
        public static int Div (this int v1, int v2) { return v1 / v2; }
		public static int Negate (this int v) { return -v; }
        //public static int Mod (this int v1, int v2) { return v1 % v2; }
		public static IArray< int > Negate(this IArray< int > self) { return self.Select(Negate); }
		public static IArray< int > Add(this IArray< int > self, IArray< int > other) { return self.Zip(other, Add); }
		public static IArray< int > Add(this IArray< int > self, int scalar) { return self.Select(x => Add(x, scalar)); }
		public static IArray< int > Add(this int self, IArray< int > vector) { return vector.Select(x => Add(self, x)); }
		public static IArray< int > Mul(this IArray< int > self, IArray< int > other) { return self.Zip(other, Mul); }
		public static IArray< int > Mul(this IArray< int > self, int scalar) { return self.Select(x => Mul(x, scalar)); }
		public static IArray< int > Mul(this int self, IArray< int > vector) { return vector.Select(x => Mul(self, x)); }
		public static IArray< int > Sub(this IArray< int > self, IArray< int > other) { return self.Zip(other, Sub); }
		public static IArray< int > Sub(this IArray< int > self, int scalar) { return self.Select(x => Sub(x, scalar)); }
		public static IArray< int > Sub(this int self, IArray< int > vector) { return vector.Select(x => Sub(self, x)); }
		public static IArray< int > Div(this IArray< int > self, IArray< int > other) { return self.Zip(other, Div); }
		public static IArray< int > Div(this IArray< int > self, int scalar) { return self.Select(x => Div(x, scalar)); }
		public static IArray< int > Div(this int self, IArray< int > vector) { return vector.Select(x => Div(self, x)); }
        public static long Add (this long v1, long v2) { return v1 + v2; }
        public static long Sub (this long v1, long v2) { return v1 - v2; }
        public static long Mul (this long v1, long v2) { return v1 * v2; }
        public static long Div (this long v1, long v2) { return v1 / v2; }
		public static long Negate (this long v) { return -v; }
        //public static long Mod (this long v1, long v2) { return v1 % v2; }
		public static IArray< long > Negate(this IArray< long > self) { return self.Select(Negate); }
		public static IArray< long > Add(this IArray< long > self, IArray< long > other) { return self.Zip(other, Add); }
		public static IArray< long > Add(this IArray< long > self, long scalar) { return self.Select(x => Add(x, scalar)); }
		public static IArray< long > Add(this long self, IArray< long > vector) { return vector.Select(x => Add(self, x)); }
		public static IArray< long > Mul(this IArray< long > self, IArray< long > other) { return self.Zip(other, Mul); }
		public static IArray< long > Mul(this IArray< long > self, long scalar) { return self.Select(x => Mul(x, scalar)); }
		public static IArray< long > Mul(this long self, IArray< long > vector) { return vector.Select(x => Mul(self, x)); }
		public static IArray< long > Sub(this IArray< long > self, IArray< long > other) { return self.Zip(other, Sub); }
		public static IArray< long > Sub(this IArray< long > self, long scalar) { return self.Select(x => Sub(x, scalar)); }
		public static IArray< long > Sub(this long self, IArray< long > vector) { return vector.Select(x => Sub(self, x)); }
		public static IArray< long > Div(this IArray< long > self, IArray< long > other) { return self.Zip(other, Div); }
		public static IArray< long > Div(this IArray< long > self, long scalar) { return self.Select(x => Div(x, scalar)); }
		public static IArray< long > Div(this long self, IArray< long > vector) { return vector.Select(x => Div(self, x)); }
        public static float Add (this float v1, float v2) { return v1 + v2; }
        public static float Sub (this float v1, float v2) { return v1 - v2; }
        public static float Mul (this float v1, float v2) { return v1 * v2; }
        public static float Div (this float v1, float v2) { return v1 / v2; }
		public static float Negate (this float v) { return -v; }
        //public static float Mod (this float v1, float v2) { return v1 % v2; }
		public static IArray< float > Negate(this IArray< float > self) { return self.Select(Negate); }
		public static IArray< float > Add(this IArray< float > self, IArray< float > other) { return self.Zip(other, Add); }
		public static IArray< float > Add(this IArray< float > self, float scalar) { return self.Select(x => Add(x, scalar)); }
		public static IArray< float > Add(this float self, IArray< float > vector) { return vector.Select(x => Add(self, x)); }
		public static IArray< float > Mul(this IArray< float > self, IArray< float > other) { return self.Zip(other, Mul); }
		public static IArray< float > Mul(this IArray< float > self, float scalar) { return self.Select(x => Mul(x, scalar)); }
		public static IArray< float > Mul(this float self, IArray< float > vector) { return vector.Select(x => Mul(self, x)); }
		public static IArray< float > Sub(this IArray< float > self, IArray< float > other) { return self.Zip(other, Sub); }
		public static IArray< float > Sub(this IArray< float > self, float scalar) { return self.Select(x => Sub(x, scalar)); }
		public static IArray< float > Sub(this float self, IArray< float > vector) { return vector.Select(x => Sub(self, x)); }
		public static IArray< float > Div(this IArray< float > self, IArray< float > other) { return self.Zip(other, Div); }
		public static IArray< float > Div(this IArray< float > self, float scalar) { return self.Select(x => Div(x, scalar)); }
		public static IArray< float > Div(this float self, IArray< float > vector) { return vector.Select(x => Div(self, x)); }
        public static double Add (this double v1, double v2) { return v1 + v2; }
        public static double Sub (this double v1, double v2) { return v1 - v2; }
        public static double Mul (this double v1, double v2) { return v1 * v2; }
        public static double Div (this double v1, double v2) { return v1 / v2; }
		public static double Negate (this double v) { return -v; }
        //public static double Mod (this double v1, double v2) { return v1 % v2; }
		public static IArray< double > Negate(this IArray< double > self) { return self.Select(Negate); }
		public static IArray< double > Add(this IArray< double > self, IArray< double > other) { return self.Zip(other, Add); }
		public static IArray< double > Add(this IArray< double > self, double scalar) { return self.Select(x => Add(x, scalar)); }
		public static IArray< double > Add(this double self, IArray< double > vector) { return vector.Select(x => Add(self, x)); }
		public static IArray< double > Mul(this IArray< double > self, IArray< double > other) { return self.Zip(other, Mul); }
		public static IArray< double > Mul(this IArray< double > self, double scalar) { return self.Select(x => Mul(x, scalar)); }
		public static IArray< double > Mul(this double self, IArray< double > vector) { return vector.Select(x => Mul(self, x)); }
		public static IArray< double > Sub(this IArray< double > self, IArray< double > other) { return self.Zip(other, Sub); }
		public static IArray< double > Sub(this IArray< double > self, double scalar) { return self.Select(x => Sub(x, scalar)); }
		public static IArray< double > Sub(this double self, IArray< double > vector) { return vector.Select(x => Sub(self, x)); }
		public static IArray< double > Div(this IArray< double > self, IArray< double > other) { return self.Zip(other, Div); }
		public static IArray< double > Div(this IArray< double > self, double scalar) { return self.Select(x => Div(x, scalar)); }
		public static IArray< double > Div(this double self, IArray< double > vector) { return vector.Select(x => Div(self, x)); }
        public static Vector2 Add (this Vector2 v1, Vector2 v2) { return v1 + v2; }
        public static Vector2 Sub (this Vector2 v1, Vector2 v2) { return v1 - v2; }
        public static Vector2 Mul (this Vector2 v1, Vector2 v2) { return v1 * v2; }
        public static Vector2 Div (this Vector2 v1, Vector2 v2) { return v1 / v2; }
		public static Vector2 Negate (this Vector2 v) { return -v; }
        //public static Vector2 Mod (this Vector2 v1, Vector2 v2) { return v1 % v2; }
		public static IArray< Vector2 > Negate(this IArray< Vector2 > self) { return self.Select(Negate); }
		public static IArray< Vector2 > Add(this IArray< Vector2 > self, IArray< Vector2 > other) { return self.Zip(other, Add); }
		public static IArray< Vector2 > Add(this IArray< Vector2 > self, Vector2 scalar) { return self.Select(x => Add(x, scalar)); }
		public static IArray< Vector2 > Add(this Vector2 self, IArray< Vector2 > vector) { return vector.Select(x => Add(self, x)); }
		public static IArray< Vector2 > Mul(this IArray< Vector2 > self, IArray< Vector2 > other) { return self.Zip(other, Mul); }
		public static IArray< Vector2 > Mul(this IArray< Vector2 > self, Vector2 scalar) { return self.Select(x => Mul(x, scalar)); }
		public static IArray< Vector2 > Mul(this Vector2 self, IArray< Vector2 > vector) { return vector.Select(x => Mul(self, x)); }
		public static IArray< Vector2 > Sub(this IArray< Vector2 > self, IArray< Vector2 > other) { return self.Zip(other, Sub); }
		public static IArray< Vector2 > Sub(this IArray< Vector2 > self, Vector2 scalar) { return self.Select(x => Sub(x, scalar)); }
		public static IArray< Vector2 > Sub(this Vector2 self, IArray< Vector2 > vector) { return vector.Select(x => Sub(self, x)); }
		public static IArray< Vector2 > Div(this IArray< Vector2 > self, IArray< Vector2 > other) { return self.Zip(other, Div); }
		public static IArray< Vector2 > Div(this IArray< Vector2 > self, Vector2 scalar) { return self.Select(x => Div(x, scalar)); }
		public static IArray< Vector2 > Div(this Vector2 self, IArray< Vector2 > vector) { return vector.Select(x => Div(self, x)); }
        public static Vector3 Add (this Vector3 v1, Vector3 v2) { return v1 + v2; }
        public static Vector3 Sub (this Vector3 v1, Vector3 v2) { return v1 - v2; }
        public static Vector3 Mul (this Vector3 v1, Vector3 v2) { return v1 * v2; }
        public static Vector3 Div (this Vector3 v1, Vector3 v2) { return v1 / v2; }
		public static Vector3 Negate (this Vector3 v) { return -v; }
        //public static Vector3 Mod (this Vector3 v1, Vector3 v2) { return v1 % v2; }
		public static IArray< Vector3 > Negate(this IArray< Vector3 > self) { return self.Select(Negate); }
		public static IArray< Vector3 > Add(this IArray< Vector3 > self, IArray< Vector3 > other) { return self.Zip(other, Add); }
		public static IArray< Vector3 > Add(this IArray< Vector3 > self, Vector3 scalar) { return self.Select(x => Add(x, scalar)); }
		public static IArray< Vector3 > Add(this Vector3 self, IArray< Vector3 > vector) { return vector.Select(x => Add(self, x)); }
		public static IArray< Vector3 > Mul(this IArray< Vector3 > self, IArray< Vector3 > other) { return self.Zip(other, Mul); }
		public static IArray< Vector3 > Mul(this IArray< Vector3 > self, Vector3 scalar) { return self.Select(x => Mul(x, scalar)); }
		public static IArray< Vector3 > Mul(this Vector3 self, IArray< Vector3 > vector) { return vector.Select(x => Mul(self, x)); }
		public static IArray< Vector3 > Sub(this IArray< Vector3 > self, IArray< Vector3 > other) { return self.Zip(other, Sub); }
		public static IArray< Vector3 > Sub(this IArray< Vector3 > self, Vector3 scalar) { return self.Select(x => Sub(x, scalar)); }
		public static IArray< Vector3 > Sub(this Vector3 self, IArray< Vector3 > vector) { return vector.Select(x => Sub(self, x)); }
		public static IArray< Vector3 > Div(this IArray< Vector3 > self, IArray< Vector3 > other) { return self.Zip(other, Div); }
		public static IArray< Vector3 > Div(this IArray< Vector3 > self, Vector3 scalar) { return self.Select(x => Div(x, scalar)); }
		public static IArray< Vector3 > Div(this Vector3 self, IArray< Vector3 > vector) { return vector.Select(x => Div(self, x)); }
        public static Vector4 Add (this Vector4 v1, Vector4 v2) { return v1 + v2; }
        public static Vector4 Sub (this Vector4 v1, Vector4 v2) { return v1 - v2; }
        public static Vector4 Mul (this Vector4 v1, Vector4 v2) { return v1 * v2; }
        public static Vector4 Div (this Vector4 v1, Vector4 v2) { return v1 / v2; }
		public static Vector4 Negate (this Vector4 v) { return -v; }
        //public static Vector4 Mod (this Vector4 v1, Vector4 v2) { return v1 % v2; }
		public static IArray< Vector4 > Negate(this IArray< Vector4 > self) { return self.Select(Negate); }
		public static IArray< Vector4 > Add(this IArray< Vector4 > self, IArray< Vector4 > other) { return self.Zip(other, Add); }
		public static IArray< Vector4 > Add(this IArray< Vector4 > self, Vector4 scalar) { return self.Select(x => Add(x, scalar)); }
		public static IArray< Vector4 > Add(this Vector4 self, IArray< Vector4 > vector) { return vector.Select(x => Add(self, x)); }
		public static IArray< Vector4 > Mul(this IArray< Vector4 > self, IArray< Vector4 > other) { return self.Zip(other, Mul); }
		public static IArray< Vector4 > Mul(this IArray< Vector4 > self, Vector4 scalar) { return self.Select(x => Mul(x, scalar)); }
		public static IArray< Vector4 > Mul(this Vector4 self, IArray< Vector4 > vector) { return vector.Select(x => Mul(self, x)); }
		public static IArray< Vector4 > Sub(this IArray< Vector4 > self, IArray< Vector4 > other) { return self.Zip(other, Sub); }
		public static IArray< Vector4 > Sub(this IArray< Vector4 > self, Vector4 scalar) { return self.Select(x => Sub(x, scalar)); }
		public static IArray< Vector4 > Sub(this Vector4 self, IArray< Vector4 > vector) { return vector.Select(x => Sub(self, x)); }
		public static IArray< Vector4 > Div(this IArray< Vector4 > self, IArray< Vector4 > other) { return self.Zip(other, Div); }
		public static IArray< Vector4 > Div(this IArray< Vector4 > self, Vector4 scalar) { return self.Select(x => Div(x, scalar)); }
		public static IArray< Vector4 > Div(this Vector4 self, IArray< Vector4 > vector) { return vector.Select(x => Div(self, x)); }

        public static int Min (this int v1, int v2) { return System.Math.Min(v1, v2); }
        public static int Max (this int v1, int v2) { return System.Math.Max(v1, v2); }

        public static long Min (this long v1, long v2) { return System.Math.Min(v1, v2); }
        public static long Max (this long v1, long v2) { return System.Math.Max(v1, v2); }

        public static float Min (this float v1, float v2) { return System.Math.Min(v1, v2); }
        public static float Max (this float v1, float v2) { return System.Math.Max(v1, v2); }

        public static double Min (this double v1, double v2) { return System.Math.Min(v1, v2); }
        public static double Max (this double v1, double v2) { return System.Math.Max(v1, v2); }
		public static double Sqr(this double self) { return self * self; }
		public static double Ceiling(this double self) { return System.Math.Ceiling(self); }
		public static double Floor(this double self) { return System.Math.Floor(self); }
		public static double Round(this double self) { return System.Math.Round(self); }
		public static double Truncate(this double self) { return System.Math.Ceiling(self); }
		public static double Inverse(this double self) { return 1.0 / self; }
		public static float Sqr(this float self) { return self * self; }
		public static float Ceiling(this float self) { return (float)System.Math.Ceiling(self); }
		public static float Floor(this float self) { return (float)System.Math.Floor(self); }
		public static float Round(this float self) { return (float)System.Math.Round(self); }
		public static float Truncate(this float self) { return (float)System.Math.Ceiling(self); }
		public static float Inverse(this float self) { return 1.0f / self; }
		public static double Abs(this double self) { return System.Math.Abs(self); }
		public static float Abs(this float self) { return (float)System.Math.Abs(self); }
		public static double Acos(this double self) { return System.Math.Acos(self); }
		public static float Acos(this float self) { return (float)System.Math.Acos(self); }
		public static double Asin(this double self) { return System.Math.Asin(self); }
		public static float Asin(this float self) { return (float)System.Math.Asin(self); }
		public static double Atan(this double self) { return System.Math.Atan(self); }
		public static float Atan(this float self) { return (float)System.Math.Atan(self); }
		public static double Cos(this double self) { return System.Math.Cos(self); }
		public static float Cos(this float self) { return (float)System.Math.Cos(self); }
		public static double Cosh(this double self) { return System.Math.Cosh(self); }
		public static float Cosh(this float self) { return (float)System.Math.Cosh(self); }
		public static double Exp(this double self) { return System.Math.Exp(self); }
		public static float Exp(this float self) { return (float)System.Math.Exp(self); }
		public static double Log(this double self) { return System.Math.Log(self); }
		public static float Log(this float self) { return (float)System.Math.Log(self); }
		public static double Log10(this double self) { return System.Math.Log10(self); }
		public static float Log10(this float self) { return (float)System.Math.Log10(self); }
		public static double Sin(this double self) { return System.Math.Sin(self); }
		public static float Sin(this float self) { return (float)System.Math.Sin(self); }
		public static double Sinh(this double self) { return System.Math.Sinh(self); }
		public static float Sinh(this float self) { return (float)System.Math.Sinh(self); }
		public static double Sqrt(this double self) { return System.Math.Sqrt(self); }
		public static float Sqrt(this float self) { return (float)System.Math.Sqrt(self); }
		public static double Tan(this double self) { return System.Math.Tan(self); }
		public static float Tan(this float self) { return (float)System.Math.Tan(self); }
		public static double Tanh(this double self) { return System.Math.Tanh(self); }
		public static float Tanh(this float self) { return (float)System.Math.Tanh(self); }

		public static Vector2 Abs(this Vector2 self) { return self.Select(Abs); }
		public static Vector3 Abs(this Vector3 self) { return self.Select(Abs); }
		public static Vector4 Abs(this Vector4 self) { return self.Select(Abs); }
        public static IArray<double> Abs (this IArray< double > self) { return self.Select(Abs); }
        public static IArray<float> Abs (this IArray< float > self) { return self.Select(Abs); }
        public static IArray<Vector2> Abs (this IArray< Vector2 > self) { return self.Select(Abs); }
        public static IArray<Vector3> Abs (this IArray< Vector3 > self) { return self.Select(Abs); }
        public static IArray<Vector4> Abs (this IArray< Vector4 > self) { return self.Select(Abs); }

		public static Vector2 Acos(this Vector2 self) { return self.Select(Acos); }
		public static Vector3 Acos(this Vector3 self) { return self.Select(Acos); }
		public static Vector4 Acos(this Vector4 self) { return self.Select(Acos); }
        public static IArray<double> Acos (this IArray< double > self) { return self.Select(Acos); }
        public static IArray<float> Acos (this IArray< float > self) { return self.Select(Acos); }
        public static IArray<Vector2> Acos (this IArray< Vector2 > self) { return self.Select(Acos); }
        public static IArray<Vector3> Acos (this IArray< Vector3 > self) { return self.Select(Acos); }
        public static IArray<Vector4> Acos (this IArray< Vector4 > self) { return self.Select(Acos); }

		public static Vector2 Asin(this Vector2 self) { return self.Select(Asin); }
		public static Vector3 Asin(this Vector3 self) { return self.Select(Asin); }
		public static Vector4 Asin(this Vector4 self) { return self.Select(Asin); }
        public static IArray<double> Asin (this IArray< double > self) { return self.Select(Asin); }
        public static IArray<float> Asin (this IArray< float > self) { return self.Select(Asin); }
        public static IArray<Vector2> Asin (this IArray< Vector2 > self) { return self.Select(Asin); }
        public static IArray<Vector3> Asin (this IArray< Vector3 > self) { return self.Select(Asin); }
        public static IArray<Vector4> Asin (this IArray< Vector4 > self) { return self.Select(Asin); }

		public static Vector2 Atan(this Vector2 self) { return self.Select(Atan); }
		public static Vector3 Atan(this Vector3 self) { return self.Select(Atan); }
		public static Vector4 Atan(this Vector4 self) { return self.Select(Atan); }
        public static IArray<double> Atan (this IArray< double > self) { return self.Select(Atan); }
        public static IArray<float> Atan (this IArray< float > self) { return self.Select(Atan); }
        public static IArray<Vector2> Atan (this IArray< Vector2 > self) { return self.Select(Atan); }
        public static IArray<Vector3> Atan (this IArray< Vector3 > self) { return self.Select(Atan); }
        public static IArray<Vector4> Atan (this IArray< Vector4 > self) { return self.Select(Atan); }

		public static Vector2 Cos(this Vector2 self) { return self.Select(Cos); }
		public static Vector3 Cos(this Vector3 self) { return self.Select(Cos); }
		public static Vector4 Cos(this Vector4 self) { return self.Select(Cos); }
        public static IArray<double> Cos (this IArray< double > self) { return self.Select(Cos); }
        public static IArray<float> Cos (this IArray< float > self) { return self.Select(Cos); }
        public static IArray<Vector2> Cos (this IArray< Vector2 > self) { return self.Select(Cos); }
        public static IArray<Vector3> Cos (this IArray< Vector3 > self) { return self.Select(Cos); }
        public static IArray<Vector4> Cos (this IArray< Vector4 > self) { return self.Select(Cos); }

		public static Vector2 Cosh(this Vector2 self) { return self.Select(Cosh); }
		public static Vector3 Cosh(this Vector3 self) { return self.Select(Cosh); }
		public static Vector4 Cosh(this Vector4 self) { return self.Select(Cosh); }
        public static IArray<double> Cosh (this IArray< double > self) { return self.Select(Cosh); }
        public static IArray<float> Cosh (this IArray< float > self) { return self.Select(Cosh); }
        public static IArray<Vector2> Cosh (this IArray< Vector2 > self) { return self.Select(Cosh); }
        public static IArray<Vector3> Cosh (this IArray< Vector3 > self) { return self.Select(Cosh); }
        public static IArray<Vector4> Cosh (this IArray< Vector4 > self) { return self.Select(Cosh); }

		public static Vector2 Exp(this Vector2 self) { return self.Select(Exp); }
		public static Vector3 Exp(this Vector3 self) { return self.Select(Exp); }
		public static Vector4 Exp(this Vector4 self) { return self.Select(Exp); }
        public static IArray<double> Exp (this IArray< double > self) { return self.Select(Exp); }
        public static IArray<float> Exp (this IArray< float > self) { return self.Select(Exp); }
        public static IArray<Vector2> Exp (this IArray< Vector2 > self) { return self.Select(Exp); }
        public static IArray<Vector3> Exp (this IArray< Vector3 > self) { return self.Select(Exp); }
        public static IArray<Vector4> Exp (this IArray< Vector4 > self) { return self.Select(Exp); }

		public static Vector2 Log(this Vector2 self) { return self.Select(Log); }
		public static Vector3 Log(this Vector3 self) { return self.Select(Log); }
		public static Vector4 Log(this Vector4 self) { return self.Select(Log); }
        public static IArray<double> Log (this IArray< double > self) { return self.Select(Log); }
        public static IArray<float> Log (this IArray< float > self) { return self.Select(Log); }
        public static IArray<Vector2> Log (this IArray< Vector2 > self) { return self.Select(Log); }
        public static IArray<Vector3> Log (this IArray< Vector3 > self) { return self.Select(Log); }
        public static IArray<Vector4> Log (this IArray< Vector4 > self) { return self.Select(Log); }

		public static Vector2 Log10(this Vector2 self) { return self.Select(Log10); }
		public static Vector3 Log10(this Vector3 self) { return self.Select(Log10); }
		public static Vector4 Log10(this Vector4 self) { return self.Select(Log10); }
        public static IArray<double> Log10 (this IArray< double > self) { return self.Select(Log10); }
        public static IArray<float> Log10 (this IArray< float > self) { return self.Select(Log10); }
        public static IArray<Vector2> Log10 (this IArray< Vector2 > self) { return self.Select(Log10); }
        public static IArray<Vector3> Log10 (this IArray< Vector3 > self) { return self.Select(Log10); }
        public static IArray<Vector4> Log10 (this IArray< Vector4 > self) { return self.Select(Log10); }

		public static Vector2 Sin(this Vector2 self) { return self.Select(Sin); }
		public static Vector3 Sin(this Vector3 self) { return self.Select(Sin); }
		public static Vector4 Sin(this Vector4 self) { return self.Select(Sin); }
        public static IArray<double> Sin (this IArray< double > self) { return self.Select(Sin); }
        public static IArray<float> Sin (this IArray< float > self) { return self.Select(Sin); }
        public static IArray<Vector2> Sin (this IArray< Vector2 > self) { return self.Select(Sin); }
        public static IArray<Vector3> Sin (this IArray< Vector3 > self) { return self.Select(Sin); }
        public static IArray<Vector4> Sin (this IArray< Vector4 > self) { return self.Select(Sin); }

		public static Vector2 Sinh(this Vector2 self) { return self.Select(Sinh); }
		public static Vector3 Sinh(this Vector3 self) { return self.Select(Sinh); }
		public static Vector4 Sinh(this Vector4 self) { return self.Select(Sinh); }
        public static IArray<double> Sinh (this IArray< double > self) { return self.Select(Sinh); }
        public static IArray<float> Sinh (this IArray< float > self) { return self.Select(Sinh); }
        public static IArray<Vector2> Sinh (this IArray< Vector2 > self) { return self.Select(Sinh); }
        public static IArray<Vector3> Sinh (this IArray< Vector3 > self) { return self.Select(Sinh); }
        public static IArray<Vector4> Sinh (this IArray< Vector4 > self) { return self.Select(Sinh); }

		public static Vector2 Sqrt(this Vector2 self) { return self.Select(Sqrt); }
		public static Vector3 Sqrt(this Vector3 self) { return self.Select(Sqrt); }
		public static Vector4 Sqrt(this Vector4 self) { return self.Select(Sqrt); }
        public static IArray<double> Sqrt (this IArray< double > self) { return self.Select(Sqrt); }
        public static IArray<float> Sqrt (this IArray< float > self) { return self.Select(Sqrt); }
        public static IArray<Vector2> Sqrt (this IArray< Vector2 > self) { return self.Select(Sqrt); }
        public static IArray<Vector3> Sqrt (this IArray< Vector3 > self) { return self.Select(Sqrt); }
        public static IArray<Vector4> Sqrt (this IArray< Vector4 > self) { return self.Select(Sqrt); }

		public static Vector2 Tan(this Vector2 self) { return self.Select(Tan); }
		public static Vector3 Tan(this Vector3 self) { return self.Select(Tan); }
		public static Vector4 Tan(this Vector4 self) { return self.Select(Tan); }
        public static IArray<double> Tan (this IArray< double > self) { return self.Select(Tan); }
        public static IArray<float> Tan (this IArray< float > self) { return self.Select(Tan); }
        public static IArray<Vector2> Tan (this IArray< Vector2 > self) { return self.Select(Tan); }
        public static IArray<Vector3> Tan (this IArray< Vector3 > self) { return self.Select(Tan); }
        public static IArray<Vector4> Tan (this IArray< Vector4 > self) { return self.Select(Tan); }

		public static Vector2 Tanh(this Vector2 self) { return self.Select(Tanh); }
		public static Vector3 Tanh(this Vector3 self) { return self.Select(Tanh); }
		public static Vector4 Tanh(this Vector4 self) { return self.Select(Tanh); }
        public static IArray<double> Tanh (this IArray< double > self) { return self.Select(Tanh); }
        public static IArray<float> Tanh (this IArray< float > self) { return self.Select(Tanh); }
        public static IArray<Vector2> Tanh (this IArray< Vector2 > self) { return self.Select(Tanh); }
        public static IArray<Vector3> Tanh (this IArray< Vector3 > self) { return self.Select(Tanh); }
        public static IArray<Vector4> Tanh (this IArray< Vector4 > self) { return self.Select(Tanh); }

		public static Vector2 Sqr(this Vector2 self) { return self.Select(Sqr); }
		public static Vector3 Sqr(this Vector3 self) { return self.Select(Sqr); }
		public static Vector4 Sqr(this Vector4 self) { return self.Select(Sqr); }
        public static IArray<double> Sqr (this IArray< double > self) { return self.Select(Sqr); }
        public static IArray<float> Sqr (this IArray< float > self) { return self.Select(Sqr); }
        public static IArray<Vector2> Sqr (this IArray< Vector2 > self) { return self.Select(Sqr); }
        public static IArray<Vector3> Sqr (this IArray< Vector3 > self) { return self.Select(Sqr); }
        public static IArray<Vector4> Sqr (this IArray< Vector4 > self) { return self.Select(Sqr); }

		public static Vector2 Inverse(this Vector2 self) { return self.Select(Inverse); }
		public static Vector3 Inverse(this Vector3 self) { return self.Select(Inverse); }
		public static Vector4 Inverse(this Vector4 self) { return self.Select(Inverse); }
        public static IArray<double> Inverse (this IArray< double > self) { return self.Select(Inverse); }
        public static IArray<float> Inverse (this IArray< float > self) { return self.Select(Inverse); }
        public static IArray<Vector2> Inverse (this IArray< Vector2 > self) { return self.Select(Inverse); }
        public static IArray<Vector3> Inverse (this IArray< Vector3 > self) { return self.Select(Inverse); }
        public static IArray<Vector4> Inverse (this IArray< Vector4 > self) { return self.Select(Inverse); }

		public static Vector2 Ceiling(this Vector2 self) { return self.Select(Ceiling); }
		public static Vector3 Ceiling(this Vector3 self) { return self.Select(Ceiling); }
		public static Vector4 Ceiling(this Vector4 self) { return self.Select(Ceiling); }
        public static IArray<double> Ceiling (this IArray< double > self) { return self.Select(Ceiling); }
        public static IArray<float> Ceiling (this IArray< float > self) { return self.Select(Ceiling); }
        public static IArray<Vector2> Ceiling (this IArray< Vector2 > self) { return self.Select(Ceiling); }
        public static IArray<Vector3> Ceiling (this IArray< Vector3 > self) { return self.Select(Ceiling); }
        public static IArray<Vector4> Ceiling (this IArray< Vector4 > self) { return self.Select(Ceiling); }

		public static Vector2 Floor(this Vector2 self) { return self.Select(Floor); }
		public static Vector3 Floor(this Vector3 self) { return self.Select(Floor); }
		public static Vector4 Floor(this Vector4 self) { return self.Select(Floor); }
        public static IArray<double> Floor (this IArray< double > self) { return self.Select(Floor); }
        public static IArray<float> Floor (this IArray< float > self) { return self.Select(Floor); }
        public static IArray<Vector2> Floor (this IArray< Vector2 > self) { return self.Select(Floor); }
        public static IArray<Vector3> Floor (this IArray< Vector3 > self) { return self.Select(Floor); }
        public static IArray<Vector4> Floor (this IArray< Vector4 > self) { return self.Select(Floor); }

		public static Vector2 Round(this Vector2 self) { return self.Select(Round); }
		public static Vector3 Round(this Vector3 self) { return self.Select(Round); }
		public static Vector4 Round(this Vector4 self) { return self.Select(Round); }
        public static IArray<double> Round (this IArray< double > self) { return self.Select(Round); }
        public static IArray<float> Round (this IArray< float > self) { return self.Select(Round); }
        public static IArray<Vector2> Round (this IArray< Vector2 > self) { return self.Select(Round); }
        public static IArray<Vector3> Round (this IArray< Vector3 > self) { return self.Select(Round); }
        public static IArray<Vector4> Round (this IArray< Vector4 > self) { return self.Select(Round); }

		public static Vector2 Truncate(this Vector2 self) { return self.Select(Truncate); }
		public static Vector3 Truncate(this Vector3 self) { return self.Select(Truncate); }
		public static Vector4 Truncate(this Vector4 self) { return self.Select(Truncate); }
        public static IArray<double> Truncate (this IArray< double > self) { return self.Select(Truncate); }
        public static IArray<float> Truncate (this IArray< float > self) { return self.Select(Truncate); }
        public static IArray<Vector2> Truncate (this IArray< Vector2 > self) { return self.Select(Truncate); }
        public static IArray<Vector3> Truncate (this IArray< Vector3 > self) { return self.Select(Truncate); }
        public static IArray<Vector4> Truncate (this IArray< Vector4 > self) { return self.Select(Truncate); }
        public static bool Eq (this int v1, int v2) { return v1 == v2; }
        public static bool NEq (this int v1, int v2) { return v1 != v2; }
        public static bool Eq (this long v1, long v2) { return v1 == v2; }
        public static bool NEq (this long v1, long v2) { return v1 != v2; }
        public static bool Eq (this float v1, float v2) { return v1 == v2; }
        public static bool NEq (this float v1, float v2) { return v1 != v2; }
        public static bool Eq (this double v1, double v2) { return v1 == v2; }
        public static bool NEq (this double v1, double v2) { return v1 != v2; }
        public static bool Eq (this Vector2 v1, Vector2 v2) { return v1 == v2; }
        public static bool NEq (this Vector2 v1, Vector2 v2) { return v1 != v2; }
        public static bool Eq (this Vector3 v1, Vector3 v2) { return v1 == v2; }
        public static bool NEq (this Vector3 v1, Vector3 v2) { return v1 != v2; }
        public static bool Eq (this Vector4 v1, Vector4 v2) { return v1 == v2; }
        public static bool NEq (this Vector4 v1, Vector4 v2) { return v1 != v2; }
        public static bool Gt (this int v1, int v2) { return v1 > v2; }
        public static bool Lt (this int v1, int v2) { return v1 < v2; }
        public static bool GtEq (this int v1, int v2) { return v1 >= v2; }
        public static bool LtEq (this int v1, int v2) { return v1 <= v2; }
        public static bool Gt (this long v1, long v2) { return v1 > v2; }
        public static bool Lt (this long v1, long v2) { return v1 < v2; }
        public static bool GtEq (this long v1, long v2) { return v1 >= v2; }
        public static bool LtEq (this long v1, long v2) { return v1 <= v2; }
        public static bool Gt (this float v1, float v2) { return v1 > v2; }
        public static bool Lt (this float v1, float v2) { return v1 < v2; }
        public static bool GtEq (this float v1, float v2) { return v1 >= v2; }
        public static bool LtEq (this float v1, float v2) { return v1 <= v2; }
        public static bool Gt (this double v1, double v2) { return v1 > v2; }
        public static bool Lt (this double v1, double v2) { return v1 < v2; }
        public static bool GtEq (this double v1, double v2) { return v1 >= v2; }
        public static bool LtEq (this double v1, double v2) { return v1 <= v2; }
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

		public static long Sum(this IArray<int> self) { return self.Aggregate(0L, (x, y) => x + y); }
		public static long Sum(this IArray<long> self) { return self.Aggregate(0L, (x, y) => x + y); }
		public static double Sum(this IArray<float> self) { return self.Aggregate(0.0, (x, y) => x + y); }
		public static double Sum(this IArray<double> self) { return self.Aggregate(0.0, (x, y) => x + y); }
		public static Vector2 Sum(this IArray<Vector2> self) { return self.Aggregate(Vector2.Zero, (x, y) => x + y); }
		public static Vector3 Sum(this IArray<Vector3> self) { return self.Aggregate(Vector3.Zero, (x, y) => x + y); }
		public static Vector4 Sum(this IArray<Vector4> self) { return self.Aggregate(Vector4.Zero, (x, y) => x + y); }
		
		public static double Average(this IArray<int> self) { return self.Sum() / self.Count; }
		public static double Average(this IArray<long> self) { return self.Sum() / self.Count; }
		public static double Average(this IArray<float> self) { return self.Sum() / self.Count; }
		public static double Average(this IArray<double> self) { return self.Sum() / self.Count; }
		public static Vector2 Average(this IArray<Vector2> self) { return self.Sum() / self.Count; }
		public static Vector3 Average(this IArray<Vector3> self) { return self.Sum() / self.Count; }
		public static Vector4 Average(this IArray<Vector4> self) { return self.Sum() / self.Count; }	

		public static double Variance(this IArray<int> self) { var mean = self.Average(); return self.Select(x => Sqr(x - mean)).Average(); }
		public static double Variance(this IArray<long> self) { var mean = self.Average(); return self.Select(x => Sqr(x - mean)).Average(); }
		public static double Variance(this IArray<float> self) { var mean = self.Average(); return self.Select(x => Sqr(x - mean)).Average(); }
		public static double Variance(this IArray<double> self) { var mean = self.Average(); return self.Select(x => Sqr(x - mean)).Average(); }
		public static Vector2 Variance(this IArray<Vector2> self) { var mean = self.Average(); return self.Select(x => Sqr(x - mean)).Average(); }
		public static Vector3 Variance(this IArray<Vector3> self) { var mean = self.Average(); return self.Select(x => Sqr(x - mean)).Average(); }
		public static Vector4 Variance(this IArray<Vector4> self) { var mean = self.Average(); return self.Select(x => Sqr(x - mean)).Average(); }

		public static double StdDev(this IArray<int> self) { return self.Variance().Sqrt(); }
		public static double StdDev(this IArray<long> self) { return self.Variance().Sqrt(); }
		public static double StdDev(this IArray<float> self) { return self.Variance().Sqrt(); }
		public static double StdDev(this IArray<double> self) { return self.Variance().Sqrt(); }
		public static Vector2 StdDev(this IArray<Vector2> self) { return self.Variance().Sqrt(); }
		public static Vector3 StdDev(this IArray<Vector3> self) { return self.Variance().Sqrt(); }
		public static Vector4 StdDev(this IArray<Vector4> self) { return self.Variance().Sqrt(); }
	} 
} 
