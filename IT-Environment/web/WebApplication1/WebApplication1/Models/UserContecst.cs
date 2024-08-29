using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace WebApplication1.Models
{
    public class UserContecst : DbContext
    {
        public UserContecst() :
            base("DefaultConnection")
        { }

        public DbSet<User> Users { get; set; }//контекст данных будет взаимодействовать с таблицей пользователей
    }
}