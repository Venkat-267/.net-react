using MoQDemo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MoQDemo
{
    public class ATMCashWithdrawal
    {
        private readonly IHSMModule hsmModule;
        private readonly IHostBank hostBank;

        public ATMCashWithdrawal(IHSMModule hsmModule, IHostBank hostBank)
        {
            this.hsmModule = hsmModule;
            this.hostBank = hostBank;
        }

        public bool WithdrawAmount(string cardNumber, int pin, int amount)
        {
            if (!hsmModule.ValidatePIN(cardNumber, pin))
            {
                return false;
            }
            if (!hostBank.AuthenticateAmount(cardNumber, amount))
            {
                return false;
            }
            // Withdraw the specified amount and perform other operations
            return true;
        }
    }
}
