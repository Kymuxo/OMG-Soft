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
    /// Логика взаимодействия для Basket.xaml
    /// </summary>
    public partial class Basket : Window
    {
        public Basket()
        {
            InitializeComponent();
        }

        static int c;
        static int c2;
        static int sum;

        private void Grid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void cbProducts_Select(object sender, EventArgs e)
        {
            cbProducts.Items.Clear();
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from PRODUCTS";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;
            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    cbProducts.Items.Add(Convert.ToString(sqlReader["PRODUCTS"]));
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

        private void cbWorkers_Select(object sender, EventArgs e)
        {
            cbWorkers.Items.Clear();
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from WORKERS where SERVICESS = '{cbServices.Text}'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;

            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    cbWorkers.Items.Add(Convert.ToString(sqlReader["WORKERS"]));
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

        private void cbServices_Select(object sender, EventArgs e)
        {
            cbServices.Items.Clear();
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from SERVICESS";

            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);

            one.Open();

            SqlDataReader sqlReader = null;
            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    cbServices.Items.Add(Convert.ToString(sqlReader["SERVICESS"]));
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

        private void btInCabinet_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            Cabinet main = new Cabinet();
            main.ShowDialog();
            
        }

        private void btEnter_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string query = $"INSERT INTO ORDERS (SERVICESS, PRODUCTS, ORDERS_DATE,ORDERS_WORKER, ORDERS_COST, CUSTOMERS, ORDERS_ADRES) VALUES (@SERVICESS, @PRODUCTS, @ORDERS_DATE, @ORDERS_WORKER, @ORDERS_COST, @CUSTOMERS, @ORDERS_ADRES)";
            string checkcmd1 = $"Select SERVICESS_PRICE from SERVICESS where SERVICESS = '{cbServices.Text}'";
            string checkcmd2 = $"Select PRODUCTS_COST from PRODUCTS where PRODUCTS = '{cbProducts.Text}'";
            string checkcmd3 = $"Select * from ORDERS where CUSTOMERS = '{loginCheck}'";


            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(query, one);
            SqlCommand check1 = new SqlCommand(checkcmd1, one);
            SqlCommand check2 = new SqlCommand(checkcmd2, one);
            SqlCommand check3 = new SqlCommand(checkcmd3, one);

            one.Open();
            SqlDataReader sqlReader = null;
            SqlDataReader sqlReader1 = null;
            SqlDataReader sqlReader2 = null;
            SqlDataReader sqlReader3 = null;


            string checkcmd4 = $"Update PRODUCTS Set [PRODUCTS_AMT] = @PRODUCTS_AMT where PRODUCTS = '{cbProducts.Text}'";
            string checkcmd5 = $"Select PRODUCTS_AMT from PRODUCTS where PRODUCTS = '{cbProducts.Text}'";
            SqlCommand check4 = new SqlCommand(checkcmd4, one);
            SqlCommand check5 = new SqlCommand(checkcmd5, one);
            SqlDataReader sqlReader4 = null;
            SqlDataReader sqlReader5 = null;
            try
            {
                int k = 0;
                if (cbProducts.Text == "Не выбрано" || cbServices.Text == "Не выбрано")
                {
                    k = 0;
                }
                else
                {
                    sqlReader5 = check5.ExecuteReader();
                    while (sqlReader5.Read())
                    {
                        k = Convert.ToInt32(sqlReader5["PRODUCTS_AMT"]);
                    }
                    if (sqlReader5 != null)
                        sqlReader5.Close();
                    check4.Parameters.AddWithValue("@PRODUCTS_AMT", k + 1);
                    check4.ExecuteNonQuery();


                    if (sqlReader4 != null)
                        sqlReader4.Close();
                }
                
                sqlReader1 = check1.ExecuteReader();
                while (sqlReader1.Read())
                {
                    c = Convert.ToInt32(sqlReader1["SERVICESS_PRICE"]);
                }
                if (sqlReader1 != null)
                    sqlReader1.Close();
                sqlReader2 = check2.ExecuteReader();
                while (sqlReader2.Read())
                {
                    c2 = Convert.ToInt32(sqlReader2["PRODUCTS_COST"]);


                }
                if (sqlReader2 != null)
                    sqlReader2.Close();

                sum = c + c2;
                sqlReader3 = check3.ExecuteReader();
                if (!sqlReader3.Read())
                {
                    MessageBox.Show("Это Ваш первый заказ, поздравляем! \n Вам предоставлена скидка 20%.");
                    sum = sum - (sum * 20 / 100);
                }
                if (sqlReader3 != null)
                    sqlReader3.Close();
                if (cbServices.Text == "" && cbProducts.Text == "")
                {
                    MessageBox.Show("Выберите товар или услугу");
                }
                else if (cbServices.Text == "")
                {
                    cbServices.Text = "Не выбрано";
                    cbWorkers.Text = "Не требуется";
                }
                else if (cbProducts.Text == "")
                {
                    cbProducts.Text = "Не выбрано";
                }
                else if (cbWorkers.Text == "")
                {
                    MessageBox.Show("Выберите работника");
                }

                int index = 1;
                switch (index)
                {
                    case 1:

                        if (sum >= 50)
                        {
                            //скидка 20%
                            MessageBox.Show("Ваш заказ на сумму: " + sum + "p. \n Вам предоставлена скидка 20%.");
                            sum = sum - (sum * 20 / 100);

                        }
                        else
                        {
                            goto case 2;
                        }
                        break;
                    case 2:

                        if (sum >= 30 && sum < 50)
                        {
                            //скидка 10%
                            MessageBox.Show("Ваш заказ на сумму: " + sum + "p. \n Вам предоставлена скидка 10%.");
                            sum = sum - (sum * 10 / 100);
                        }
                        else
                        {
                            goto case 3;
                        }
                        break;
                    case 3:

                        if (sum >= 15 && sum < 30)
                        {
                            //скидка 5%
                            MessageBox.Show("Ваш заказ на сумму: " + sum + "p. \n Вам предоставлена скидка 5%.");
                            sum = sum - (sum * 5 / 100);
                        }
                        else
                        {
                            goto case 4;
                        }
                        break;
                    case 4:
                        //скидки нет
                        break;

                }
                check.Parameters.AddWithValue("@SERVICESS", cbServices.Text);
                check.Parameters.AddWithValue("@PRODUCTS", cbProducts.Text);
                check.Parameters.AddWithValue("@ORDERS_DATE", monthCalendar.SelectedDate.Value.Date.ToShortDateString().ToString());
                check.Parameters.AddWithValue("@ORDERS_WORKER", cbWorkers.Text);
                check.Parameters.AddWithValue("@ORDERS_COST", sum);
                check.Parameters.AddWithValue("@CUSTOMERS", loginCheck);
                check.Parameters.AddWithValue("@ORDERS_ADRES", tbAdress.Text);
                string order = "Ваш заказ \n услуга:" + cbServices.Text + "\n товар:" + cbProducts.Text + "\n Стоимость заказа: " + sum + "р.";
                MessageBox.Show(order);
                check.ExecuteNonQuery();


            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(), MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {

                if (sqlReader != null)
                    sqlReader.Close();


                if (sqlReader3 != null)
                    sqlReader3.Close();
                cbServices.Text = string.Empty;
                cbProducts.Text = string.Empty;
                cbWorkers.Text = string.Empty;
                tbAdress.Text = string.Empty;
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
    }
}
