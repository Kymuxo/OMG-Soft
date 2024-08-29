using System;
using System.Collections.Generic;
using System.IO;
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
using Microsoft.Win32;

namespace OMG_Soft
{
    /// <summary>
    /// Логика взаимодействия для ProfileSettings.xaml
    /// </summary>
    public partial class ProfileSettings : Window
    {
        public ProfileSettings()
        {
            InitializeComponent();
        }

        private void Grid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
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
                        CheckRu.IsSelected = true;
                        btChooseTheme.IsChecked = true;
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
                        CheckEn.IsSelected = true;
                        btChooseTheme.IsChecked = true;
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
                        CheckRu.IsSelected = true;
                        btChooseTheme.IsChecked = false;
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
                        CheckEn.IsSelected = true;
                        btChooseTheme.IsChecked = false;
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
            tbChangeName.Text = string.Empty;
            tbChangeSurname.Text = string.Empty;
            tbChangeLogin.Text = string.Empty;
            tbChangePassword.Password = string.Empty;
            tbChangeCartNum.Text = string.Empty;
            tbChangeUserMail.Text = string.Empty;

            List<byte[]> iScreen = new List<byte[]>();
            byte[] iTrimByte = null;

            try
            {
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



                    tbChangeName.Text = Convert.ToString(sqlReader["CUSTOMERS_NAME"]);
                    tbChangeSurname.Text = Convert.ToString(sqlReader["CUSTOMERS_SURNAME"]);
                    tbChangeLogin.Text = Convert.ToString(sqlReader["CUSTOMERS"]);
                    tbChangePassword.Password = Convert.ToString(sqlReader["CUSTOMERS_PASSWORD"]);
                    tbChangeCartNum.Text = Convert.ToString(sqlReader["CUSTOMERS_CART"]);
                    tbChangeUserMail.Text = Convert.ToString(sqlReader["CUSTOMERS_CONTACTS"]);
                    
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

        private void BtDeleteUser_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Delete from CUSTOMERS where CUSTOMERS ='{loginCheck}' and CUSTOMERS_PASSWORD = '{passwordCheck}'";
            string checkcmd1 = $"Delete from ORDERS where CUSTOMERS ='{loginCheck}'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            SqlCommand check1 = new SqlCommand(checkcmd1, one);
            one.Open();
            SqlDataReader sqlReader = null;

            try
            {

                sqlReader = check1.ExecuteReader();
                sqlReader.Close();
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
                this.Close();
                MainWindow insert = new MainWindow();
                insert.ShowDialog();
                
            }
        }
        private byte[] _imageBytes = null;
        private void BtSaveChanges_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = MainWindow.quantity;
            string passwordCheck = MainWindow.quantity1;
            string checkcmd = $"Update CUSTOMERS Set [CUSTOMERS] = @CUSTOMERS, CUSTOMERS_PASSWORD = @CUSTOMERS_PASSWORD, CUSTOMERS_SURNAME = @CUSTOMERS_SURNAME, CUSTOMERS_NAME = @CUSTOMERS_NAME, CUSTOMERS_CART = @CUSTOMERS_CART, CUSTOMERS_CONTACTS = @CUSTOMERS_CONTACTS, CUSTOMERS_LANGUAGE = @CUSTOMERS_LANGUAGE, CUSTOMERS_THEME = @CUSTOMERS_THEME, CUSTOMERS_PHOTO = @CUSTOMERS_PHOTO where CUSTOMERS ='" + loginCheck + "' and CUSTOMERS_PASSWORD = '" + passwordCheck + "'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            
            using (var fs = new FileStream(ImagePath.Text, FileMode.Open, FileAccess.Read))
            {
                _imageBytes = new byte[fs.Length];
                fs.Read(_imageBytes, 0, System.Convert.ToInt32(fs.Length));
            }
           

            try
            {
                check.Parameters.AddWithValue("@CUSTOMERS_NAME", tbChangeName.Text);
                check.Parameters.AddWithValue("@CUSTOMERS_SURNAME", tbChangeSurname.Text);
                check.Parameters.AddWithValue("@CUSTOMERS", tbChangeLogin.Text);
                check.Parameters.AddWithValue("@CUSTOMERS_PASSWORD", tbChangePassword.Password);
                check.Parameters.AddWithValue("@CUSTOMERS_CART", tbChangeCartNum.Text);
                check.Parameters.AddWithValue("@CUSTOMERS_CONTACTS", tbChangeUserMail.Text);
                check.Parameters.AddWithValue("@CUSTOMERS_LANGUAGE", MainWindow.language);
                check.Parameters.AddWithValue("@CUSTOMERS_THEME", MainWindow.theme);
                check.Parameters.AddWithValue("@CUSTOMERS_PHOTO", _imageBytes);
                one.Open();
                check.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(), MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                one.Close();
                this.Close();
                MainWindow insert = new MainWindow();
                insert.ShowDialog();
                
            }
        }

        private void BtInCabinet_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            Cabinet cabinet = new Cabinet();
            cabinet.ShowDialog();
            
        }

        private void ChooseLanguage_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (CheckRu.IsSelected == true)
            {
                if(btChooseTheme.IsChecked == true) { 
                Resources.Source = MainWindow.DarkRus;
                MainWindow.language = 0;
                }
                else
                {
                    Resources.Source = MainWindow.LightRus;
                    MainWindow.language = 0;
                }
            }
            if (CheckEn.IsSelected == true)
            {
                if (btChooseTheme.IsChecked == true)
                {
                    Resources.Source = MainWindow.DarkEng;
                    MainWindow.language = 1;
                }
                else
                {
                    Resources.Source = MainWindow.LightEng;
                    MainWindow.language = 1;
                }
                
            }
        }

        private void ToggleButton_Checked(object sender, RoutedEventArgs e)
        {
            if (btChooseTheme.IsChecked == true)
            {
                if (CheckRu.IsSelected == true)
                {
                    Resources.Source = MainWindow.DarkRus;
                    MainWindow.theme = 0;
                }
                else
                {
                    Resources.Source = MainWindow.DarkEng;
                    MainWindow.theme = 0;
                }
            }
            
        }

        private void BtChooseTheme_Unchecked(object sender, RoutedEventArgs e)
        {
            if (btChooseTheme.IsChecked == false)
            {
                if (CheckRu.IsSelected == true)
                {
                    Resources.Source = MainWindow.LightRus;
                    MainWindow.theme = 1;
                }
                else
                {
                    Resources.Source = MainWindow.LightEng;
                    MainWindow.theme = 1;
                }
                
            }
        }
        
        private void ChangeMyPhoto_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog op = new OpenFileDialog();
            op.Title = "Select a picture";
            op.Filter = "All supported graphics|*.jpg;*.jpeg;*.png|" +
              "JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg|" +
              "Portable Network Graphic (*.png)|*.png";
            if (op.ShowDialog() == true)
            {
                ImagePath.Text = op.FileName;
                MyPhoto.Source = new BitmapImage(new Uri(op.FileName));
            }
        }
    }
}
