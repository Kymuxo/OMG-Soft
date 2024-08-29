using System;
using System.Collections.Generic;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace OMG_Soft
{
    /// <summary>
    /// Логика взаимодействия для UserControl2.xaml
    /// </summary>
    public partial class UserControl2 : UserControl
    {
        public UserControl2()
        {
            InitializeComponent();
            this.DirectButton.Click += UserControl2_Click;
        }

        public static readonly RoutedEvent ClickEvent;

        public event RoutedEventHandler Click
        {
            add { AddHandler(ClickEvent, value); }
            remove { RemoveHandler(ClickEvent, value); }
        }
        public static readonly DependencyProperty TitleProperty;
        public static readonly DependencyProperty PriceProperty;

        static UserControl2()
        {
            ClickEvent = EventManager.RegisterRoutedEvent("Click", RoutingStrategy.Bubble, typeof(RoutedEventHandler), typeof(UserControl2));
            TitleProperty = DependencyProperty.Register("Title", typeof(string), typeof(UserControl2), new PropertyMetadata("Something"));
            PropertyMetadata metadata = new PropertyMetadata(100);
            metadata.CoerceValueCallback = new CoerceValueCallback(CorrectValue);
            PriceProperty = DependencyProperty.Register("Price", typeof(int), typeof(UserControl2), metadata, new ValidateValueCallback(ValidateValue));
        }

        private static object CorrectValue(DependencyObject d, object baseValue)
        {
            int currentValue = (int)baseValue;
            if (currentValue > 1000)
                return 1000;
            return currentValue;
        }

        private static bool ValidateValue(object value)
        {
            int currentValue = (int)value;
            if (currentValue >= 0)
                return true;
            return false;
        }

        public string Title
        {
            get { return (string)GetValue(TitleProperty); }
            set { SetValue(TitleProperty, value); }
        }
        public int Price
        {
            get { return (int)GetValue(PriceProperty); }
            set { SetValue(PriceProperty, value); }
        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (MyButton.Visibility == Visibility.Visible)
            {
                MyContent.Visibility = Visibility.Visible;
                MyButton.Visibility = Visibility.Collapsed;
            }
            else
            {
                MyContent.Visibility = Visibility.Collapsed;
                MyButton.Visibility = Visibility.Visible;
            }

        }
        private void UserControl2_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Hi");
        }
    }
}
