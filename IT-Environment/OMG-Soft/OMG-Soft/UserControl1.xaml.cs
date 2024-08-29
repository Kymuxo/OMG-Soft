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
    /// Логика взаимодействия для UserControl1.xaml
    /// </summary>
    public partial class UserControl1 : UserControl
    {
        public UserControl1()
        {
            InitializeComponent();
        }

        static UserControl1()
        {
            metadata.CoerceValueCallback = new CoerceValueCallback(CorrectValue);
            MyProperty1Property = DependencyProperty.Register("MyProperty1", typeof(object), typeof(UserControl1), new PropertyMetadata("Hello World"), new ValidateValueCallback(ValidateMyProperty1));
            MyProperty2Property = DependencyProperty.Register("MyProperty2", typeof(object), typeof(UserControl1), metadata, new ValidateValueCallback(ValidateMyProperty2));

        }
        static PropertyMetadata metadata = new PropertyMetadata(5);
        private static object CorrectValue(DependencyObject d, object baseValue)
        {
            return 1000;
        }

        public object MyProperty1
        {
            get { return (object)GetValue(MyProperty1Property); }
            set { SetValue(MyProperty1Property, value); }
        }
        public static bool ValidateMyProperty1(object property)
        {
            if (property is string)
                return true;
            else return false;
        }
        public static readonly DependencyProperty MyProperty1Property;
        public object MyProperty2
        {
            get { return (object)GetValue(MyProperty2Property); }
            set { SetValue(MyProperty2Property, value); }
        }
        public static bool ValidateMyProperty2(object property)
        {
            if (property is int)
                return true;
            else return false;
        }

        public static readonly DependencyProperty MyProperty2Property;
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
    }
}
