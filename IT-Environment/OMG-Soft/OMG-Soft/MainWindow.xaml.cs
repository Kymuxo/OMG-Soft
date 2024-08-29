using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Data.SqlClient;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace OMG_Soft
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        public static string connection = @"Data Source=ADMIN\SQLEXPRESS;Initial Catalog=ITEnvironment;Integrated Security=True";
        public static Uri DarkRus = new Uri("E:/CourseProject/IT-Environment/OMG-Soft/OMG-Soft/Resources/Dictionaries/ThemeDarkLanguageRUS.xaml");
        public static Uri DarkEng = new Uri("E:/CourseProject/IT-Environment/OMG-Soft/OMG-Soft/Resources/Dictionaries/ThemeDarkLanguageENG.xaml");
        public static Uri LightRus = new Uri("E:/CourseProject/IT-Environment/OMG-Soft/OMG-Soft/Resources/Dictionaries/ThemeLightLanguageRUS.xaml");
        public static Uri LightEng = new Uri("E:/CourseProject/IT-Environment/OMG-Soft/OMG-Soft/Resources/Dictionaries/ThemeLightLanguageENG.xaml");

        public static string quantity;
        public static string quantity1;
        public static int language = 0;
        public static int theme = 0;

        private void Close_Click(object sender, RoutedEventArgs e)
        {
            Environment.Exit(0);
        }

        private void Window_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void btRegestration_Click(object sender, RoutedEventArgs e)
        {
            this.Hide();
            Registration registration = new Registration();
            registration.ShowDialog();
            
        }

        private void btSubmit_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = tbLogin.Text.ToString();
            string passwordCheck = tbPassword.Password;
            quantity = loginCheck;
            quantity1 = passwordCheck;
            int index = 1;

            switch (index)
            {
                case 1:
                    string checkcmd = $"Select * from CUSTOMERS where CUSTOMERS ='{loginCheck}' and CUSTOMERS_PASSWORD = '{passwordCheck}'";
                    SqlConnection one = new SqlConnection(connection);
                    SqlCommand check = new SqlCommand(checkcmd, one);
                    one.Open();
                    check.Prepare();
                    check.ExecuteNonQuery();
                    if (loginCheck == (string)check.ExecuteScalar())
                    {
                        this.Hide();
                        Menu main = new Menu();
                        main.ShowDialog();
                        
                    }
                    else
                    {
                        one.Close();
                        goto case 2;
                    }
                    break;
                case 2:
                    string checkcmd1 = $"Select * from WORKERS where WORKERS ='{loginCheck}' and WORKERS_PASSWORD = '{passwordCheck}'";
                    SqlConnection one1 = new SqlConnection(connection);
                    SqlCommand check1 = new SqlCommand(checkcmd1, one1);
                    one1.Open();
                    check1.Prepare();
                    check1.ExecuteNonQuery();
                    if (loginCheck == (string)check1.ExecuteScalar())
                    {
                        this.Hide();
                        WorkersCabinet main = new WorkersCabinet();
                        main.ShowDialog();
                        

                    }
                    else
                    {
                        one1.Close();
                        goto case 3;
                    }
                    break;
                case 3:
                    string checkcmd3 = $"Select * from ADMINS where ADMINS ='{loginCheck}' and ADMINS_PASSWORD = '{passwordCheck}'";
                    SqlConnection one3 = new SqlConnection(connection);
                    SqlCommand check3 = new SqlCommand(checkcmd3, one3);
                    one3.Open();
                    check3.Prepare();
                    check3.ExecuteNonQuery();
                    if (loginCheck == (string)check3.ExecuteScalar())
                    {
                        this.Hide();
                        AdminsCabinet main = new AdminsCabinet();
                        main.ShowDialog();
                        
                    }
                    else
                    {
                        one3.Close();
                        goto case 4;
                    }
                    break;
                case 4:
                    MessageBox.Show("Неверный логин или пароль!");
                    break;

            }
        }

        private void Grid_Loaded(object sender, RoutedEventArgs e)
        {
            
            if (language == 0)
            {
                Resources.Source = DarkRus;
                CheckRu.IsSelected = true;
            }
            else
            {
                Resources.Source = DarkEng;
                CheckEn.IsSelected = true;
            }
        }

        private void ChooseLanguage_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if(CheckRu.IsSelected == true)
            {
                Resources.Source = DarkRus;
                language = 0;
            }
            if (CheckEn.IsSelected == true)
            {
                Resources.Source = DarkEng;
                language = 1;
            }
        }
    }
}
