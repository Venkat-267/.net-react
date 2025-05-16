using Moq;
using MoQDemo;

namespace ATMSystem.Tests
{
    public class Tests
    {
        ATMCashWithdrawal atmCash;

        [SetUp]
        public void Setup()
        {
            var hsmModuleMock = new Mock<IHSMModule>();
            hsmModuleMock.Setup(h => h.ValidatePIN("123456781234", 1234)).Returns(true);

            var hostBankMock = new Mock<IHostBank>();
            hostBankMock.Setup(h => h.AuthenticateAmount("123456781234", 500)).Returns(true);

            atmCash = new ATMCashWithdrawal(hsmModuleMock.Object, hostBankMock.Object);
        }
        [TestCase]
        [Test]
        public void WithdrawAmount_ValidTransaction_ReturnsTrue()
        {
            bool result = atmCash.WithdrawAmount("123456781234", 1234, 500);
            // Assert
            Assert.IsTrue(result);
        }
    }
}