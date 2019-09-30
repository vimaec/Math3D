using System;

namespace Vim
{
    public interface IMappable<TContainer, TPart>
    {
        TContainer Map(Func<TPart, TPart> f);
    }
}
