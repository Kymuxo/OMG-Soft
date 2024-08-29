using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class MapControllerController : Controller
    {
        // GET: Map

        public ActionResult Index()
        {
            //// получаем ip клиента (если не локальный хост)
            //string IP = HttpContext.Request.UserHostAddress;
            //string coordinates = "";
            //// получаем географию
            //ViewBag.Location = DefineLocation(IP, ref coordinates);
            //ViewBag.Coords = coordinates;
            return View();
        }

        public JsonResult GetData()
        {
            // создадим список данных
            List<Station> stations = new List<Station>();
            stations.Add(new Station()
            {
                Id = 1,
                PlaceName = "Библиотека имени Ленина",
                GeoLong = 53.90465139,
                GeoLat = 27.54732513,
                Line = "Сокольническая",
                Traffic = 1.0
            });
            stations.Add(new Station()
            {
                Id = 2,
                PlaceName = "Александровский сад",
                GeoLong = 53.94248239,
                GeoLat = 27.66680145,
                Line = "Арбатско-Покровская",
                Traffic = 1.2
            });
            stations.Add(new Station()
            {
                Id = 3,
                PlaceName = "Боровицкая",
                GeoLong = 53.94773248,
                GeoLat = 27.51196289,
                Line = "Серпуховско-Тимирязевская",
                Traffic = 1.0
            });
            //////////////////////////////////////////////////
            stations.Add(new Station()
            {
                Id = 1,
                PlaceName = "Библиотека имени Ленина",
                GeoLong = 53.89472216,
                GeoLat = 27.46973419,
                Line = "Сокольническая",
                Traffic = 1.0
            });
            stations.Add(new Station()
            {
                Id = 1,
                PlaceName = "Библиотека имени Ленина",
                GeoLong = 61.18521907,
                GeoLat = 57.44531035,
                Line = "Сокольническая",
                Traffic = 1.0
            });
            stations.Add(new Station()
            {
                Id = 1,
                PlaceName = "Библиотека имени Ленина",
                GeoLong = 43.94644861,
                GeoLat = -113.06250215,
                Line = "Сокольническая",
                Traffic = 1.0
            });
            stations.Add(new Station()
            {
                Id = 1,
                PlaceName = "Библиотека имени Ленина",
                GeoLong = 28.11990086,
                GeoLat = -81.77343965,
                Line = "Сокольническая",
                Traffic = 1.0
            });

            return Json(stations, JsonRequestBehavior.AllowGet);
        }


    }
}