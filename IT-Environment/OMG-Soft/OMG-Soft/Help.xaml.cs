using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
    /// Логика взаимодействия для Help.xaml
    /// </summary>
    public partial class Help : Window
    {
        public Help()
        {
            InitializeComponent();
        }

        private void Grid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void Lisst_Loaded(object sender, RoutedEventArgs e)
        {
            string conparms = @"Data Source=DESKTOP-CQVO167\SQLEXPRESS;Initial Catalog=ITEnvironment;Integrated Security=True";
            string checkcmd = $"Select * from HELP";
            SqlConnection one = new SqlConnection(conparms);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;


            sqlReader = check.ExecuteReader();
            while (sqlReader.Read())
            {
                Lisst.Items.Add(Convert.ToString(sqlReader["QUESTION"]));
                Lisst.Items.Add(Convert.ToString("_________________________"));
                Lisst.Items.Add(Convert.ToString(sqlReader["ANSWER"]));
                Lisst.Items.Add(Convert.ToString("______________________________________________________________________________________"));
            }

            if (sqlReader != null)
                sqlReader.Close();
        }

        private void BtBack_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            Menu menu = new Menu();
            menu.ShowDialog();
            
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
    }
}
