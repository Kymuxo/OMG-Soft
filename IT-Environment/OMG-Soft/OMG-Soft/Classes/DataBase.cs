using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization.Json;


namespace OMG_Soft.Classes
{
    class DataBase
    {
        DataContractJsonSerializer jsonformatter = new DataContractJsonSerializer(typeof(List<Task>));

        private string path = @"E:\CourseProject\IT-Environment\OMG-Soft\OMG-Soft\bin\Debug\Tasks.json";

        public List<Task> GetTasks()
        {
            bool flag = false;
            List<Task> tasks;
            using (FileStream fs = new FileStream(path, FileMode.OpenOrCreate))
            {
                try
                {
                    tasks = (List<Task>)jsonformatter.ReadObject(fs);
                    tasks = tasks.OrderBy((x) => x.Title).ToList();
                }
                catch
                {
                    tasks = new List<Task>();
                    flag = true;
                }
            }
            if (flag)
            {
                using (FileStream fs = new FileStream(path, FileMode.Create))
                {
                    jsonformatter.WriteObject(fs, tasks);
                }
            }
            return tasks;
        }

        public void AddTask(Task task)
        {
            var list = GetTasks();
            list.Add(task);
            using (FileStream fs = new FileStream(path, FileMode.Create))
            {
                jsonformatter.WriteObject(fs, list);
            }
        }

        public void RemoveTask(Task task)
        {
            var list = GetTasks();
            list.RemoveAll(x => x.Title == task.Title && x.Category == task.Category && x.StartTime == task.StartTime);
            using (FileStream fs = new FileStream(path, FileMode.Create))
            {
                jsonformatter.WriteObject(fs, list);
            }
        }

        public void EditTask(Task task, Task task2)
        {
            if (task != null && task2 != null)
            {
                RemoveTask(task);
                AddTask(task2);
            }
        }
    }
}
