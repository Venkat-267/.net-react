using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MoQDemo
{
    public interface IHostBank
    {
        bool AuthenticateAmount(string accountNumber, int amount);
    }
}