namespace Vim.Math3d
{
    public partial struct ColorRGBA
    {
        public static readonly ColorRGBA White = new ColorRGBA(255, 255, 255, 255);
        public static readonly ColorRGBA Black = new ColorRGBA(0, 0, 0, 255);
        public static readonly ColorRGBA LightRed = new ColorRGBA(255, 128, 128, 255);
        public static readonly ColorRGBA Transparent = new ColorRGBA(255, 255, 255, 0);
        public static readonly ColorRGBA DarkRed = new ColorRGBA(255, 0, 0, 255);
        public static readonly ColorRGBA LightGreen = new ColorRGBA(128, 255, 128, 255);
        public static readonly ColorRGBA DarkGreen = new ColorRGBA(0, 255, 0, 255);
        public static readonly ColorRGBA LightBlue = new ColorRGBA(128, 128, 255, 255);
        public static readonly ColorRGBA DarkBlue = new ColorRGBA(0, 0, 255, 255);
    }
}