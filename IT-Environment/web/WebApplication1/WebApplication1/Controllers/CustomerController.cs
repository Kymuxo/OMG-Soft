using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;
using System.Data.SqlClient;

namespace WebApplication1.Controllers
{
    public class CustomerController : Controller
    {
        // GET: Customer
        public ActionResult Index(string login)
        {
            ViewBag.Login = login;
            return View();
        }
        public List<Customers> GetCustomers()
        {
            List<Customers> servicess = new List<Customers>();
            string query = "Select * from CUSTOMERS";

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
                servicess.Add(new Customers()
                {
                    Login = row[0].ToString(),
                    Password = row[1].ToString(),
                    Name = row[3].ToString(),
                    Surname = row[2].ToString(),
                    Cart = row[4].ToString(),
                    Cotacts= row[5].ToString(),
                });
            }
            sqlReader.Close();
            return servicess;
        }

        public ActionResult Index(Customers customers)
        {
            //GetCustomers();
            
            for(int i = 0; i < 13; i++)
            {
                if(customers.Login == customers.InputLogin && customers.Password == customers.InputPassword)
                {
                    ViewBag.Hed = "Yes";
                }
                else
                {
                    ViewBag.Hed = "No";
                }
            }
            return View();
        }
    }
}