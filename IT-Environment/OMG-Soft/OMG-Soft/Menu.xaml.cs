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

namespace OMG_Soft
{
    /// <summary>
    /// Логика взаимодействия для Menu.xaml
    /// </summary>
    public partial class Menu : Window
    {
        public Menu()
        {
            InitializeComponent();
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

        private void Grid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
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
                    this.Close();
                    Cabinet cabinet = new Cabinet();
                    cabinet.ShowDialog();
                    
                    break;
                case "btHome":
                    lbInfo.Items.Clear();
                    lbInfo.Visibility = Visibility.Collapsed;
                    break;
                case "listOfServices":
                    lbInfo.Items.Clear();
                    lbInfo.Visibility = Visibility.Visible;
                    string loginCheck = MainWindow.quantity;
                    string passwordCheck = MainWindow.quantity1;
                    string checkcmd = $"Select * from SERVICESS";
                    SqlConnection one = new SqlConnection(MainWindow.connection);
                    SqlCommand check = new SqlCommand(checkcmd, one);
                    one.Open();
                    SqlDataReader sqlReader = null;
                    sqlReader = check.ExecuteReader();
                    while (sqlReader.Read())
                    {
                        lbInfo.Items.Add(Convert.ToString(sqlReader["SERVICESS"]) + "     " + Convert.ToString(sqlReader["SERVICESS_PRICE"]));
                    }

                    if (sqlReader != null)
                        sqlReader.Close();
                    break;
                case "listOfProducts":
                    lbInfo.Items.Clear();
                    lbInfo.Visibility = Visibility.Visible;
                    string checkcmd2 = $"Select * from PRODUCTS";
                    SqlConnection one2 = new SqlConnection(MainWindow.connection);
                    SqlCommand check2 = new SqlCommand(checkcmd2, one2);
                    one2.Open();
                    SqlDataReader sqlReader2 = null;
                    sqlReader2 = check2.ExecuteReader();
                    while (sqlReader2.Read())
                    {
                        lbInfo.Items.Add(Convert.ToString(sqlReader2["PRODUCTS"]) + "    Цена: " + Convert.ToString(sqlReader2["PRODUCTS_COST"]));
                    }
                    if (sqlReader2 != null)
                        sqlReader2.Close();
                    break;
                case "listOfWorkers":
                    lbInfo.Items.Clear();
                    lbInfo.Visibility = Visibility.Visible;
                    string checkcmd3 = $"Select * from WORKERS";
                    SqlConnection one3 = new SqlConnection(MainWindow.connection);
                    SqlCommand check3 = new SqlCommand(checkcmd3, one3);
                    one3.Open();
                    SqlDataReader sqlReader3 = null;
                    sqlReader3 = check3.ExecuteReader();
                    while (sqlReader3.Read())
                    {
                        lbInfo.Items.Add(Convert.ToString(sqlReader3["WORKERS"]) + "     " + Convert.ToString(sqlReader3["WORKERS_NAME"]) + "     " +
                            Convert.ToString(sqlReader3["SERVICESS"]) + "     " + Convert.ToString(sqlReader3["WORKERS_CONTACTS"]));
                    }
                    if (sqlReader3 != null)
                        sqlReader3.Close();
                    break;
                case "listOfOffices":
                    lbInfo.Items.Clear();
                    lbInfo.Visibility = Visibility.Visible;
                    string checkcmd4 = $"Select * from OFFICES";
                    SqlConnection one4 = new SqlConnection(MainWindow.connection);
                    SqlCommand check4 = new SqlCommand(checkcmd4, one4);
                    one4.Open();
                    SqlDataReader sqlReader4 = null;
                    sqlReader4 = check4.ExecuteReader();
                    while (sqlReader4.Read())
                    {
                        lbInfo.Items.Add(Convert.ToString(sqlReader4["OFFICES"]) + "     " + Convert.ToString(sqlReader4["OFFICES_TOWN"]));
                    }
                    if (sqlReader4 != null)
                        sqlReader4.Close();
                    break;
                default:
                    break;
            }
        }

        private void BtSearch_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            int index = 1;
            switch (index)
            {
                case 1:
                    string checkcmd = $"Select * from SERVICESS where SERVICESS ='{tbSearch.Text}'";
                    SqlConnection one = new SqlConnection(MainWindow.connection);
                    SqlCommand check = new SqlCommand(checkcmd, one);
                    one.Open();
                    check.Prepare();
                    check.ExecuteNonQuery();
                    if (tbSearch.Text == (string)check.ExecuteScalar())
                    {

                        MessageBox.Show("Данная услуга присутствует в нашем списке услуг. \n Для заказа перейдите в корзину.\n" +
                            " Для получение более подробной информации перейдите во вкладку 'Список услуг'");

                    }
                    else
                    {
                        one.Close();
                        goto case 2;
                    }
                    break;
                case 2:
                    string checkcmd1 = $"Select * from PRODUCTS where PRODUCTS ='{tbSearch.Text}'";
                    SqlConnection one1 = new SqlConnection(MainWindow.connection);
                    SqlCommand check1 = new SqlCommand(checkcmd1, one1);
                    one1.Open();
                    check1.Prepare();
                    check1.ExecuteNonQuery();
                    if (tbSearch.Text == (string)check1.ExecuteScalar())
                    {
                        MessageBox.Show("Данный товар присутствует в нашем списке товаров. \n Для заказа перейдите в корзину.\n" +
                            " Для получение более подробной информации перейдите во вкладку 'Список товаров'");

                    }
                    else
                    {
                        one1.Close();
                        goto case 3;
                    }
                    break;

                case 3:
                    MessageBox.Show("К сожалению, по вашему запросу ничего не найдено, \n" +
                        "для заказа данного товара или услуги обритесь к консультанту.");
                    break;
            }
        }

        private void BtInfoAboutUs_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            AboutUs aboutUs = new AboutUs();
            aboutUs.ShowDialog();
            
        }

        private void BtConsultation_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            Consultation consultation = new Consultation();
            consultation.ShowDialog();
            
        }

        private void BtTOP_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            TOP top = new TOP();
            top.ShowDialog();
           
        }

        private void BtAdmins_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string query = $"Select * from ADMINS";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(query, one);
            one.Open();
            SqlDataReader sqlReader = null;
            try
            {
                sqlReader = check.ExecuteReader();
                while (sqlReader.Read())
                {
                    MessageBox.Show(Convert.ToString(sqlReader["ADMINS"]) + "       " + Convert.ToString(sqlReader["ADMINS_SURNAME"]) + " " +
                                    Convert.ToString(sqlReader["ADMINS_NAME"]) + " " + Convert.ToString(sqlReader["ADMINS_PATRONYMIC"]) + "     " +
                                    Convert.ToString(sqlReader["ADMINS_CONTACTS"]));
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

        private void BtHelp_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            Help help = new Help();
            help.ShowDialog();
            
        }

        private void Grid_Loaded(object sender, RoutedEventArgs e)
        {
            string checkcmd = $"Select * from CUSTOMERS where CUSTOMERS ='{MainWindow.quantity}' and CUSTOMERS_PASSWORD = '{MainWindow.quantity1}'";
            
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);

            one.Open();
            SqlDataReader sqlReader = null;
            try
            {
                sqlReader = check.ExecuteReader();
                
                while (sqlReader.Read())
                {
                    MainWindow.language = Convert.ToInt32(sqlReader["CUSTOMERS_LANGUAGE"]);
                    MainWindow.theme = Convert.ToInt32(sqlReader["CUSTOMERS_THEME"]);
                }
                   
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(), MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {

                if (sqlReader != null )
                    sqlReader.Close();
                one.Close();
            }

            int index = 0;
            switch (index)
            {
                case 0:
                    if(MainWindow.language == 0 && MainWindow.theme == 0)
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
