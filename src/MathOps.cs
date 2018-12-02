// MIT License - Copyright (C) Ara 3D, Inc.
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.


using System.Numerics;

namespace Ara3D 
{
	public static class MathOps
	{
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
	
        public static int Add (this int v1, int v2) { return v1 + v2; }
        public static int Sub (this int v1, int v2) { return v1 - v2; }
        public static int Mul (this int v1, int v2) { return v1 * v2; }
        public static int Div (this int v1, int v2) { return v1 / v2; }
		public static int Negate (this int v) { return -v; }
        //public static int Mod (this int v1, int v2) { return v1 % v2; }
        public static long Add (this long v1, long v2) { return v1 + v2; }
        public static long Sub (this long v1, long v2) { return v1 - v2; }
        public static long Mul (this long v1, long v2) { return v1 * v2; }
        public static long Div (this long v1, long v2) { return v1 / v2; }
		public static long Negate (this long v) { return -v; }
        //public static long Mod (this long v1, long v2) { return v1 % v2; }
        public static float Add (this float v1, float v2) { return v1 + v2; }
        public static float Sub (this float v1, float v2) { return v1 - v2; }
        public static float Mul (this float v1, float v2) { return v1 * v2; }
        public static float Div (this float v1, float v2) { return v1 / v2; }
		public static float Negate (this float v) { return -v; }
        //public static float Mod (this float v1, float v2) { return v1 % v2; }
        public static double Add (this double v1, double v2) { return v1 + v2; }
        public static double Sub (this double v1, double v2) { return v1 - v2; }
        public static double Mul (this double v1, double v2) { return v1 * v2; }
        public static double Div (this double v1, double v2) { return v1 / v2; }
		public static double Negate (this double v) { return -v; }
        //public static double Mod (this double v1, double v2) { return v1 % v2; }
        public static Vector2 Add (this Vector2 v1, Vector2 v2) { return v1 + v2; }
        public static Vector2 Sub (this Vector2 v1, Vector2 v2) { return v1 - v2; }
        public static Vector2 Mul (this Vector2 v1, Vector2 v2) { return v1 * v2; }
        public static Vector2 Div (this Vector2 v1, Vector2 v2) { return v1 / v2; }
		public static Vector2 Negate (this Vector2 v) { return -v; }
        //public static Vector2 Mod (this Vector2 v1, Vector2 v2) { return v1 % v2; }
        public static Vector3 Add (this Vector3 v1, Vector3 v2) { return v1 + v2; }
        public static Vector3 Sub (this Vector3 v1, Vector3 v2) { return v1 - v2; }
        public static Vector3 Mul (this Vector3 v1, Vector3 v2) { return v1 * v2; }
        public static Vector3 Div (this Vector3 v1, Vector3 v2) { return v1 / v2; }
		public static Vector3 Negate (this Vector3 v) { return -v; }
        //public static Vector3 Mod (this Vector3 v1, Vector3 v2) { return v1 % v2; }
        public static Vector4 Add (this Vector4 v1, Vector4 v2) { return v1 + v2; }
        public static Vector4 Sub (this Vector4 v1, Vector4 v2) { return v1 - v2; }
        public static Vector4 Mul (this Vector4 v1, Vector4 v2) { return v1 * v2; }
        public static Vector4 Div (this Vector4 v1, Vector4 v2) { return v1 / v2; }
		public static Vector4 Negate (this Vector4 v) { return -v; }
        //public static Vector4 Mod (this Vector4 v1, Vector4 v2) { return v1 % v2; }

        public static int Min (this int v1, int v2) { return System.Math.Min(v1, v2); }
        public static int Max (this int v1, int v2) { return System.Math.Max(v1, v2); }

        public static long Min (this long v1, long v2) { return System.Math.Min(v1, v2); }
        public static long Max (this long v1, long v2) { return System.Math.Max(v1, v2); }

        public static float Min (this float v1, float v2) { return System.Math.Min(v1, v2); }
        public static float Max (this float v1, float v2) { return System.Math.Max(v1, v2); }

        public static double Min (this double v1, double v2) { return System.Math.Min(v1, v2); }
        public static double Max (this double v1, double v2) { return System.Math.Max(v1, v2); }
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

		public static Vector2 Acos(this Vector2 self) { return self.Select(Acos); }
		public static Vector3 Acos(this Vector3 self) { return self.Select(Acos); }
		public static Vector4 Acos(this Vector4 self) { return self.Select(Acos); }

		public static Vector2 Asin(this Vector2 self) { return self.Select(Asin); }
		public static Vector3 Asin(this Vector3 self) { return self.Select(Asin); }
		public static Vector4 Asin(this Vector4 self) { return self.Select(Asin); }

		public static Vector2 Atan(this Vector2 self) { return self.Select(Atan); }
		public static Vector3 Atan(this Vector3 self) { return self.Select(Atan); }
		public static Vector4 Atan(this Vector4 self) { return self.Select(Atan); }

		public static Vector2 Cos(this Vector2 self) { return self.Select(Cos); }
		public static Vector3 Cos(this Vector3 self) { return self.Select(Cos); }
		public static Vector4 Cos(this Vector4 self) { return self.Select(Cos); }

		public static Vector2 Cosh(this Vector2 self) { return self.Select(Cosh); }
		public static Vector3 Cosh(this Vector3 self) { return self.Select(Cosh); }
		public static Vector4 Cosh(this Vector4 self) { return self.Select(Cosh); }

		public static Vector2 Exp(this Vector2 self) { return self.Select(Exp); }
		public static Vector3 Exp(this Vector3 self) { return self.Select(Exp); }
		public static Vector4 Exp(this Vector4 self) { return self.Select(Exp); }

		public static Vector2 Log(this Vector2 self) { return self.Select(Log); }
		public static Vector3 Log(this Vector3 self) { return self.Select(Log); }
		public static Vector4 Log(this Vector4 self) { return self.Select(Log); }

		public static Vector2 Log10(this Vector2 self) { return self.Select(Log10); }
		public static Vector3 Log10(this Vector3 self) { return self.Select(Log10); }
		public static Vector4 Log10(this Vector4 self) { return self.Select(Log10); }

		public static Vector2 Sin(this Vector2 self) { return self.Select(Sin); }
		public static Vector3 Sin(this Vector3 self) { return self.Select(Sin); }
		public static Vector4 Sin(this Vector4 self) { return self.Select(Sin); }

		public static Vector2 Sinh(this Vector2 self) { return self.Select(Sinh); }
		public static Vector3 Sinh(this Vector3 self) { return self.Select(Sinh); }
		public static Vector4 Sinh(this Vector4 self) { return self.Select(Sinh); }

		public static Vector2 Sqrt(this Vector2 self) { return self.Select(Sqrt); }
		public static Vector3 Sqrt(this Vector3 self) { return self.Select(Sqrt); }
		public static Vector4 Sqrt(this Vector4 self) { return self.Select(Sqrt); }

		public static Vector2 Tan(this Vector2 self) { return self.Select(Tan); }
		public static Vector3 Tan(this Vector3 self) { return self.Select(Tan); }
		public static Vector4 Tan(this Vector4 self) { return self.Select(Tan); }

		public static Vector2 Tanh(this Vector2 self) { return self.Select(Tanh); }
		public static Vector3 Tanh(this Vector3 self) { return self.Select(Tanh); }
		public static Vector4 Tanh(this Vector4 self) { return self.Select(Tanh); }

		public static Vector2 Sqr(this Vector2 self) { return self.Select(Sqr); }
		public static Vector3 Sqr(this Vector3 self) { return self.Select(Sqr); }
		public static Vector4 Sqr(this Vector4 self) { return self.Select(Sqr); }

		public static Vector2 Inverse(this Vector2 self) { return self.Select(Inverse); }
		public static Vector3 Inverse(this Vector3 self) { return self.Select(Inverse); }
		public static Vector4 Inverse(this Vector4 self) { return self.Select(Inverse); }

		public static Vector2 Ceiling(this Vector2 self) { return self.Select(Ceiling); }
		public static Vector3 Ceiling(this Vector3 self) { return self.Select(Ceiling); }
		public static Vector4 Ceiling(this Vector4 self) { return self.Select(Ceiling); }

		public static Vector2 Floor(this Vector2 self) { return self.Select(Floor); }
		public static Vector3 Floor(this Vector3 self) { return self.Select(Floor); }
		public static Vector4 Floor(this Vector4 self) { return self.Select(Floor); }

		public static Vector2 Round(this Vector2 self) { return self.Select(Round); }
		public static Vector3 Round(this Vector3 self) { return self.Select(Round); }
		public static Vector4 Round(this Vector4 self) { return self.Select(Round); }

		public static Vector2 Truncate(this Vector2 self) { return self.Select(Truncate); }
		public static Vector3 Truncate(this Vector3 self) { return self.Select(Truncate); }
		public static Vector4 Truncate(this Vector4 self) { return self.Select(Truncate); }
		
	} 
} 
