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
    /// Логика взаимодействия для AdminsCabinet.xaml
    /// </summary>
    public partial class AdminsCabinet : Window
    {
        public AdminsCabinet()
        {
            InitializeComponent();
        }

        private void Grid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void ButtonOpenMenu_Click(object sender, RoutedEventArgs e)
        {
            ButtonCloseMenu.Visibility = Visibility.Visible;
            LogoImage.Visibility = Visibility.Visible;
            ButtonOpenMenu.Visibility = Visibility.Collapsed;
            HidePoint.Visibility = Visibility.Collapsed;
        }

        private void ButtonCloseMenu_Click(object sender, RoutedEventArgs e)
        {
            ButtonCloseMenu.Visibility = Visibility.Collapsed;
            ButtonOpenMenu.Visibility = Visibility.Visible;
            HidePoint.Visibility = Visibility.Visible;
        }

        private void ButtonClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            MainWindow main = new MainWindow();
            main.ShowDialog();
            
        }

        private void ListViewMenu_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            switch (((ListViewItem)((ListView)sender).SelectedItem).Name)
            {
                case "btCabinet":
                    lbInfo.Visibility = Visibility.Collapsed;
                    lbServices.Visibility = Visibility.Collapsed;
                    AddServices.Visibility = Visibility.Collapsed;
                    DeleteServices.Visibility = Visibility.Collapsed;
                    lbProducts.Visibility = Visibility.Collapsed;
                    AddProducts.Visibility = Visibility.Collapsed;
                    DeleteProducts.Visibility = Visibility.Collapsed;
                    lbWorkers.Visibility = Visibility.Collapsed;
                    AddWorkers.Visibility = Visibility.Collapsed;
                    DeleteWorkers.Visibility = Visibility.Collapsed;
                    break;
                case "btServices":
                    lbInfo.Visibility = Visibility.Visible;
                    lbServices.Visibility = Visibility.Visible;
                    AddServices.Visibility = Visibility.Visible;
                    DeleteServices.Visibility = Visibility.Visible;
                    lbProducts.Visibility = Visibility.Collapsed;
                    AddProducts.Visibility = Visibility.Collapsed;
                    DeleteProducts.Visibility = Visibility.Collapsed;
                    lbWorkers.Visibility = Visibility.Collapsed;
                    AddWorkers.Visibility = Visibility.Collapsed;
                    DeleteWorkers.Visibility = Visibility.Collapsed;
                    break;
                case "btProducts":
                    lbInfo.Visibility = Visibility.Visible;
                    lbProducts.Visibility = Visibility.Visible;
                    AddProducts.Visibility = Visibility.Visible;
                    DeleteProducts.Visibility = Visibility.Visible;
                    lbServices.Visibility = Visibility.Collapsed;
                    AddServices.Visibility = Visibility.Collapsed;
                    DeleteServices.Visibility = Visibility.Collapsed;
                    lbWorkers.Visibility = Visibility.Collapsed;
                    AddWorkers.Visibility = Visibility.Collapsed;
                    DeleteWorkers.Visibility = Visibility.Collapsed;
                    break;
                case "btWorkers":
                    lbInfo.Visibility = Visibility.Visible;
                    lbWorkers.Visibility = Visibility.Visible;
                    AddWorkers.Visibility = Visibility.Visible;
                    DeleteWorkers.Visibility = Visibility.Visible;
                    lbServices.Visibility = Visibility.Collapsed;
                    AddServices.Visibility = Visibility.Collapsed;
                    DeleteServices.Visibility = Visibility.Collapsed;
                    lbProducts.Visibility = Visibility.Collapsed;
                    AddProducts.Visibility = Visibility.Collapsed;
                    DeleteProducts.Visibility = Visibility.Collapsed;
                    break;
                default:
                    break;
            }
        }

        private void Grid_Loaded(object sender, RoutedEventArgs e)
        {
            lbInfo.Visibility = Visibility.Collapsed;
            lbServices.Visibility = Visibility.Collapsed;
            AddServices.Visibility = Visibility.Collapsed;
            DeleteServices.Visibility = Visibility.Collapsed;
            lbProducts.Visibility = Visibility.Collapsed;
            AddProducts.Visibility = Visibility.Collapsed;
            DeleteProducts.Visibility = Visibility.Collapsed;
            lbWorkers.Visibility = Visibility.Collapsed;
            AddWorkers.Visibility = Visibility.Collapsed;
            DeleteWorkers.Visibility = Visibility.Collapsed;
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from ADMINS where ADMINS ='{loginCheck}' and ADMINS_PASSWORD = '{passwordCheck}'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;

            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {

                    lbHello.Content = "Здравствуйте, " + Convert.ToString(sqlReader["ADMINS_NAME"]) + " " + Convert.ToString(sqlReader["ADMINS_PATRONYMIC"]) + "!";

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
                one.Close();
            }
        }

        private void CbWorkerSN_DropDownOpened(object sender, EventArgs e)
        {
            cbWorkerSN.Items.Clear();
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from WORKERS";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;

            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    cbWorkerSN.Items.Add(Convert.ToString(sqlReader["WORKERS"]));
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

        private void BtDeleteWorkers_Click(object sender, RoutedEventArgs e)
        {
            string checkcmd = $"Delete from WORKERS where WORKERS ='{cbWorkerSN.Text}'";
            string checkcmd1 = $"Update ORDERS Set [ORDERS_WORKER] = @ORDERS_WORKER where ORDERS_WORKER ='{cbWorkerSN.Text}'";

            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            SqlCommand check1 = new SqlCommand(checkcmd1, one);
            one.Open();

            try
            {

                check1.Parameters.AddWithValue("@ORDERS_WORKER", cbWorkerSN.Text = "Пока нет специалиста");
                check1.ExecuteNonQuery();
                check.ExecuteReader();
                MessageBox.Show("Работник уволен");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(), MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                one.Close();
            }
        }

        private void BtAddWorkers_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = "INSERT INTO WORKERS (WORKERS, WORKERS_NAME, WORKERS_PASSWORD, SERVICESS, OFFICES, WORKERS_YEARS, WORKERS_CONTACTS) VALUES (@WORKERS, @WORKERS_NAME, @WORKERS_PASSWORD, @SERVICESS, @OFFICES, @WORKERS_YEARS, @WORKERS_CONTACTS)";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            try
            {
                if (tbWorkerSurname.Text != String.Empty && tbWorkerName.Text != String.Empty && tbWorkerPassword.Text != String.Empty &&
                cbWorkerSpecialization.Text != String.Empty && cbWorkerOffice.Text != String.Empty && tbWorkerYears.Text != String.Empty && tbWorkerContacts.Text != String.Empty)
                {
                    check.Parameters.AddWithValue("@WORKERS", tbWorkerSurname.Text);
                    check.Parameters.AddWithValue("@WORKERS_NAME", tbWorkerName.Text);
                    check.Parameters.AddWithValue("@WORKERS_PASSWORD", tbWorkerPassword.Text);
                    check.Parameters.AddWithValue("@SERVICESS", cbWorkerSpecialization.Text);
                    check.Parameters.AddWithValue("@OFFICES", cbWorkerOffice.Text);
                    //check.Parameters.AddWithValue("@WORKERS_YEARS", Convert.ToInt32(tbWorkerYears.Text));
                    check.Parameters.AddWithValue("@WORKERS_CONTACTS", tbWorkerContacts.Text);
                    if (int.TryParse(tbWorkerYears.Text, out int a))                  //we can input only int values
                    {
                        check.Parameters.AddWithValue("@WORKERS_YEARS", Convert.ToInt32(tbWorkerYears.Text));
                    }
                    else
                    {
                        MessageBox.Show("Некорректное значение, введите число");
                    }
                }
                else
                {
                    MessageBox.Show("Строка не заполнена, введите значение");
                }
                check.ExecuteNonQuery();
                MessageBox.Show("Работник добавлен");
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Ошибка!");
                throw new ApplicationException("error insert new_tovar", ex);
            }
            finally
            {
                one.Close();
            }
        }

        private void CbWorkerSpecialization_DropDownOpened(object sender, EventArgs e)
        {
            cbWorkerSpecialization.Items.Clear();
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
                    cbWorkerSpecialization.Items.Add(Convert.ToString(sqlReader["SERVICESS"]));
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

        private void CbWorkerOffice_DropDownOpened(object sender, EventArgs e)
        {
            cbWorkerOffice.Items.Clear();
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from OFFICES";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;

            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    cbWorkerOffice.Items.Add(Convert.ToString(sqlReader["OFFICES"]));
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

        private void BtAddServices_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = "INSERT INTO SERVICESS (SERVICESS, SERVICESS_PRICE, SERVICESS_AMT, SERVICESS_SPECIALITY) VALUES (@SERVICESS, @SERVICESS_PRICE, @SERVICESS_AMT, @SERVICESS_SPECIALITY)";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();

            try
            {
                if (tbServiceName.Text != String.Empty && tbServicePrice.Text != String.Empty && сbServiceSpeciality.Text != String.Empty)
                {
                    check.Parameters.AddWithValue("@SERVICESS", tbServiceName.Text);
                    check.Parameters.AddWithValue("@SERVICESS_SPECIALITY", сbServiceSpeciality.Text);
                    check.Parameters.AddWithValue("@SERVICESS_AMT", 0);
                    if (int.TryParse(tbServicePrice.Text, out int a))                  //we can input only int values
                    {
                        check.Parameters.AddWithValue("@SERVICESS_PRICE", Convert.ToInt32(tbServicePrice.Text));
                    }
                    else
                    {
                        MessageBox.Show("Некорректное значение, введите число");
                    }
                }
                else
                {
                    MessageBox.Show("Строка не заполнена, введите значение");
                }

                check.ExecuteNonQuery();


                MessageBox.Show("Услуга добавлена");
            }
            catch (SqlException ex)
            {
                throw new ApplicationException("error insert new_tovar", ex);
                MessageBox.Show("Ошибка!");
            }
            finally
            {
                one.Close();
            }
        }

        private void CbServiceSpeciality_DropDownOpened(object sender, EventArgs e)
        {
            сbServiceSpeciality.Items.Clear();
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
                    сbServiceSpeciality.Items.Add(Convert.ToString(sqlReader["SERVICESS_SPECIALITY"]));
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

        private void CbServiceName_DropDownOpened(object sender, EventArgs e)
        {
            cbServiceName.Items.Clear();
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
                    cbServiceName.Items.Add(Convert.ToString(sqlReader["SERVICESS"]));
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

        private void BtDeleteServices_Click(object sender, RoutedEventArgs e)
        {
            string checkcmd = $"Delete from SERVICESS where SERVICESS ='{cbServiceName.Text}'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;

            try
            {
                sqlReader = check.ExecuteReader();
                one.Close();
                sqlReader.Close();

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
                cbServiceName.Items.Clear();
                cbServiceName.Text = String.Empty;
            }
        }

        private void BtAddProducts_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = "INSERT INTO PRODUCTS (PRODUCTS, PRODUCTS_COST, PRODUCTS_AMT, OFFICES) VALUES (@PRODUCTS, @PRODUCTS_COST, @PRODUCTS_AMT, @OFFICES)";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();

            try
            {
                if (tbProductName.Text != String.Empty && tbProductCost.Text != String.Empty && сbProductPlace.Text != String.Empty)
                {
                    check.Parameters.AddWithValue("@PRODUCTS", tbProductName.Text);
                    check.Parameters.AddWithValue("@OFFICES", сbProductPlace.Text);
                    check.Parameters.AddWithValue("@PRODUCTS_AMT", 10);
                    if (int.TryParse(tbProductCost.Text, out int a))                  //we can input only int values
                    {
                        check.Parameters.AddWithValue("@PRODUCTS_COST", Convert.ToInt32(tbProductCost.Text));
                    }
                    else
                    {
                        MessageBox.Show("Некорректное значение, введите число");
                    }
                }
                else
                {
                    MessageBox.Show("Строка не заполнена, введите значение");
                }

                check.ExecuteNonQuery();


                MessageBox.Show("Товар добавлен");
            }
            catch (SqlException ex)
            {
                throw new ApplicationException("error insert new_tovar", ex);
                MessageBox.Show("Ошибка!");
            }
            finally
            {
                one.Close();
            }
        }

        private void СbProductPlace_DropDownOpened(object sender, EventArgs e)
        {
            cbProductName.Items.Clear();
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from OFFICES";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;

            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    сbProductPlace.Items.Add(Convert.ToString(sqlReader["OFFICES"]));
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

        private void CbProductName_DropDownOpened(object sender, EventArgs e)
        {
            cbProductName.Items.Clear();
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
                    cbProductName.Items.Add(Convert.ToString(sqlReader["PRODUCTS"]));
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

        private void BtDeleteProducts_Click(object sender, RoutedEventArgs e)
        {
            string checkcmd = $"Delete from PRODUCTS where PRODUCTS ='{cbProductName.Text}'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;

            try
            {
                sqlReader = check.ExecuteReader();
                one.Close();
                sqlReader.Close();

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
                cbProductName.Items.Clear();
                cbProductName.Text = String.Empty;
            }
        }
    }
}
