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
    /// Логика взаимодействия для WorkersCabinet.xaml
    /// </summary>
    public partial class WorkersCabinet : Window
    {
        public WorkersCabinet()
        {
            InitializeComponent();
        }

        private void Grid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void Grid_Loaded(object sender, RoutedEventArgs e)
        {
            pInfo.Visibility = Visibility.Collapsed;
            lbCustomerLogin.Visibility = Visibility.Collapsed;
            lbOrderAdres.Visibility = Visibility.Collapsed;
            lbOrderCost.Visibility = Visibility.Collapsed;
            lbOrderDate.Visibility = Visibility.Collapsed;
            btMoreInfo.Visibility = Visibility.Collapsed;
        }

        private void MonthCalendar_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            pInfo.Visibility = Visibility.Collapsed;
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from ORDERS where ORDERS_WORKER ='{loginCheck}'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;

            try
            {

                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {

                    lbCustomerLogin.Content = monthCalendar.SelectedDate.Value.Date.ToShortDateString().ToString();
                    string ss = monthCalendar.SelectedDate.Value.Date.ToShortDateString().ToString();
                    string s = Convert.ToString(sqlReader["ORDERS_DATE"]);
                    s = DateTime.Parse(s).Date.ToShortDateString().ToString();

                    if (s == ss)
                    {
                        lbCustomerLogin.Visibility = Visibility.Visible;
                        lbOrderAdres.Visibility = Visibility.Visible;
                        lbOrderCost.Visibility = Visibility.Visible;
                        lbOrderDate.Visibility = Visibility.Visible;
                        btMoreInfo.Visibility = Visibility.Visible;
                        lbCustomerLogin.Content = Convert.ToString(sqlReader["CUSTOMERS"]);
                        lbOrderAdres.Content = Convert.ToString(sqlReader["ORDERS_ADRES"]);
                        lbOrderCost.Content = Convert.ToString(sqlReader["ORDERS_COST"]);
                        lbOrderDate.Content = Convert.ToString(sqlReader["ORDERS_DATE"]);
                    }
                    else
                    {
                        lbCustomerLogin.Content = "На этот день заказов нет.";
                        lbOrderAdres.Visibility = Visibility.Collapsed;
                        lbOrderCost.Visibility = Visibility.Collapsed;
                        lbOrderDate.Visibility = Visibility.Collapsed;
                        btMoreInfo.Visibility = Visibility.Collapsed;
                    }
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(), MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                if (sqlReader != null)
                {
                    sqlReader.Close();

                }
                one.Close();
            }
        }

        private void BtMoreInfo_Click(object sender, RoutedEventArgs e)
        {
            pInfo.Visibility = Visibility.Visible;
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from CUSTOMERS where CUSTOMERS ='{lbCustomerLogin.Content}'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;
            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    lbCabName.Content = Convert.ToString(sqlReader["CUSTOMERS_NAME"]);
                    lbCabSurname.Content = Convert.ToString(sqlReader["CUSTOMERS_SURNAME"]);
                    lbCabUserMail.Text = Convert.ToString(sqlReader["CUSTOMERS_CONTACTS"]);
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

        private void BtTOP_Copy_Click(object sender, RoutedEventArgs e)
        {
            Laba7_8 laba = new Laba7_8();
            laba.ShowDialog();
        }

        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            MainWindow insert = new MainWindow();
            insert.ShowDialog();
            
        }

        
    }
}
