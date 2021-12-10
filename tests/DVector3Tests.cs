using NUnit.Framework;

namespace Vim.Math3d.Tests
{
    public class DVector3Tests
    {
        // A test for Cross (DVector3, DVector3)
        [Test]
        public void DVector3CrossTest()
        {
            var a = new DVector3(1.0d, 0.0d, 0.0d);
            var b = new DVector3(0.0d, 1.0d, 0.0d);

            var expected = new DVector3(0.0d, 0.0d, 1.0d);
            DVector3 actual;

            actual = MathOps.Cross(a, b);
            Assert.True(MathHelper.Equal(expected, actual), "Vector3f.Cross did not return the expected value.");
        }
    }
}
