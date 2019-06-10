using System;

namespace Ara3D
{
    public interface IMappable<TContainer, TPart>
    {
        TContainer Map(Func<TPart, TPart> f);
    }
}
