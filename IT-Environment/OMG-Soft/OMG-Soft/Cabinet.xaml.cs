using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
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
    /// Логика взаимодействия для Cabinet.xaml
    /// </summary>
    public partial class Cabinet : Window
    {
        public Cabinet()
        {
            InitializeComponent();
        }

        private void ButtonClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            MainWindow main = new MainWindow();
            main.ShowDialog();
            
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

            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Select * from CUSTOMERS where CUSTOMERS ='{loginCheck}' and CUSTOMERS_PASSWORD = '{passwordCheck}'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            one.Open();
            SqlDataReader sqlReader = null;

            List<byte[]> iScreen = new List<byte[]>();
            byte[] iTrimByte = null;

            sqlReader = check.ExecuteReader();
            while (sqlReader.Read())
            {

                iTrimByte = (byte[])sqlReader["CUSTOMERS_PHOTO"]; // читаем строки с изображениями
                iScreen.Add(iTrimByte);
                byte[] imageData = iScreen[0];
                MemoryStream ms = new MemoryStream(imageData);


                BitmapImage bmp = new BitmapImage();
                bmp.BeginInit();
                bmp.StreamSource = ms;
                bmp.EndInit();
                MyPhoto.Source = bmp;

                lbCabName.Content = Convert.ToString(sqlReader["CUSTOMERS_NAME"]);
                lbCabSurname.Content = Convert.ToString(sqlReader["CUSTOMERS_SURNAME"]);
                lbCabLogin.Content = Convert.ToString(sqlReader["CUSTOMERS"]);
                lbCabCartNum.Content = Convert.ToString(sqlReader["CUSTOMERS_CART"]);
                lbCabUserMail.Text = Convert.ToString(sqlReader["CUSTOMERS_CONTACTS"]);
            }


            if (sqlReader != null)
                sqlReader.Close();
            one.Close();
        }

        private void ListViewMenu_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            switch (((ListViewItem)((ListView)sender).SelectedItem).Name)
            {
                case "InMenu":
                    this.Close();
                    Menu main = new Menu();
                    main.ShowDialog();
                    
                    break;
                case "btMyBasket":
                    this.Close();
                    Basket basket = new Basket();
                    basket.ShowDialog();
                    
                    break;
                case "btSettings":
                    this.Close();
                    ProfileSettings profileSettings = new ProfileSettings();
                    profileSettings.ShowDialog();
                    
                    break;
                default:
                    break;
            }
        }
    }
}
