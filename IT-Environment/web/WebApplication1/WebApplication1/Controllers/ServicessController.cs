using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;
using System.Data.SqlClient;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Threading.Tasks;


namespace WebApplication1.Controllers
{
    public class ServicessController : Controller
    {
        SqlConnection SqlConnection;
        // GET: Servicess
        public ActionResult Index()
        {
            var services = new Servicess
            {
                ServiceName = "IT-аутсорсинг",
                ServicePrice = "6",
                ServiceSpeciality = "IT-аутсорсинг"
            };

            return View("Index", services);
        }

        public List<Servicess> GetServicess()
        {
            List<Servicess> servicess = new List<Servicess>();
            string query = "Select * from SERVICESS";

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
                servicess.Add(new Servicess()
                {
                    ServiceName = row[0].ToString(),
                    ServicePrice = row[1].ToString(),
                    ServiceSpeciality = row[2].ToString(),
                    
                });
            }
            sqlReader.Close();
            return servicess;
        }

        public ActionResult All()
        {
          

            return View(GetServicess());
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