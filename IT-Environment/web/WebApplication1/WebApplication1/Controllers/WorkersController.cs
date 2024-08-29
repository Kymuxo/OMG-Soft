using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class WorkersController : Controller
    {
        // GET: Workers
        public ActionResult Index()
        {
            
            return View();
        }


        public List<Workers> GetWorkers()
        {
            List<Workers> services = new List<Workers>();
            string query = "Select * from WORKERS";

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
                services.Add(new Workers()
                {
                    
                    Surname = row[0].ToString(),
                    Name = row[1].ToString(),
                    Password = row[2].ToString(),
                    WorkYeats = System.Convert.ToInt32(row[5]),
                    Contacts = row[6].ToString(),
                });
                
            }
            sqlReader.Close();
            return services;
        }

        public ActionResult All()
        {


            return View(GetWorkers());

        }
    }

    
}