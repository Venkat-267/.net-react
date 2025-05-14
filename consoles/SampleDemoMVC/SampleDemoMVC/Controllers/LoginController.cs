using Microsoft.AspNetCore.Mvc;
using SampleDemoMVC.Models;

namespace SampleDemoMVC.Controllers
{
    public class LoginController : Controller
    {
        public IActionResult Index()
        {
            return View("Login");
        }

        public List<LoginUser> PutValue()
        {
            var users = new List<LoginUser>
            {
                new LoginUser{id=1,username="venkat",password="asf"},
                new LoginUser{id=2,username="dc",password="vffg"},
                new LoginUser{id=3,username="bf",password="gbf"},
                new LoginUser{id=4,username="gtr",password="gbg"}

            };

            return users;
        }

        [HttpPost]
        public IActionResult Verify(LoginUser usr)
        {
            var u = PutValue();
            var ue= u.Where(u=>u.username.Equals(usr.username));
            var up = ue.Where(p => p.password.Equals(usr.password));

            if (up.Count() == 1)
            {
                ViewBag.message = "LoginSuccess";
                return View("LoginSuccess");
            }
            else
            {
                ViewBag.message = "LoginFailed";
                return View("LoginFailed");
            }
        }
    }
}
