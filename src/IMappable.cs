using System;

namespace Vim.Math3d
{
    public interface IMappable<TContainer, TPart>
    {
        TContainer Map(Func<TPart, TPart> f);
    }
}
