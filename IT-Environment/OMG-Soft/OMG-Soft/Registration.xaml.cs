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
using System.Windows.Shapes;
using System.IO;

namespace OMG_Soft
{
    /// <summary>
    /// Логика взаимодействия для Registration.xaml
    /// </summary>
    public partial class Registration : Window
    {
        public Registration()
        {
            InitializeComponent();
        }
        private string ImagePath = "E:\\CourseProject\\IT-Environment\\OMG-Soft\\OMG-Soft\\Resources\\Pictures\\Users\\koshka-vysovyvaet-konchik-yazyka1-1024x730.jpg";
        private byte[] _imageBytes = null;
        private void Window_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void btSubmit_Click(object sender, RoutedEventArgs e)
        {
            string checkcmd = "INSERT INTO CUSTOMERS (CUSTOMERS, CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME, CUSTOMERS_NAME, CUSTOMERS_CART, CUSTOMERS_CONTACTS, CUSTOMERS_PHOTO) VALUES (@CUSTOMERS, @CUSTOMERS_PASSWORD, @CUSTOMERS_SURNAME, @CUSTOMERS_NAME, @CUSTOMERS_CART, @CUSTOMERS_CONTACTS, @CUSTOMERS_PHOTO)";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);

            using (var fs = new FileStream(ImagePath, FileMode.Open, FileAccess.Read))
            {
                _imageBytes = new byte[fs.Length];
                fs.Read(_imageBytes, 0, System.Convert.ToInt32(fs.Length));
            }

            check.Parameters.AddWithValue("@CUSTOMERS", tbUserLogin.Text);
            check.Parameters.AddWithValue("@CUSTOMERS_PASSWORD", tbUserPassword.Password);
            check.Parameters.AddWithValue("@CUSTOMERS_SURNAME", tbSurname.Text);
            check.Parameters.AddWithValue("@CUSTOMERS_NAME", tbName.Text);
            check.Parameters.AddWithValue("@CUSTOMERS_CART", tbCard.Text);
            check.Parameters.AddWithValue("@CUSTOMERS_CONTACTS", tbUserMail.Text);
            check.Parameters.AddWithValue("@CUSTOMERS_PHOTO", _imageBytes);
            try
            {
                one.Open();
                check.ExecuteNonQuery();
                this.Close();
                MainWindow insert = new MainWindow();
                insert.ShowDialog();
                
            }
            catch (SqlException ex)
            {
                throw new ApplicationException("error insert new_tovar", ex);
            }
            finally
            {
                one.Close();
            }
        }

        private void BtCancel_Click(object sender, RoutedEventArgs e)
        {         
            this.Close();
            MainWindow back = new MainWindow();
            back.ShowDialog();
            
        }

        private void Grid_Loaded(object sender, RoutedEventArgs e)
        {
            if (MainWindow.language == 0)
            {
                Resources.Source = MainWindow.DarkRus;
            }
            else
            {
                Resources.Source = MainWindow.DarkEng;
            }
        }
    }
}
