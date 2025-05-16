using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MoQDemo
{
    public interface IHSMModule
    {
        bool ValidatePIN(string cardNumber, int pin);
    }
}
