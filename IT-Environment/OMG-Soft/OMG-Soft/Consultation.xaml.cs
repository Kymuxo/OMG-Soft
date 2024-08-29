using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
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
    /// Логика взаимодействия для Consultation.xaml
    /// </summary>
    public partial class Consultation : Window
    {
        public Consultation()
        {
            InitializeComponent();
        }

        public string name;

        private void Grid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void cbOffice_SelectedIndexChanged(object sender, EventArgs e)
        {
            cbOffice.Items.Clear();

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
                    cbOffice.Items.Add(Convert.ToString(sqlReader["OFFICES"]));
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
                cbOffice.Text = String.Empty;
            }
        }

        private void BtSend_Click(object sender, RoutedEventArgs e)
        {
            string loginCheck = MainWindow.quantity.ToString();
            string passwordCheck = MainWindow.quantity1.ToString();
            string ss = monthCalendar.SelectedDate.ToString();

            string checkcmd = "INSERT INTO CONSULTATION (CUSTOMERS, CONSULTATION_DATE, OFFICES) VALUES (@CUSTOMERS, @CONSULTATION_DATE, @OFFICES)";
            string checkcmd1 = $"Select * from CUSTOMERS where CUSTOMERS ='{loginCheck}' and CUSTOMERS_PASSWORD = '{passwordCheck}'";
            SqlConnection one = new SqlConnection(MainWindow.connection);
            SqlCommand check = new SqlCommand(checkcmd, one);
            SqlCommand check1 = new SqlCommand(checkcmd1, one);
            one.Open();
            SqlDataReader sqlReader = null;
            try
            {

                sqlReader = check1.ExecuteReader();
                while (sqlReader.Read())
                {
                    name = Convert.ToString(sqlReader["CUSTOMERS_NAME"]);
                }
                if (sqlReader != null)
                    sqlReader.Close();

                check.Parameters.AddWithValue("@CUSTOMERS", loginCheck);
                check.Parameters.AddWithValue("@CONSULTATION_DATE", ss);
                check.Parameters.AddWithValue("@OFFICES", cbOffice.Text);
                check.ExecuteNonQuery();
                // отправитель - устанавливаем адрес и отображаемое в письме имя
                MailAddress from = new MailAddress("YourLogin", "YourName");
                // кому отправляем
                MailAddress to = new MailAddress("elizabeth.mayer2020@list.ru");
                // создаем объект сообщения
                MailMessage m = new MailMessage(from, to);
                // тема письма
                m.Subject = "Заказ консультации";
                // текст письма
                m.Body = "Пользователь " + name + " заказал консультацию на дату " + ss + " в офисе по адресу: " + cbOffice.Text
                    + ". Его номер телефона: " + tbTelephone.Text;
                // письмо представляет код html
                m.IsBodyHtml = true;
                // адрес smtp-сервера и порт, с которого будем отправлять письмо
                SmtpClient smtp = new SmtpClient("smtp.mail.ru", 587);
                // логин и пароль от почты с которой будет приходить сообщение
                smtp.Credentials = new NetworkCredential("YourLogin", "YourPassword");
                smtp.EnableSsl = true;
                smtp.Send(m);
                Console.Read();

               MessageBox.Show("Вы записаны");
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Ошибка!");
                throw new ApplicationException("error insert new_tovar", ex);
            }
            finally
            {
                one.Close();
                this.Close();
                Menu menu = new Menu();
                menu.ShowDialog();
                
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

            WPFUserControl userControl = new WPFUserControl();
            stc.Children.Add(userControl);
        }
    }
}
