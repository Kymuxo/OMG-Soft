using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;


namespace OMG_Soft
{
    /// <summary>
    /// Логика взаимодействия для AddTask.xaml
    /// </summary>
    public partial class AddTask : Window
    {
        private bool editFlag = false;
        private Classes.Task oldTask;

        public AddTask()
        {
            editFlag = false;
            InitializeComponent();
        }

        public AddTask(Classes.Task Task)
        {
            InitializeComponent();
            if (Task != null)
            {
                oldTask = new Classes.Task(Task);
                Title.Text = Task.Title;
                Category.Text = Task.Category;
                Priority.Text = Task.Priority;
                Status.Text = Task.Status;
                More.Text = Task.More;
            }
        }

        private void Grid_Loaded(object sender, RoutedEventArgs e)
        {
            int index = 0;
            switch (index)
            {
                case 0:
                    if (MainWindow.language == 0 && MainWindow.theme == 0)
                    {
                        Resources.Source = MainWindow.DarkRus;
                    }
                    else
                    {
                        goto case 1;
                    }
                    break;
                case 1:
                    if (MainWindow.language == 1 && MainWindow.theme == 0)
                    {
                        Resources.Source = MainWindow.DarkEng;
                    }
                    else
                    {
                        goto case 2;
                    }
                    break;
                case 2:
                    if (MainWindow.language == 0 && MainWindow.theme == 1)
                    {
                        Resources.Source = MainWindow.LightRus;
                    }
                    else
                    {
                        goto case 3;
                    }
                    break;
                case 3:
                    if (MainWindow.language == 1 && MainWindow.theme == 1)
                    {
                        Resources.Source = MainWindow.LightEng;
                    }
                    break;
            }
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            if (Title.Text == "" || Category.Text == "" || Priority.Text == "" || Status.Text == "")
            {
                MessageBox.Show("Проверьте   данные");
                return;
            }
            if (!editFlag)
            {
                (new Classes.DataBase()).AddTask((new Classes.Task(Title.Text, Category.Text, Priority.Text, DateTime.Now, Status.Text, More.Text)));
            }
            else
            {
                (new Classes.DataBase()).EditTask(oldTask, (new Classes.Task(Title.Text, Category.Text, Priority.Text, DateTime.Now, Status.Text, More.Text)));
            }
            this.Close();
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
