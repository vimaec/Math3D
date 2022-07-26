import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:vim_math3d/vim_math3d.dart';
import 'test_utils.dart';

void main() {
  group('AABox2DTests', () {
    // No intersection tests
    test('testNoIntersection1', () {
      const box1 = AABox2D(Vector2(0, 0), Vector2(3, 3));
      const box2 = AABox2D(Vector2(4, 4), Vector2(5, 5));
      expect(box1.intersects(box2), false);
      expect(box2.intersects(box1), false);
    });
    test('testNoIntersection2', () {
      const box1 = AABox2D(Vector2(0, 0), Vector2(3, 3));
      const box2 = AABox2D(Vector2(-5, -5), Vector2(-4, -4));
      expect(box1.intersects(box2), false);
      expect(box2.intersects(box1), false);
    });
    // Intersection tests
    test('testIntersects1', () {
      const box1 = AABox2D(Vector2(0, 0), Vector2(5, 5));
      const box2 = AABox2D(Vector2(1, 1), Vector2(2, 2));
      expect(box1.intersects(box2), true);
      expect(box2.intersects(box1), true);
    });
    test('testIntersects2', () {
      const box1 = AABox2D(Vector2(0, 0), Vector2(3, 3));
      const box2 = AABox2D(Vector2(1, -1), Vector2(2, 7));
      expect(box1.intersects(box2), true);
      expect(box2.intersects(box1), true);
    });
    test('testIntersects3', () {
      const box1 = AABox2D(Vector2(0, 0), Vector2(3, 3));
      const box2 = AABox2D(Vector2(1, -1), Vector2(2, 2));
      expect(box1.intersects(box2), true);
      expect(box2.intersects(box1), true);
    });
    test('testIntersects4', () {
      const box1 = AABox2D(Vector2(0, 0), Vector2(3, 3));
      const box2 = AABox2D(Vector2(3, 3), Vector2(5, 5));
      expect(box1.intersects(box2), true);
      expect(box2.intersects(box1), true);
    });
  });

  group('DVector3Tests', () {
    // No intersection tests
    test('vector3CrossTest', () {
      const a = Vector3(1.0, 0.0, 0.0);
      const b = Vector3(0.0, 1.0, 0.0);
      const expected = Vector3(0.0, 0.0, 1.0);

      final actual = a.cross(b);
      expect(expected == actual, true,
          reason: "Vector3f.Cross did not return the expected value.");
    });
  });

  group('Line2DTests', () {
    // No intersection tests
    test('testNoIntersection1', () {
      const a = Line2D(Vector2(0, 0), Vector2(7, 7));
      const b = Line2D(Vector2(3, 4), Vector2(4, 5));
      expect(a.intersects(b), false);
      expect(b.intersects(a), false);
    });

    test('testNoIntersection2', () {
      const a = Line2D(Vector2(-4, 4), Vector2(-2, 1));
      const b = Line2D(Vector2(-2, 3), Vector2(0, 0));
      expect(a.intersects(b), false);
      expect(b.intersects(a), false);
    });

    test('testNoIntersection3', () {
      const a = Line2D(Vector2(0, 0), Vector2(0, 1));
      const b = Line2D(Vector2(2, 2), Vector2(2, 3));
      expect(a.intersects(b), false);
      expect(b.intersects(a), false);
    });

    test('testNoIntersection4', () {
      const a = Line2D(Vector2(0, 0), Vector2(0, 1));
      const b = Line2D(Vector2(2, 2), Vector2(3, 2));
      expect(a.intersects(b), false);
      expect(b.intersects(a), false);
    });
    test('testNoIntersection5', () {
      const a = Line2D(Vector2(-1, -1), Vector2(2, 2));
      const b = Line2D(Vector2(3, 3), Vector2(5, 5));
      expect(a.intersects(b), false);
      expect(b.intersects(a), false);
    });

    test('testNoIntersection6', () {
      const a = Line2D(Vector2(0, 0), Vector2(1, 1));
      const b = Line2D(Vector2(2, 0), Vector2(0.5, 2));
      expect(a.intersects(b), false);
      expect(b.intersects(a), false);
    });

    test('testNoIntersection7', () {
      const a = Line2D(Vector2(1, 1), Vector2(4, 1));
      const b = Line2D(Vector2(2, 2), Vector2(3, 2));
      expect(a.intersects(b), false);
      expect(b.intersects(a), false);
    });

    test('testNoIntersection8', () {
      const a = Line2D(Vector2(0, 5), Vector2(6, 0));
      const b = Line2D(Vector2(2, 1), Vector2(2, 2));
      expect(a.intersects(b), false);
      expect(b.intersects(a), false);
    });
    // Intersection tests

    test('testIntersects1', () {
      const a = Line2D(Vector2(0, -2), Vector2(0, 2));
      const b = Line2D(Vector2(-2, 0), Vector2(2, 0));
      expect(a.intersects(b), true);
      expect(b.intersects(a), true);
    });

    test('testIntersects2', () {
      const a = Line2D(Vector2(5, 5), Vector2(0, 0));
      const b = Line2D(Vector2(1, 1), Vector2(8, 2));
      expect(a.intersects(b), true);
      expect(b.intersects(a), true);
    });

    test('testIntersects3', () {
      const a = Line2D(Vector2(-1, 0), Vector2(0, 0));
      const b = Line2D(Vector2(-1, -1), Vector2(-1, 1));
      expect(a.intersects(b), true);
      expect(b.intersects(a), true);
    });

    test('testIntersects4', () {
      const a = Line2D(Vector2(0, 2), Vector2(2, 2));
      const b = Line2D(Vector2(2, 0), Vector2(2, 4));
      expect(a.intersects(b), true);
      expect(b.intersects(a), true);
    });

    test('testIntersects5', () {
      const a = Line2D(Vector2(0, 0), Vector2(5, 5));
      const b = Line2D(Vector2(1, 1), Vector2(3, 3));
      expect(a.intersects(b), true);
      expect(b.intersects(a), true);
    });

    test('testIntersects6', () {
      for (var i = 0; i < 50; i++) {
        final rng = math.Random();

        final ax = rng.nextDouble();
        final ay = rng.nextDouble();
        final bx = rng.nextDouble();
        final by = rng.nextDouble();
        final a = Line2D(Vector2(ax, ay), Vector2(bx, by));
        final b = Line2D(Vector2(ax, ay), Vector2(bx, by));
        expect(a.intersects(b), true);
        expect(b.intersects(a), true);
      }
    });
  });

  group('PlaneTests', () {
    test('planeEqualsTest1', () {
      final a = Plane.values(1.0, 2.0, 3.0, 4.0);
      final b = Plane.values(1.0, 2.0, 3.0, 4.0);

      // case 1: compare between same values
      expect(a == b, true);
      // ignore: unnecessary_cast
      expect((a as Object) == b, true);

      // case 2: compare between different values
      final c = Plane(Vector3(10.0, b.normal.y, b.normal.z), b.d);
      expect(b == c, false);
      // ignore: unnecessary_cast
      expect((b as Object) == c, false);
    });
    // A test for Plane (float, float, float, float)
    test('planeConstructorTest1', () {
      const double a = 1.0, b = 2.0, c = 3.0, d = 4.0;
      final target = Plane.values(a, b, c, d);

      expect(
          target.normal.x == a &&
              target.normal.y == b &&
              target.normal.z == c &&
              target.d == d,
          true,
          reason: "Plane.cstor did not return the expected value.");
    });
    // A test for Plane.CreateFromVertices
    test('planeCreateFromVerticesTest', () {
      const point1 = Vector3(0.0, 1.0, 1.0);
      const point2 = Vector3(0.0, 0.0, 1.0);
      const point3 = Vector3(1.0, 0.0, 1.0);

      final target = Plane.fromVertices(point1, point2, point3);
      const expected = Plane(Vector3(0, 0, 1), -1.0);
      expect(target == expected, true);
    });

    // A test for Plane.CreateFromVertices
    test('planeCreateFromVerticesTest2', () {
      const point1 = Vector3(0.0, 0.0, 1.0);
      const point2 = Vector3(1.0, 0.0, 0.0);
      const point3 = Vector3(1.0, 1.0, 0.0);

      final target = Plane.fromVertices(point1, point2, point3);
      final invRoot2 = 1.0 / 2.0.sqrt();

      final expected = Plane(Vector3(invRoot2, 0, invRoot2), -invRoot2);
      expect(equalPlane(target, expected), true,
          reason: "Plane.cstor did not return the expected value.");
    });

    // A test for Plane (Vector3f, float)
    test('planeConstructorTest3', () {
      const normal = Vector3(1, 2, 3);
      const d = 4.0;

      const target = Plane(normal, d);
      expect(target.normal == normal && target.d == d, true,
          reason: "Plane.cstor did not return the expected value.");
    });

    // A test for Plane (Vector4f)
    test('planeConstructorTest', () {
      const value = Vector4(1.0, 2.0, 3.0, 4.0);
      final target = Plane.fromVector(value);

      expect(
          target.normal.x == value.x &&
              target.normal.y == value.y &&
              target.normal.z == value.z &&
              target.d == value.w,
          true,
          reason: "Plane.cstor did not return the expected value.");
    });

    test('planeDotTest', () {
      final target = Plane.values(2.0, 3.0, 4.0, 5.0);
      const value = Vector4(5.0, 4.0, 3.0, 2.0);

      const expected = 10.0 + 12 + 12 + 10;
      final actual = target.dot(value);
      expect(equalDouble(expected, actual), true,
          reason: "Plane.Dot returns unexpected value.");
    });

    test('planeDotCoordinateTest', () {
      final target = Plane.values(2.0, 3.0, 4.0, 5.0);
      const value = Vector3(5.0, 4.0, 3.0);

      const expected = 10.0 + 12.0 + 12.0 + 5.0;
      final actual = Plane.dotCoordinate(target, value);
      expect(equalDouble(expected, actual), true,
          reason: "Plane.DotCoordinate returns unexpected value.");
    });

    test('planeDotNormalTest', () {
      final target = Plane.values(2.0, 3.0, 4.0, 5.0);
      const value = Vector3(5.0, 4.0, 3.0);

      const expected = 10.0 + 12.0 + 12.0;
      final actual = Plane.dotNormal(target, value);
      expect(equalDouble(expected, actual), true,
          reason: "Plane.DotNormal returns unexpected value.");
    });

    test('planeNormalizeTest', () {
      final target = Plane.values(1.0, 2.0, 3.0, 4.0);

      final f = target.normal.lengthSquared;
      final invF = 1.0 / f.sqrt();
      final expected = Plane(target.normal * invF, target.d * invF);

      var actual = Plane.normalize(target);
      expect(equalPlane(expected, actual), true,
          reason: "Plane.Normalize returns unexpected value.");

      // normalize, normalized normal.
      actual = Plane.normalize(actual);
      expect(equalPlane(expected, actual), true,
          reason: "Plane.Normalize returns unexpected value.");
    });

    test('planeTransformTest1', () {
      var target = Plane.values(1.0, 2.0, 3.0, 4.0);
      target = Plane.normalize(target);

      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      // m.m41 = 10.0;
      // m.m42 = 20.0;
      // m.m43 = 30.0;
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));

      final inv = Matrix4x4.invert(m);
      final itm = Matrix4x4.transpose(inv);
      final x = target.normal.x,
          y = target.normal.y,
          z = target.normal.z,
          w = target.d;
      final normal = Vector3(
          x * itm.m11 + y * itm.m21 + z * itm.m31 + w * itm.m41,
          x * itm.m12 + y * itm.m22 + z * itm.m32 + w * itm.m42,
          x * itm.m13 + y * itm.m23 + z * itm.m33 + w * itm.m43);
      final d = x * itm.m14 + y * itm.m24 + z * itm.m34 + w * itm.m44;
      final expected = Plane(normal, d);
      final actual = target.transform(m);
      expect(equalPlane(expected, actual), true,
          reason: "Plane.Transform returns unexpected value.");
    });

    test('planeTransformTest2', () {
      var target = Plane.values(1.0, 2.0, 3.0, 4.0);
      target = Plane.normalize(target);

      final m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      final q = Quaternion.fromRotationMatrix(m);

      final x = target.normal.x,
          y = target.normal.y,
          z = target.normal.z,
          w = target.d;
      final normal = Vector3(
          x * m.m11 + y * m.m21 + z * m.m31 + w * m.m41,
          x * m.m12 + y * m.m22 + z * m.m32 + w * m.m42,
          x * m.m13 + y * m.m23 + z * m.m33 + w * m.m43);
      final d = x * m.m14 + y * m.m24 + z * m.m34 + w * m.m44;
      final expected = Plane(normal, d);
      final actual = target.transformByQuaternion(q);

      expect(equalPlane(expected, actual), true,
          reason: "Plane.Transform did not return the expected value.");
    });

    // A test for Plane comparison involving NaN values
    test('planeEqualsNanTest', () {
      final a = Plane.values(double.nan, 0.0, 0.0, 0.0);
      final b = Plane.values(0.0, double.nan, 0.0, 0.0);
      final c = Plane.values(0.0, 0.0, double.nan, 0.0);
      final d = Plane.values(0.0, 0.0, 0.0, double.nan);

      expect(a == Plane.values(0, 0, 0, 0), false);
      expect(b == Plane.values(0, 0, 0, 0), false);
      expect(c == Plane.values(0, 0, 0, 0), false);
      expect(d == Plane.values(0, 0, 0, 0), false);

      expect(a != Plane.values(0, 0, 0, 0), true);
      expect(b != Plane.values(0, 0, 0, 0), true);
      expect(c != Plane.values(0, 0, 0, 0), true);
      expect(d != Plane.values(0, 0, 0, 0), true);

      expect(a == (Plane.values(0, 0, 0, 0)), false);
      expect(b == (Plane.values(0, 0, 0, 0)), false);
      expect(c == (Plane.values(0, 0, 0, 0)), false);
      expect(d == (Plane.values(0, 0, 0, 0)), false);

      // Counterintuitive result - IEEE rules for NaN comparison are weird!
      expect(a == a, false);
      expect(b == b, false);
      expect(c == c, false);
      expect(d == d, false);
    });
  });

  group('RayTests', () {
    test('ray_IntersectBox_IsFalse_OutsideBox', () {
      const ray = Ray(Vector3(-2, 0, -2), Vector3(0, 0, 1));
      const box = AABox(Vector3(-1, -1, -1), Vector3(1, 1, 1));

      expect(ray.intersectsBox(box) == null, true);
    });

    test('ray_IntersectBox_IsTrue_Through', () {
      const front = Ray(Vector3(0, 0, -2), Vector3(0, 0, 1));
      const back = Ray(Vector3(0, 0, 2), Vector3(0, 0, -1));
      const left = Ray(Vector3(-2, 0, 0), Vector3(1, 0, 0));
      const right = Ray(Vector3(2, 0, 0), Vector3(-1, 0, 0));
      const top = Ray(Vector3(0, 2, 0), Vector3(0, -1, 0));
      const under = Ray(Vector3(0, -2, 0), Vector3(0, 1, 0));

      const box = AABox(Vector3(-1, -1, -1), Vector3(1, 1, 1));

      expect(front.intersectsBox(box) != null, true, reason: 'front');
      expect(back.intersectsBox(box) != null, true, reason: 'back');
      expect(left.intersectsBox(box) != null, true, reason: 'left');
      expect(right.intersectsBox(box) != null, true, reason: 'right');
      expect(top.intersectsBox(box) != null, true, reason: 'top');
      expect(under.intersectsBox(box) != null, true, reason: 'under');
    });

    test('ray_IntersectBox_IsTrue_ThroughDiagonals', () {
      const xYnZ = Ray(Vector3(2, 2, -2), Vector3(-1, -1, 1));
      const nXYnZ = Ray(Vector3(-2, 2, -2), Vector3(1, -1, 1));
      const nXnYnZ = Ray(Vector3(-2, -2, -2), Vector3(1, 1, 1));
      const xnYnZ = Ray(Vector3(2, -2, -2), Vector3(-1, 1, 1));

      const box = AABox(Vector3(-1, -1, -1), Vector3(1, 1, 1));

      expect(xYnZ.intersectsBox(box) != null, true, reason: 'XYnZ');
      expect(nXYnZ.intersectsBox(box) != null, true, reason: 'nXYnZ');
      expect(nXnYnZ.intersectsBox(box) != null, true, reason: 'nXnYnZ');
      expect(xnYnZ.intersectsBox(box) != null, true, reason: 'XnYnZ');
    });

    test('ray_IntersectBox_IsFalse_AwayFromBox', () {
      const front = Ray(Vector3(0, 0, -2), Vector3(0, 0, -1));
      const back = Ray(Vector3(0, 0, 2), Vector3(0, 0, 1));
      const left = Ray(Vector3(-2, 0, 0), Vector3(-1, 0, 0));
      const right = Ray(Vector3(2, 0, 0), Vector3(1, 0, 0));
      const top = Ray(Vector3(0, 2, 0), Vector3(0, 1, 0));
      const under = Ray(Vector3(0, -2, 0), Vector3(0, -1, 0));

      const box = AABox(Vector3(-1, -1, -1), Vector3(1, 1, 1));

      expect(front.intersectsBox(box) == null, true, reason: 'front');
      expect(back.intersectsBox(box) == null, true, reason: 'back');
      expect(left.intersectsBox(box) == null, true, reason: 'left');
      expect(right.intersectsBox(box) == null, true, reason: 'right');
      expect(top.intersectsBox(box) == null, true, reason: 'top');
      expect(under.intersectsBox(box) == null, true, reason: 'under');
    });

    test('ray_IntersectBox_IsTrue_OnEdge', () {
      const front = Ray(Vector3(0, 2, -1), Vector3(0, -1, 0));
      const back = Ray(Vector3(0, 2, 1), Vector3(0, -1, 0));
      const left = Ray(Vector3(-1, 0, -2), Vector3(0, 0, 1));
      const right = Ray(Vector3(1, 0, -2), Vector3(0, 0, 1));
      const top = Ray(Vector3(0, 1, -2), Vector3(0, 0, 1));
      const under = Ray(Vector3(0, -1, -2), Vector3(0, 0, 1));

      const box = AABox(Vector3(-1, -1, -1), Vector3(1, 1, 1));

      expect(front.intersectsBox(box) != null, true, reason: 'front');
      expect(back.intersectsBox(box) != null, true, reason: 'back');
      expect(left.intersectsBox(box) != null, true, reason: 'left');
      expect(right.intersectsBox(box) != null, true, reason: 'right');
      expect(top.intersectsBox(box) != null, true, reason: 'top');
      expect(under.intersectsBox(box) != null, true, reason: 'under');
    });

    test('ray_IntersectBox_IsFalse_NearEdge', () {
      const ray = Ray(Vector3(0, 0, -2), Vector3(0, 1.1, 1));
      const box = AABox(Vector3(-1, -1, -1), Vector3(1, 1, 1));

      expect(ray.intersectsBox(box) == null, true);
    });

    test('ray_IntersectBox_IsTrue_FlatBox', () {
      const box = AABox(Vector3(-1, -1, 0), Vector3(1, 1, 0));
      const ray = Ray(Vector3(0, 0, -1), Vector3(0, 0, 1));

      expect(ray.intersectsBox(box) != null, true);
    });

    test('ray_IntersectTriangle_IsTrue_Inside', () {
      const ray = Ray(Vector3(0, 0, -1), Vector3(0, 0, 1));

      const triangle =
          Triangle(Vector3(0, 1, 0), Vector3(1, -1, 0), Vector3(-1, -1, 0));

      expect(ray.intersectsTriangle(triangle) != null, true);
    });

    test('ray_IntersectTriangle_IsFalse_Parralel', () {
      const ray = Ray(Vector3(0, 0, -1), Vector3(0, 0, 1));
      const triangle =
          Triangle(Vector3(1, 0, 0), Vector3(-1, 0, 0), Vector3(0, 0, 1));

      expect(ray.intersectsTriangle(triangle) == null, true);
    });

    // static void ray_IntersectTriangle_IsTrue_OnCorner() {
    test('ray_IntersectTriangle_IsTrue_OnCorner', () {
      const ray = Ray(Vector3(0, 1, -1), Vector3(0, 0, 1));
      const triangle =
          Triangle(Vector3(0, 1, 0), Vector3(1, -1, 0), Vector3(-1, -1, 0));

      expect(ray.intersectsTriangle(triangle) != null, true);
    });

    // static void ray_IntersectTriangle_IsFalse_InTrickyCorner() {
    test('ray_IntersectTriangle_IsFalse_InTrickyCorner', () {
      const ray = Ray(Vector3(-0.1, 0, -1), Vector3(0, 0, 1));
      const triangle =
          Triangle(Vector3(0, 0, 0), Vector3(-1, 1, 0), Vector3(1, 0, 0));

      expect(ray.intersectsTriangle(triangle) == null, true);
    });

    test('ray_IntersectTriangle_PerfTest', () {
      //IsFalse_InTrickyCorner
      const ray1 = Ray(Vector3(-0.1, 0, -1), Vector3(0, 0, 1));
      const triangle1 =
          Triangle(Vector3(0, 0, 0), Vector3(-1, 1, 0), Vector3(1, 0, 0));

      //IsTrue_OnCorner
      const ray2 = Ray(Vector3(0, 1, -1), Vector3(0, 0, 1));
      const triangle2 =
          Triangle(Vector3(0, 1, 0), Vector3(1, -1, 0), Vector3(-1, -1, 0));

      //IsTrue_OnCorner
      const ray3 = Ray(Vector3(0, 0, -1), Vector3(0, 0, 1));
      const triangle3 =
          Triangle(Vector3(1, 0, 0), Vector3(-1, 0, 0), Vector3(0, 0, 1));

      // IsFalse_Parralel
      const ray4 = Ray(Vector3(0, 0, -1), Vector3(0, 0, 1));
      const triangle4 =
          Triangle(Vector3(1, 0, 0), Vector3(-1, 0, 0), Vector3(0, 0, 1));

      final watch = Stopwatch();
      for (var j = 0; j < 10; j++) {
        watch
          ..reset()
          ..start();
        for (var i = 0; i < 1000000; i++) {
          ray1.intersectsTriangle(triangle1);
          ray2.intersectsTriangle(triangle2);
          ray3.intersectsTriangle(triangle3);
          ray4.intersectsTriangle(triangle4);
        }
        watch.stop();
        final thombore = watch.elapsedMilliseconds;

        print("TomboreMoller $thombore ms");
      }
    });
  });

  group('QuaternionTests', () {
    // A test for Dot (Quaternion, Quaternion)
    test('quaternionDotTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const b = Quaternion(5.0, 6.0, 7.0, 8.0);

      const expected = 70.0;
      final actual = a.dot(b);
      expect(equalDouble(expected, actual), true,
          reason:
              "Quaternion.Dot did not return the expected value: expected $expected actual $actual");
    });

    // A test for Length ()
    test('quaternionLengthTest', () {
      const v = Vector3(1.0, 2.0, 3.0);
      const w = 4.0;
      final target = Quaternion.fromVectorAndScalar(v, w);
      const expected = 5.477226;
      final actual = target.length;
      expect(equalDouble(expected, actual), true,
          reason:
              "Quaternion.Length did not return the expected value: expected $expected actual $actual");
    });

    // A test for LengthSquared ()
    test('quaternionLengthSquaredTest', () {
      const v = Vector3(1.0, 2.0, 3.0);
      const w = 4.0;

      final target = Quaternion.fromVectorAndScalar(v, w);
      const expected = 30.0;
      final actual = target.lengthSquared;

      expect(equalDouble(expected, actual), true,
          reason:
              "Quaternion.LengthSquared did not return the expected value: expected $expected actual $actual");
    });

    // A test for Lerp (Quaternion, Quaternion, float)
    test('quaternionLerpTest', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final a = Quaternion.fromAxisAndAngle(axis, toRadians(10.0));
      final b = Quaternion.fromAxisAndAngle(axis, toRadians(30.0));
      const t = 0.5;
      var expected = Quaternion.fromAxisAndAngle(axis, toRadians(20.0));

      var actual = Quaternion.lerp(a, b, t);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Lerp did not return the expected value: expected $expected actual $actual");

      // Case a and b are same.
      expected = a;
      actual = Quaternion.lerp(a, a, t);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Lerp did not return the expected value: expected $expected actual $actual");
    });

    // A test for Lerp (Quaternion, Quaternion, float)
    // Lerp test when t = 0
    test('quaternionLerpTest1', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final a = Quaternion.fromAxisAndAngle(axis, toRadians(10.0));
      final b = Quaternion.fromAxisAndAngle(axis, toRadians(30.0));

      const t = 0.0;

      final expected = Quaternion(a.x, a.y, a.z, a.w);
      final actual = Quaternion.lerp(a, b, t);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Lerp did not return the expected value: expected $expected actual $actual");
    });

    // A test for Lerp (Quaternion, Quaternion, float)
    // Lerp test when t = 1
    test('quaternionLerpTest2', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final a = Quaternion.fromAxisAndAngle(axis, toRadians(10.0));
      final b = Quaternion.fromAxisAndAngle(axis, toRadians(30.0));

      const t = 1.0;

      final expected = Quaternion(b.x, b.y, b.z, b.w);
      final actual = Quaternion.lerp(a, b, t);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Lerp did not return the expected value: expected $expected actual $actual");
    });

    // A test for Lerp (Quaternion, Quaternion, float)
    // Lerp test when the two quaternions are more than 90 degree (dot product <0)
    test('quaternionLerpTest3', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final a = Quaternion.fromAxisAndAngle(axis, toRadians(10.0));
      final b = -a;
      const t = 1.0;

      final actual = Quaternion.lerp(a, b, t);
      // Note that in quaternion world, Q == -Q. In the case of quaternions dot product is zero,
      // one of the quaternion will be flipped to compute the shortest distance. When t = 1, we
      // expect the result to be the same as quaternion b but flipped.
      expect(actual == a, true,
          reason:
              "Quaternion.Lerp did not return the expected value: expected $a actual $actual");
    });

    // A test for Conjugate(Quaternion)
    test('quaternionConjugateTest1', () {
      const a = Quaternion(1, 2, 3, 4);
      const expected = Quaternion(-1, -2, -3, 4);

      final actual = a.conjugate();
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Conjugate did not return the expected value: expected $expected actual $actual");
    });

    // A test for Normalize (Quaternion)
    test('quaternionNormalizeTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const expected = Quaternion(0.18257417, 0.36514834, 0.5477225, 0.7302967);

      final actual = a.normalize();
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Normalize did not return the expected value: expected $expected actual $actual");
    });

    // A test for Normalize (Quaternion)
    // Normalize zero length quaternion
    test('quaternionNormalizeTest1', () {
      const a = Quaternion(0.0, 0.0, -0.0, 0.0);

      final actual = a.normalize();
      expect(
          actual.x.isNaN && actual.y.isNaN && actual.z.isNaN && actual.w.isNaN,
          true,
          reason:
              "Quaternion.Normalize did not return the expected value: expected ${Quaternion.nan} actual $actual");
    });

    // A test for Concatenate(Quaternion, Quaternion)
    test('quaternionConcatenateTest1', () {
      const b = Quaternion(1.0, 2.0, 3.0, 4.0);
      const a = Quaternion(5.0, 6.0, 7.0, 8.0);
      const expected = Quaternion(24.0, 48.0, 48.0, -6.0);

      final actual = Quaternion.concatenate(a, b);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Concatenate did not return the expected value: expected $expected actual $actual");
    });

    // A test for operator - (Quaternion, Quaternion)
    test('quaternionSubtractionTest', () {
      const a = Quaternion(1.0, 6.0, 7.0, 4.0);
      const b = Quaternion(5.0, 2.0, 3.0, 8.0);
      const expected = Quaternion(-4.0, 4.0, 4.0, -4.0);

      final actual = a - b;
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.operator - did not return the expected value: expected $expected actual $actual");
    });

    // A test for operator * (Quaternion, float)
    test('quaternionMultiplyTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const factor = 0.5;
      const expected = Quaternion(0.5, 1.0, 1.5, 2.0);

      final actual = a * factor;
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.operator * did not return the expected value: expected $expected actual $actual");
    });

    // A test for operator * (Quaternion, Quaternion)
    test('quaternionMultiplyTest1', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const b = Quaternion(5.0, 6.0, 7.0, 8.0);
      const expected = Quaternion(24.0, 48.0, 48.0, -6.0);

      final actual = a * b;
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.operator * did not return the expected value: expected $expected actual $actual");
    });

    // A test for operator / (Quaternion, Quaternion)
    test('quaternionDivisionTest1', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const b = Quaternion(5.0, 6.0, 7.0, 8.0);
      const expected =
          Quaternion(-0.045977015, -0.09195402, -7.450581E-09, 0.40229887);

      final actual = a / b;
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.operator / did not return the expected value: expected $expected actual $actual");
    });

    // A test for operator + (Quaternion, Quaternion)
    test('quaternionAdditionTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const b = Quaternion(5.0, 6.0, 7.0, 8.0);
      const expected = Quaternion(6.0, 8.0, 10.0, 12.0);

      final actual = a + b;
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.operator + did not return the expected value: expected $expected actual $actual");
    });

    // A test for Quaternion (float, float, float, float)
    test('quaternionConstructorTest', () {
      const x = 1.0;
      const y = 2.0;
      const z = 3.0;
      const w = 4.0;

      const target = Quaternion(x, y, z, w);
      expect(
          equalDouble(target.x, x) &&
              equalDouble(target.y, y) &&
              equalDouble(target.z, z) &&
              equalDouble(target.w, w),
          true,
          reason:
              "Quaternion.constructor (x,y,z,w) did not return the expected value.");
    });

    // A test for Quaternion (Vector3f, float)
    test('quaternionConstructorTest1', () {
      const v = Vector3(1.0, 2.0, 3.0);
      const w = 4.0;

      final target = Quaternion.fromVectorAndScalar(v, w);
      expect(
          equalDouble(target.x, v.x) &&
              equalDouble(target.y, v.y) &&
              equalDouble(target.z, v.z) &&
              equalDouble(target.w, w),
          true,
          reason:
              "Quaternion.constructor (Vector3f,w) did not return the expected value.");
    });

    // A test for CreateFromAxisAngle (Vector3f, float)
    test('quaternionCreateFromAxisAngleTest', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final angle = toRadians(30.0);

      const expected = Quaternion(0.0691723, 0.1383446, 0.20751688, 0.9659258);

      final actual = Quaternion.fromAxisAndAngle(axis, angle);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.fromAxisAndAngle did not return the expected value: expected $expected actual $actual");
    });

    // A test for CreateFromAxisAngle (Vector3f, float)
    // CreateFromAxisAngle of zero vector
    test('quaternionCreateFromAxisAngleTest1', () {
      const axis = Vector3.zero;
      final angle = toRadians(-30.0);

      final cos = math.cos(angle / 2.0);
      final actual = Quaternion.fromAxisAndAngle(axis, angle);

      expect(
          actual.x == 0.0 &&
              actual.y == 0.0 &&
              actual.z == 0.0 &&
              equalDouble(cos, actual.w),
          true,
          reason:
              "Quaternion.fromAxisAndAngle did not return the expected value.");
    });

    // A test for CreateFromAxisAngle (Vector3f, float)
    // CreateFromAxisAngle of angle = 30 && 750
    test('quaternionCreateFromAxisAngleTest2', () {
      const axis = Vector3(1, 0, 0);
      final angle1 = toRadians(30.0);
      final angle2 = toRadians(750.0);

      final actual1 = Quaternion.fromAxisAndAngle(axis, angle1);
      final actual2 = Quaternion.fromAxisAndAngle(axis, angle2);
      expect(equalQuaternion(actual1, actual2), true,
          reason:
              "Quaternion.fromAxisAndAngle did not return the expected value: actual1 $actual1 actual2 $actual2");
    });

    // A test for CreateFromAxisAngle (Vector3f, float)
    // CreateFromAxisAngle of angle = 30 && 390
    test('quaternionCreateFromAxisAngleTest3', () {
      const axis = Vector3(1.0, 0.0, 0.0);
      final angle1 = toRadians(30.0);
      final angle2 = toRadians(390.0);

      var actual1 = Quaternion.fromAxisAndAngle(axis, angle1);
      var actual2 = Quaternion.fromAxisAndAngle(axis, angle2);
      actual1 = actual1.setX(-actual1.x);
      actual1 = actual1.setW(-actual1.w);

      expect(equalQuaternion(actual1, actual2), true,
          reason:
              "Quaternion.fromAxisAndAngle did not return the expected value: actual1 $actual1 actual2 $actual2");
    });

    test('quaternionCreateFromYawPitchRollTest1', () {
      final yawAngle = toRadians(30.0);
      final pitchAngle = toRadians(40.0);
      final rollAngle = toRadians(50.0);

      final yaw = Quaternion.fromAxisAndAngle(Vector3.unitY, yawAngle);
      final pitch = Quaternion.fromAxisAndAngle(Vector3.unitX, pitchAngle);
      final roll = Quaternion.fromAxisAndAngle(Vector3.unitZ, rollAngle);

      final expected = yaw * pitch * roll;
      final actual =
          Quaternion.fromYawPitchRoll(yawAngle, pitchAngle, rollAngle);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.QuaternionCreateFromYawPitchRollTest1 did not return the expected value: expected $expected actual $actual");
    });

    // Covers more numeric rigions
    test('quaternionCreateFromYawPitchRollTest2', () {
      const step = 35.0;

      for (var yawAngle = -720.0; yawAngle <= 720.0; yawAngle += step) {
        for (var pitchAngle = -720.0; pitchAngle <= 720.0; pitchAngle += step) {
          for (var rollAngle = -720.0; rollAngle <= 720.0; rollAngle += step) {
            final yawRad = toRadians(yawAngle);
            final pitchRad = toRadians(pitchAngle);
            final rollRad = toRadians(rollAngle);

            final yaw = Quaternion.fromAxisAndAngle(Vector3.unitY, yawRad);
            final pitch = Quaternion.fromAxisAndAngle(Vector3.unitX, pitchRad);
            final roll = Quaternion.fromAxisAndAngle(Vector3.unitZ, rollRad);

            final expected = yaw * pitch * roll;
            final actual =
                Quaternion.fromYawPitchRoll(yawRad, pitchRad, rollRad);
            expect(equalQuaternion(expected, actual), true,
                reason:
                    "Quaternion.QuaternionCreateFromYawPitchRollTest2 Yaw:$yawAngle Pitch:$pitchAngle Roll:$rollAngle did not return the expected value: expected $expected actual $actual");
          }
        }
      }
    });

    // A test for Slerp (Quaternion, Quaternion, float)
    test('quaternionSlerpTest', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final a = Quaternion.fromAxisAndAngle(axis, toRadians(10.0));
      final b = Quaternion.fromAxisAndAngle(axis, toRadians(30.0));
      const t = 0.5;

      var expected = Quaternion.fromAxisAndAngle(axis, toRadians(20.0));
      var actual = Quaternion.slerp(a, b, t);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Slerp did not return the expected value: expected $expected actual $actual");

      // Case a and b are same.
      expected = a;
      actual = Quaternion.slerp(a, a, t);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Slerp did not return the expected value: expected $expected actual $actual");
    });

    // A test for Slerp (Quaternion, Quaternion, float)
    // Slerp test where t = 0
    test('quaternionSlerpTest1', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final a = Quaternion.fromAxisAndAngle(axis, toRadians(10.0));
      final b = Quaternion.fromAxisAndAngle(axis, toRadians(30.0));

      const t = 0.0;

      final expected = Quaternion(a.x, a.y, a.z, a.w);
      final actual = Quaternion.slerp(a, b, t);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Slerp did not return the expected value: expected $expected actual $actual");
    });

    // A test for Slerp (Quaternion, Quaternion, float)
    // Slerp test where t = 1
    test('quaternionSlerpTest2', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final a = Quaternion.fromAxisAndAngle(axis, toRadians(10.0));
      final b = Quaternion.fromAxisAndAngle(axis, toRadians(30.0));

      const t = 1.0;

      final expected = Quaternion(b.x, b.y, b.z, b.w);
      final actual = Quaternion.slerp(a, b, t);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Slerp did not return the expected value: expected $expected actual $actual");
    });

    // A test for Slerp (Quaternion, Quaternion, float)
    // Slerp test where dot product is < 0
    test('quaternionSlerpTest3', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final a = Quaternion.fromAxisAndAngle(axis, toRadians(10.0));
      final b = -a;

      const t = 1.0;

      final expected = a;
      final actual = Quaternion.slerp(a, b, t);
      // Note that in quaternion world, Q == -Q. In the case of quaternions dot product is zero,
      // one of the quaternion will be flipped to compute the shortest distance. When t = 1, we
      // expect the result to be the same as quaternion b but flipped.
      expect(actual == expected, true,
          reason:
              "Quaternion.Slerp did not return the expected value: expected $expected actual $actual");
    });

    // A test for Slerp (Quaternion, Quaternion, float)
    // Slerp test where the quaternion is flipped
    test('quaternionSlerpTest4', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final a = Quaternion.fromAxisAndAngle(axis, toRadians(10.0));
      final b = -Quaternion.fromAxisAndAngle(axis, toRadians(30.0));

      const t = 0.0;

      final expected = Quaternion(a.x, a.y, a.z, a.w);
      final actual = Quaternion.slerp(a, b, t);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.Slerp did not return the expected value: expected $expected actual $actual");
    });

    // A test for operator - (Quaternion)
    test('quaternionUnaryNegationTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const expected = Quaternion(-1.0, -2.0, -3.0, -4.0);

      final actual = -a;
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.operator - did not return the expected value: expected $expected actual $actual");
    });

    // A test for Inverse (Quaternion)
    test('quaternionInverseTest', () {
      const a = Quaternion(5.0, 6.0, 7.0, 8.0);
      const expected =
          Quaternion(-0.028735632, -0.03448276, -0.040229887, 0.04597701);

      final actual = a.inverse();
      expect(equalQuaternion(expected, actual), true);
    });

    // A test for Inverse (Quaternion)
    // Invert zero length quaternion
    test('quaternionInverseTest1', () {
      const a = Quaternion.zero;
      final actual = a.inverse();

      expect(
          actual.x.isNaN && actual.y.isNaN && actual.z.isNaN && actual.w.isNaN,
          true,
          reason:
              "Quaternion.Inverse - did not return the expected value: expected ${Quaternion.nan} actual $actual");
    });

    // A test for Add (Quaternion, Quaternion)
    test('quaternionAddTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const b = Quaternion(5.0, 6.0, 7.0, 8.0);
      const expected = Quaternion(6.0, 8.0, 10.0, 12.0);
      expect(equalQuaternion(expected, a + b), true);
    });

    // A test for Divide (Quaternion, Quaternion)
    test('quaternionDivideTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const b = Quaternion(5.0, 6.0, 7.0, 8.0);
      const expected =
          Quaternion(-0.045977015, -0.09195402, -7.450581E-09, 0.40229887);
      expect(equalQuaternion(expected, a / b), true);
    });

    // A test for Multiply (Quaternion, float)
    test('quaternionMultiplyTest2', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const factor = 0.5;
      const expected = Quaternion(0.5, 1.0, 1.5, 2.0);
      expect(equalQuaternion(expected, a * factor), true);
    });

    // A test for Multiply (Quaternion, Quaternion)
    test('quaternionMultiplyTest3', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const b = Quaternion(5.0, 6.0, 7.0, 8.0);
      const expected = Quaternion(24.0, 48.0, 48.0, -6.0);
      expect(equalQuaternion(expected, a * b), true);
    });

    // A test for Negate (Quaternion)
    test('quaternionNegateTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const expected = Quaternion(-1.0, -2.0, -3.0, -4.0);
      expect(equalQuaternion(expected, -a), true);
    });

    // A test for Subtract (Quaternion, Quaternion)
    test('quaternionSubtractTest', () {
      const a = Quaternion(1.0, 6.0, 7.0, 4.0);
      const b = Quaternion(5.0, 2.0, 3.0, 8.0);
      const expected = Quaternion(-4.0, 4.0, 4.0, -4.0);
      expect(equalQuaternion(expected, a - b), true);
    });

    // A test for operator != (Quaternion, Quaternion)
    test('quaternionInequalityTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      const b = Quaternion(1.0, 2.0, 3.0, 4.0);

      // case 1: compare between same values
      var expected = false;
      var actual = a != b;
      expect(actual, expected);

      // case 2: compare between different values
      expected = true;
      actual = a != b.setX(10.0);
      expect(actual, expected);
    });

    // A test for operator == (Quaternion, Quaternion)
    test('quaternionEqualityTest', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      var b = const Quaternion(1.0, 2.0, 3.0, 4.0);

      // case 1: compare between same values
      var expected = true;
      var actual = a == b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.setX(10.0);
      expected = false;
      actual = a == b;
      expect(actual, expected);
    });

    // A test for CreateFromRotationMatrix (Matrix4x4)
    // Convert Identity matrix test
    test('quaternionFromRotationMatrixTest1', () {
      const matrix = Matrix4x4.identity;

      const expected = Quaternion(0.0, 0.0, 0.0, 1.0);
      final actual = Quaternion.fromRotationMatrix(matrix);
      expect(equalQuaternion(expected, actual), true,
          reason:
              "Quaternion.CreateFromRotationMatrix did not return the expected value: expected $expected actual $actual");

      // make sure convert back to matrix is same as we passed matrix.
      final m2 = Matrix4x4.fromQuaternion(actual);
      expect(equalMatrix(matrix, m2), true,
          reason:
              "Quaternion.CreateFromQuaternion did not return the expected value: matrix $matrix m2 $m2");
    });

    // A test for CreateFromRotationMatrix (Matrix4x4)
    // Convert X axis rotation matrix
    test('quaternionFromRotationMatrixTest2', () {
      for (var angle = 0.0; angle < 720.0; angle += 10.0) {
        final matrix = Matrix4x4.rotationX(angle);

        final expected = Quaternion.fromAxisAndAngle(Vector3.unitX, angle);
        final actual = Quaternion.fromRotationMatrix(matrix);
        expect(equalRotation(expected, actual), true,
            reason:
                "Quaternion.CreateFromRotationMatrix angle:$angle did not return the expected value: expected $expected actual $actual");

        // make sure convert back to matrix is same as we passed matrix.
        final m2 = Matrix4x4.fromQuaternion(actual);
        expect(equalMatrix(matrix, m2), true,
            reason:
                "Quaternion.CreateFromQuaternion angle:$angle did not return the expected value: matrix $matrix m2 $m2");
      }
    });

    // A test for CreateFromRotationMatrix (Matrix4x4)
    // Convert Y axis rotation matrix
    test('quaternionFromRotationMatrixTest3', () {
      for (var angle = 0.0; angle < 720.0; angle += 10.0) {
        final matrix = Matrix4x4.rotationY(angle);

        final expected = Quaternion.fromAxisAndAngle(Vector3.unitY, angle);
        final actual = Quaternion.fromRotationMatrix(matrix);
        expect(equalRotation(expected, actual), true,
            reason:
                "Quaternion.CreateFromRotationMatrix angle:$angle did not return the expected value: expected $expected actual $actual");

        // make sure convert back to matrix is same as we passed matrix.
        final m2 = Matrix4x4.fromQuaternion(actual);
        expect(equalMatrix(matrix, m2), true,
            reason:
                "Quaternion.CreateFromQuaternion angle:$angle did not return the expected value: matrix $matrix m2 $m2");
      }
    });

    // A test for CreateFromRotationMatrix (Matrix4x4)
    // Convert Z axis rotation matrix
    test('quaternionFromRotationMatrixTest4', () {
      for (var angle = 0.0; angle < 720.0; angle += 10.0) {
        final matrix = Matrix4x4.rotationZ(angle);

        final expected = Quaternion.fromAxisAndAngle(Vector3.unitZ, angle);
        final actual = Quaternion.fromRotationMatrix(matrix);
        expect(equalRotation(expected, actual), true,
            reason:
                "Quaternion.CreateFromRotationMatrix angle:$angle did not return the expected value: expected $expected actual $actual");

        // make sure convert back to matrix is same as we passed matrix.
        final m2 = Matrix4x4.fromQuaternion(actual);
        expect(equalMatrix(matrix, m2), true,
            reason:
                "Quaternion.CreateFromQuaternion angle:$angle did not return the expected value: matrix $matrix m2 $m2");
      }
    });

    // A test for CreateFromRotationMatrix (Matrix4x4)
    // Convert XYZ axis rotation matrix
    test('quaternionFromRotationMatrixTest5', () {
      for (var angle = 0.0; angle < 720.0; angle += 10.0) {
        final matrix = Matrix4x4.rotationX(angle) *
            Matrix4x4.rotationY(angle) *
            Matrix4x4.rotationZ(angle);

        final expected = Quaternion.fromAxisAndAngle(Vector3.unitZ, angle) *
            Quaternion.fromAxisAndAngle(Vector3.unitY, angle) *
            Quaternion.fromAxisAndAngle(Vector3.unitX, angle);

        final actual = Quaternion.fromRotationMatrix(matrix);
        expect(equalRotation(expected, actual), true,
            reason:
                "Quaternion.CreateFromRotationMatrix angle:$angle did not return the expected value: expected $expected actual $actual");

        // make sure convert back to matrix is same as we passed matrix.
        final m2 = Matrix4x4.fromQuaternion(actual);
        expect(equalMatrix(matrix, m2), true,
            reason:
                "Quaternion.CreateFromQuaternion angle:$angle did not return the expected value: matrix $matrix m2 $m2");
      }
    });

    // A test for CreateFromRotationMatrix (Matrix4x4)
    // X axis is most large axis case
    test('quaternionFromRotationMatrixWithScaledMatrixTest1', () {
      final angle = toRadians(180.0);
      final matrix = Matrix4x4.rotationY(angle) * Matrix4x4.rotationZ(angle);

      final expected = Quaternion.fromAxisAndAngle(Vector3.unitZ, angle) *
          Quaternion.fromAxisAndAngle(Vector3.unitY, angle);
      final actual = Quaternion.fromRotationMatrix(matrix);
      expect(equalRotation(expected, actual), true,
          reason:
              "Quaternion.CreateFromRotationMatrix did not return the expected value: expected $expected actual $actual");

      // make sure convert back to matrix is same as we passed matrix.
      final m2 = Matrix4x4.fromQuaternion(actual);
      expect(equalMatrix(matrix, m2), true,
          reason:
              "Quaternion.CreateFromQuaternion did not return the expected value: matrix $matrix m2 $m2");
    });

    // A test for CreateFromRotationMatrix (Matrix4x4)
    // Y axis is most large axis case
    test('quaternionFromRotationMatrixWithScaledMatrixTest2', () {
      final angle = toRadians(180.0);
      final matrix = Matrix4x4.rotationX(angle) * Matrix4x4.rotationZ(angle);

      final expected = Quaternion.fromAxisAndAngle(Vector3.unitZ, angle) *
          Quaternion.fromAxisAndAngle(Vector3.unitX, angle);
      final actual = Quaternion.fromRotationMatrix(matrix);
      expect(equalRotation(expected, actual), true,
          reason:
              "Quaternion.CreateFromRotationMatrix did not return the expected value: expected $expected actual $actual");

      // make sure convert back to matrix is same as we passed matrix.
      final m2 = Matrix4x4.fromQuaternion(actual);
      expect(equalMatrix(matrix, m2), true,
          reason:
              "Quaternion.CreateFromQuaternion did not return the expected value: matrix $matrix m2 $m2");
    });

    // A test for CreateFromRotationMatrix (Matrix4x4)
    // Z axis is most large axis case
    test('quaternionFromRotationMatrixWithScaledMatrixTest3', () {
      final angle = toRadians(180.0);
      final matrix = Matrix4x4.rotationX(angle) * Matrix4x4.rotationY(angle);

      final expected = Quaternion.fromAxisAndAngle(Vector3.unitY, angle) *
          Quaternion.fromAxisAndAngle(Vector3.unitX, angle);
      final actual = Quaternion.fromRotationMatrix(matrix);
      expect(equalRotation(expected, actual), true,
          reason:
              "Quaternion.CreateFromRotationMatrix did not return the expected value: expected $expected actual $actual");

      // make sure convert back to matrix is same as we passed matrix.
      final m2 = Matrix4x4.fromQuaternion(actual);
      expect(equalMatrix(matrix, m2), true,
          reason:
              "Quaternion.CreateFromQuaternion did not return the expected value: matrix $matrix m2 $m2");
    });

    // A test for Equals (Quaternion)
    test('quaternionEqualsTest1', () {
      const a = Quaternion(1.0, 2.0, 3.0, 4.0);
      var b = const Quaternion(1.0, 2.0, 3.0, 4.0);

      // case 1: compare between same values
      var expected = true;
      var actual = a == b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.setX(10.0);
      expected = false;
      actual = a == b;
      expect(actual, expected);
    });

    // A test for Identity
    test('quaternionIdentityTest', () {
      const val = Quaternion(0, 0, 0, 1);
      expect(equalQuaternion(val, Quaternion.identity), true);
    });

    // A test for IsIdentity
    test('quaternionIsIdentityTest', () {
      expect(Quaternion.identity.isIdentity, true);
      expect(const Quaternion(0, 0, 0, 1).isIdentity, true);

      expect(const Quaternion(1, 0, 0, 1).isIdentity, false);
      expect(const Quaternion(0, 1, 0, 1).isIdentity, false);
      expect(const Quaternion(0, 0, 1, 1).isIdentity, false);
      expect(const Quaternion(0, 0, 0, 0).isIdentity, false);
    });

    // A test for Quaternion comparison involving NaN values
    test('quaternionEqualsNanTest', () {
      const a = Quaternion(double.nan, 0, 0, 0);
      const b = Quaternion(0, double.nan, 0, 0);
      const c = Quaternion(0, 0, double.nan, 0);
      const d = Quaternion(0, 0, 0, double.nan);

      expect(a == const Quaternion(0, 0, 0, 0), false);
      expect(b == const Quaternion(0, 0, 0, 0), false);
      expect(c == const Quaternion(0, 0, 0, 0), false);
      expect(d == const Quaternion(0, 0, 0, 0), false);

      expect(a != const Quaternion(0, 0, 0, 0), true);
      expect(b != const Quaternion(0, 0, 0, 0), true);
      expect(c != const Quaternion(0, 0, 0, 0), true);
      expect(d != const Quaternion(0, 0, 0, 0), true);

      expect(a == const Quaternion(0, 0, 0, 0), false);
      expect(b == const Quaternion(0, 0, 0, 0), false);
      expect(c == const Quaternion(0, 0, 0, 0), false);
      expect(d == const Quaternion(0, 0, 0, 0), false);

      expect(a.isIdentity, false);
      expect(b.isIdentity, false);
      expect(c.isIdentity, false);
      expect(d.isIdentity, false);

      // Counterintuitive result - IEEE rules for NaN comparison are weird!
      expect(a == a, false);
      expect(b == b, false);
      expect(c == c, false);
      expect(d == d, false);
    });

    test('toEulerAndBack', () {
      const x = math.pi / 5.0;
      const y = math.pi * 2.0 / 7.0;
      const z = math.pi / 3.0;
      const euler = Vector3(x, y, z);
      final quat = Quaternion.fromEulerAngles(euler);
      final euler2 = quat.toEulerAngles();
      expect(equalDouble(euler.x, euler2.x, 0.001), true);
      expect(equalDouble(euler.y, euler2.y, 0.001), true);
      expect(equalDouble(euler.z, euler2.z, 0.001), true);
    });
  });

  group('Vector2Tests', () {
    // test('vector2MarshalSizeTest', () {
    //   expect(true, true);
    // });
    test('vector2GetHashCodeTest', () {
      const v1 = Vector2(2.0, 3.0);
      const v2 = Vector2(2.0, 3.0);
      const v3 = Vector2(3.0, 2.0);
      expect(v1.hashCode == v1.hashCode, true);
      expect(v1.hashCode == v2.hashCode, true);
      expect(v1.hashCode == v3.hashCode, false);
      const v4 = Vector2(0.0, 0.0);
      const v6 = Vector2(1.0, 0.0);
      const v7 = Vector2(0.0, 1.0);
      const v8 = Vector2(1.0, 1.0);
      expect(v4.hashCode == v6.hashCode, false);
      expect(v4.hashCode == v7.hashCode, false);
      expect(v4.hashCode == v8.hashCode, false);
      expect(v7.hashCode == v6.hashCode, false);
      expect(v8.hashCode == v6.hashCode, false);
      expect(v8.hashCode == v7.hashCode, false);
    });

    // A test for Distance (Vector2f, Vector2f)
    test('vector2DistanceTest', () {
      const a = Vector2(1.0, 2.0);
      const b = Vector2(3.0, 4.0);
      final expected = 8.sqrt();

      final actual = a.distance(b);
      expect(equalDouble(expected, actual), true,
          reason: "Vector2f.Distance did not return the expected value.");
    });

    // A test for Distance (Vector2f, Vector2f)
    // Distance from the same point
    test('vector2DistanceTest2', () {
      const a = Vector2(1.051, 2.05);
      const b = Vector2(1.051, 2.05);

      final actual = a.distance(b);
      expect(actual, 0.0);
    });

    // A test for DistanceSquared (Vector2f, Vector2f)
    test('vector2DistanceSquaredTest', () {
      const a = Vector2(1.0, 2.0);
      const b = Vector2(3.0, 4.0);
      const expected = 8.0;

      final actual = a.distanceSquared(b);
      expect(equalDouble(expected, actual), true,
          reason:
              "Vector2f.DistanceSquared did not return the expected value.");
    });

    // A test for Dot (Vector2f, Vector2f)
    test('vector2DotTest', () {
      const a = Vector2(1.0, 2.0);
      const b = Vector2(3.0, 4.0);
      const expected = 11.0;

      final actual = a.dot(b);
      expect(equalDouble(expected, actual), true,
          reason: "Vector2f.Dot did not return the expected value.");
    });

    // A test for Dot (Vector2f, Vector2f)
    // Dot test for perpendicular vector
    test('vector2DotTest1', () {
      const a = Vector2(1.55, 1.55);
      const b = Vector2(-1.55, 1.55);

      const expected = 0.0;
      final actual = a.dot(b);
      expect(actual, expected);
    });

    // A test for Dot (Vector2f, Vector2f)
    // Dot test with specail float values
    test('vector2DotTest2', () {
      const a = Vector2.minValue;
      const b = Vector2.maxValue;

      final actual = a.dot(b);
      final isNegativeInfinity = actual.isInfinite && actual.isNegative;
      expect(isNegativeInfinity, true,
          reason: "Vector2f.Dot did not return the expected value.");
    });

    // A test for Length ()
    test('vector2LengthTest', () {
      const a = Vector2(2.0, 4.0);
      const target = a;
      final expected = math.sqrt(20.0);
      final actual = target.length;
      expect(equalDouble(expected, actual), true,
          reason: "Vector2f.Length did not return the expected value.");
    });

    // A test for Length ()
    // Length test where length is zero
    test('vector2LengthTest1', () {
      const target = Vector2(0.0, 0.0);
      const expected = 0.0;
      final actual = target.length;
      expect(equalDouble(expected, actual), true,
          reason: "Vector2f.Length did not return the expected value.");
    });

    // A test for LengthSquared ()
    test('vector2LengthSquaredTest', () {
      const a = Vector2(2.0, 4.0);
      const target = a;
      const expected = 20.0;
      final actual = target.lengthSquared;
      expect(equalDouble(expected, actual), true,
          reason: "Vector2f.LengthSquared did not return the expected value.");
    });

    // A test for LengthSquared ()
    // LengthSquared test where the result is zero
    test('vector2LengthSquaredTest1', () {
      const a = Vector2(0.0, 0.0);
      const expected = 0.0;
      final actual = a.lengthSquared;

      expect(actual, expected);
    });

    // A test for Min (Vector2f, Vector2f)
    test('vector2MinTest', () {
      const a = Vector2(-1.0, 4.0);
      const b = Vector2(2.0, 1.0);
      const expected = Vector2(-1.0, 1.0);
      final actual = a.min(b);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Min did not return the expected value.");
    });

    test('vector2MinMaxCodeCoverageTest', () {
      const min = Vector2(0, 0);
      const max = Vector2(1, 1);
      // Min.
      var actual = min.min(max);
      expect(min, actual);

      actual = max.min(min);
      expect(min, actual);
      // Max.
      actual = min.max(max);
      expect(max, actual);

      actual = max.max(min);
      expect(max, actual);
    });

    // A test for Max (Vector2f, Vector2f)
    test('vector2MaxTest', () {
      const a = Vector2(-1.0, 4.0);
      const b = Vector2(2.0, 1.0);

      const expected = Vector2(2.0, 4.0);

      final actual = a.max(b);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Max did not return the expected value.");
    });

    // A test for Clamp (Vector2f, Vector2f, Vector2f)
    test('vector2ClampTest', () {
      var a = const Vector2(0.5, 0.3);
      var min = const Vector2(0.0, 0.1);
      var max = const Vector2(1.0, 1.1);

      // Normal case.
      // Case N1: specified value is in the range.
      var expected = const Vector2(0.5, 0.3);
      var actual = a.clamp(min, max);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Clamp did not return the expected value.");
      // Normal case.
      // Case N2: specified value is bigger than max value.
      a = const Vector2(2.0, 3.0);
      expected = max;
      actual = a.clamp(min, max);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Clamp did not return the expected value.");
      // Case N3: specified value is smaller than max value.
      a = const Vector2(-1.0, -2.0);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Clamp did not return the expected value.");
      // Case N4: combination case.
      a = const Vector2(-2.0, 4.0);
      expected = Vector2(min.x, max.y);
      actual = a.clamp(min, max);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Clamp did not return the expected value.");
      // User specified min value is bigger than max value.
      max = const Vector2(0.0, 0.1);
      min = const Vector2(1.0, 1.1);

      // Case W1: specified value is in the range.
      a = const Vector2(0.5, 0.3);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Clamp did not return the expected value.");

      // Normal case.
      // Case W2: specified value is bigger than max and min value.
      a = const Vector2(2.0, 3.0);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Clamp did not return the expected value.");

      // Case W3: specified value is smaller than min and max value.
      a = const Vector2(-1.0, -2.0);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Clamp did not return the expected value.");
    });

    // A test for Lerp (Vector2f, Vector2f, float)
    test('vector2LerpTest', () {
      const a = Vector2(1.0, 2.0);
      const b = Vector2(3.0, 4.0);
      const t = 0.5;

      const expected = Vector2(2.0, 3.0);
      final actual = a.lerp(b, t);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector2f, Vector2f, float)
    // Lerp test with factor zero
    test('vector2LerpTest1', () {
      const a = Vector2(0.0, 0.0);
      const b = Vector2(3.18, 4.25);

      const t = 0.0;
      const expected = Vector2.zero;
      final actual = a.lerp(b, t);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector2f, Vector2f, float)
    // Lerp test with factor one
    test('vector2LerpTest2', () {
      const a = Vector2(0.0, 0.0);
      const b = Vector2(3.18, 4.25);
      const t = 1.0;
      const expected = Vector2(3.18, 4.25);
      final actual = a.lerp(b, t);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector2f, Vector2f, float)
    // Lerp test with factor > 1
    test('vector2LerpTest3', () {
      const a = Vector2(0.0, 0.0);
      const b = Vector2(3.18, 4.25);

      const t = 2.0;
      final expected = b * 2.0;
      final actual = a.lerp(b, t);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector2f, Vector2f, float)
    // Lerp test with factor < 0
    test('vector2LerpTest4', () {
      const a = Vector2(0.0, 0.0);
      const b = Vector2(3.18, 4.25);

      const t = -2.0;
      final expected = -(b * 2.0);
      final actual = a.lerp(b, t);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector2f, Vector2f, float)
    // Lerp test with special float value
    test('vector2LerpTest5', () {
      const a = Vector2(45.67, 90.0);
      const b = Vector2(double.infinity, double.negativeInfinity);
      const t = 0.408;
      final actual = a.lerp(b, t);
      final isPositiveInfinity = actual.x.isInfinite && !actual.x.isNegative;
      final isNegativeInfinity = actual.y.isInfinite && actual.y.isNegative;
      expect(isPositiveInfinity, true,
          reason: "Vector2f.Lerp did not return the expected value.");
      expect(isNegativeInfinity, true,
          reason: "Vector2f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector2f, Vector2f, float)
    // Lerp test from the same point
    test('vector2LerpTest6', () {
      const a = Vector2(1.0, 2.0);
      const b = Vector2(1.0, 2.0);
      const t = 0.5;
      const expected = Vector2(1.0, 2.0);
      final actual = a.lerp(b, t);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Lerp did not return the expected value.");
    });

    // A test for Transform(Vector2f, Matrix4x4)
    test('vector2TransformTest', () {
      const v = Vector2(1.0, 2.0);
      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));
      // m.M41 = 10.0;
      // m.M42 = 20.0;
      // m.M43 = 30.0;
      const expected = Vector2(10.316987, 22.183012);
      final actual = v.transform(m);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Transform did not return the expected value.");
    });

    // A test for TransformNormal (Vector2f, Matrix4x4)
    test('vector2TransformNormalTest', () {
      const v = Vector2(1.0, 2.0);
      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));
      // m.M41 = 10.0;
      // m.M42 = 20.0;
      // m.M43 = 30.0;
      const expected = Vector2(0.3169873, 2.1830127);
      final actual = Vector2.transformNormal(v, m);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Tranform did not return the expected value.");
    });

    // A test for Transform (Vector2f, Quaternion)
    test('vector2TransformByQuaternionTest', () {
      const v = Vector2(1.0, 2.0);
      final m = Matrix4x4.rotationX(30.0.toRadians()) *
          Matrix4x4.rotationY(30.0.toRadians()) *
          Matrix4x4.rotationZ(30.0.toRadians());
      final q = Quaternion.fromRotationMatrix(m);
      final expected = v.transform(m);
      final actual = v.transformByQuaternion(q);
      expect(expected.almostEquals(actual), true);
    });

    // A test for Transform (Vector2f, Quaternion)
    // Transform Vector2f with zero quaternion
    test('vector2TransformByQuaternionTest1', () {
      const v = Vector2(1.0, 2.0);
      const q = Quaternion.zero;
      const expected = v;
      final actual = v.transformByQuaternion(q);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector2f, Quaternion)
    // Transform Vector2f with identity quaternion
    test('vector2TransformByQuaternionTest2', () {
      const v = Vector2(1.0, 2.0);
      const q = Quaternion.identity;
      const expected = v;
      final actual = v.transformByQuaternion(q);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Transform did not return the expected value.");
    });

    // A test for Normalize (Vector2f)
    test('vector2NormalizeTest', () {
      const a = Vector2(2.0, 3.0);
      const expected = Vector2(0.5547002, 0.8320503);
      expect(equalVector2(a.normalize(), expected), true);
    });

    // A test for Normalize (Vector2f)
    // Normalize zero length vector
    test('vector2NormalizeTest1', () {
      const a = Vector2.zero;
      // no parameter, default to 0.0f
      final actual = a.normalize();
      expect(actual.x.isNaN && actual.y.isNaN, true,
          reason: "Vector2f.Normalize did not return the expected value.");
    });

    // A test for Normalize (Vector2f)
    // Normalize infinite length vector
    test('vector2NormalizeTest2', () {
      const a = Vector2.maxValue;
      final actual = a.normalize();
      const expected = Vector2(0, 0);
      expect(actual, expected);
    });

    // A test for operator - (Vector2f)
    test('vector2UnaryNegationTest', () {
      const a = Vector2(1.0, 2.0);
      const expected = Vector2(-1.0, -2.0);
      final actual = -a;
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.operator - did not return the expected value.");
    });

    // A test for operator - (Vector2f)
    // Negate test with special float value
    test('vector2UnaryNegationTest1', () {
      const a = Vector2(double.infinity, double.negativeInfinity);
      final actual = -a;
      final isNegativeInfinity = actual.x.isInfinite && actual.x.isNegative;
      final isPositiveInfinity = actual.y.isInfinite && !actual.y.isNegative;
      expect(isNegativeInfinity, true,
          reason: "Vector2f.operator - did not return the expected value.");
      expect(isPositiveInfinity, true,
          reason: "Vector2f.operator - did not return the expected value.");
    });

    // A test for operator - (Vector2f)
    // Negate test with special float value
    test('vector2UnaryNegationTest2', () {
      const a = Vector2(double.nan, 0.0);
      final actual = -a;

      expect(actual.x.isNaN, true,
          reason: "Vector2f.operator - did not return the expected value.");
      expect(actual.y, 0.0,
          reason: "Vector2f.operator - did not return the expected value.");
    });

    // A test for operator - (Vector2f, Vector2f)
    test('vector2SubtractionTest', () {
      const a = Vector2(1.0, 3.0);
      const b = Vector2(2.0, 1.5);
      const expected = Vector2(-1.0, 1.5);
      final actual = a - b;
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.operator - did not return the expected value.");
    });

    // A test for operator * (Vector2f, float)
    test('vector2MultiplyOperatorTest', () {
      const a = Vector2(2.0, 3.0);
      const factor = 2.0;
      const expected = Vector2(4.0, 6.0);
      final actual = a * factor;
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.operator * did not return the expected value.");
    });

    // A test for operator * (float, Vector2f)
    // test('vector2MultiplyOperatorTest2', () {
    //   const a = Vector2(2.0, 3.0);
    //   const factor = 2.0;
    //   const expected = Vector2(4.0, 6.0);
    //   final actual = factor * a;
    //   expect(equalVector2(expected, actual), true,
    //       reason: "Vector2f.operator * did not return the expected value.");
    // });

    // A test for operator * (Vector2f, Vector2f)
    test('vector2MultiplyOperatorTest3', () {
      const a = Vector2(2.0, 3.0);
      const b = Vector2(4.0, 5.0);
      const expected = Vector2(8.0, 15.0);
      final actual = a * b;
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.operator * did not return the expected value.");
    });

    // A test for operator / (Vector2f, float)
    test('vector2DivisionTest', () {
      const a = Vector2(2.0, 3.0);
      const div = 2.0;
      const expected = Vector2(1.0, 1.5);
      final actual = a / div;
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.operator / did not return the expected value.");
    });

    // A test for operator / (Vector2f, Vector2f)
    test('vector2DivisionTest1', () {
      const a = Vector2(2.0, 3.0);
      const b = Vector2(4.0, 5.0);
      const expected = Vector2(2.0 / 4.0, 3.0 / 5.0);
      final actual = a / b;
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.operator / did not return the expected value.");
    });

    // A test for operator / (Vector2f, float)
    // Divide by zero
    test('vector2DivisionTest2', () {
      const a = Vector2(-2.0, 3.0);
      const div = 0.0;
      final actual = a / div;
      final isNegativeInfinity = actual.x.isInfinite && actual.x.isNegative;
      final isPositiveInfinity = actual.y.isInfinite && !actual.y.isNegative;
      expect(isNegativeInfinity, true,
          reason: "Vector2f.operator / did not return the expected value.");
      expect(isPositiveInfinity, true,
          reason: "Vector2f.operator / did not return the expected value.");
    });

    // A test for operator / (Vector2f, Vector2f)
    // Divide by zero
    test('vector2DivisionTest3', () {
      const a = Vector2(0.047, -3.0);
      const b = Vector2.zero;
      final actual = a / b;
      expect(actual.x.isInfinite, true,
          reason: "Vector2f.operator / did not return the expected value.");
      expect(actual.y.isInfinite, true,
          reason: "Vector2f.operator / did not return the expected value.");
    });

    // A test for operator + (Vector2f, Vector2f)
    test('vector2AdditionTest', () {
      const a = Vector2(1.0, 2.0);
      const b = Vector2(3.0, 4.0);
      const expected = Vector2(4.0, 6.0);
      final actual = a + b;
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.operator + did not return the expected value.");
    });

    // A test for Vector2f (float, float)
    test('vector2ConstructorTest', () {
      const x = 1.0;
      const y = 2.0;

      const target = Vector2(x, y);
      expect(equalDouble(target.x, x) && equalDouble(target.y, y), true,
          reason:
              "Vector2f(x,y) constructor did not return the expected value.");
    });

    // A test for Vector2f ()
    // Constructor with no parameter
    test('vector2ConstructorTest2', () {
      const target = Vector2.zero;
      expect(target.x, 0.0);
      expect(target.y, 0.0);
    });

    // A test for Vector2f (float, float)
    // Constructor with special floating values
    test('vector2ConstructorTest3', () {
      const target = Vector2(double.nan, double.maxFinite);
      expect(target.x.isNaN, true);
      expect(target.y, double.maxFinite);
    });

    // A test for Vector2f (float)
    test('vector2ConstructorTest4', () {
      var value = 1.0;
      var target = Vector2.value(value);
      var expected = Vector2(value, value);
      expect(target, expected);

      value = 2.0;
      target = Vector2.value(value);
      expected = Vector2(value, value);
      expect(target, expected);
    });

    // A test for Add (Vector2f, Vector2f)
    test('vector2AddTest', () {
      const a = Vector2(1.0, 2.0);
      const b = Vector2(5.0, 6.0);
      const expected = Vector2(6.0, 8.0);
      final actual = a.add(b);
      expect(actual, expected);
    });

    // A test for Divide (Vector2f, float)
    test('vector2DivideTest', () {
      const a = Vector2(1.0, 2.0);
      const div = 2.0;
      const expected = Vector2(0.5, 1.0);
      expect(a / div, expected);
    });

    // A test for Divide (Vector2f, Vector2f)
    test('vector2DivideTest1', () {
      const a = Vector2(1.0, 6.0);
      const b = Vector2(5.0, 2.0);
      const expected = Vector2(1.0 / 5.0, 6.0 / 2.0);
      final actual = a.divide(b);
      expect(actual, expected);
    });

    // A test for Equals (object)
    test('vector2EqualsTest', () {
      const a = Vector2(1.0, 2.0);
      var b = const Vector2(1.0, 2.0);

      // case 1: compare between same values
      Object? obj = b;

      var expected = true;
      var actual = a == obj;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.setX(10.0);
      obj = b;
      expected = false;
      actual = a == obj;
      expect(actual, expected);

      // case 3: compare between different types.
      obj = Quaternion.zero;
      expected = false;
      actual = a == obj;
      expect(actual, expected);

      // case 3: compare against null.
      obj = null;
      expected = false;
      actual = a == obj;
      expect(actual, expected);
    });

    // A test for Multiply (Vector2f, float)
    test('vector2MultiplyTest', () {
      const a = Vector2(1.0, 2.0);
      const factor = 2.0;
      const expected = Vector2(2.0, 4.0);
      expect(a * factor, expected);
    });

    // A test for Multiply (float, Vector2f)
    // test('vector2MultiplyTest2', () {
    //   const a = Vector2(1.0, 2.0);
    //   const factor = 2.0;
    //   const expected = Vector2(2.0, 4.0);
    //   expect(factor * a, expected);
    // });

    // A test for Multiply (Vector2f, Vector2f)
    test('vector2MultiplyTest3', () {
      const a = Vector2(1.0, 2.0);
      const b = Vector2(5.0, 6.0);
      const expected = Vector2(5.0, 12.0);
      final actual = a.multiply(b);
      expect(actual, expected);
    });

    // A test for Negate (Vector2f)
    test('vector2NegateTest', () {
      const a = Vector2(1.0, 2.0);
      const expected = Vector2(-1.0, -2.0);
      final actual = a.negate();
      expect(actual, expected);
    });

    // A test for operator != (Vector2f, Vector2f)
    test('vector2InequalityTest', () {
      const a = Vector2(1.0, 2.0);
      var b = const Vector2(1.0, 2.0);
      // case 1: compare between same values
      var expected = false;
      var actual = a != b;
      expect(actual, expected);
      // case 2: compare between different values
      b = b.setX(10.0);
      expected = true;
      actual = a != b;
      expect(actual, expected);
    });

    // A test for operator == (Vector2f, Vector2f)
    test('vector2EqualityTest', () {
      const a = Vector2(1.0, 2.0);
      var b = const Vector2(1.0, 2.0);

      // case 1: compare between same values
      var expected = true;
      var actual = a == b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.setX(10.0);
      expected = false;
      actual = a == b;
      expect(actual, expected);
    });

    // A test for Subtract (Vector2f, Vector2f)
    test('vector2SubtractTest', () {
      const a = Vector2(1.0, 6.0);
      const b = Vector2(5.0, 2.0);
      const expected = Vector2(-4.0, 4.0);
      final actual = a.subtract(b);
      expect(actual, expected);
    });

    // A test for UnitX
    test('vector2UnitXTest', () {
      const val = Vector2(1.0, 0.0);
      expect(val, Vector2.unitX);
    });

    // A test for UnitY
    test('vector2UnitYTest', () {
      const val = Vector2(0.0, 1.0);
      expect(val, Vector2.unitY);
    });

    // A test for One
    test('vector2OneTest', () {
      const val = Vector2(1.0, 1.0);
      expect(val, Vector2.one);
    });

    // A test for Zero
    test('vector2ZeroTest', () {
      const val = Vector2(0.0, 0.0);
      expect(val, Vector2.zero);
    });

    // A test for Equals (Vector2f)
    test('vector2EqualsTest1', () {
      const a = Vector2(1.0, 2.0);
      var b = const Vector2(1.0, 2.0);

      // case 1: compare between same values
      var expected = true;
      var actual = a == b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.setX(10.0);
      expected = false;
      actual = a == b;
      expect(actual, expected);
    });

    // A test for Vector2f comparison involving NaN values
    test('vector2EqualsNanTest', () {
      const a = Vector2(double.nan, 0);
      const b = Vector2(0, double.nan);

      expect(a == Vector2.zero, false);
      expect(b == Vector2.zero, false);

      expect(a != Vector2.zero, true);
      expect(b != Vector2.zero, true);

      expect(a == Vector2.zero, false);
      expect(b == Vector2.zero, false);

      // Counterintuitive result - IEEE rules for NaN comparison are weird!
      expect(a == a, false);
      expect(b == b, false);
    });

    // A test for Reflect (Vector2f, Vector2f)
    test('vector2ReflectTest', () {
      var a = const Vector2(1.0, 1.0).normalize();

      // Reflect on XZ plane.
      var n = const Vector2(0.0, 1.0);
      var expected = Vector2(a.x, -a.y);
      var actual = a.reflect(n);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Reflect did not return the expected value.");

      // Reflect on XY plane.
      n = const Vector2(0.0, 0.0);
      expected = Vector2(a.x, a.y);
      actual = a.reflect(n);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Reflect did not return the expected value.");

      // Reflect on YZ plane.
      n = const Vector2(1.0, 0.0);
      expected = Vector2(-a.x, a.y);
      actual = a.reflect(n);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Reflect did not return the expected value.");
    });

    // A test for Reflect (Vector2f, Vector2f)
    // Reflection when normal and source are the same
    test('vector2ReflectTest1', () {
      var n = const Vector2(0.45, 1.28);
      n = n.normalize();
      var a = n;

      var expected = -n;
      var actual = a.reflect(n);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Reflect did not return the expected value.");
    });

    // A test for Reflect (Vector2f, Vector2f)
    // Reflection when normal and source are negation
    test('vector2ReflectTest2', () {
      var n = const Vector2(0.45, 1.28);
      n = n.normalize();
      var a = -n;

      var expected = n;
      var actual = a.reflect(n);
      expect(equalVector2(expected, actual), true,
          reason: "Vector2f.Reflect did not return the expected value.");
    });

    test('vector2AbsTest', () {
      const v1 = Vector2(-2.5, 2.0);
      final v3 = const Vector2(0.0, double.negativeInfinity).abs();
      final v = v1.abs();
      expect(2.5, v.x);
      expect(2.0, v.y);
      expect(0.0, v3.x);
      expect(double.infinity, v3.y);
    });

    test('vector2SqrtTest', () {
      const v1 = Vector2(-2.5, 2.0);
      const v2 = Vector2(5.5, 4.5);
      expect(2, v2.squareRoot().x.toInt());
      expect(2, v2.squareRoot().y.toInt());
      expect(v1.squareRoot().x.isNaN, true);
    });
  });

  group('Vector3Tests', () {
    // test('vector3MarshalSizeTest', () {
    //   expect(true, true);
    // });

    test('vector3GetHashCodeTest', () {
      const v1 = Vector3(2.0, 3.0, 3.3);
      const v2 = Vector3(2.0, 3.0, 3.3);
      const v3 = Vector3(2.0, 3.0, 3.3);
      const v5 = Vector3(3.0, 2.0, 3.3);
      expect(v1.hashCode == v1.hashCode, true);
      expect(v1.hashCode == v2.hashCode, true);
      expect(v1.hashCode == v5.hashCode, false);
      expect(v1.hashCode == v3.hashCode, true);
      const v4 = Vector3(0.0, 0.0, 0.0);
      const v6 = Vector3(1.0, 0.0, 0.0);
      const v7 = Vector3(0.0, 1.0, 0.0);
      const v8 = Vector3(1.0, 1.0, 1.0);
      const v9 = Vector3(1.0, 1.0, 0.0);
      expect(v4.hashCode == v6.hashCode, false);
      expect(v4.hashCode == v7.hashCode, false);
      expect(v4.hashCode == v8.hashCode, false);
      expect(v7.hashCode == v6.hashCode, false);
      expect(v8.hashCode == v6.hashCode, false);
      expect(v8.hashCode == v9.hashCode, false);
      expect(v7.hashCode == v9.hashCode, false);
    });

    // A test for Cross (Vector3f, Vector3f)
    test('vector3CrossTest', () {
      const a = Vector3(1.0, 0.0, 0.0);
      const b = Vector3(0.0, 1.0, 0.0);
      const expected = Vector3(0.0, 0.0, 1.0);

      final actual = a.cross(b);
      expect(equalVector3(actual, expected), true,
          reason: "Vector3f.Cross did not return the expected value.");
    });

    // A test for Cross (Vector3f, Vector3f)
    // Cross test of the same vector
    test('vector3CrossTest1', () {
      const a = Vector3(0.0, 1.0, 0.0);
      const b = Vector3(0.0, 1.0, 0.0);

      const expected = Vector3(0.0, 0.0, 0.0);
      final actual = a.cross(b);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Cross did not return the expected value.");
    });

    // A test for Distance (Vector3f, Vector3f)
    test('vector3DistanceTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const b = Vector3(4.0, 5.0, 6.0);

      final expected = math.sqrt(27);
      double actual = 0.0;

      actual = a.distance(b);
      expect(equalDouble(expected, actual), true,
          reason: "Vector3f.Distance did not return the expected value.");
    });

    // A test for Distance (Vector3f, Vector3f)
    // Distance from the same point
    test('vector3DistanceTest1', () {
      const a = Vector3(1.051, 2.05, 3.478);
      const b = Vector3(1.051, 2.05, 3.478);

      final actual = a.distance(b);
      expect(0.0, actual);
    });

    // A test for DistanceSquared (Vector3f, Vector3f)
    test('vector3DistanceSquaredTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const b = Vector3(4.0, 5.0, 6.0);

      const expected = 27.0;
      double actual = 0.0;

      actual = a.distanceSquared(b);
      expect(equalDouble(expected, actual), true,
          reason:
              "Vector3f.DistanceSquared did not return the expected value.");
    });

    // A test for Dot (Vector3f, Vector3f)
    test('vector3DotTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const b = Vector3(4.0, 5.0, 6.0);

      const expected = 32.0;
      double actual = 0.0;

      actual = a.dot(b);
      expect(equalDouble(expected, actual), true,
          reason: "Vector3f.Dot did not return the expected value.");
    });

    // A test for Dot (Vector3f, Vector3f)
    // Dot test for perpendicular vector
    test('vector3DotTest1', () {
      const a = Vector3(1.55, 1.55, 1);
      const b = Vector3(2.5, 3, 1.5);
      final c = a.cross(b);

      const expected = 0.0;
      final actual1 = a.dot(c);
      final actual2 = b.dot(c);
      expect(equalDouble(expected, actual1), true,
          reason: "Vector3f.Dot did not return the expected value.");
      expect(equalDouble(expected, actual2), true,
          reason: "Vector3f.Dot did not return the expected value.");
    });

    // A test for Length ()
    test('vector3LengthTest', () {
      const a = Vector2(1.0, 2.0);

      const z = 3.0;

      final target = Vector3.fromVector2(a, z);

      final expected = math.sqrt(14.0);
      double actual = 0.0;

      actual = target.length;
      expect(equalDouble(expected, actual), true,
          reason: "Vector3f.Length did not return the expected value.");
    });

    // A test for Length ()
    // Length test where length is zero
    test('vector3LengthTest1', () {
      const target = Vector3.zero;

      const expected = 0.0;
      final actual = target.length;
      expect(equalDouble(expected, actual), true,
          reason: "Vector3f.Length did not return the expected value.");
    });

    // A test for LengthSquared ()
    test('vector3LengthSquaredTest', () {
      const a = Vector2(1.0, 2.0);

      const z = 3.0;

      final target = Vector3.fromVector2(a, z);

      const expected = 14.0;
      double actual = 0.0;

      actual = target.lengthSquared;
      expect(equalDouble(expected, actual), true,
          reason: "Vector3f.LengthSquared did not return the expected value.");
    });

    // A test for Min (Vector3f, Vector3f)
    test('vector3MinTest', () {
      const a = Vector3(-1.0, 4.0, -3.0);
      const b = Vector3(2.0, 1.0, -1.0);

      const expected = Vector3(-1.0, 1.0, -3.0);

      final actual = a.min(b);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Min did not return the expected value.");
    });

    // A test for Max (Vector3f, Vector3f)
    test('vector3MaxTest', () {
      const a = Vector3(-1.0, 4.0, -3.0);
      const b = Vector3(2.0, 1.0, -1.0);

      const expected = Vector3(2.0, 4.0, -1.0);

      final actual = a.max(b);
      expect(equalVector3(expected, actual), true,
          reason: "MathOps.Max did not return the expected value.");
    });

    test('vector3MinMaxCodeCoverageTest', () {
      const min = Vector3.zero;
      const max = Vector3.one;

      // Min.
      var actual = min.min(max);
      expect(min, actual);

      actual = max.min(min);
      expect(min, actual);

      // Max.
      actual = min.max(max);
      expect(max, actual);

      actual = max.max(min);
      expect(max, actual);
    });

    // A test for Lerp (Vector3f, Vector3f, float)
    test('vector3LerpTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const b = Vector3(4.0, 5.0, 6.0);

      const t = 0.5;

      const expected = Vector3(2.5, 3.5, 4.5);

      final actual = a.lerp(b, t);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector3f, Vector3f, float)
    // Lerp test with factor zero
    test('vector3LerpTest1', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const b = Vector3(4.0, 5.0, 6.0);

      const t = 0.0;
      const expected = Vector3(1.0, 2.0, 3.0);
      final actual = a.lerp(b, t);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector3f, Vector3f, float)
    // Lerp test with factor one
    test('vector3LerpTest2', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const b = Vector3(4.0, 5.0, 6.0);

      const t = 1.0;
      const expected = Vector3(4.0, 5.0, 6.0);
      final actual = a.lerp(b, t);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector3f, Vector3f, float)
    // Lerp test with factor > 1
    test('vector3LerpTest3', () {
      const a = Vector3(0.0, 0.0, 0.0);
      const b = Vector3(4.0, 5.0, 6.0);

      const t = 2.0;
      const expected = Vector3(8.0, 10.0, 12.0);
      final actual = a.lerp(b, t);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector3f, Vector3f, float)
    // Lerp test with factor < 0
    test('vector3LerpTest4', () {
      const a = Vector3(0.0, 0.0, 0.0);
      const b = Vector3(4.0, 5.0, 6.0);

      const t = -2.0;
      const expected = Vector3(-8.0, -10.0, -12.0);
      final actual = a.lerp(b, t);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector3f, Vector3f, float)
    // Lerp test from the same point
    test('vector3LerpTest5', () {
      const a = Vector3(1.68, 2.34, 5.43);
      const b = a;

      const t = 0.18;
      const expected = Vector3(1.68, 2.34, 5.43);
      final actual = a.lerp(b, t);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Lerp did not return the expected value.");
    });

    // A test for Reflect (Vector3f, Vector3f)
    test('vector3ReflectTest', () {
      final a = const Vector3(1.0, 1.0, 1.0).normalize();

      // Reflect on XZ plane.
      var n = const Vector3(0.0, 1.0, 0.0);
      var expected = Vector3(a.x, -a.y, a.z);
      var actual = a.reflect(n);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Reflect did not return the expected value.");

      // Reflect on XY plane.
      n = const Vector3(0.0, 0.0, 1.0);
      expected = Vector3(a.x, a.y, -a.z);
      actual = a.reflect(n);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Reflect did not return the expected value.");

      // Reflect on YZ plane.
      n = const Vector3(1.0, 0.0, 0.0);
      expected = Vector3(-a.x, a.y, a.z);
      actual = a.reflect(n);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Reflect did not return the expected value.");
    });

    // A test for Reflect (Vector3f, Vector3f)
    // Reflection when normal and source are the same
    test('vector3ReflectTest1', () {
      var n = const Vector3(0.45, 1.28, 0.86);
      n = n.normalize();
      final a = n;

      final expected = -n;
      final actual = a.reflect(n);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Reflect did not return the expected value.");
    });

    // A test for Reflect (Vector3f, Vector3f)
    // Reflection when normal and source are negation
    test('vector3ReflectTest2', () {
      var n = const Vector3(0.45, 1.28, 0.86);
      n = n.normalize();
      final a = -n;

      final expected = n;
      final actual = a.reflect(n);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Reflect did not return the expected value.");
    });

    // A test for Reflect (Vector3f, Vector3f)
    // Reflection when normal and source are perpendicular (a dot n = 0)
    test('vector3ReflectTest3', () {
      const n = Vector3(0.45, 1.28, 0.86);
      const temp = Vector3(1.28, 0.45, 0.01);
      // find a perpendicular vector of n
      final a = temp.cross(n);

      final expected = a;
      final actual = a.reflect(n);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Reflect did not return the expected value.");
    });

    // A test for Transform(Vector3f, Matrix4x4)
    test('vector3TransformTest', () {
      const v = Vector3(1.0, 2.0, 3.0);
      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));
      // m.M41 = 10.0;
      // m.M42 = 20.0;
      // m.M43 = 30.0;

      const expected = Vector3(12.191987, 21.533493, 32.616024);

      final actual = v.transform(m);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Transform did not return the expected value.");
    });

    // A test for Clamp (Vector3f, Vector3f, Vector3f)
    test('vector3ClampTest', () {
      var a = const Vector3(0.5, 0.3, 0.33);
      var min = const Vector3(0.0, 0.1, 0.13);
      var max = const Vector3(1.0, 1.1, 1.13);

      // Normal case.
      // Case N1: specified value is in the range.
      var expected = const Vector3(0.5, 0.3, 0.33);
      var actual = a.clamp(min, max);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Clamp did not return the expected value.");

      // Normal case.
      // Case N2: specified value is bigger than max value.
      a = const Vector3(2.0, 3.0, 4.0);
      expected = max;
      actual = a.clamp(min, max);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Clamp did not return the expected value.");

      // Case N3: specified value is smaller than max value.
      a = const Vector3(-2.0, -3.0, -4.0);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Clamp did not return the expected value.");

      // Case N4: combination case.
      a = const Vector3(-2.0, 0.5, 4.0);
      expected = Vector3(min.x, a.y, max.z);
      actual = a.clamp(min, max);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Clamp did not return the expected value.");

      // User specified min value is bigger than max value.
      max = const Vector3(0.0, 0.1, 0.13);
      min = const Vector3(1.0, 1.1, 1.13);

      // Case W1: specified value is in the range.
      a = const Vector3(0.5, 0.3, 0.33);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Clamp did not return the expected value.");

      // Normal case.
      // Case W2: specified value is bigger than max and min value.
      a = const Vector3(2.0, 3.0, 4.0);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Clamp did not return the expected value.");

      // Case W3: specified value is smaller than min and max value.
      a = const Vector3(-2.0, -3.0, -4.0);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Clamp did not return the expected value.");
    });

    // A test for TransformNormal (Vector3f, Matrix4x4)
    test('vector3TransformNormalTest', () {
      const v = Vector3(1.0, 2.0, 3.0);
      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));
      // m.M41 = 10.0;
      // m.M42 = 20.0;
      // m.M43 = 30.0;

      const expected = Vector3(2.1919873, 1.5334936, 2.6160254);

      final actual = v.transformNormal(m);
      expect(equalVector3(expected, actual), true,
          reason:
              "Vector3f.TransformNormal did not return the expected value.");
    });

    // A test for Transform (Vector3f, Quaternion)
    test('vector3TransformByQuaternionTest', () {
      const v = Vector3(1.0, 2.0, 3.0);

      final m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      final q = Quaternion.fromRotationMatrix(m);

      final expected = v.transform(m);
      final actual = v.transformByQuaternion(q);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Quaternion)
    // Transform vector3 with zero quaternion
    test('vector3TransformByQuaternionTest1', () {
      const v = Vector3(1.0, 2.0, 3.0);
      const q = Quaternion.zero;
      const expected = v;

      final actual = v.transformByQuaternion(q);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Quaternion)
    // Transform vector3 with identity quaternion
    test('vector3TransformByQuaternionTest2', () {
      const v = Vector3(1.0, 2.0, 3.0);
      const q = Quaternion.identity;
      const expected = v;

      final actual = v.transformByQuaternion(q);
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Transform did not return the expected value.");
    });

    // A test for Normalize (Vector3f)
    test('vector3NormalizeTest', () {
      const a = Vector3(1.0, 2.0, 3.0);

      const expected = Vector3(0.26726124, 0.5345225, 0.80178374);

      final actual = a.normalize();
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Normalize did not return the expected value.");
    });

    // A test for Normalize (Vector3f)
    // Normalize vector of length one
    test('vector3NormalizeTest1', () {
      const a = Vector3(1.0, 0.0, 0.0);

      const expected = Vector3(1.0, 0.0, 0.0);
      final actual = a.normalize();
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.Normalize did not return the expected value.");
    });

    // A test for Normalize (Vector3f)
    // Normalize vector of length zero
    test('vector3NormalizeTest2', () {
      const a = Vector3(0.0, 0.0, 0.0);

      //const expected = Vector3(0.0, 0.0, 0.0);
      final actual = a.normalize();
      expect(actual.x.isNaN && actual.y.isNaN && actual.z.isNaN, true,
          reason: "Vector3f.Normalize did not return the expected value.");
    });

    // A test for operator - (Vector3f)
    test('vector3UnaryNegationTest', () {
      const a = Vector3(1.0, 2.0, 3.0);

      const expected = Vector3(-1.0, -2.0, -3.0);

      final actual = -a;

      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.operator - did not return the expected value.");
    });

    test('vector3UnaryNegationTest1', () {
      final a =
          -const Vector3(double.nan, double.infinity, double.negativeInfinity);
      final b = -const Vector3(0.0, 0.0, 0.0);
      expect(a.x.isNaN, true);
      expect(a.y.isInfinite && a.y.isNegative, true);
      expect(a.z.isInfinite, true);
      expect(b.x, 0.0);
      expect(b.y, 0.0);
      expect(b.z, 0.0);
    });

    // A test for operator - (Vector3f, Vector3f)
    test('vector3SubtractionTest', () {
      const a = Vector3(4.0, 2.0, 3.0);

      const b = Vector3(1.0, 5.0, 7.0);

      const expected = Vector3(3.0, -3.0, -4.0);

      final actual = a - b;

      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.operator - did not return the expected value.");
    });

    // A test for operator * (Vector3f, float)
    test('vector3MultiplyOperatorTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const factor = 2.0;
      const expected = Vector3(2.0, 4.0, 6.0);
      final actual = a * factor;
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.operator * did not return the expected value.");
    });

    // A test for operator * (float, Vector3f)
    // test('vector3MultiplyOperatorTest2', () {
    //   const a = Vector3(1.0, 2.0, 3.0);
    //   const factor = 2.0;
    //   const expected = Vector3(2.0, 4.0, 6.0);
    //   final actual = factor * a;
    //   expect(equalVector3(expected, actual), true,
    //       reason: "Vector3f.operator * did not return the expected value.");
    // });

    // A test for operator * (Vector3f, Vector3f)
    test('vector3MultiplyOperatorTest3', () {
      const a = Vector3(1.0, 2.0, 3.0);

      const b = Vector3(4.0, 5.0, 6.0);

      const expected = Vector3(4.0, 10.0, 18.0);

      final actual = a * b;

      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.operator * did not return the expected value.");
    });

    // A test for operator / (Vector3f, float)
    test('vector3DivisionTest', () {
      const a = Vector3(1.0, 2.0, 3.0);

      const div = 2.0;

      const expected = Vector3(0.5, 1.0, 1.5);

      final actual = a / div;

      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.operator / did not return the expected value.");
    });

    // A test for operator / (Vector3f, Vector3f)
    test('vector3DivisionTest1', () {
      const a = Vector3(4.0, 2.0, 3.0);

      const b = Vector3(1.0, 5.0, 6.0);

      const expected = Vector3(4.0, 0.4, 0.5);

      final actual = a / b;

      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.operator / did not return the expected value.");
    });

    // A test for operator / (Vector3f, Vector3f)
    // Divide by zero
    test('vector3DivisionTest2', () {
      const a = Vector3(-2.0, 3.0, double.maxFinite);
      const div = 0.0;
      final actual = a / div;
      final isNegativeInfinity = actual.x.isInfinite && actual.x.isNegative;
      final isPositiveInfinity = actual.y.isInfinite && !actual.y.isNegative;
      final isZPositiveInfinity = actual.z.isInfinite && !actual.z.isNegative;
      expect(isNegativeInfinity, true,
          reason: "Vector3f.operator / did not return the expected value.");
      expect(isPositiveInfinity, true,
          reason: "Vector3f.operator / did not return the expected value.");
      expect(isZPositiveInfinity, true,
          reason: "Vector3f.operator / did not return the expected value.");
    });

    // A test for operator / (Vector3f, Vector3f)
    // Divide by zero
    test('vector3DivisionTest3', () {
      const a = Vector3(0.047, -3.0, double.negativeInfinity);
      const b = Vector3.zero;

      final actual = a / b;
      final isPositiveInfinity = actual.x.isInfinite && !actual.x.isNegative;
      final isNegativeInfinity = actual.y.isInfinite && actual.y.isNegative;
      final isZNegativeInfinity = actual.z.isInfinite && actual.z.isNegative;
      expect(isPositiveInfinity, true,
          reason: "Vector3f.operator / did not return the expected value.");
      expect(isNegativeInfinity, true,
          reason: "Vector3f.operator / did not return the expected value.");
      expect(isZNegativeInfinity, true,
          reason: "Vector3f.operator / did not return the expected value.");
    });

    // A test for operator + (Vector3f, Vector3f)
    test('vector3AdditionTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const b = Vector3(4.0, 5.0, 6.0);
      const expected = Vector3(5.0, 7.0, 9.0);
      final actual = a + b;
      expect(equalVector3(expected, actual), true,
          reason: "Vector3f.operator + did not return the expected value.");
    });

    // A test for Vector3f (float, float, float)
    test('vector3ConstructorTest', () {
      const x = 1.0;
      const y = 2.0;
      const z = 3.0;

      const target = Vector3(x, y, z);
      expect(
          equalDouble(target.x, x) &&
              equalDouble(target.y, y) &&
              equalDouble(target.z, z),
          true,
          reason:
              "Vector3f.constructor (x,y,z) did not return the expected value.");
    });

    // A test for Vector3f (Vector2f, float)
    test('vector3ConstructorTest1', () {
      const a = Vector2(1.0, 2.0);

      const z = 3.0;

      final target = Vector3.fromVector2(a, z);
      expect(
          equalDouble(target.x, a.x) &&
              equalDouble(target.y, a.y) &&
              equalDouble(target.z, z),
          true,
          reason:
              "Vector3f.constructor (Vector2f,z) did not return the expected value.");
    });

    // A test for Vector3f ()
    // Constructor with no parameter
    test('vector3ConstructorTest3', () {
      const a = Vector3.zero;

      expect(a.x, 0.0);
      expect(a.y, 0.0);
      expect(a.z, 0.0);
    });

    // A test for Vector2f (float, float)
    // Constructor with special floating values
    test('vector3ConstructorTest4', () {
      const target = Vector3(double.nan, double.maxFinite, double.infinity);
      final isPositiveInfinity = target.z.isInfinite && !target.z.isNegative;
      expect(target.x.isNaN, true,
          reason:
              "Vector3f.constructor (Vector3f) did not return the expected value.");
      expect(target.y == double.maxFinite, true,
          reason:
              "Vector3f.constructor (Vector3f) did not return the expected value.");
      expect(isPositiveInfinity, true,
          reason:
              "Vector3f.constructor (Vector3f) did not return the expected value.");
    });

    // A test for Add (Vector3f, Vector3f)
    test('vector3AddTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const b = Vector3(5.0, 6.0, 7.0);

      const expected = Vector3(6.0, 8.0, 10.0);

      final actual = a.add(b);
      expect(actual, expected);
    });

    // A test for Divide (Vector3f, float)
    test('vector3DivideTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const div = 2.0;
      const expected = Vector3(0.5, 1.0, 1.5);
      expect(a / div, expected);
    });

    // A test for Divide (Vector3f, Vector3f)
    test('vector3DivideTest1', () {
      const a = Vector3(1.0, 6.0, 7.0);
      const b = Vector3(5.0, 2.0, 3.0);

      const expected = Vector3(1.0 / 5.0, 6.0 / 2.0, 7.0 / 3.0);

      final actual = a.divide(b);
      expect(actual, expected);
    });

    // A test for Equals (object)
    test('vector3EqualsTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      var b = const Vector3(1.0, 2.0, 3.0);

      // case 1: compare between same values
      Object? obj = b;

      var expected = true;
      var actual = a == obj;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.setX(10.0);
      obj = b;
      expected = false;
      actual = a == obj;
      expect(actual, expected);

      // case 3: compare between different types.
      obj = Quaternion.zero;
      expected = false;
      actual = a == obj;
      expect(actual, expected);

      // case 3: compare against null.
      obj = null;
      expected = false;
      actual = a == obj;
      expect(actual, expected);
    });

    // A test for Multiply (Vector3f, float)
    test('vector3MultiplyTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const factor = 2.0;
      const expected = Vector3(2.0, 4.0, 6.0);
      expect(a * factor, expected);
    });

    // A test for Multiply (float, Vector3f)
    // test('vector3MultiplyTest2', () {
    //   const a = Vector3(1.0, 2.0, 3.0);
    //   const factor = 2.0;
    //   const expected = Vector3(2.0, 4.0, 6.0);
    //   expect(factor * a, expected);
    // });

    // A test for Multiply (Vector3f, Vector3f)
    test('vector3MultiplyTest3', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const b = Vector3(5.0, 6.0, 7.0);
      const expected = Vector3(5.0, 12.0, 21.0);
      final actual = a.multiply(b);
      expect(actual, expected);
    });

    // A test for Negate (Vector3f)
    test('vector3NegateTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const expected = Vector3(-1.0, -2.0, -3.0);
      final actual = a.negate();
      expect(actual, expected);
    });

    // A test for operator != (Vector3f, Vector3f)
    test('vector3InequalityTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      var b = const Vector3(1.0, 2.0, 3.0);

      // case 1: compare between same values
      var expected = false;
      var actual = a != b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.setX(10.0);
      expected = true;
      actual = a != b;
      expect(actual, expected);
    });

    // A test for operator == (Vector3f, Vector3f)
    test('vector3EqualityTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      var b = const Vector3(1.0, 2.0, 3.0);

      // case 1: compare between same values
      var expected = true;
      var actual = a == b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.setX(10.0);
      expected = false;
      actual = a == b;
      expect(actual, expected);
    });

    // A test for Subtract (Vector3f, Vector3f)
    test('vector3SubtractTest', () {
      const a = Vector3(1.0, 6.0, 3.0);
      const b = Vector3(5.0, 2.0, 3.0);

      const expected = Vector3(-4.0, 4.0, 0.0);

      final actual = a.subtract(b);
      expect(actual, expected);
    });

    // A test for One
    test('vector3OneTest', () {
      const val = Vector3(1.0, 1.0, 1.0);
      expect(val, Vector3.one);
    });

    // A test for UnitX
    test('vector3UnitXTest', () {
      const val = Vector3(1.0, 0.0, 0.0);
      expect(val, Vector3.unitX);
    });

    // A test for UnitY
    test('vector3UnitYTest', () {
      const val = Vector3(0.0, 1.0, 0.0);
      expect(val, Vector3.unitY);
    });

    // A test for UnitZ
    test('vector3UnitZTest', () {
      const val = Vector3(0.0, 0.0, 1.0);
      expect(val, Vector3.unitZ);
    });

    // A test for Zero
    test('vector3ZeroTest', () {
      const val = Vector3(0.0, 0.0, 0.0);
      expect(val, Vector3.zero);
    });

    // A test for Equals (Vector3f)
    test('vector3EqualsTest1', () {
      const a = Vector3(1.0, 2.0, 3.0);
      var b = const Vector3(1.0, 2.0, 3.0);

      // case 1: compare between same values
      var expected = true;
      var actual = a == b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.setX(10.0);
      expected = false;
      actual = a == b;
      expect(actual, expected);
    });

    // A test for Vector3f (float)
    test('vector3ConstructorTest5', () {
      var value = 1.0;
      var target = Vector3.value(value);

      var expected = Vector3(value, value, value);
      expect(target, expected);

      value = 2.0;
      target = Vector3.value(value);
      expected = Vector3(value, value, value);
      expect(target, expected);
    });

    // A test for Vector3f comparison involving NaN values
    test('vector3EqualsNanTest', () {
      const a = Vector3(double.nan, 0, 0);
      const b = Vector3(0, double.nan, 0);
      const c = Vector3(0, 0, double.nan);

      expect(a == Vector3.zero, false);
      expect(b == Vector3.zero, false);
      expect(c == Vector3.zero, false);

      expect(a != Vector3.zero, true);
      expect(b != Vector3.zero, true);
      expect(c != Vector3.zero, true);

      expect(a == Vector3.zero, false);
      expect(b == Vector3.zero, false);
      expect(c == Vector3.zero, false);

      // Counterintuitive result - IEEE rules for NaN comparison are weird!
      expect(a == a, false);
      expect(b == b, false);
      expect(c == c, false);
    });

    test('vector3AbsTest', () {
      const v1 = Vector3(-2.5, 2.0, 0.5);
      final v3 = const Vector3(0.0, double.negativeInfinity, double.nan).abs();
      final v = v1.abs();
      expect(2.5, v.x);
      expect(2.0, v.y);
      expect(0.5, v.z);
      expect(0.0, v3.x);
      expect(v3.y.isInfinite, true);
      expect(v3.z.isNaN, true);
    });

    test('vector3SqrtTest', () {
      const a = Vector3(-2.5, 2.0, 0.5);
      const b = Vector3(5.5, 4.5, 16.5);
      expect(2, b.squareRoot().x.toInt());
      expect(2, b.squareRoot().y.toInt());
      expect(4, b.squareRoot().z.toInt());
      expect(a.squareRoot().x.isNaN, true);
    });
  });

  group('Vector4Tests', () {
    // test('vector4MarshalSizeTest', () {
    //   expect(true, true);
    // });

    test('vector4GetHashCodeTest', () {
      const v1 = Vector4(2.5, 2.0, 3.0, 3.3);
      const v2 = Vector4(2.5, 2.0, 3.0, 3.3);
      const v3 = Vector4(2.5, 2.0, 3.0, 3.3);
      const v5 = Vector4(3.3, 3.0, 2.0, 2.5);
      expect(v1.hashCode == v1.hashCode, true);
      expect(v1.hashCode == v2.hashCode, true);
      expect(v1.hashCode == v5.hashCode, false);
      expect(v1.hashCode == v3.hashCode, true);
      const v4 = Vector4(0.0, 0.0, 0.0, 0.0);
      const v6 = Vector4(1.0, 0.0, 0.0, 0.0);
      const v7 = Vector4(0.0, 1.0, 0.0, 0.0);
      const v8 = Vector4(1.0, 1.0, 1.0, 1.0);
      const v9 = Vector4(1.0, 1.0, 0.0, 0.0);
      expect(v4.hashCode == v6.hashCode, false);
      expect(v4.hashCode == v7.hashCode, false);
      expect(v4.hashCode == v8.hashCode, false);
      expect(v7.hashCode == v6.hashCode, false);
      expect(v8.hashCode == v6.hashCode, false);
      expect(v8.hashCode == v7.hashCode, false);
      expect(v9.hashCode == v7.hashCode, false);
    });

    // A test for DistanceSquared (Vector4f, Vector4f)
    test('vector4DistanceSquaredTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const b = Vector4(5.0, 6.0, 7.0, 8.0);

      const expected = 64.0;
      final actual = a.distanceSquared(b);
      expect(equalDouble(expected, actual), true,
          reason:
              "Vector4f.DistanceSquared did not return the expected value.");
    });

    // A test for Distance (Vector4f, Vector4f)
    test('vector4DistanceTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const b = Vector4(5.0, 6.0, 7.0, 8.0);

      const expected = 8.0;

      final actual = a.distance(b);
      expect(equalDouble(expected, actual), true,
          reason: "Vector4f.Distance did not return the expected value.");
    });

    // A test for Distance (Vector4f, Vector4f)
    // Distance from the same point
    test('vector4DistanceTest1', () {
      final a = Vector4.fromVector2(const Vector2(1.051, 2.05), 3.478, 1.0);
      var b = Vector4.fromVector3(const Vector3(1.051, 2.05, 3.478), 0.0);
      b = b.setW(1.0);

      final actual = a.distance(b);
      expect(0.0, actual);
    });

    // A test for Dot (Vector4f, Vector4f)
    test('vector4DotTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const b = Vector4(5.0, 6.0, 7.0, 8.0);

      const expected = 70.0;

      final actual = a.dot(b);
      expect(equalDouble(expected, actual), true,
          reason: "Vector4f.Dot did not return the expected value.");
    });

    // A test for Dot (Vector4f, Vector4f)
    // Dot test for perpendicular vector
    test('vector4DotTest1', () {
      const a = Vector3(1.55, 1.55, 1);
      const b = Vector3(2.5, 3, 1.5);
      final c = a.cross(b);

      final d = Vector4.fromVector3(a, 0);
      final e = Vector4.fromVector3(c, 0);

      final actual = d.dot(e);
      expect(equalDouble(0.0, actual), true,
          reason: "Vector4f.Dot did not return the expected value.");
    });

    // A test for Length ()
    test('vector4LengthTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const w = 4.0;

      final target = Vector4.fromVector3(a, w);

      final expected = math.sqrt(30.0);

      final actual = target.length;

      expect(equalDouble(expected, actual), true,
          reason: "Vector4f.Length did not return the expected value.");
    });

    // A test for Length ()
    // Length test where length is zero
    test('vector4LengthTest1', () {
      const target = Vector4.zero;

      const expected = 0.0;
      final actual = target.length;

      expect(equalDouble(expected, actual), true,
          reason: "Vector4f.Length did not return the expected value.");
    });

    // A test for LengthSquared ()
    test('vector4LengthSquaredTest', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const w = 4.0;

      final target = Vector4.fromVector3(a, w);

      double expected = 30.0;

      final actual = target.lengthSquared;

      expect(equalDouble(expected, actual), true,
          reason: "Vector4f.LengthSquared did not return the expected value.");
    });

    // A test for Min (Vector4f, Vector4f)
    test('vector4MinTest', () {
      const a = Vector4(-1.0, 4.0, -3.0, 1000.0);
      const b = Vector4(2.0, 1.0, -1.0, 0.0);

      const expected = Vector4(-1.0, 1.0, -3.0, 0.0);

      final actual = a.min(b);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Min did not return the expected value.");
    });

    // A test for Max (Vector4f, Vector4f)
    test('vector4MaxTest', () {
      const a = Vector4(-1.0, 4.0, -3.0, 1000.0);
      const b = Vector4(2.0, 1.0, -1.0, 0.0);

      const expected = Vector4(2.0, 4.0, -1.0, 1000.0);

      final actual = a.max(b);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Max did not return the expected value.");
    });

    test('vector4MinMaxCodeCoverageTest', () {
      const min = Vector4.zero;
      const max = Vector4.one;

      // Min.
      var actual = min.min(max);
      expect(actual, min);

      actual = max.min(min);
      expect(actual, min);

      // Max.
      actual = min.max(max);
      expect(actual, max);

      actual = max.max(min);
      expect(actual, max);
    });

    // A test for Clamp (Vector4f, Vector4f, Vector4f)
    test('vector4ClampTest', () {
      var a = const Vector4(0.5, 0.3, 0.33, 0.44);
      var min = const Vector4(0.0, 0.1, 0.13, 0.14);
      var max = const Vector4(1.0, 1.1, 1.13, 1.14);

      // Normal case.
      // Case N1: specified value is in the range.
      var expected = const Vector4(0.5, 0.3, 0.33, 0.44);
      var actual = a.clamp(min, max);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Clamp did not return the expected value.");

      // Normal case.
      // Case N2: specified value is bigger than max value.
      a = const Vector4(2.0, 3.0, 4.0, 5.0);
      expected = max;
      actual = a.clamp(min, max);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Clamp did not return the expected value.");

      // Case N3: specified value is smaller than max value.
      a = const Vector4(-2.0, -3.0, -4.0, -5.0);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Clamp did not return the expected value.");

      // Case N4: combination case.
      a = const Vector4(-2.0, 0.5, 4.0, -5.0);
      expected = Vector4(min.x, a.y, max.z, min.w);
      actual = a.clamp(min, max);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Clamp did not return the expected value.");

      // User specified min value is bigger than max value.
      max = const Vector4(0.0, 0.1, 0.13, 0.14);
      min = const Vector4(1.0, 1.1, 1.13, 1.14);

      // Case W1: specified value is in the range.
      a = const Vector4(0.5, 0.3, 0.33, 0.44);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Clamp did not return the expected value.");

      // Normal case.
      // Case W2: specified value is bigger than max and min value.
      a = const Vector4(2.0, 3.0, 4.0, 5.0);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Clamp did not return the expected value.");

      // Case W3: specified value is smaller than min and max value.
      a = const Vector4(-2.0, -3.0, -4.0, -5.0);
      expected = min;
      actual = a.clamp(min, max);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Clamp did not return the expected value.");
    });

    // A test for Lerp (Vector4f, Vector4f, float)
    test('vector4LerpTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const b = Vector4(5.0, 6.0, 7.0, 8.0);

      const t = 0.5;

      const expected = Vector4(3.0, 4.0, 5.0, 6.0);

      final actual = a.lerp(b, t);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector4f, Vector4f, float)
    // Lerp test with factor zero
    test('vector4LerpTest1', () {
      final a = Vector4.fromVector3(const Vector3(1.0, 2.0, 3.0), 4.0);
      const b = Vector4(4.0, 5.0, 6.0, 7.0);

      const t = 0.0;
      const expected = Vector4(1.0, 2.0, 3.0, 4.0);
      final actual = a.lerp(b, t);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector4f, Vector4f, float)
    // Lerp test with factor one
    test('vector4LerpTest2', () {
      final a = Vector4.fromVector3(const Vector3(1.0, 2.0, 3.0), 4.0);
      const b = Vector4(4.0, 5.0, 6.0, 7.0);

      const t = 1.0;
      const expected = Vector4(4.0, 5.0, 6.0, 7.0);
      final actual = a.lerp(b, t);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector4f, Vector4f, float)
    // Lerp test with factor > 1
    test('vector4LerpTest3', () {
      final a = Vector4.fromVector3(const Vector3(0.0, 0.0, 0.0), 0.0);
      const b = Vector4(4.0, 5.0, 6.0, 7.0);

      const t = 2.0;
      const expected = Vector4(8.0, 10.0, 12.0, 14.0);
      final actual = a.lerp(b, t);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector4f, Vector4f, float)
    // Lerp test with factor < 0
    test('vector4LerpTest4', () {
      final a = Vector4.fromVector3(const Vector3(0.0, 0.0, 0.0), 0.0);
      const b = Vector4(4.0, 5.0, 6.0, 7.0);

      const t = -2.0;
      final expected = -(b * 2);
      final actual = a.lerp(b, t);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Lerp did not return the expected value.");
    });

    // A test for Lerp (Vector4f, Vector4f, float)
    // Lerp test from the same point
    test('vector4LerpTest5', () {
      const a = Vector4(4.0, 5.0, 6.0, 7.0);
      const b = Vector4(4.0, 5.0, 6.0, 7.0);

      const t = 0.85;
      const expected = a;
      final actual = a.lerp(b, t);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Lerp did not return the expected value.");
    });

    // A test for Transform (Vector2f, Matrix4x4)
    test('vector4TransformTest1', () {
      const v = Vector2(1.0, 2.0);

      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));
      // m.M41 = 10.0;
      // m.M42 = 20.0;
      // m.M43 = 30.0;

      const expected = Vector4(10.316987, 22.183012, 30.366026, 1.0);

      final actual = v.transformToVector4(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Matrix4x4)
    test('vector4TransformTest2', () {
      const v = Vector3(1.0, 2.0, 3.0);

      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));
      // m.M41 = 10.0;
      // m.M42 = 20.0;
      // m.M43 = 30.0;

      const expected = Vector4(12.191987, 21.533493, 32.616024, 1.0);

      final actual = v.transformToVector4(m);
      expect(equalVector4(expected, actual), true,
          reason: "MathOps.Transform did not return the expected value.");
    });

    // A test for Transform (Vector4f, Matrix4x4)
    test('vector4TransformVector4Test', () {
      var v = const Vector4(1.0, 2.0, 3.0, 0.0);

      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));
      // m.M41 = 10.0;
      // m.M42 = 20.0;
      // m.M43 = 30.0;

      var expected = const Vector4(2.1919873, 1.5334938, 2.6160254, 0.0);

      var actual = v.transform(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");

      //
      v = v.setW(1.0);

      expected = const Vector4(12.191987, 21.533493, 32.616024, 1.0);
      actual = v.transform(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector4f, Matrix4x4)
    // Transform vector4 with zero matrix
    test('vector4TransformVector4Test1', () {
      const v = Vector4(1.0, 2.0, 3.0, 0.0);
      const m = Matrix4x4.zero;
      const expected = Vector4(0, 0, 0, 0);

      final actual = v.transform(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector4f, Matrix4x4)
    // Transform vector4 with identity matrix
    test('vector4TransformVector4Test2', () {
      const v = Vector4(1.0, 2.0, 3.0, 0.0);
      const m = Matrix4x4.identity;
      const expected = Vector4(1.0, 2.0, 3.0, 0.0);

      final actual = v.transform(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Matrix4x4)
    // Transform Vector3f test
    test('vector4TransformVector3Test', () {
      const v = Vector3(1.0, 2.0, 3.0);

      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));
      // m.M41 = 10.0;
      // m.M42 = 20.0;
      // m.M43 = 30.0;

      final expected = Vector4.fromVector3(v, 1.0).transform(m);
      final actual = v.transformToVector4(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Matrix4x4)
    // Transform vector3 with zero matrix
    test('vector4TransformVector3Test1', () {
      const v = Vector3(1.0, 2.0, 3.0);
      const m = Matrix4x4.zero;
      const expected = Vector4(0, 0, 0, 0);

      final actual = v.transformToVector4(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Matrix4x4)
    // Transform vector3 with identity matrix
    test('vector4TransformVector3Test2', () {
      const v = Vector3(1.0, 2.0, 3.0);
      const m = Matrix4x4.identity;
      const expected = Vector4(1.0, 2.0, 3.0, 1.0);

      final actual = v.transformToVector4(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector2f, Matrix4x4)
    // Transform Vector2f test
    test('vector4TransformVector2Test', () {
      const v = Vector2(1.0, 2.0);

      var m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      m = m.setTranslation(const Vector3(10.0, 20.0, 30.0));
      // m.M41 = 10.0;
      // m.M42 = 20.0;
      // m.M43 = 30.0;

      final expected = Vector4.fromVector2(v, 0.0, 1.0).transform(m);
      final actual = v.transformToVector4(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector2f, Matrix4x4)
    // Transform Vector2f with zero matrix
    test('vector4TransformVector2Test1', () {
      const v = Vector2(1.0, 2.0);
      const m = Matrix4x4.zero;
      const expected = Vector4(0, 0, 0, 0);

      final actual = v.transformToVector4(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector2f, Matrix4x4)
    // Transform vector2 with identity matrix
    test('vector4TransformVector2Test2', () {
      const v = Vector2(1.0, 2.0);
      const m = Matrix4x4.identity;
      const expected = Vector4(1.0, 2.0, 0, 1.0);

      final actual = v.transformToVector4(m);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector2f, Quaternion)
    test('vector4TransformVector2QuatanionTest', () {
      const v = Vector2(1.0, 2.0);
      final m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      final q = Quaternion.fromRotationMatrix(m);
      final expected = v.transformToVector4(m);
      final actual = v.transformToVector4ByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Quaternion)
    test('vector4TransformVector3Quaternion', () {
      const v = Vector3(1.0, 2.0, 3.0);

      final m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      final q = Quaternion.fromRotationMatrix(m);

      final expected = v.transformToVector4(m);
      final actual = v.transformToVector4ByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "MathOps.Transform did not return the expected value.");
    });

    // A test for Transform (Vector4f, Quaternion)
    test('vector4TransformVector4QuaternionTest', () {
      var v = const Vector4(1.0, 2.0, 3.0, 0.0);

      final m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      final q = Quaternion.fromRotationMatrix(m);

      var expected = v.transform(m);

      var actual = v.transformByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");

      //
      v = v.setW(1.0);
      expected = expected.setW(1.0);
      actual = v.transformByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector4f, Quaternion)
    // Transform vector4 with zero quaternion
    test('vector4TransformVector4QuaternionTest1', () {
      const v = Vector4(1.0, 2.0, 3.0, 0.0);
      const q = Quaternion.zero;
      const expected = v;

      final actual = v.transformByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector4f, Quaternion)
    // Transform vector4 with identity matrix
    test('vector4TransformVector4QuaternionTest2', () {
      const v = Vector4(1.0, 2.0, 3.0, 0.0);
      const q = Quaternion.identity;
      const expected = Vector4(1.0, 2.0, 3.0, 0.0);

      final actual = v.transformByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Quaternion)
    // Transform Vector3f test
    test('vector4TransformVector3QuaternionTest', () {
      const v = Vector3(1.0, 2.0, 3.0);

      final m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      final q = Quaternion.fromRotationMatrix(m);

      final expected = v.transformToVector4(m);
      final actual = v.transformToVector4ByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Quaternion)
    // Transform vector3 with zero quaternion
    test('vector4TransformVector3QuaternionTest1', () {
      const v = Vector3(1.0, 2.0, 3.0);
      const q = Quaternion.zero;
      final expected = Vector4.fromVector3(v, 1.0);

      final actual = v.transformToVector4ByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector3f, Quaternion)
    // Transform vector3 with identity quaternion
    test('vector4TransformVector3QuaternionTest2', () {
      const v = Vector3(1.0, 2.0, 3.0);
      const q = Quaternion.identity;
      const expected = Vector4(1.0, 2.0, 3.0, 1.0);

      final actual = v.transformToVector4ByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector2f, Quaternion)
    // Transform Vector2f by quaternion test
    test('vector4TransformVector2QuaternionTest', () {
      const v = Vector2(1.0, 2.0);

      final m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      final q = Quaternion.fromRotationMatrix(m);

      final expected = v.transformToVector4(m);
      final actual = v.transformToVector4ByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector2f, Quaternion)
    // Transform Vector2f with zero quaternion
    test('vector4TransformVector2QuaternionTest1', () {
      const v = Vector2(1.0, 2.0);
      const q = Quaternion.zero;
      const expected = Vector4(1.0, 2.0, 0, 1.0);

      final actual = v.transformToVector4ByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Transform (Vector2f, Matrix4x4)
    // Transform vector2 with identity Quaternion
    test('vector4TransformVector2QuaternionTest2', () {
      const v = Vector2(1.0, 2.0);
      const q = Quaternion.identity;
      const expected = Vector4(1.0, 2.0, 0, 1.0);

      final actual = v.transformToVector4ByQuaternion(q);
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Transform did not return the expected value.");
    });

    // A test for Normalize (Vector4f)
    test('vector4NormalizeTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const expected = Vector4(0.18257418, 0.36514837, 0.5477226, 0.73029673);

      final actual = a.normalize();
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Normalize did not return the expected value.");
    });

    // A test for Normalize (Vector4f)
    // Normalize vector of length one
    test('vector4NormalizeTest1', () {
      const a = Vector4(1.0, 0.0, 0.0, 0.0);

      const expected = Vector4(1.0, 0.0, 0.0, 0.0);
      final actual = a.normalize();
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.Normalize did not return the expected value.");
    });

    // A test for Normalize (Vector4f)
    // Normalize vector of length zero
    test('vector4NormalizeTest2', () {
      const a = Vector4(0.0, 0.0, 0.0, 0.0);

      //const expected = Vector4(0.0, 0.0, 0.0, 0.0);
      final actual = a.normalize();
      expect(
          actual.x.isNaN && actual.y.isNaN && actual.z.isNaN && actual.w.isNaN,
          true,
          reason: "Vector4f.Normalize did not return the expected value.");
    });

    // A test for operator - (Vector4f)
    test('vector4UnaryNegationTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);

      const expected = Vector4(-1.0, -2.0, -3.0, -4.0);

      final actual = -a;

      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.operator - did not return the expected value.");
    });

    // A test for operator - (Vector4f, Vector4f)
    test('vector4SubtractionTest', () {
      const a = Vector4(1.0, 6.0, 3.0, 4.0);
      const b = Vector4(5.0, 2.0, 3.0, 9.0);

      const expected = Vector4(-4.0, 4.0, 0.0, -5.0);
      final actual = a - b;

      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.operator - did not return the expected value.");
    });

    // A test for operator * (Vector4f, float)
    test('vector4MultiplyOperatorTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const factor = 2.0;
      const expected = Vector4(2.0, 4.0, 6.0, 8.0);
      final actual = a * factor;
      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.operator * did not return the expected value.");
    });

    // A test for operator * (float, Vector4f)
    // test('vector4MultiplyOperatorTest2', () {
    //   const a = Vector4(1.0, 2.0, 3.0, 4.0);
    //   const factor = 2.0;
    //   const expected = Vector4(2.0, 4.0, 6.0, 8.0);
    //   final actual = factor * a;
    //   expect(equalVector4(expected, actual), true,
    //       reason: "Vector4f.operator * did not return the expected value.");
    // });

    // A test for operator * (Vector4f, Vector4f)
    test('vector4MultiplyOperatorTest3', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const b = Vector4(5.0, 6.0, 7.0, 8.0);

      const expected = Vector4(5.0, 12.0, 21.0, 32.0);

      final actual = a * b;

      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.operator * did not return the expected value.");
    });

    // A test for operator / (Vector4f, float)
    test('vector4DivisionTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);

      const div = 2.0;

      const expected = Vector4(0.5, 1.0, 1.5, 2.0);

      final actual = a / div;

      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.operator / did not return the expected value.");
    });

    // A test for operator / (Vector4f, Vector4f)
    test('vector4DivisionTest1', () {
      const a = Vector4(1.0, 6.0, 7.0, 4.0);
      const b = Vector4(5.0, 2.0, 3.0, 8.0);

      const expected = Vector4(1.0 / 5.0, 6.0 / 2.0, 7.0 / 3.0, 4.0 / 8.0);

      final actual = a / b;

      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.operator / did not return the expected value.");
    });

    // A test for operator / (Vector4f, Vector4f)
    // Divide by zero
    test('vector4DivisionTest2', () {
      const a = Vector4(-2.0, 3.0, double.maxFinite, double.nan);

      const div = 0.0;

      final actual = a / div;
      final isNegativeInfinity = actual.x.isInfinite && actual.x.isNegative;
      final isPositiveInfinity = actual.y.isInfinite && !actual.y.isNegative;
      final isZPositiveInfinity = actual.z.isInfinite && !actual.z.isNegative;
      expect(isNegativeInfinity, true,
          reason: "Vector4f.operator / did not return the expected value.");
      expect(isPositiveInfinity, true,
          reason: "Vector4f.operator / did not return the expected value.");
      expect(isZPositiveInfinity, true,
          reason: "Vector4f.operator / did not return the expected value.");
      expect(actual.w.isNaN, true,
          reason: "Vector4f.operator / did not return the expected value.");
    });

    // A test for operator / (Vector4f, Vector4f)
    // Divide by zero
    test('vector4DivisionTest3', () {
      const a =
          Vector4(0.047, -3.0, double.negativeInfinity, -double.maxFinite);
      const b = Vector4.zero;

      final actual = a / b;

      final isPositiveInfinity = actual.x.isInfinite && !actual.x.isNegative;
      final isNegativeInfinity = actual.y.isInfinite && actual.y.isNegative;
      final isZNegativeInfinity = actual.z.isInfinite && actual.z.isNegative;
      final isWNegativeInfinity = actual.w.isInfinite && actual.w.isNegative;
      expect(isPositiveInfinity, true,
          reason: "Vector4f.operator / did not return the expected value.");
      expect(isNegativeInfinity, true,
          reason: "Vector4f.operator / did not return the expected value.");
      expect(isZNegativeInfinity, true,
          reason: "Vector4f.operator / did not return the expected value.");
      expect(isWNegativeInfinity, true,
          reason: "Vector4f.operator / did not return the expected value.");
    });

    // A test for operator + (Vector4f, Vector4f)
    test('vector4AdditionTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const b = Vector4(5.0, 6.0, 7.0, 8.0);

      const expected = Vector4(6.0, 8.0, 10.0, 12.0);
      final actual = a + b;

      expect(equalVector4(expected, actual), true,
          reason: "Vector4f.operator + did not return the expected value.");
    });

    test('operatorAddTest', () {
      const v1 = Vector4(2.5, 2.0, 3.0, 3.3);
      const v2 = Vector4(5.5, 4.5, 6.5, 7.5);

      final v3 = v1 + v2;
      const v5 = Vector4(-1.0, 0.0, 0.0, double.nan);
      final v4 = v1 + v5;
      expect(8.0, v3.x);
      expect(6.5, v3.y);
      expect(9.5, v3.z);
      expect(10.8, v3.w);
      expect(1.5, v4.x);
      expect(2.0, v4.y);
      expect(3.0, v4.z);
      expect(v4.w.isNaN, true);
    });

    // A test for Vector4f (float, float, float, float)
    test('vector4ConstructorTest', () {
      const x = 1.0;
      const y = 2.0;
      const z = 3.0;
      const w = 4.0;

      const target = Vector4(x, y, z, w);

      expect(
          equalDouble(target.x, x) &&
              equalDouble(target.y, y) &&
              equalDouble(target.z, z) &&
              equalDouble(target.w, w),
          true,
          reason:
              "Vector4f constructor(x,y,z,w) did not return the expected value.");
    });

    // A test for Vector4f (Vector2f, float, float)
    test('vector4ConstructorTest1', () {
      const a = Vector2(1.0, 2.0);
      const z = 3.0;
      const w = 4.0;

      final target = Vector4.fromVector2(a, z, w);
      expect(
          equalDouble(target.x, a.x) &&
              equalDouble(target.y, a.y) &&
              equalDouble(target.z, z) &&
              equalDouble(target.w, w),
          true,
          reason:
              "Vector4f constructor(Vector2f,z,w) did not return the expected value.");
    });

    // A test for Vector4f (Vector3f, float)
    test('vector4ConstructorTest2', () {
      const a = Vector3(1.0, 2.0, 3.0);
      const w = 4.0;

      final target = Vector4.fromVector3(a, w);

      expect(
          equalDouble(target.x, a.x) &&
              equalDouble(target.y, a.y) &&
              equalDouble(target.z, a.z) &&
              equalDouble(target.w, w),
          true,
          reason:
              "Vector4f constructor(Vector3f,w) did not return the expected value.");
    });

    // A test for Vector4f ()
    // Constructor with no parameter
    test('vector4ConstructorTest4', () {
      const a = Vector4.zero;

      expect(a.x, 0.0);
      expect(a.y, 0.0);
      expect(a.z, 0.0);
      expect(a.w, 0.0);
    });

    // A test for Vector4f ()
    // Constructor with special floating values
    test('vector4ConstructorTest5', () {
      const target = Vector4(
          double.nan, double.maxFinite, double.infinity, double.minPositive);

      expect(target.x.isNaN, true,
          reason:
              "Vector4f.constructor (float, float, float, float) did not return the expected value.");
      expect(target.y == double.maxFinite, true,
          reason:
              "Vector4f.constructor (float, float, float, float) did not return the expected value.");
      expect(target.z.isInfinite && !target.z.isNegative, true,
          reason:
              "Vector4f.constructor (float, float, float, float) did not return the expected value.");
      expect(target.w == double.minPositive, true,
          reason:
              "Vector4f.constructor (float, float, float, float) did not return the expected value.");
    });

    // A test for Add (Vector4f, Vector4f)
    test('vector4AddTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const b = Vector4(5.0, 6.0, 7.0, 8.0);

      const expected = Vector4(6.0, 8.0, 10.0, 12.0);

      final actual = a.add(b);
      expect(expected, actual);
    });

    // A test for Divide (Vector4f, float)
    test('vector4DivideTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const div = 2.0;
      const expected = Vector4(0.5, 1.0, 1.5, 2.0);
      expect(expected, a / div);
    });

    // A test for Divide (Vector4f, Vector4f)
    test('vector4DivideTest1', () {
      const a = Vector4(1.0, 6.0, 7.0, 4.0);
      const b = Vector4(5.0, 2.0, 3.0, 8.0);

      const expected = Vector4(1.0 / 5.0, 6.0 / 2.0, 7.0 / 3.0, 4.0 / 8.0);

      final actual = a.divide(b);
      expect(expected, actual);
    });

    // A test for Equals (object)
    test('vector4EqualsTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      var b = const Vector4(1.0, 2.0, 3.0, 4.0);

      // case 1: compare between same values
      Object? obj = b;

      var expected = true;
      var actual = a == obj;
      expect(expected, actual);

      // case 2: compare between different values
      b = b.setX(10.0);
      obj = b;
      expected = false;
      actual = a == obj;
      expect(expected, actual);

      // case 3: compare between different types.
      obj = Quaternion.zero;
      expected = false;
      actual = a == obj;
      expect(expected, actual);

      // case 3: compare against null.
      obj = null;
      expected = false;
      actual = a == obj;
      expect(expected, actual);
    });

    // A test for Multiply (float, Vector4f)
    // test('vector4MultiplyTest', () {
    //   final a = Vector4(1.0, 2.0, 3.0, 4.0);
    //   const factor = 2.0;
    //   final expected = Vector4(2.0, 4.0, 6.0, 8.0);
    //   expect(expected, factor * a);
    // });

    // A test for Multiply (Vector4f, float)
    test('vector4MultiplyTest2', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const factor = 2.0;
      const expected = Vector4(2.0, 4.0, 6.0, 8.0);
      expect(expected, a * factor);
    });

    // A test for Multiply (Vector4f, Vector4f)
    test('vector4MultiplyTest3', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      const b = Vector4(5.0, 6.0, 7.0, 8.0);

      const expected = Vector4(5.0, 12.0, 21.0, 32.0);

      final actual = a.multiply(b);
      expect(expected, actual);
    });

    // A test for Negate (Vector4f)
    test('vector4NegateTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);

      const expected = Vector4(-1.0, -2.0, -3.0, -4.0);

      final actual = a.negate();
      expect(expected, actual);
    });

    // A test for operator != (Vector4f, Vector4f)
    test('vector4InequalityTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      var b = const Vector4(1.0, 2.0, 3.0, 4.0);

      // case 1: compare between same values
      var expected = false;
      var actual = a != b;
      expect(expected, actual);

      // case 2: compare between different values
      b = b.setX(10.0);
      expected = true;
      actual = a != b;
      expect(expected, actual);
    });

    // A test for operator == (Vector4f, Vector4f)
    test('vector4EqualityTest', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      var b = const Vector4(1.0, 2.0, 3.0, 4.0);

      // case 1: compare between same values
      var expected = true;
      var actual = a == b;
      expect(expected, actual);

      // case 2: compare between different values
      b = b.setX(10.0);
      expected = false;
      actual = a == b;
      expect(expected, actual);
    });

    // A test for Subtract (Vector4f, Vector4f)
    test('vector4SubtractTest', () {
      const a = Vector4(1.0, 6.0, 3.0, 4.0);
      const b = Vector4(5.0, 2.0, 3.0, 9.0);

      const expected = Vector4(-4.0, 4.0, 0.0, -5.0);

      final actual = a.subtract(b);

      expect(expected, actual);
    });

    // A test for UnitW
    test('vector4UnitWTest', () {
      const val = Vector4(0.0, 0.0, 0.0, 1.0);
      expect(val, Vector4.unitW);
    });

    // A test for UnitX
    test('vector4UnitXTest', () {
      const val = Vector4(1.0, 0.0, 0.0, 0.0);
      expect(val, Vector4.unitX);
    });

    // A test for UnitY
    test('vector4UnitYTest', () {
      const val = Vector4(0.0, 1.0, 0.0, 0.0);
      expect(val, Vector4.unitY);
    });

    // A test for UnitZ
    test('vector4UnitZTest', () {
      const val = Vector4(0.0, 0.0, 1.0, 0.0);
      expect(val, Vector4.unitZ);
    });

    // A test for One
    test('vector4OneTest', () {
      const val = Vector4(1.0, 1.0, 1.0, 1.0);
      expect(val, Vector4.one);
    });

    // A test for Zero
    test('vector4ZeroTest', () {
      const val = Vector4(0.0, 0.0, 0.0, 0.0);
      expect(val, Vector4.zero);
    });

    // A test for Equals (Vector4f)
    test('vector4EqualsTest1', () {
      const a = Vector4(1.0, 2.0, 3.0, 4.0);
      var b = const Vector4(1.0, 2.0, 3.0, 4.0);

      // case 1: compare between same values
      expect(a == b, true);

      // case 2: compare between different values
      b = b.setX(10.0);
      expect(a == b, false);
    });

    // A test for Vector4f (float)
    test('vector4ConstructorTest6', () {
      var value = 1.0;
      var target = Vector4.value(value);

      var expected = Vector4(value, value, value, value);
      expect(expected, target);

      value = 2.0;
      target = Vector4.value(value);
      expected = Vector4(value, value, value, value);
      expect(expected, target);
    });

    // A test for Vector4f comparison involving NaN values
    test('vector4EqualsNanTest', () {
      const a = Vector4(double.nan, 0, 0, 0);
      const b = Vector4(0, double.nan, 0, 0);
      const c = Vector4(0, 0, double.nan, 0);
      const d = Vector4(0, 0, 0, double.nan);

      expect(a == Vector4.zero, false);
      expect(b == Vector4.zero, false);
      expect(c == Vector4.zero, false);
      expect(d == Vector4.zero, false);

      expect(a != Vector4.zero, true);
      expect(b != Vector4.zero, true);
      expect(c != Vector4.zero, true);
      expect(d != Vector4.zero, true);

      expect(a == Vector4.zero, false);
      expect(b == Vector4.zero, false);
      expect(c == Vector4.zero, false);
      expect(d == Vector4.zero, false);

      // Counterintuitive result - IEEE rules for NaN comparison are weird!
      expect(a == a, false);
      expect(b == b, false);
      expect(c == c, false);
      expect(d == d, false);
    });

    test('vector4AbsTest', () {
      const v1 = Vector4(-2.5, 2.0, 3.0, 3.3);
      var v3 = const Vector4(
          double.infinity, 0.0, double.negativeInfinity, double.nan);
      v3 = v3.abs();
      final v = v1.abs();
      expect(2.5, v.x);
      expect(2.0, v.y);
      expect(3.0, v.z);
      expect(3.3, v.w);
      expect(double.infinity, v3.x);
      expect(0.0, v3.y);
      expect(double.infinity, v3.z);
      expect(v3.w.isNaN, true);
    });

    test('vector4SqrtTest', () {
      const v1 = Vector4(-2.5, 2.0, 3.0, 3.3);
      const v2 = Vector4(5.5, 4.5, 6.5, 7.5);
      expect(2, v2.squareRoot().x.toInt());
      expect(2, v2.squareRoot().y.toInt());
      expect(2, v2.squareRoot().z.toInt());
      expect(2, v2.squareRoot().w.toInt());
      expect(v1.squareRoot().x.isNaN, true);
    });
  });

  group('Matrix4x4Tests', () {
    Matrix4x4 generateMatrixNumberFrom1To16() {
      final values = List.generate(16, (index) => index + 1.0);
      return Matrix4x4.fromList(values);
    }

    Matrix4x4 generateTestMatrix() {
      final m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      return m.setTranslation(const Vector3(111.0, 222.0, 333.0));
    }

    // A test for Identity
    test('matrix4x4IdentityTest', () {
      final val =
          Matrix4x4.zero.copyWith(m11: 1.0, m22: 1.0, m33: 1.0, m44: 1.0);

      expect(equalMatrix(val, Matrix4x4.identity), true,
          reason: "Matrix4x4.Indentity was not set correctly.");
    });

    // A test for Determinant
    test('matrix4x4DeterminantTest', () {
      final target = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));

      const val = 1.0;
      final det = target.getDeterminant();

      expect(equalDouble(val, det), true,
          reason: "Matrix4x4.Determinant was not set correctly.");
    });

    // A test for Determinant
    // Determinant test |A| = 1 / |A'|
    test('matrix4x4DeterminantTest1', () {
      const a = Matrix4x4(5.0, 2.0, 8.25, 1.0, 12.0, 6.8, 2.14, 9.6, 6.5, 1.0,
          3.14, 2.22, 0.0, 0.86, 4.0, 1.0);

      Matrix4x4 i = Matrix4x4.invert(a);
      expect(i.isNaN, false);

      final detA = a.getDeterminant();
      final detI = i.getDeterminant();
      final t = 1.0 / detI;

      // only accurate to 3 precision
      expect((detA - t).abs() < 0.001, true,
          reason: "Matrix4x4.Determinant was not set correctly.");
    });

    // A test for Invert (Matrix4x4)
    test('matrix4x4InvertTest', () {
      final mtx = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));

      const expected = Matrix4x4(
        0.74999994,
        -0.21650632,
        0.62499994,
        0.0,
        0.43301263,
        0.87499994,
        -0.21650632,
        0.0,
        -0.49999997,
        0.43301263,
        0.74999994,
        0.0,
        0.0,
        0.0,
        0.0,
        0.99999994,
      );

      Matrix4x4 actual = Matrix4x4.invert(mtx);
      expect(actual.isNaN, false);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.Invert did not return the expected value.");

      // Make sure M*M is identity matrix
      final i = mtx * actual;
      expect(equalMatrix(i, Matrix4x4.identity), true,
          reason: "Matrix4x4.Invert did not return the expected value.");
    });

    // A test for Invert (Matrix4x4)
    test('matrix4x4InvertIdentityTest', () {
      const mtx = Matrix4x4.identity;
      final actual = Matrix4x4.invert(mtx);

      expect(actual.isNaN, false);
      expect(equalMatrix(actual, Matrix4x4.identity), true);
    });

    // A test for Invert (Matrix4x4)
    test('matrix4x4InvertTranslationTest', () {
      final mtx = Matrix4x4.translationXyz(23, 42, 666);
      final actual = Matrix4x4.invert(mtx);
      expect(actual.isNaN, false);

      final i = mtx * actual;
      expect(equalMatrix(i, Matrix4x4.identity), true);
    });

    // A test for Invert (Matrix4x4)
    test('matrix4x4InvertRotationTest', () {
      final mtx = Matrix4x4.fromYawPitchRoll(3, 4, 5);

      final actual = Matrix4x4.invert(mtx);
      expect(actual.isNaN, false);

      final i = mtx * actual;
      expect(equalMatrix(i, Matrix4x4.identity), true);
    });

    // A test for Invert (Matrix4x4)
    test('matrix4x4InvertScaleTest', () {
      final mtx = Matrix4x4.scaleXyz(23, 42, -666);

      final actual = Matrix4x4.invert(mtx);
      expect(actual.isNaN, false);

      final i = mtx * actual;
      expect(equalMatrix(i, Matrix4x4.identity), true);
    });

    // A test for Invert (Matrix4x4)
    test('matrix4x4InvertProjectionTest', () {
      final mtx = Matrix4x4.perspectiveFieldOfView(1, 1.333, 0.1, 666);

      final actual = Matrix4x4.invert(mtx);
      expect(actual.isNaN, false);

      final i = mtx * actual;
      expect(equalMatrix(i, Matrix4x4.identity), true);
    });

    // A test for Invert (Matrix4x4)
    test('matrix4x4InvertAffineTest', () {
      final mtx = Matrix4x4.fromYawPitchRoll(3, 4, 5) *
          Matrix4x4.scaleXyz(23, 42, -666) *
          Matrix4x4.translationXyz(17, 53, 89);

      final actual = Matrix4x4.invert(mtx);
      expect(actual.isNaN, false);

      final i = mtx * actual;
      expect(equalMatrix(i, Matrix4x4.identity), true);
    });

    void decomposeTest(double yaw, double pitch, double roll,
        Vector3 expectedTranslation, Vector3 expectedScales) {
      final expectedRotation = Quaternion.fromYawPitchRoll(
          toRadians(yaw), toRadians(pitch), toRadians(roll));
      final m = Matrix4x4.scaleVector3(expectedScales) *
          Matrix4x4.fromQuaternion(expectedRotation) *
          Matrix4x4.translation(expectedTranslation);

      final actualResult = Matrix4x4.tryDecompose(m);
      expect(actualResult != null, true,
          reason: "Matrix4x4.Decompose did not return expected value.");
      assert(actualResult != null);

      final scales = actualResult!.scale;
      final rotation = actualResult.rotation;
      final translation = actualResult.translation;
      final scaleIsZeroOrNegative = expectedScales.x <= 0 ||
          expectedScales.y <= 0 ||
          expectedScales.z <= 0;

      if (scaleIsZeroOrNegative) {
        expect(equalDouble(expectedScales.x.abs(), scales.x.abs()), true,
            reason: "Matrix4x4.Decompose did not return expected value.");
        expect(equalDouble(expectedScales.y.abs(), scales.y.abs()), true,
            reason: "Matrix4x4.Decompose did not return expected value.");
        expect(equalDouble(expectedScales.z.abs(), scales.z.abs()), true,
            reason: "Matrix4x4.Decompose did not return expected value.");
      } else {
        expect(equalVector3(expectedScales, scales), true,
            reason:
                "Matrix4x4.Decompose did not return expected value Expected:$expectedScales actual:$scales.");
        expect(equalRotation(expectedRotation, rotation), true,
            reason:
                "Matrix4x4.Decompose did not return expected value. Expected:$expectedRotation actual:$rotation.");
      }

      expect(equalVector3(expectedTranslation, translation), true,
          reason:
              "Matrix4x4.Decompose did not return expected value. Expected:$expectedTranslation actual:$translation.");
    }

    // Various rotation decompose test.
    test('matrix4x4DecomposeTest01', () {
      decomposeTest(
          10.0, 20.0, 30.0, const Vector3(10, 20, 30), const Vector3(2, 3, 4));
      const step = 35.0;
      for (var yawAngle = -720.0; yawAngle <= 720.0; yawAngle += step) {
        for (var pitchAngle = -720.0; pitchAngle <= 720.0; pitchAngle += step) {
          for (var rollAngle = -720.0; rollAngle <= 720.0; rollAngle += step) {
            decomposeTest(yawAngle, pitchAngle, rollAngle,
                const Vector3(10, 20, 30), const Vector3(2, 3, 4));
          }
        }
      }
    });

    // Various scaled matrix decompose test.
    test('matrix4x4DecomposeTest02', () {
      decomposeTest(
          10.0, 20.0, 30.0, const Vector3(10, 20, 30), const Vector3(2, 3, 4));

      // Various scales.
      decomposeTest(0.0, 0.0, 0.0, Vector3.zero, const Vector3(1, 2, 3));
      decomposeTest(0.0, 0.0, 0.0, Vector3.zero, const Vector3(1, 3, 2));
      decomposeTest(0.0, 0.0, 0.0, Vector3.zero, const Vector3(2, 1, 3));
      decomposeTest(0.0, 0.0, 0.0, Vector3.zero, const Vector3(2, 3, 1));
      decomposeTest(0.0, 0.0, 0.0, Vector3.zero, const Vector3(3, 1, 2));
      decomposeTest(0.0, 0.0, 0.0, Vector3.zero, const Vector3(3, 2, 1));

      decomposeTest(0.0, 0.0, 0.0, Vector3.zero, const Vector3(-2, 1, 1));

      // Small scales.
      decomposeTest(
          0.0, 0.0, 0.0, Vector3.zero, const Vector3(0.0001, 0.0002, 0.0003));
      decomposeTest(
          0.0, 0.0, 0.0, Vector3.zero, const Vector3(0.0001, 0.0003, 0.0002));
      decomposeTest(
          0.0, 0.0, 0.0, Vector3.zero, const Vector3(0.0002, 0.0001, 0.0003));
      decomposeTest(
          0.0, 0.0, 0.0, Vector3.zero, const Vector3(0.0002, 0.0003, 0.0001));
      decomposeTest(
          0.0, 0.0, 0.0, Vector3.zero, const Vector3(0.0003, 0.0001, 0.0002));
      decomposeTest(
          0.0, 0.0, 0.0, Vector3.zero, const Vector3(0.0003, 0.0002, 0.0001));

      // Zero scales.
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(0, 0, 0));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(1, 0, 0));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(0, 1, 0));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(0, 0, 1));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(0, 1, 1));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(1, 0, 1));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(1, 1, 0));

      // Negative scales.
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(-1, -1, -1));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(1, -1, -1));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(-1, 1, -1));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(-1, -1, 1));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(-1, 1, 1));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(1, -1, 1));
      decomposeTest(
          0.0, 0.0, 0.0, const Vector3(10, 20, 30), const Vector3(1, 1, -1));
    });

    void decomposeScaleTest(double sx, double sy, double sz) {
      final m = Matrix4x4.scaleXyz(sx, sy, sz);
      final expectedScales = Vector3(sx, sy, sz);
      final actualResult = Matrix4x4.tryDecompose(m);
      expect(actualResult != null, true,
          reason: "Matrix4x4.Decompose did not return expected value.");
      assert(actualResult != null);

      final scales = actualResult!.scale;
      final rotation = actualResult.rotation;
      final translation = actualResult.translation;
      expect(equalVector3(expectedScales, scales), true,
          reason: "Matrix4x4.Decompose did not return expected value.");
      expect(equalRotation(Quaternion.identity, rotation), true,
          reason: "Matrix4x4.Decompose did not return expected value.");
      expect(equalVector3(Vector3.zero, translation), true,
          reason: "Matrix4x4.Decompose did not return expected value.");
    }

    // Tiny scale decompose test.
    test('matrix4x4DecomposeTest03', () {
      decomposeScaleTest(1.0, 0.0002, 0.0003);
      decomposeScaleTest(1.0, 0.0003, 0.0002);
      decomposeScaleTest(0.0002, 1.0, 0.0003);
      decomposeScaleTest(0.0002, 0.0003, 1.0);
      decomposeScaleTest(0.0003, 1.0, 0.0002);
      decomposeScaleTest(0.0003, 0.0002, 1.0);
    });

    // Simple scale extraction test.
    test('matrix4x4ExtractScaleTest', () {
      void extractScaleTest(Vector3 s, Vector3 r) {
        final m = Matrix4x4.scaleVector3(s) *
            Matrix4x4.rotation(Quaternion.fromEulerAngles(r));
        expect(m.extractDirectScale().almostEquals(s), true,
            reason:
                "Failed to extract similar scale to input: ${m.extractDirectScale()} != $s");
      }

      extractScaleTest(const Vector3(1, 2, 1), Vector3.zero);
      extractScaleTest(const Vector3(-1, 2, 1), Vector3.zero);
      extractScaleTest(const Vector3(-1, 2, -1), Vector3.zero);

      extractScaleTest(const Vector3(1, 2, 0.75), Vector3.unitX);
      extractScaleTest(const Vector3(1, 2, 0.75), Vector3.unitY);
      extractScaleTest(const Vector3(1, 2, 0.75), Vector3.unitZ);

      extractScaleTest(const Vector3(1, 2, 0.75), -Vector3.unitX);
      extractScaleTest(const Vector3(1, 2, 0.75), -Vector3.unitY);
      extractScaleTest(const Vector3(1, 2, 0.75), -Vector3.unitZ);

      extractScaleTest(const Vector3(-1, 2, 0.75), -Vector3.unitX);
      extractScaleTest(const Vector3(1, -2, -0.75), -Vector3.unitY);
      extractScaleTest(const Vector3(1, 2, -0.75), -Vector3.unitZ);
    });

    test('matrix4x4DecomposeTest04', () {
      final actualResult =
          Matrix4x4.tryDecompose(generateMatrixNumberFrom1To16());
      expect(actualResult != null, false,
          reason: "decompose should have failed.");
    });

    // Transform by quaternion test
    test('matrix4x4TransformTest', () {
      final target = generateMatrixNumberFrom1To16();
      final m = Matrix4x4.rotationX(toRadians(30.0)) *
          Matrix4x4.rotationY(toRadians(30.0)) *
          Matrix4x4.rotationZ(toRadians(30.0));
      final q = Quaternion.fromRotationMatrix(m);
      final expected = target * m;
      final actual = Matrix4x4.transform(target, q);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.Transform did not return the expected value.");
    });

    // A test for CreateRotationX (float)
    test('matrix4x4CreateRotationXTest', () {
      final radians = toRadians(30.0);
      final expected = Matrix4x4.zero.copyWith(
          m11: 1.0,
          m22: 0.8660254,
          m23: 0.5,
          m32: -0.5,
          m33: 0.8660254,
          m44: 1.0);
      final actual = Matrix4x4.rotationX(radians);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.rotationX did not return the expected value.");
    });

    // A test for CreateRotationX (float)
    // CreateRotationX of zero degree
    test('matrix4x4CreateRotationXTest1', () {
      const radians = 0.0;
      const expected = Matrix4x4.identity;
      final actual = Matrix4x4.rotationX(radians);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.rotationX did not return the expected value.");
    });

    // A test for CreateRotationX (float, Vector3f)
    test('matrix4x4CreateRotationXCenterTest', () {
      final radians = toRadians(30.0);
      const center = Vector3(23, 42, 66);

      final rotateAroundZero =
          Matrix4x4.rotationXByCenterPoint(radians, Vector3.zero);
      final rotateAroundZeroExpected = Matrix4x4.rotationX(radians);
      expect(equalMatrix(rotateAroundZero, rotateAroundZeroExpected), true);

      final rotateAroundCenter =
          Matrix4x4.rotationXByCenterPoint(radians, center);
      final rotateAroundCenterExpected = Matrix4x4.translation(-center) *
          Matrix4x4.rotationX(radians) *
          Matrix4x4.translation(center);
      expect(equalMatrix(rotateAroundCenter, rotateAroundCenterExpected), true);
    });

    // A test for CreateRotationY (float)
    test('matrix4x4CreateRotationYTest', () {
      final radians = toRadians(60.0);
      final expected = Matrix4x4.zero.copyWith(
          m11: 0.49999997,
          m13: -0.86602545,
          m22: 1.0,
          m31: 0.86602545,
          m33: 0.49999997,
          m44: 1.0);
      final actual = Matrix4x4.rotationY(radians);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.rotationY did not return the expected value.");
    });

    // A test for RotationY (float)
    // CreateRotationY test for negative angle
    test('matrix4x4CreateRotationYTest1', () {
      final radians = toRadians(-300.0);
      final expected = Matrix4x4.zero.copyWith(
          m11: 0.49999997,
          m13: -0.86602545,
          m22: 1.0,
          m31: 0.86602545,
          m33: 0.49999997,
          m44: 1.0);
      final actual = Matrix4x4.rotationY(radians);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.rotationY did not return the expected value.");
    });

    // A test for CreateRotationY (float, Vector3f)
    test('matrix4x4CreateRotationYCenterTest', () {
      final radians = toRadians(30.0);
      const center = Vector3(23, 42, 66);

      final rotateAroundZero =
          Matrix4x4.rotationYByCenterPoint(radians, Vector3.zero);
      final rotateAroundZeroExpected = Matrix4x4.rotationY(radians);
      expect(equalMatrix(rotateAroundZero, rotateAroundZeroExpected), true);

      final rotateAroundCenter =
          Matrix4x4.rotationYByCenterPoint(radians, center);
      final rotateAroundCenterExpected = Matrix4x4.translation(-center) *
          Matrix4x4.rotationY(radians) *
          Matrix4x4.translation(center);
      expect(equalMatrix(rotateAroundCenter, rotateAroundCenterExpected), true);
    });

    // A test for CreateFromAxisAngle(Vector3f,float)
    test('matrix4x4CreateFromAxisAngleTest', () {
      final radians = toRadians(-30.0);

      var expected = Matrix4x4.rotationX(radians);
      var actual = Matrix4x4.fromAxisAndAngle(Vector3.unitX, radians);
      expect(equalMatrix(expected, actual), true);

      expected = Matrix4x4.rotationY(radians);
      actual = Matrix4x4.fromAxisAndAngle(Vector3.unitY, radians);
      expect(equalMatrix(expected, actual), true);

      expected = Matrix4x4.rotationZ(radians);
      actual = Matrix4x4.fromAxisAndAngle(Vector3.unitZ, radians);
      expect(equalMatrix(expected, actual), true);

      expected = Matrix4x4.fromQuaternion(
          Quaternion.fromAxisAndAngle(Vector3.one.normalize(), radians));
      actual = Matrix4x4.fromAxisAndAngle(Vector3.one.normalize(), radians);
      expect(equalMatrix(expected, actual), true);

      int rotCount = 16;
      for (var i = 0; i < rotCount; ++i) {
        final latitude = (2.0 * pi) * (i / rotCount);
        for (var j = 0; j < rotCount; ++j) {
          final longitude = -piOver2 + pi * (j / rotCount);

          final m =
              Matrix4x4.rotationZ(longitude) * Matrix4x4.rotationY(latitude);
          final axis = Vector3(m.m11, m.m12, m.m13);
          for (var k = 0; k < rotCount; ++k) {
            final rot = (2.0 * pi) * (k / rotCount);
            expected = Matrix4x4.fromQuaternion(
                Quaternion.fromAxisAndAngle(axis, rot));
            actual = Matrix4x4.fromAxisAndAngle(axis, rot);
            expect(equalMatrix(expected, actual), true);
          }
        }
      }
    });

    test('matrix4x4CreateFromYawPitchRollTest1', () {
      final yawAngle = toRadians(30.0);
      final pitchAngle = toRadians(40.0);
      final rollAngle = toRadians(50.0);

      final yaw = Matrix4x4.fromAxisAndAngle(Vector3.unitY, yawAngle);
      final pitch = Matrix4x4.fromAxisAndAngle(Vector3.unitX, pitchAngle);
      final roll = Matrix4x4.fromAxisAndAngle(Vector3.unitZ, rollAngle);

      final expected = roll * pitch * yaw;
      final actual =
          Matrix4x4.fromYawPitchRoll(yawAngle, pitchAngle, rollAngle);
      expect(equalMatrix(expected, actual), true);
    });

    // Covers more numeric rigions
    test('matrix4x4CreateFromYawPitchRollTest2', () {
      const step = 35.0;

      for (var yawAngle = -720.0; yawAngle <= 720.0; yawAngle += step) {
        for (var pitchAngle = -720.0; pitchAngle <= 720.0; pitchAngle += step) {
          for (var rollAngle = -720.0; rollAngle <= 720.0; rollAngle += step) {
            final yawRad = toRadians(yawAngle);
            final pitchRad = toRadians(pitchAngle);
            final rollRad = toRadians(rollAngle);
            final yaw = Matrix4x4.fromAxisAndAngle(Vector3.unitY, yawRad);
            final pitch = Matrix4x4.fromAxisAndAngle(Vector3.unitX, pitchRad);
            final roll = Matrix4x4.fromAxisAndAngle(Vector3.unitZ, rollRad);

            final expected = roll * pitch * yaw;
            final actual =
                Matrix4x4.fromYawPitchRoll(yawRad, pitchRad, rollRad);
            expect(equalMatrix(expected, actual), true,
                reason: ("Yaw:$yawAngle Pitch:$pitchAngle Roll:$rollAngle"));
          }
        }
      }
    });

    // Simple shadow test.
    test('matrix4x4CreateShadowTest01', () {
      const lightDir = Vector3.unitY;
      const plane = Plane(Vector3.unitY, 0);
      final expected = Matrix4x4.scaleXyz(1, 0, 1);
      final actual = Matrix4x4.shadow(lightDir, plane);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.CreateShadow did not returned expected value.");
    });

    // Various plane projections.
    test('matrix4x4CreateShadowTest02', () {
      // Complex cases.
      final planes = [
        Plane.values(0, 1, 0, 0),
        Plane.values(1, 2, 3, 4),
        Plane.values(5, 6, 7, 8),
        Plane.values(-1, -2, -3, -4),
        Plane.values(-5, -6, -7, -8)
      ];
      const points = [
        Vector3(1, 2, 3),
        Vector3(5, 6, 7),
        Vector3(8, 9, 10),
        Vector3(-1, -2, -3),
        Vector3(-5, -6, -7),
        Vector3(-8, -9, -10)
      ];

      for (final p in planes) {
        final plane = Plane.normalize(p);
        // Try various direction of light directions.
        final testDirections = <Vector3>[];
        for (final lightDirInfo in testDirections) {
          if (lightDirInfo.length < 0.1) {
            continue;
          }
          final lightDir = lightDirInfo.normalize();
          if (Plane.dotNormal(plane, lightDir) < 0.1) {
            continue;
          }
          final m = Matrix4x4.shadow(lightDir, plane);
          final pp = plane.normal * (-plane.d);
          // origin of the plane.
          for (final point in points) {
            final v4 = point.transformToVector4(m);
            final sp = Vector3(v4.x, v4.y, v4.z) / v4.w;
            // Make sure transformed position is on the plane.
            final v = sp - pp;
            final d = v.dot(plane.normal);
            expect(equalDouble(d, 0.0), true,
                reason:
                    "Matrix4x4.CreateShadow did not provide expected value.");

            // make sure direction between transformed position and original position are same as light direction.
            if ((point - pp).dot(plane.normal) > 0.0001) {
              final dir = (point - sp).normalize();
              expect(equalVector3(dir, lightDir), true,
                  reason:
                      "Matrix4x4.CreateShadow did not provide expected value.");
            }
          }
        }
      }
    });

    void createReflectionTest(Plane plane, Matrix4x4 expected) {
      final actual = Matrix4x4.reflection(plane);
      expect(equalMatrix(actual, expected), true,
          reason: "Matrix4x4.CreateReflection did not return expected value.");
      expect(actual.isReflection, true,
          reason: "Matrix4x4.IsReflection did not return expected value.");
    }

    test('matrix4x4CreateReflectionTest01', () {
      // XY plane.
      createReflectionTest(
          const Plane(Vector3.unitZ, 0), Matrix4x4.scaleXyz(1, 1, -1));
      // XZ plane.
      createReflectionTest(
          const Plane(Vector3.unitY, 0), Matrix4x4.scaleXyz(1, -1, 1));
      // YZ plane.
      createReflectionTest(
          const Plane(Vector3.unitX, 0), Matrix4x4.scaleXyz(-1, 1, 1));

      // Complex cases.
      final planes = [
        Plane.values(0, 1, 0, 0),
        Plane.values(1, 2, 3, 4),
        Plane.values(5, 6, 7, 8),
        Plane.values(-1, -2, -3, -4),
        Plane.values(-5, -6, -7, -8)
      ];
      const points = [
        Vector3(1, 2, 3),
        Vector3(5, 6, 7),
        Vector3(-1, -2, -3),
        Vector3(-5, -6, -7)
      ];

      for (final p in planes) {
        final plane = Plane.normalize(p);
        final m = Matrix4x4.reflection(plane);
        final pp = plane.normal * (-plane.d);
        // Position on the plane.
        for (final point in points) {
          final rp = point.transform(m);
          // Manually compute reflection point and compare results.
          final v = point - pp;
          final d = v.dot(plane.normal);
          //final vp = point - 2.0 * d * plane.normal;
          final vp = point - plane.normal * 2.0 * d;
          expect(equalVector3(rp, vp), true,
              reason: "Matrix4x4.Reflection did not provide expected value.");
        }
      }
    });

    // A test for CreateRotationZ (float)
    test('matrix4x4CreateRotationZTest', () {
      final radians = toRadians(50.0);
      final expected = Matrix4x4.zero.copyWith(
        m11: 0.64278764,
        m12: 0.76604444,
        m21: -0.76604444,
        m22: 0.64278764,
        m33: 1.0,
        m44: 1.0,
      );
      final actual = Matrix4x4.rotationZ(radians);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.rotationZ did not return the expected value.");
    });

    // A test for CreateRotationZ (float, Vector3f)
    test('matrix4x4CreateRotationZCenterTest', () {
      final radians = toRadians(30.0);
      const center = Vector3(23, 42, 66);

      final rotateAroundZero =
          Matrix4x4.rotationZByCenterPoint(radians, Vector3.zero);
      final rotateAroundZeroExpected = Matrix4x4.rotationZ(radians);
      expect(equalMatrix(rotateAroundZero, rotateAroundZeroExpected), true);

      final rotateAroundCenter =
          Matrix4x4.rotationZByCenterPoint(radians, center);
      final rotateAroundCenterExpected = Matrix4x4.translation(-center) *
          Matrix4x4.rotationZ(radians) *
          Matrix4x4.translation(center);
      expect(equalMatrix(rotateAroundCenter, rotateAroundCenterExpected), true);
    });

    // A test for CrateLookAt (Vector3f, Vector3f, Vector3f)
    test('matrix4x4CreateLookAtTest', () {
      const cameraPosition = Vector3(10.0, 20.0, 30.0);
      const cameraTarget = Vector3(3.0, 2.0, -4.0);
      const cameraUpVector = Vector3(0.0, 1.0, 0.0);
      const expected = Matrix4x4(
          0.979457,
          -0.092826776,
          0.179017,
          0.0,
          0.0,
          0.8877481,
          0.46032947,
          0.0,
          -0.20165291,
          -0.45087293,
          0.8695112,
          0.0,
          -3.7449827,
          -3.3005068,
          -37.082096,
          1.0);

      final actual =
          Matrix4x4.lookAt(cameraPosition, cameraTarget, cameraUpVector);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.CreateLookAt did not return the expected value.");
    });

    // A test for CreateWorld (Vector3f, Vector3f, Vector3f)
    test('matrix4x4CreateWorldTest', () {
      const objectPosition = Vector3(10.0, 20.0, 30.0);
      const objectForwardDirection = Vector3(3.0, 2.0, -4.0);
      const objectUpVector = Vector3(0.0, 1.0, 0.0);
      const expected = Matrix4x4(
          0.79999995,
          0.0,
          0.59999996,
          0.0,
          -0.2228344,
          0.92847663,
          0.29711252,
          0.0,
          -0.557086,
          -0.37139067,
          0.74278134,
          0.0,
          10.0,
          20.0,
          30.0,
          1.0);

      final actual = Matrix4x4.world(
          objectPosition, objectForwardDirection, objectUpVector);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.CreateWorld did not return the expected value.");

      expect(actual.translation, objectPosition);
      expect(
          objectUpVector
                  .normalize()
                  .dot(Vector3(actual.m21, actual.m22, actual.m23)) >
              0,
          true);
      expect(
          objectForwardDirection
                  .normalize()
                  .dot(Vector3(-actual.m31, -actual.m32, -actual.m33)) >
              0.999,
          true);
    });

    // A test for CreateOrtho (float, float, float, float)
    test('matrix4x4CreateOrthoTest', () {
      const width = 100.0;
      const height = 200.0;
      const zNearPlane = 1.5;
      const zFarPlane = 1000.0;
      final expected = Matrix4x4.zero.copyWith(
        m11: 0.02,
        m22: 0.01,
        m33: -0.0010015023,
        m43: -0.0015022533,
        m44: 1.0,
      );
      final actual =
          Matrix4x4.orthographic(width, height, zNearPlane, zFarPlane);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.CreateOrtho did not return the expected value.");
    });

    // A test for CreateOrthoOffCenter (float, float, float, float, float, float)
    test('matrix4x4CreateOrthoOffCenterTest', () {
      const left = 10.0;
      const right = 90.0;
      const bottom = 20.0;
      const top = 180.0;
      const zNearPlane = 1.5;
      const zFarPlane = 1000.0;
      final expected = Matrix4x4.zero.copyWith(
        m11: 0.025,
        m22: 0.0125,
        m33: -0.0010015023,
        m41: -1.25,
        m42: -1.25,
        m43: -0.0015022533,
        m44: 1.0,
      );
      final actual = Matrix4x4.orthographicOffCenter(
          left, right, bottom, top, zNearPlane, zFarPlane);
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateOrthoOffCenter did not return the expected value.");
    });

    // A test for CreatePerspective (float, float, float, float)
    test('matrix4x4CreatePerspectiveTest', () {
      const width = 100.0;
      const height = 200.0;
      const zNearPlane = 1.5;
      const zFarPlane = 1000.0;

      final expected = Matrix4x4.zero.copyWith(
        m11: 0.03,
        m22: 0.015,
        m33: -1.0015023,
        m34: -1.0,
        m43: -1.5022534,
      );

      final actual =
          Matrix4x4.perspective(width, height, zNearPlane, zFarPlane);
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreatePerspective did not return the expected value.");
    });

    // A test for CreatePerspective (float, float, float, float)
    // CreatePerspective test where znear = zfar
    test('matrix4x4CreatePerspectiveTest1()', () {
      const width = 100.0;
      const height = 200.0;
      const zNearPlane = 0.0;
      const zFarPlane = 0.0;
      bool isCatch = false;
      try {
        Matrix4x4.perspective(width, height, zNearPlane, zFarPlane);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspective (float, float, float, float)
    // CreatePerspective test where near plane is negative value
    test('matrix4x4CreatePerspectiveTest2()', () {
      bool isCatch = false;
      try {
        Matrix4x4.perspective(10, 10, -10, 10);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspective (float, float, float, float)
    // CreatePerspective test where far plane is negative value
    test('matrix4x4CreatePerspectiveTest3()', () {
      bool isCatch = false;
      try {
        Matrix4x4.perspective(10, 10, 10, -10);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspective (float, float, float, float)
    // CreatePerspective test where near plane is beyond far plane
    test('matrix4x4CreatePerspectiveTest4()', () {
      bool isCatch = false;
      try {
        Matrix4x4.perspective(10, 10, 10, 1);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspectiveFieldOfView (float, float, float, float)
    test('matrix4x4CreatePerspectiveFieldOfViewTest', () {
      final fieldOfView = toRadians(30.0);
      const aspectRatio = 1280.0 / 720.0;
      const zNearPlane = 1.5;
      const zFarPlane = 1000.0;

      final expected = Matrix4x4.zero.copyWith(
        m11: 2.0992785,
        m22: 3.7320507,
        m33: -1.0015023,
        m34: -1.0,
        m43: -1.5022534,
      );
      final actual = Matrix4x4.perspectiveFieldOfView(
          fieldOfView, aspectRatio, zNearPlane, zFarPlane);
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreatePerspectiveFieldOfView did not return the expected value.");
    });

    // A test for CreatePerspectiveFieldOfView (float, float, float, float)
    // CreatePerspectiveFieldOfView test where filedOfView is negative value.
    test('matrix4x4CreatePerspectiveFieldOfViewTest1()', () {
      bool isCatch = false;
      try {
        Matrix4x4.perspectiveFieldOfView(-1, 1, 1, 10);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspectiveFieldOfView (float, float, float, float)
    // CreatePerspectiveFieldOfView test where filedOfView is more than pi.
    test('matrix4x4CreatePerspectiveFieldOfViewTest2()', () {
      bool isCatch = false;
      try {
        Matrix4x4.perspectiveFieldOfView(pi + 0.01, 1, 1, 10);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspectiveFieldOfView (float, float, float, float)
    // CreatePerspectiveFieldOfView test where nearPlaneDistance is negative value.
    test('matrix4x4CreatePerspectiveFieldOfViewTest3()', () {
      bool isCatch = false;
      try {
        Matrix4x4.perspectiveFieldOfView(piOver4, 1, -1, 10);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspectiveFieldOfView (float, float, float, float)
    // CreatePerspectiveFieldOfView test where farPlaneDistance is negative value.
    test('matrix4x4CreatePerspectiveFieldOfViewTest4()', () {
      bool isCatch = false;
      try {
        Matrix4x4.perspectiveFieldOfView(piOver4, 1, 1, -10);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspectiveFieldOfView (float, float, float, float)
    // CreatePerspectiveFieldOfView test where nearPlaneDistance is larger than farPlaneDistance.
    test('matrix4x4CreatePerspectiveFieldOfViewTest5()', () {
      bool isCatch = false;
      try {
        Matrix4x4.perspectiveFieldOfView(piOver4, 1, 10, 1);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspectiveOffCenter (float, float, float, float, float, float)
    test('matrix4x4CreatePerspectiveOffCenterTest', () {
      const left = 10.0;
      const right = 90.0;
      const bottom = 20.0;
      const top = 180.0;
      const zNearPlane = 1.5;
      const zFarPlane = 1000.0;

      final expected = Matrix4x4.zero.copyWith(
        m11: 0.0375,
        m22: 0.01875,
        m31: 1.25,
        m32: 1.25,
        m33: -1.0015023,
        m34: -1.0,
        m43: -1.5022534,
      );
      final actual = Matrix4x4.perspectiveOffCenter(
          left, right, bottom, top, zNearPlane, zFarPlane);
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreatePerspectiveOffCenter did not return the expected value.");
    });

    // A test for CreatePerspectiveOffCenter (float, float, float, float, float, float)
    // CreatePerspectiveOffCenter test where nearPlaneDistance is negative.
    test('matrix4x4CreatePerspectiveOffCenterTest1()', () {
      const left = 10.0, right = 90.0, bottom = 20.0, top = 180.0;
      bool isCatch = false;
      try {
        Matrix4x4.perspectiveOffCenter(left, right, bottom, top, -1, 10);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspectiveOffCenter (float, float, float, float, float, float)
    // CreatePerspectiveOffCenter test where farPlaneDistance is negative.
    test('matrix4x4CreatePerspectiveOffCenterTest2()', () {
      const left = 10.0, right = 90.0, bottom = 20.0, top = 180.0;
      bool isCatch = false;
      try {
        Matrix4x4.perspectiveOffCenter(left, right, bottom, top, 1, -10);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for CreatePerspectiveOffCenter (float, float, float, float, float, float)
    // CreatePerspectiveOffCenter test where test where nearPlaneDistance is larger than farPlaneDistance.
    test('matrix4x4CreatePerspectiveOffCenterTest3()', () {
      const left = 10.0, right = 90.0, bottom = 20.0, top = 180.0;
      bool isCatch = false;
      try {
        Matrix4x4.perspectiveOffCenter(left, right, bottom, top, 10, 1);
      } catch (e) {
        expect(e is RangeError, true);
        isCatch = true;
      }
      expect(isCatch, true, reason: "Assert doesn't throws RangeError");
    });

    // A test for Invert (Matrix4x4)
    // Non invertible matrix - determinant is zero - singular matrix
    test('matrix4x4InvertTest1', () {
      const a = Matrix4x4(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0,
          11.0, 12.0, 13.0, 14.0, 15.0, 16.0);

      final detA = a.getDeterminant();
      expect(equalDouble(detA, 0.0), true,
          reason: "Matrix4x4.Invert did not return the expected value.");

      final actual = Matrix4x4.invert(a);
      //expect(actual.isNaN, false);

      // all the elements in Actual is NaN
      expect(
          actual.m11.isNaN &&
              actual.m12.isNaN &&
              actual.m13.isNaN &&
              actual.m14.isNaN &&
              actual.m21.isNaN &&
              actual.m22.isNaN &&
              actual.m23.isNaN &&
              actual.m24.isNaN &&
              actual.m31.isNaN &&
              actual.m32.isNaN &&
              actual.m33.isNaN &&
              actual.m34.isNaN &&
              actual.m41.isNaN &&
              actual.m42.isNaN &&
              actual.m43.isNaN &&
              actual.m44.isNaN,
          true,
          reason: "Matrix4x4.Invert did not return the expected value.");
    });

    // A test for Lerp (Matrix4x4, Matrix4x4, float)
    test('matrix4x4LerpTest', () {
      const a = Matrix4x4(11.0, 12.0, 13.0, 14.0, 21.0, 22.0, 23.0, 24.0, 31.0,
          32.0, 33.0, 34.0, 41.0, 42.0, 43.0, 44.0);
      final b = generateMatrixNumberFrom1To16();
      const t = 0.5;
      final expected = Matrix4x4(
          a.m11 + (b.m11 - a.m11) * t,
          a.m12 + (b.m12 - a.m12) * t,
          a.m13 + (b.m13 - a.m13) * t,
          a.m14 + (b.m14 - a.m14) * t,
          a.m21 + (b.m21 - a.m21) * t,
          a.m22 + (b.m22 - a.m22) * t,
          a.m23 + (b.m23 - a.m23) * t,
          a.m24 + (b.m24 - a.m24) * t,
          a.m31 + (b.m31 - a.m31) * t,
          a.m32 + (b.m32 - a.m32) * t,
          a.m33 + (b.m33 - a.m33) * t,
          a.m34 + (b.m34 - a.m34) * t,
          a.m41 + (b.m41 - a.m41) * t,
          a.m42 + (b.m42 - a.m42) * t,
          a.m43 + (b.m43 - a.m43) * t,
          a.m44 + (b.m44 - a.m44) * t);
      final actual = Matrix4x4.lerp(a, b, t);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.Lerp did not return the expected value.");
    });

    // A test for operator - (Matrix4x4)
    test('matrix4x4UnaryNegationTest', () {
      final a = generateMatrixNumberFrom1To16();
      const expected = Matrix4x4(-1.0, -2.0, -3.0, -4.0, -5.0, -6.0, -7.0, -8.0,
          -9.0, -10.0, -11.0, -12.0, -13.0, -14.0, -15.0, -16.0);
      final actual = -a;
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.operator - did not return the expected value.");
    });

    // A test for operator - (Matrix4x4, Matrix4x4)
    test('matrix4x4SubtractionTest', () {
      final a = generateMatrixNumberFrom1To16();
      final b = generateMatrixNumberFrom1To16();
      const expected = Matrix4x4.zero;
      final actual = a - b;
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.operator - did not return the expected value.");
    });

    // A test for operator * (Matrix4x4, Matrix4x4)
    test('matrix4x4MultiplyTest1', () {
      final a = generateMatrixNumberFrom1To16();
      final b = generateMatrixNumberFrom1To16();
      final expected = Matrix4x4(
          a.m11 * b.m11 + a.m12 * b.m21 + a.m13 * b.m31 + a.m14 * b.m41,
          a.m11 * b.m12 + a.m12 * b.m22 + a.m13 * b.m32 + a.m14 * b.m42,
          a.m11 * b.m13 + a.m12 * b.m23 + a.m13 * b.m33 + a.m14 * b.m43,
          a.m11 * b.m14 + a.m12 * b.m24 + a.m13 * b.m34 + a.m14 * b.m44,
          a.m21 * b.m11 + a.m22 * b.m21 + a.m23 * b.m31 + a.m24 * b.m41,
          a.m21 * b.m12 + a.m22 * b.m22 + a.m23 * b.m32 + a.m24 * b.m42,
          a.m21 * b.m13 + a.m22 * b.m23 + a.m23 * b.m33 + a.m24 * b.m43,
          a.m21 * b.m14 + a.m22 * b.m24 + a.m23 * b.m34 + a.m24 * b.m44,
          a.m31 * b.m11 + a.m32 * b.m21 + a.m33 * b.m31 + a.m34 * b.m41,
          a.m31 * b.m12 + a.m32 * b.m22 + a.m33 * b.m32 + a.m34 * b.m42,
          a.m31 * b.m13 + a.m32 * b.m23 + a.m33 * b.m33 + a.m34 * b.m43,
          a.m31 * b.m14 + a.m32 * b.m24 + a.m33 * b.m34 + a.m34 * b.m44,
          a.m41 * b.m11 + a.m42 * b.m21 + a.m43 * b.m31 + a.m44 * b.m41,
          a.m41 * b.m12 + a.m42 * b.m22 + a.m43 * b.m32 + a.m44 * b.m42,
          a.m41 * b.m13 + a.m42 * b.m23 + a.m43 * b.m33 + a.m44 * b.m43,
          a.m41 * b.m14 + a.m42 * b.m24 + a.m43 * b.m34 + a.m44 * b.m44);
      final actual = a * b;
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.operator * did not return the expected value.");
    });

    // A test for operator * (Matrix4x4, Matrix4x4)
    // Multiply with identity matrix
    test('matrix4x4MultiplyTest4', () {
      const a = Matrix4x4(1.0, 2.0, 3.0, 4.0, 5.0, -6.0, 7.0, -8.0, 9.0, 10.0,
          11.0, 12.0, 13.0, -14.0, 15.0, -16.0);
      const b = Matrix4x4.identity;
      const expected = a;
      final actual = a * b;
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.operator * did not return the expected value.");
    });

    // A test for operator + (Matrix4x4, Matrix4x4)
    test('matrix4x4AdditionTest', () {
      final a = generateMatrixNumberFrom1To16();
      final b = generateMatrixNumberFrom1To16();
      final expected = Matrix4x4(
          a.m11 + b.m11,
          a.m12 + b.m12,
          a.m13 + b.m13,
          a.m14 + b.m14,
          a.m21 + b.m21,
          a.m22 + b.m22,
          a.m23 + b.m23,
          a.m24 + b.m24,
          a.m31 + b.m31,
          a.m32 + b.m32,
          a.m33 + b.m33,
          a.m34 + b.m34,
          a.m41 + b.m41,
          a.m42 + b.m42,
          a.m43 + b.m43,
          a.m44 + b.m44);
      final actual = a + b;
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.operator + did not return the expected value.");
    });

    // A test for Transpose (Matrix4x4)
    test('matrix4x4TransposeTest', () {
      final a = generateMatrixNumberFrom1To16();
      final expected = Matrix4x4(a.m11, a.m21, a.m31, a.m41, a.m12, a.m22,
          a.m32, a.m42, a.m13, a.m23, a.m33, a.m43, a.m14, a.m24, a.m34, a.m44);
      final actual = Matrix4x4.transpose(a);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.Transpose did not return the expected value.");
    });

    // A test for Transpose (Matrix4x4)
    // Transpose Identity matrix
    test('matrix4x4TransposeTest1', () {
      const a = Matrix4x4.identity;
      const expected = Matrix4x4.identity;
      final actual = Matrix4x4.transpose(a);
      expect(equalMatrix(expected, actual), true,
          reason: "Matrix4x4.Transpose did not return the expected value.");
    });

    // A test for Matrix4x4 (Quaternion)
    test('matrix4x4FromQuaternionTest1', () {
      final axis = const Vector3(1.0, 2.0, 3.0).normalize();
      final q = Quaternion.fromAxisAndAngle(axis, toRadians(30.0));
      const expected = Matrix4x4(
          0.87559503,
          0.42003104,
          -0.2385524,
          0.0,
          -0.38175258,
          0.90430385,
          0.1910483,
          0.0,
          0.29597008,
          -0.07621294,
          0.95215195,
          0.0,
          0.0,
          0.0,
          0.0,
          1.0);
      final target = Matrix4x4.fromQuaternion(q);
      expect(equalMatrix(expected, target), true,
          reason:
              "Matrix4x4.Matrix4x4(Quaternion) did not return the expected value.");
    });

    // A test for FromQuaternion (Matrix4x4)
    // Convert X axis rotation matrix
    test('matrix4x4FromQuaternionTest2', () {
      for (var angle = 0.0; angle < 720.0; angle += 10.0) {
        final quat = Quaternion.fromAxisAndAngle(Vector3.unitX, angle);

        final expected = Matrix4x4.rotationX(angle);
        final actual = Matrix4x4.fromQuaternion(quat);
        expect(equalMatrix(expected, actual), true,
            reason:
                "Quaternion.FromQuaternion did not return the expected value. angle:$angle");

        // make sure convert back to quaternion is same as we passed quaternion.
        final q2 = Quaternion.fromRotationMatrix(actual);
        expect(equalRotation(quat, q2), true,
            reason:
                "Quaternion.FromQuaternion did not return the expected value. angle:$angle");
      }
    });

    // A test for FromQuaternion (Matrix4x4)
    // Convert Y axis rotation matrix
    test('matrix4x4FromQuaternionTest3', () {
      for (var angle = 0.0; angle < 720.0; angle += 10.0) {
        final quat = Quaternion.fromAxisAndAngle(Vector3.unitY, angle);

        final expected = Matrix4x4.rotationY(angle);
        final actual = Matrix4x4.fromQuaternion(quat);
        expect(equalMatrix(expected, actual), true,
            reason:
                "Quaternion.FromQuaternion did not return the expected value. angle:$angle");

        // make sure convert back to quaternion is same as we passed quaternion.
        final q2 = Quaternion.fromRotationMatrix(actual);
        expect(equalRotation(quat, q2), true,
            reason:
                "Quaternion.FromQuaternion did not return the expected value. angle:$angle");
      }
    });

    // A test for FromQuaternion (Matrix4x4)
    // Convert Z axis rotation matrix
    test('matrix4x4FromQuaternionTest4', () {
      for (var angle = 0.0; angle < 720.0; angle += 10.0) {
        final quat = Quaternion.fromAxisAndAngle(Vector3.unitZ, angle);

        final expected = Matrix4x4.rotationZ(angle);
        final actual = Matrix4x4.fromQuaternion(quat);
        expect(equalMatrix(expected, actual), true,
            reason:
                "Quaternion.FromQuaternion did not return the expected value. angle:$angle");

        // make sure convert back to quaternion is same as we passed quaternion.
        final q2 = Quaternion.fromRotationMatrix(actual);
        expect(equalRotation(quat, q2), true,
            reason:
                "Quaternion.FromQuaternion did not return the expected value. angle:$angle");
      }
    });

    // A test for FromQuaternion (Matrix4x4)
    // Convert XYZ axis rotation matrix
    test('matrix4x4FromQuaternionTest5', () {
      for (var angle = 0.0; angle < 720.0; angle += 10.0) {
        final quat = Quaternion.fromAxisAndAngle(Vector3.unitZ, angle) *
            Quaternion.fromAxisAndAngle(Vector3.unitY, angle) *
            Quaternion.fromAxisAndAngle(Vector3.unitX, angle);

        final expected = Matrix4x4.rotationX(angle) *
            Matrix4x4.rotationY(angle) *
            Matrix4x4.rotationZ(angle);
        final actual = Matrix4x4.fromQuaternion(quat);
        expect(equalMatrix(expected, actual), true,
            reason:
                "Quaternion.FromQuaternion did not return the expected value. angle:$angle");

        // make sure convert back to quaternion is same as we passed quaternion.
        final q2 = Quaternion.fromRotationMatrix(actual);
        expect(equalRotation(quat, q2), true,
            reason:
                "Quaternion.FromQuaternion did not return the expected value. angle:$angle");
      }
    });

    // A test for ToString ()
    test('matrix4x4ToStringTest', () {
      const a = Matrix4x4(11.0, -12.0, -13.3, 14.4, 21.0, 22.0, 23.0, 24.0,
          31.0, 32.0, 33.0, 34.0, 41.0, 42.0, 43.0, 44.0);
      const expected =
          "{{ {{M11:${11.0} M12:${-12.0} M13:${-13.3} M14:${14.4}}} {{M21:${21.0} M22:${22.0} M23:${23.0} M24:${24.0}}} {{M31:${31.0} M32:${32.0} M33:${33.0} M34:${34.0}}} {{M41:${41.0} M42:${42.0} M43:${43.0} M44:${44.0}}} }}";
      final actual = a.toString();
      expect(expected, actual);
    });

    // A test for Add (Matrix4x4, Matrix4x4)
    test('matrix4x4AddTest', () {
      final a = generateMatrixNumberFrom1To16();
      final b = generateMatrixNumberFrom1To16();
      final expected = Matrix4x4(
          a.m11 + b.m11,
          a.m12 + b.m12,
          a.m13 + b.m13,
          a.m14 + b.m14,
          a.m21 + b.m21,
          a.m22 + b.m22,
          a.m23 + b.m23,
          a.m24 + b.m24,
          a.m31 + b.m31,
          a.m32 + b.m32,
          a.m33 + b.m33,
          a.m34 + b.m34,
          a.m41 + b.m41,
          a.m42 + b.m42,
          a.m43 + b.m43,
          a.m44 + b.m44);
      final actual = Matrix4x4.add(a, b);
      expect(actual, expected);
    });

    // A test for Equals (object)
    test('matrix4x4EqualsTest', () {
      final a = generateMatrixNumberFrom1To16();
      var b = generateMatrixNumberFrom1To16();

      // case 1: compare between same values
      Object? obj = b;

      var expected = true;
      var actual = a == obj;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.copyWith(m11: 11.0);
      obj = b;
      expected = false;
      actual = a == obj;
      expect(actual, expected);

      // case 3: compare between different types.
      obj = Vector4.zero;
      expected = false;
      actual = a == obj;
      expect(actual, expected);

      // case 3: compare against null.
      obj = null;
      expected = false;
      actual = a == obj;
      expect(actual, expected);
    });

    // A test for GetHashCode ()
    test('matrix4x4GetHashCodeTest', () {
      final target = generateMatrixNumberFrom1To16();
      final expected = Hash.hashCodes([
        target.m11.hashCode,
        target.m12.hashCode,
        target.m13.hashCode,
        target.m14.hashCode,
        target.m21.hashCode,
        target.m22.hashCode,
        target.m23.hashCode,
        target.m24.hashCode,
        target.m31.hashCode,
        target.m32.hashCode,
        target.m33.hashCode,
        target.m34.hashCode,
        target.m41.hashCode,
        target.m42.hashCode,
        target.m43.hashCode,
        target.m44.hashCode,
      ]);
      final actual = target.hashCode;
      expect(actual, expected);
    });

    // A test for Multiply (Matrix4x4, Matrix4x4)
    test('matrix4x4MultiplyTest3', () {
      final a = generateMatrixNumberFrom1To16();
      final b = generateMatrixNumberFrom1To16();
      final expected = Matrix4x4(
          a.m11 * b.m11 + a.m12 * b.m21 + a.m13 * b.m31 + a.m14 * b.m41,
          a.m11 * b.m12 + a.m12 * b.m22 + a.m13 * b.m32 + a.m14 * b.m42,
          a.m11 * b.m13 + a.m12 * b.m23 + a.m13 * b.m33 + a.m14 * b.m43,
          a.m11 * b.m14 + a.m12 * b.m24 + a.m13 * b.m34 + a.m14 * b.m44,
          a.m21 * b.m11 + a.m22 * b.m21 + a.m23 * b.m31 + a.m24 * b.m41,
          a.m21 * b.m12 + a.m22 * b.m22 + a.m23 * b.m32 + a.m24 * b.m42,
          a.m21 * b.m13 + a.m22 * b.m23 + a.m23 * b.m33 + a.m24 * b.m43,
          a.m21 * b.m14 + a.m22 * b.m24 + a.m23 * b.m34 + a.m24 * b.m44,
          a.m31 * b.m11 + a.m32 * b.m21 + a.m33 * b.m31 + a.m34 * b.m41,
          a.m31 * b.m12 + a.m32 * b.m22 + a.m33 * b.m32 + a.m34 * b.m42,
          a.m31 * b.m13 + a.m32 * b.m23 + a.m33 * b.m33 + a.m34 * b.m43,
          a.m31 * b.m14 + a.m32 * b.m24 + a.m33 * b.m34 + a.m34 * b.m44,
          a.m41 * b.m11 + a.m42 * b.m21 + a.m43 * b.m31 + a.m44 * b.m41,
          a.m41 * b.m12 + a.m42 * b.m22 + a.m43 * b.m32 + a.m44 * b.m42,
          a.m41 * b.m13 + a.m42 * b.m23 + a.m43 * b.m33 + a.m44 * b.m43,
          a.m41 * b.m14 + a.m42 * b.m24 + a.m43 * b.m34 + a.m44 * b.m44);
      final actual = Matrix4x4.multiply(a, b);
      expect(actual, expected);
    });

    // A test for Multiply (Matrix4x4, float)
    test('matrix4x4MultiplyTest5', () {
      final a = generateMatrixNumberFrom1To16();
      const expected = Matrix4x4(
          3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48);
      final actual = Matrix4x4.multiplyScalar(a, 3);
      expect(actual, expected);
    });

    // A test for Multiply (Matrix4x4, float)
    test('matrix4x4MultiplyTest6', () {
      final a = generateMatrixNumberFrom1To16();
      const expected = Matrix4x4(
          3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48);
      final actual = a * 3;
      expect(actual, expected);
    });

    // A test for Negate (Matrix4x4)
    test('matrix4x4NegateTest', () {
      final m = generateMatrixNumberFrom1To16();
      const expected = Matrix4x4(-1.0, -2.0, -3.0, -4.0, -5.0, -6.0, -7.0, -8.0,
          -9.0, -10.0, -11.0, -12.0, -13.0, -14.0, -15.0, -16.0);
      final actual = Matrix4x4.negate(m);
      expect(actual, expected);
    });

    // A test for operator != (Matrix4x4, Matrix4x4)
    test('matrix4x4InequalityTest', () {
      final a = generateMatrixNumberFrom1To16();
      var b = generateMatrixNumberFrom1To16();

      // case 1: compare between same values
      var expected = false;
      var actual = a != b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.copyWith(m11: 11.0);
      expected = true;
      actual = a != b;
      expect(actual, expected);
    });

    // A test for operator == (Matrix4x4, Matrix4x4)
    test('matrix4x4EqualityTest', () {
      final a = generateMatrixNumberFrom1To16();
      var b = generateMatrixNumberFrom1To16();

      // case 1: compare between same values
      var expected = true;
      var actual = a == b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.copyWith(m11: 11.0);
      expected = false;
      actual = a == b;
      expect(actual, expected);
    });

    // A test for Subtract (Matrix4x4, Matrix4x4)
    test('matrix4x4SubtractTest', () {
      final a = generateMatrixNumberFrom1To16();
      final b = generateMatrixNumberFrom1To16();
      const expected = Matrix4x4.zero;

      final actual = Matrix4x4.subtract(a, b);
      expect(actual, expected);
    });

    void createBillboardFact(Vector3 placeDirection, Vector3 cameraUpVector,
        Matrix4x4 expectedRotation) {
      const cameraPosition = Vector3(3.0, 4.0, 5.0);
      final objectPosition = cameraPosition + placeDirection * 10.0;
      final expected = expectedRotation * Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.billboard(objectPosition, cameraPosition,
          cameraUpVector, const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateBillboard did not return the expected value.");
    }

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Forward side of camera on XZ-plane
    // Object placed at Forward of camera. result must be same as 180 degrees rotate along y-axis.
    test('matrix4x4CreateBillboardTest01', () {
      createBillboardFact(const Vector3(0, 0, -1), const Vector3(0, 1, 0),
          Matrix4x4.rotationY(toRadians(180.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Backward side of camera on XZ-plane
    // Object placed at Backward of camera. This result must be same as 0 degrees rotate along y-axis.
    test('matrix4x4CreateBillboardTest02()', () {
      createBillboardFact(const Vector3(0, 0, 1), const Vector3(0, 1, 0),
          Matrix4x4.rotationY(toRadians(0.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Right side of camera on XZ-plane
    // Place object at Right side of camera. This result must be same as 90 degrees rotate along y-axis.
    test('matrix4x4CreateBillboardTest03()', () {
      createBillboardFact(const Vector3(1, 0, 0), const Vector3(0, 1, 0),
          Matrix4x4.rotationY(toRadians(90.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Left side of camera on XZ-plane
    // Place object at Left side of camera. This result must be same as -90 degrees rotate along y-axis.
    test('matrix4x4CreateBillboardTest04()', () {
      createBillboardFact(const Vector3(-1, 0, 0), const Vector3(0, 1, 0),
          Matrix4x4.rotationY(toRadians(-90)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Up side of camera on XY-plane
    // Place object at Up side of camera. result must be same as 180 degrees rotate along z-axis after 90 degrees rotate along x-axis.
    test('matrix4x4CreateBillboardTest05()', () {
      createBillboardFact(
          const Vector3(0, 1, 0),
          const Vector3(0, 0, 1),
          Matrix4x4.rotationX(toRadians(90.0)) *
              Matrix4x4.rotationZ(toRadians(180.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Down side of camera on XY-plane
    // Place object at Down side of camera. result must be same as 0 degrees rotate along z-axis after 90 degrees rotate along x-axis.
    test('matrix4x4CreateBillboardTest06()', () {
      createBillboardFact(
          const Vector3(0, -1, 0),
          const Vector3(0, 0, 1),
          Matrix4x4.rotationX(toRadians(90.0)) *
              Matrix4x4.rotationZ(toRadians(0.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Right side of camera on XY-plane
    // Place object at Right side of camera. result must be same as 90 degrees rotate along z-axis after 90 degrees rotate along x-axis.
    test('matrix4x4CreateBillboardTest07()', () {
      createBillboardFact(
          const Vector3(1, 0, 0),
          const Vector3(0, 0, 1),
          Matrix4x4.rotationX(toRadians(90.0)) *
              Matrix4x4.rotationZ(toRadians(90.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Left side of camera on XY-plane
    // Place object at Left side of camera. result must be same as -90 degrees rotate along z-axis after 90 degrees rotate along x-axis.
    test('matrix4x4CreateBillboardTest08()', () {
      createBillboardFact(
          const Vector3(-1, 0, 0),
          const Vector3(0, 0, 1),
          Matrix4x4.rotationX(toRadians(90.0)) *
              Matrix4x4.rotationZ(toRadians(-90.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Up side of camera on YZ-plane
    // Place object at Up side of camera. result must be same as -90 degrees rotate along x-axis after 90 degrees rotate along z-axis.
    test('matrix4x4CreateBillboardTest09()', () {
      createBillboardFact(
          const Vector3(0, 1, 0),
          const Vector3(-1, 0, 0),
          Matrix4x4.rotationZ(toRadians(90.0)) *
              Matrix4x4.rotationX(toRadians(-90.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Down side of camera on YZ-plane
    // Place object at Down side of camera. result must be same as 90 degrees rotate along x-axis after 90 degrees rotate along z-axis.
    test('matrix4x4CreateBillboardTest10()', () {
      createBillboardFact(
          const Vector3(0, -1, 0),
          const Vector3(-1, 0, 0),
          Matrix4x4.rotationZ(toRadians(90.0)) *
              Matrix4x4.rotationX(toRadians(90.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Forward side of camera on YZ-plane
    // Place object at Forward side of camera. result must be same as 180 degrees rotate along x-axis after 90 degrees rotate along z-axis.
    test('matrix4x4CreateBillboardTest11()', () {
      createBillboardFact(
          const Vector3(0, 0, -1),
          const Vector3(-1, 0, 0),
          Matrix4x4.rotationZ(toRadians(90.0)) *
              Matrix4x4.rotationX(toRadians(180.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Backward side of camera on YZ-plane
    // Place object at Backward side of camera. result must be same as 0 degrees rotate along x-axis after 90 degrees rotate along z-axis.
    test('matrix4x4CreateBillboardTest12()', () {
      createBillboardFact(
          const Vector3(0, 0, 1),
          const Vector3(-1, 0, 0),
          Matrix4x4.rotationZ(toRadians(90.0)) *
              Matrix4x4.rotationX(toRadians(0.0)));
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Object and camera positions are too close and doesn't pass cameraForwardVector.
    test('matrix4x4CreateBillboardTooCloseTest1', () {
      const objectPosition = Vector3(3.0, 4.0, 5.0);
      const cameraPosition = objectPosition;
      const cameraUpVector = Vector3(0, 1, 0);

      // Doesn't pass camera face direction. CreateBillboard uses new Vector3f(0, 0, -1) direction. Result must be same as 180 degrees rotate along y-axis.
      final expected = Matrix4x4.rotationY(toRadians(180.0)) *
          Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.billboard(objectPosition, cameraPosition,
          cameraUpVector, const Vector3(0, 0, 1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateBillboard did not return the expected value.");
    });

    // A test for CreateBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Object and camera positions are too close and passed cameraForwardVector.
    test('matrix4x4CreateBillboardTooCloseTest2', () {
      const objectPosition = Vector3(3.0, 4.0, 5.0);
      const cameraPosition = objectPosition;
      const cameraUpVector = Vector3(0, 1, 0);

      // Passes Vector3f.Right as camera face direction. Result must be same as -90 degrees rotate along y-axis.
      final expected = Matrix4x4.rotationY(toRadians(-90.0)) *
          Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.billboard(objectPosition, cameraPosition,
          cameraUpVector, const Vector3(1, 0, 0));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateBillboard did not return the expected value.");
    });

    void createConstrainedBillboardFact(Vector3 placeDirection,
        Vector3 rotateAxis, Matrix4x4 expectedRotation) {
      var cameraPosition = const Vector3(3.0, 4.0, 5.0);
      final objectPosition = cameraPosition + placeDirection * 10.0;
      final expected = expectedRotation * Matrix4x4.translation(objectPosition);
      var actual = Matrix4x4.constrainedBillboard(
          objectPosition,
          cameraPosition,
          rotateAxis,
          const Vector3(0, 0, -1),
          const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");

      // When you move camera along rotateAxis, result must be same.
      cameraPosition += rotateAxis * 10.0;
      actual = Matrix4x4.constrainedBillboard(objectPosition, cameraPosition,
          rotateAxis, const Vector3(0, 0, -1), const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");

      cameraPosition -= rotateAxis * 30.0;
      actual = Matrix4x4.constrainedBillboard(objectPosition, cameraPosition,
          rotateAxis, const Vector3(0, 0, -1), const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");
    }

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Forward side of camera on XZ-plane
    // Object placed at Forward of camera. result must be same as 180 degrees rotate along y-axis.
    test('matrix4x4CreateConstrainedBillboardTest01()', () {
      createConstrainedBillboardFact(const Vector3(0, 0, -1),
          const Vector3(0, 1, 0), Matrix4x4.rotationY(toRadians(180.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Backward side of camera on XZ-plane
    // Object placed at Backward of camera. This result must be same as 0 degrees rotate along y-axis.
    test('matrix4x4CreateConstrainedBillboardTest02()', () {
      createConstrainedBillboardFact(const Vector3(0, 0, 1),
          const Vector3(0, 1, 0), Matrix4x4.rotationY(toRadians(0.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Right side of camera on XZ-plane
    // Place object at Right side of camera. This result must be same as 90 degrees rotate along y-axis.
    test('matrix4x4CreateConstrainedBillboardTest03()', () {
      createConstrainedBillboardFact(const Vector3(1, 0, 0),
          const Vector3(0, 1, 0), Matrix4x4.rotationY(toRadians(90.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Left side of camera on XZ-plane
    // Place object at Left side of camera. This result must be same as -90 degrees rotate along y-axis.
    test('matrix4x4CreateConstrainedBillboardTest04()', () {
      createConstrainedBillboardFact(const Vector3(-1, 0, 0),
          const Vector3(0, 1, 0), Matrix4x4.rotationY(toRadians(-90)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Up side of camera on XY-plane
    // Place object at Up side of camera. result must be same as 180 degrees rotate along z-axis after 90 degrees rotate along x-axis.
    test('matrix4x4CreateConstrainedBillboardTest05()', () {
      createConstrainedBillboardFact(
          const Vector3(0, 1, 0),
          const Vector3(0, 0, 1),
          Matrix4x4.rotationX(toRadians(90.0)) *
              Matrix4x4.rotationZ(toRadians(180.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Down side of camera on XY-plane
    // Place object at Down side of camera. result must be same as 0 degrees rotate along z-axis after 90 degrees rotate along x-axis.
    test('matrix4x4CreateConstrainedBillboardTest06()', () {
      createConstrainedBillboardFact(
          const Vector3(0, -1, 0),
          const Vector3(0, 0, 1),
          Matrix4x4.rotationX(toRadians(90.0)) *
              Matrix4x4.rotationZ(toRadians(0.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Right side of camera on XY-plane
    // Place object at Right side of camera. result must be same as 90 degrees rotate along z-axis after 90 degrees rotate along x-axis.
    test('matrix4x4CreateConstrainedBillboardTest07()', () {
      createConstrainedBillboardFact(
          const Vector3(1, 0, 0),
          const Vector3(0, 0, 1),
          Matrix4x4.rotationX(toRadians(90.0)) *
              Matrix4x4.rotationZ(toRadians(90.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Left side of camera on XY-plane
    // Place object at Left side of camera. result must be same as -90 degrees rotate along z-axis after 90 degrees rotate along x-axis.
    test('matrix4x4CreateConstrainedBillboardTest08()', () {
      createConstrainedBillboardFact(
          const Vector3(-1, 0, 0),
          const Vector3(0, 0, 1),
          Matrix4x4.rotationX(toRadians(90.0)) *
              Matrix4x4.rotationZ(toRadians(-90.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Up side of camera on YZ-plane
    // Place object at Up side of camera. result must be same as -90 degrees rotate along x-axis after 90 degrees rotate along z-axis.
    test('matrix4x4CreateConstrainedBillboardTest09()', () {
      createConstrainedBillboardFact(
          const Vector3(0, 1, 0),
          const Vector3(-1, 0, 0),
          Matrix4x4.rotationZ(toRadians(90.0)) *
              Matrix4x4.rotationX(toRadians(-90.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Down side of camera on YZ-plane
    // Place object at Down side of camera. result must be same as 90 degrees rotate along x-axis after 90 degrees rotate along z-axis.
    test('matrix4x4CreateConstrainedBillboardTest10()', () {
      createConstrainedBillboardFact(
          const Vector3(0, -1, 0),
          const Vector3(-1, 0, 0),
          Matrix4x4.rotationZ(toRadians(90.0)) *
              Matrix4x4.rotationX(toRadians(90.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Forward side of camera on YZ-plane
    // Place object at Forward side of camera. result must be same as 180 degrees rotate along x-axis after 90 degrees rotate along z-axis.
    test('matrix4x4CreateConstrainedBillboardTest11()', () {
      createConstrainedBillboardFact(
          const Vector3(0, 0, -1),
          const Vector3(-1, 0, 0),
          Matrix4x4.rotationZ(toRadians(90.0)) *
              Matrix4x4.rotationX(toRadians(180.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Place object at Backward side of camera on YZ-plane
    // Place object at Backward side of camera. result must be same as 0 degrees rotate along x-axis after 90 degrees rotate along z-axis.
    test('matrix4x4CreateConstrainedBillboardTest12()', () {
      createConstrainedBillboardFact(
          const Vector3(0, 0, 1),
          const Vector3(-1, 0, 0),
          Matrix4x4.rotationZ(toRadians(90.0)) *
              Matrix4x4.rotationX(toRadians(0.0)));
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Object and camera positions are too close and doesn't pass cameraForwardVector.
    test('matrix4x4CreateConstrainedBillboardTooCloseTest1', () {
      const objectPosition = Vector3(3.0, 4.0, 5.0);
      const cameraPosition = objectPosition;
      const cameraUpVector = Vector3(0, 1, 0);

      // Doesn't pass camera face direction. CreateConstrainedBillboard uses new Vector3f(0, 0, -1) direction. Result must be same as 180 degrees rotate along y-axis.
      final expected = Matrix4x4.rotationY(toRadians(180.0)) *
          Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.constrainedBillboard(
          objectPosition,
          cameraPosition,
          cameraUpVector,
          const Vector3(0, 0, 1),
          const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Object and camera positions are too close and passed cameraForwardVector.
    test('matrix4x4CreateConstrainedBillboardTooCloseTest2', () {
      const objectPosition = Vector3(3.0, 4.0, 5.0);
      const cameraPosition = objectPosition;
      const cameraUpVector = Vector3(0, 1, 0);

      // Passes Vector3f.Right as camera face direction. Result must be same as -90 degrees rotate along y-axis.
      final expected = Matrix4x4.rotationY(toRadians(-90.0)) *
          Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.constrainedBillboard(
          objectPosition,
          cameraPosition,
          cameraUpVector,
          const Vector3(1, 0, 0),
          const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Angle between rotateAxis and camera to object vector is too small. And use doesn't passed objectForwardVector parameter.
    test('matrix4x4CreateConstrainedBillboardAlongAxisTest1', () {
      // Place camera at up side of object.
      const objectPosition = Vector3(3.0, 4.0, 5.0);
      const rotateAxis = Vector3(0, 1, 0);
      final cameraPosition = objectPosition + rotateAxis * 10.0;

      // In this case, CreateConstrainedBillboard picks new Vector3f(0, 0, -1) as object forward vector.
      final expected = Matrix4x4.rotationY(toRadians(180.0)) *
          Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.constrainedBillboard(
          objectPosition,
          cameraPosition,
          rotateAxis,
          const Vector3(0, 0, -1),
          const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Angle between rotateAxis and camera to object vector is too small. And user doesn't passed objectForwardVector parameter.
    test('matrix4x4CreateConstrainedBillboardAlongAxisTest2', () {
      // Place camera at up side of object.
      const objectPosition = Vector3(3.0, 4.0, 5.0);
      const rotateAxis = Vector3(0, 0, -1);
      final cameraPosition = objectPosition + rotateAxis * 10.0;

      // In this case, CreateConstrainedBillboard picks new Vector3f(1, 0, 0) as object forward vector.
      final expected = Matrix4x4.rotationX(toRadians(-90.0)) *
          Matrix4x4.rotationZ(toRadians(-90.0)) *
          Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.constrainedBillboard(
          objectPosition,
          cameraPosition,
          rotateAxis,
          const Vector3(0, 0, -1),
          const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Angle between rotateAxis and camera to object vector is too small. And user passed correct objectForwardVector parameter.
    test('matrix4x4CreateConstrainedBillboardAlongAxisTest3', () {
      // Place camera at up side of object.
      const objectPosition = Vector3(3.0, 4.0, 5.0);
      const rotateAxis = Vector3(0, 1, 0);
      final cameraPosition = objectPosition + rotateAxis * 10.0;

      // User passes correct objectForwardVector.
      final expected = Matrix4x4.rotationY(toRadians(180.0)) *
          Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.constrainedBillboard(
          objectPosition,
          cameraPosition,
          rotateAxis,
          const Vector3(0, 0, -1),
          const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Angle between rotateAxis and camera to object vector is too small. And user passed incorrect objectForwardVector parameter.
    test('matrix4x4CreateConstrainedBillboardAlongAxisTest4', () {
      // Place camera at up side of object.
      const objectPosition = Vector3(3.0, 4.0, 5.0);
      const rotateAxis = Vector3(0, 1, 0);
      final cameraPosition = objectPosition + rotateAxis * 10.0;

      // User passes correct objectForwardVector.
      final expected = Matrix4x4.rotationY(toRadians(180.0)) *
          Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.constrainedBillboard(
          objectPosition,
          cameraPosition,
          rotateAxis,
          const Vector3(0, 0, -1),
          const Vector3(0, 1, 0));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");
    });

    // A test for CreateConstrainedBillboard (Vector3f, Vector3f, Vector3f, Vector3f?)
    // Angle between rotateAxis and camera to object vector is too small. And user passed incorrect objectForwardVector parameter.
    test('matrix4x4CreateConstrainedBillboardAlongAxisTest5', () {
      // Place camera at up side of object.
      const objectPosition = Vector3(3.0, 4.0, 5.0);
      const rotateAxis = Vector3(0, 0, -1);
      final cameraPosition = objectPosition + rotateAxis * 10.0;

      // In this case, CreateConstrainedBillboard picks Vector3f.Right as object forward vector.
      final expected = Matrix4x4.rotationX(toRadians(-90.0)) *
          Matrix4x4.rotationZ(toRadians(-90.0)) *
          Matrix4x4.translation(objectPosition);
      final actual = Matrix4x4.constrainedBillboard(
          objectPosition,
          cameraPosition,
          rotateAxis,
          const Vector3(0, 0, -1),
          const Vector3(0, 0, -1));
      expect(equalMatrix(expected, actual), true,
          reason:
              "Matrix4x4.CreateConstrainedBillboard did not return the expected value.");
    });

    // A test for CreateScale (Vector3f)
    test('matrix4x4CreateScaleTest1', () {
      const scales = Vector3(2.0, 3.0, 4.0);
      const expected = Matrix4x4(2.0, 0.0, 0.0, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0,
          0.0, 4.0, 0.0, 0.0, 0.0, 0.0, 1.0);
      final actual = Matrix4x4.scaleVector3(scales);
      expect(expected, actual);
    });

    // A test for CreateScale (Vector3f, Vector3f)
    test('matrix4x4CreateScaleCenterTest1', () {
      const scale = Vector3(3, 4, 5);
      const center = Vector3(23, 42, 666);

      final scaleAroundZero =
          Matrix4x4.scaleVector3ByCenterPoint(scale, Vector3.zero);
      final scaleAroundZeroExpected = Matrix4x4.scaleVector3(scale);
      expect(equalMatrix(scaleAroundZero, scaleAroundZeroExpected), true);

      final scaleAroundCenter =
          Matrix4x4.scaleVector3ByCenterPoint(scale, center);
      final scaleAroundCenterExpected = Matrix4x4.translation(-center) *
          Matrix4x4.scaleVector3(scale) *
          Matrix4x4.translation(center);
      expect(equalMatrix(scaleAroundCenter, scaleAroundCenterExpected), true);
    });

    // A test for CreateScale (float)
    test('matrix4x4CreateScaleTest2', () {
      const scale = 2.0;
      const expected = Matrix4x4(2.0, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0,
          0.0, 2.0, 0.0, 0.0, 0.0, 0.0, 1.0);
      final actual = Matrix4x4.scale(scale);
      expect(actual, expected);
    });

    // A test for CreateScale (float, Vector3f)
    test('matrix4x4CreateScaleCenterTest2', () {
      const scale = 5.0;
      const center = Vector3(23, 42, 666);

      final scaleAroundZero = Matrix4x4.scaleByCenterPoint(scale, Vector3.zero);
      final scaleAroundZeroExpected = Matrix4x4.scale(scale);
      expect(equalMatrix(scaleAroundZero, scaleAroundZeroExpected), true);

      final scaleAroundCenter = Matrix4x4.scaleByCenterPoint(scale, center);
      final scaleAroundCenterExpected = Matrix4x4.translation(-center) *
          Matrix4x4.scale(scale) *
          Matrix4x4.translation(center);
      expect(equalMatrix(scaleAroundCenter, scaleAroundCenterExpected), true);
    });

    // A test for CreateScale (float, float, float)
    test('matrix4x4CreateScaleTest3', () {
      const xScale = 2.0;
      const yScale = 3.0;
      const zScale = 4.0;
      const expected = Matrix4x4(2.0, 0.0, 0.0, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0,
          0.0, 4.0, 0.0, 0.0, 0.0, 0.0, 1.0);
      final actual = Matrix4x4.scaleXyz(xScale, yScale, zScale);
      expect(actual, expected);
    });

    // A test for CreateScale (float, float, float, Vector3f)
    test('matrix4x4CreateScaleCenterTest3', () {
      const scale = Vector3(3, 4, 5);
      const center = Vector3(23, 42, 666);

      final scaleAroundZero = Matrix4x4.scaleXyzByCenterPoint(
          scale.x, scale.y, scale.z, Vector3.zero);
      final scaleAroundZeroExpected =
          Matrix4x4.scaleXyz(scale.x, scale.y, scale.z);
      expect(equalMatrix(scaleAroundZero, scaleAroundZeroExpected), true);

      final scaleAroundCenter =
          Matrix4x4.scaleXyzByCenterPoint(scale.x, scale.y, scale.z, center);
      final scaleAroundCenterExpected = Matrix4x4.translation(-center) *
          Matrix4x4.scaleXyz(scale.x, scale.y, scale.z) *
          Matrix4x4.translation(center);
      expect(equalMatrix(scaleAroundCenter, scaleAroundCenterExpected), true);
    });

    // A test for CreateTranslation (Vector3f)
    test('matrix4x4CreateTranslationTest1', () {
      const position = Vector3(2.0, 3.0, 4.0);
      const expected = Matrix4x4(1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0,
          0.0, 1.0, 0.0, 2.0, 3.0, 4.0, 1.0);

      final actual = Matrix4x4.translation(position);
      expect(actual, expected);
    });

    // A test for CreateTranslation (float, float, float)
    test('matrix4x4CreateTranslationTest2', () {
      const xPosition = 2.0;
      const yPosition = 3.0;
      const zPosition = 4.0;

      const expected = Matrix4x4(1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0,
          0.0, 1.0, 0.0, 2.0, 3.0, 4.0, 1.0);

      final actual = Matrix4x4.translationXyz(xPosition, yPosition, zPosition);
      expect(actual, expected);
    });

    // A test for Translation
    test('matrix4x4TranslationTest', () {
      var a = generateTestMatrix();
      final b = a;

      // Transformed vector that has same semantics of property must be same.
      var val = Vector3(a.m41, a.m42, a.m43);
      expect(a.translation, val);

      // Set value and get value must be same.
      val = const Vector3(1.0, 2.0, 3.0);
      a = a.setTranslation(val);
      expect(a.translation, val);

      // Make sure it only modifies expected value of matrix.
      expect(
          a.m11 == b.m11 &&
              a.m12 == b.m12 &&
              a.m13 == b.m13 &&
              a.m14 == b.m14 &&
              a.m21 == b.m21 &&
              a.m22 == b.m22 &&
              a.m23 == b.m23 &&
              a.m24 == b.m24 &&
              a.m31 == b.m31 &&
              a.m32 == b.m32 &&
              a.m33 == b.m33 &&
              a.m34 == b.m34 &&
              a.m41 != b.m41 &&
              a.m42 != b.m42 &&
              a.m43 != b.m43 &&
              a.m44 == b.m44,
          true);
    });

    // A test for Equals (Matrix4x4)
    test('matrix4x4EqualsTest1', () {
      final a = generateMatrixNumberFrom1To16();
      var b = generateMatrixNumberFrom1To16();

      // case 1: compare between same values
      var expected = true;
      var actual = a == b;
      expect(actual, expected);

      // case 2: compare between different values
      b = b.copyWith(m11: 11.0);
      expected = false;
      actual = a == b;
      expect(actual, expected);
    });

    // A test for IsIdentity
    test('matrix4x4IsIdentityTest', () {
      expect(Matrix4x4.identity.isIdentity, true);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          true);
      expect(
          const Matrix4x4(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1)
              .isIdentity,
          false);
      expect(
          const Matrix4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)
              .isIdentity,
          false);
    });

    // A test for Matrix4x4 comparison involving NaN values
    test('matrix4x4EqualsNanTest', () {
      const a =
          Matrix4x4(double.nan, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
      const b =
          Matrix4x4(0, double.nan, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
      const c =
          Matrix4x4(0, 0, double.nan, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
      const d =
          Matrix4x4(0, 0, 0, double.nan, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
      const e =
          Matrix4x4(0, 0, 0, 0, double.nan, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
      const f =
          Matrix4x4(0, 0, 0, 0, 0, double.nan, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
      const g =
          Matrix4x4(0, 0, 0, 0, 0, 0, double.nan, 0, 0, 0, 0, 0, 0, 0, 0, 0);
      const h =
          Matrix4x4(0, 0, 0, 0, 0, 0, 0, double.nan, 0, 0, 0, 0, 0, 0, 0, 0);
      const i =
          Matrix4x4(0, 0, 0, 0, 0, 0, 0, 0, double.nan, 0, 0, 0, 0, 0, 0, 0);
      const j =
          Matrix4x4(0, 0, 0, 0, 0, 0, 0, 0, 0, double.nan, 0, 0, 0, 0, 0, 0);
      const k =
          Matrix4x4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, double.nan, 0, 0, 0, 0, 0);
      const l =
          Matrix4x4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, double.nan, 0, 0, 0, 0);
      const m =
          Matrix4x4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, double.nan, 0, 0, 0);
      const n =
          Matrix4x4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, double.nan, 0, 0);
      const o =
          Matrix4x4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, double.nan, 0);
      const p =
          Matrix4x4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, double.nan);

      expect(a == Matrix4x4.zero, false);
      expect(b == Matrix4x4.zero, false);
      expect(c == Matrix4x4.zero, false);
      expect(d == Matrix4x4.zero, false);
      expect(e == Matrix4x4.zero, false);
      expect(f == Matrix4x4.zero, false);
      expect(g == Matrix4x4.zero, false);
      expect(h == Matrix4x4.zero, false);
      expect(i == Matrix4x4.zero, false);
      expect(j == Matrix4x4.zero, false);
      expect(k == Matrix4x4.zero, false);
      expect(l == Matrix4x4.zero, false);
      expect(m == Matrix4x4.zero, false);
      expect(n == Matrix4x4.zero, false);
      expect(o == Matrix4x4.zero, false);
      expect(p == Matrix4x4.zero, false);

      expect(a != Matrix4x4.zero, true);
      expect(b != Matrix4x4.zero, true);
      expect(c != Matrix4x4.zero, true);
      expect(d != Matrix4x4.zero, true);
      expect(e != Matrix4x4.zero, true);
      expect(f != Matrix4x4.zero, true);
      expect(g != Matrix4x4.zero, true);
      expect(h != Matrix4x4.zero, true);
      expect(i != Matrix4x4.zero, true);
      expect(j != Matrix4x4.zero, true);
      expect(k != Matrix4x4.zero, true);
      expect(l != Matrix4x4.zero, true);
      expect(m != Matrix4x4.zero, true);
      expect(n != Matrix4x4.zero, true);
      expect(o != Matrix4x4.zero, true);
      expect(p != Matrix4x4.zero, true);

      expect(a == Matrix4x4.zero, false);
      expect(b == Matrix4x4.zero, false);
      expect(c == Matrix4x4.zero, false);
      expect(d == Matrix4x4.zero, false);
      expect(e == Matrix4x4.zero, false);
      expect(f == Matrix4x4.zero, false);
      expect(g == Matrix4x4.zero, false);
      expect(h == Matrix4x4.zero, false);
      expect(i == Matrix4x4.zero, false);
      expect(j == Matrix4x4.zero, false);
      expect(k == Matrix4x4.zero, false);
      expect(l == Matrix4x4.zero, false);
      expect(m == Matrix4x4.zero, false);
      expect(n == Matrix4x4.zero, false);
      expect(o == Matrix4x4.zero, false);
      expect(p == Matrix4x4.zero, false);

      expect(a.isIdentity, false);
      expect(b.isIdentity, false);
      expect(c.isIdentity, false);
      expect(d.isIdentity, false);
      expect(e.isIdentity, false);
      expect(f.isIdentity, false);
      expect(g.isIdentity, false);
      expect(h.isIdentity, false);
      expect(i.isIdentity, false);
      expect(j.isIdentity, false);
      expect(k.isIdentity, false);
      expect(l.isIdentity, false);
      expect(m.isIdentity, false);
      expect(n.isIdentity, false);
      expect(o.isIdentity, false);
      expect(p.isIdentity, false);

      // Counterintuitive result - IEEE rules for NaN comparison are weird!
      expect(a == a, false);
      expect(b == b, false);
      expect(c == c, false);
      expect(d == d, false);
      expect(e == e, false);
      expect(f == f, false);
      expect(g == g, false);
      expect(h == h, false);
      expect(i == i, false);
      expect(j == j, false);
      expect(k == k, false);
      expect(l == l, false);
      expect(m == m, false);
      expect(n == n, false);
      expect(o == o, false);
      expect(p == p, false);
    });

    test('perspectiveFarPlaneAtInfinityTest', () {
      const nearPlaneDistance = 0.125;
      final m =
          Matrix4x4.perspective(1.0, 1.0, nearPlaneDistance, double.infinity);
      expect(m.m33, -1.0);
      expect(m.m43, -nearPlaneDistance);
    });

    test('perspectiveFieldOfViewFarPlaneAtInfinityTest', () {
      const nearPlaneDistance = 0.125;
      final m = Matrix4x4.perspectiveFieldOfView(
          toRadians(60.0), 1.5, nearPlaneDistance, double.infinity);
      expect(m.m33, -1.0);
      expect(m.m43, -nearPlaneDistance);
    });

    test('perspectiveOffCenterFarPlaneAtInfinityTest', () {
      const nearPlaneDistance = 0.125;
      final m = Matrix4x4.perspectiveOffCenter(
          0.0, 0.0, 1.0, 1.0, nearPlaneDistance, double.infinity);
      expect(m.m33, -1.0);
      expect(m.m43, -nearPlaneDistance);
    });
  });
}
