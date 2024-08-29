using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OMG_Soft.Classes
{
    [Serializable]
    public class Task
    {
        public Task(Task task)
        {
            if (task != null)
            {
                this.Title = task.Title;
                this.Category = task.Category;
                this.Priority = task.Priority;
                this.StartTime = task.StartTime;

                this.Status = task.Status;
                this.More = task.More;
            }
        }

        public Task(string title, string category, string priority, DateTime startTime, string status, string more)
        {
            Title = title;
            Category = category;
            Priority = priority;
            StartTime = startTime;
            Status = status;
            More = more;
        }

        public string Title { get; set; }
        public string Category { get; set; }
        public string Priority { get; set; }
        public DateTime StartTime { get; set; }

        public string GetStartTime { get { return StartTime.ToShortDateString(); } }
        public string Status { get; set; }
        public string More { get; set; }
    }
}
