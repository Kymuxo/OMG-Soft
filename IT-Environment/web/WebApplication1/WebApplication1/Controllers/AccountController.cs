using WebApplication1.Models;
using System;

using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ItEnvironment.Controllers
{
    public class AccountController : Controller
    {
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel model)
        {
            if (ModelState.IsValid)//проверяем модель на корректность
                                   //
            {
                User user = null;
                using (UserContecst db = new UserContecst())//обращаемся к еонтексту данных
                {
                    user = db.Users.FirstOrDefault(u => u.Email == model.Name);
                }
                //if have user
                if (user != null)
                {
                    FormsAuthentication.SetAuthCookie(model.Name, true);
                    return RedirectToAction("Index", "Home");//переадресация на метод индекс контроллера хоум
                }
            }
            else
            {
                ModelState.AddModelError("", "This login have already token");
            }
            return View(model);//возвращаем модель в прее=дставление
        }

        // GET: Account гет версия
        public ActionResult Register()
        {
            return View();
        }
        //пост версия
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterModel model)
        {
            if (ModelState.IsValid)//проверяем модель на корректность
                                   //
            {
                User user = null;
                using (UserContecst db = new UserContecst())//обращаемся к еонтексту данных
                {
                    user = db.Users.FirstOrDefault(u => u.Email == model.Name);
                }
                if (user == null)//если поьзователь не найден
                {
                    //new user
                    using (UserContecst db = new UserContecst())
                    {
                        db.Users.Add(new User { Email = model.Name, Password = model.Password, Age = model.Age });
                        db.SaveChanges();

                        user = db.Users.Where(u => u.Email == model.Name && u.Password == model.Password).FirstOrDefault();
                    }
                    //if have user
                    if (user != null)
                    {
                        FormsAuthentication.SetAuthCookie(model.Name, true);
                        return RedirectToAction("Index", "Home");//переадресация на метод индекс контроллера хоум
                    }
                }
            }
            else
            {
                ModelState.AddModelError("", "This login have already token");
            }
            return View(model);//возвращаем модель в прее=дставление
        }
        //return View(model);
    }
}