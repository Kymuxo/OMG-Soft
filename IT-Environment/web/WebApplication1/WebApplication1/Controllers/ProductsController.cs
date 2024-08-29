using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Threading.Tasks;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class ProductsController : Controller
    {
        // GET: Products
        public ActionResult Index()
        {
            var services = new Products
            {
                Name = "IT-аутсорсинг",
                Cost = 6,
                Atm = 6
            };

            return View("Index", services);
        }

        public List<Products> GetProductss()
        {
            List<Products> servicess = new List<Products>();
            string query = "Select * from PRODUCTS";

            string conparms = @"Data Source=ADMIN\SQLEXPRESS;Initial Catalog=ITEnvironment;Integrated Security=True";
            SqlConnection one = new SqlConnection(conparms);
            SqlCommand check = new SqlCommand(query, one);
            one.Open();
            SqlDataReader sqlReader = null;
            sqlReader = check.ExecuteReader();

            object[] row;
            while (sqlReader.Read())
            {
                row = new object[sqlReader.FieldCount];
                sqlReader.GetValues(row);
                servicess.Add(new Products()
                {
                    Name = row[0].ToString(),
                    Cost = System.Convert.ToInt32(row[1]),
                    Atm = System.Convert.ToInt32(row[2]),
                     
                });
            }
            sqlReader.Close();
            return servicess;
        }

        public ActionResult All()
        {


            return View(GetProductss());
            //var servicess = new List<Servicess>
            //{

            //    new Servicess
            //    {
            //        ServiceName = "IT-аутсорсинг",
            //    ServicePrice = 6,
            //    ServiceSpeciality = "IT-аутсорсинг"
            //    },

            //    new Servicess
            //    {
            //        ServiceName = "Создание ЛВС",
            //    ServicePrice = 6,
            //    ServiceSpeciality = "Системный администратор"
            //    },

            //    new Servicess
            //    {
            //        ServiceName = "Безопасность сети",
            //    ServicePrice = 6,
            //    ServiceSpeciality = "Специалист по информационной безопасности"
            //    },

            //    new Servicess
            //    {
            //        ServiceName = "Поддержка ПО",
            //    ServicePrice = 6,
            //    ServiceSpeciality = "Системный программист"
            //    },

            //    new Servicess
            //    {
            //        ServiceName = "Оптимизация сети",
            //    ServicePrice = 6,
            //    ServiceSpeciality = "Сетевой администратор"
            //    },
            //};
            //return View(servicesss);
        }
    }
}