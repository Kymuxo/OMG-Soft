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
    /// Логика взаимодействия для TOP.xaml
    /// </summary>
    public partial class TOP : Window
    {
        public TOP()
        {
            InitializeComponent();
        }

        private void Grid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void TOPOfProducts_Click(object sender, RoutedEventArgs e)
        {
            lbTOPs.Items.Clear();
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string query = $"Select top 5 PRODUCTS_AMT, PRODUCTS from PRODUCTS order by PRODUCTS_AMT desc";
           
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(query, one);
            one.Open();
            SqlDataReader sqlReader = null;
            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    lbTOPs.Items.Add(Convert.ToString(sqlReader["PRODUCTS"]));
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(), MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {

                if (sqlReader != null)
                    sqlReader.Close();
            }
        }

        private void TOPOfServices_Click(object sender, RoutedEventArgs e)
        {
            lbTOPs.Items.Clear();
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string query = $"Select top 5 SERVICESS_AMT, SERVICESS from SERVICESS order by SERVICESS_AMT desc";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(query, one);
            one.Open();
            SqlDataReader sqlReader = null;
            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    lbTOPs.Items.Add(Convert.ToString(sqlReader["SERVICESS"]));
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(), MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {

                if (sqlReader != null)
                    sqlReader.Close();
            }
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
