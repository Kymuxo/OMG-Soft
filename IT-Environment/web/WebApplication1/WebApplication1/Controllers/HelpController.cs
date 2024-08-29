using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class HelpController : Controller
    {
        // GET: Help
        public ActionResult Index()
        {
            return View();
        }

        public List<Help> GetHelp()
        {
            List<Help> services = new List<Help>();
            string query = "Select * from HELP";

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
                services.Add(new Help()
                {

                    Question = row[0].ToString(),
                    Answer = row[1].ToString(),
                    
                });

            }
            sqlReader.Close();
            return services;
        }

        public ActionResult All()
        {


            return View(GetHelp());

        }
    }
}