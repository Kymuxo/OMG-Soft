using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using OMG_Soft.Classes;

namespace OMG_Soft
{
    /// <summary>
    /// Логика взаимодействия для Laba7_8.xaml
    /// </summary>
    public partial class Laba7_8 : Window, INotifyPropertyChanged
    {
        protected virtual void NotifyPropertyChanged([CallerMemberName] string propertyName = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public Laba7_8()
        {
            InitializeComponent();
            FromFile();
            DataContext = this;

            AddCommand = new Command(OnAdd);
            DeleteCommand = new Command(OnDelete);
            EditCommand = new Command(OnEdit);
            SortByStatusCommand = new Command(OnSortByStatus);
            SortByPriorityCommand = new Command(OnSortByPriority);
            SortByCategoryCommand = new Command(OnSortByCategory);
            ChangeLanguageCommand = new Command(OnChangeLanguage);
            UndoCommand = new Command(OnUndo);
            RedoCommand = new Command(OnRedo);
            StyleCommand = new Command(ChangeStyle);


            ClickEvent = EventManager.RegisterRoutedEvent(
               "Control_MouseDown",
               RoutingStrategy.Bubble,
               typeof(RoutedEventHandler),
               typeof(ButtonBase));

            OnChangeLanguage();
        }

        public RoutedEvent ClickEvent;
        public event RoutedEventHandler Click
        {
            add
            {
                base.AddHandler(ButtonBase.ClickEvent, value);
            }
            remove
            {
                base.RemoveHandler(ButtonBase.ClickEvent, value);
            }
        }
        public void DoEvent(object sender, MouseButtonEventArgs e)
        {
            ; MessageBox.Show(ClickEvent.RoutingStrategy.ToString());
            Control_MouseDown(sender, e);
        }
        private void Control_MouseDown(object sender, MouseButtonEventArgs e)
        {
            block.Text = "sender: " + sender.ToString() + "\n";
            block.Text += "source: " + e.Source.ToString() + "\n\n";
        }
        #region View

        public string GetDescription
        {
            get
            {
                if (_selectedTask != null)
                    return _selectedTask.More;
                return "";
            }
        }

        private Classes.Task _deletedTask;

        private Stack<Classes.Task> _undoTasks = new Stack<Classes.Task>();
        private Stack<Classes.Task> _redoTasks = new Stack<Classes.Task>();

        private Classes.Task _selectedTask;
        public Classes.Task selectedTask
        {
            set
            {
                if (value != null)
                {
                    _selectedTask = value;
                    NotifyPropertyChanged("GetDescription");
                }
            }
        }


        public ObservableCollection<Classes.Task> listTask { get { return new ObservableCollection<Classes.Task>(_tasks); } }
        private List<Classes.Task> _tasks;
        public List<Classes.Task> tasks
        {
            get { return _tasks; }
            set { _tasks = value; NotifyPropertyChanged("listTask"); NotifyPropertyChanged(); }
        }

        #endregion

        private static int _style = 0;

        public string Category { get; set; }
        public string Priority { get; set; }
        public string Status { get; set; }
        public string Add { get; set; }
        public string Delete { get; set; }
        public string Edit { get; set; }
        public string CLanguage { get; set; }
        public string Description { get; set; }
        private bool LanguageFlag = true;




        #region Commands

        public Command AddCommand { get; set; }
        public Command DeleteCommand { get; set; }
        public Command EditCommand { get; set; }
        public Command SortByStatusCommand { get; set; }
        public Command SortByPriorityCommand { get; set; }
        public Command SortByCategoryCommand { get; set; }
        public Command ChangeLanguageCommand { get; set; }
        public Command UndoCommand { get; set; }
        public Command RedoCommand { get; set; }
        public Command StyleCommand { get; set; }

        public void OnAdd()
        {
            (new AddTask()).ShowDialog();
            FromFile();
        }

        public void OnDelete()
        {
            if (_selectedTask != null)
            {
                _undoTasks.Push(new Classes.Task(_selectedTask));
                (new DataBase()).RemoveTask(_selectedTask);
                FromFile();
            }
            else MessageBox.Show("Select task");
        }

        public void OnEdit()
        {
            if (_selectedTask != null)
            {
                (new AddTask(_selectedTask)).ShowDialog();
                FromFile();
            }
            else MessageBox.Show("Select task");
        }


        public void OnSortByStatus()
        {
            List<Classes.Task> listResult = new List<Classes.Task>();
            List<Classes.Task> temp = new List<Classes.Task>();

            temp = _tasks.FindAll(x => x.Status == "In process" || x.Status == "В процессе");
            foreach (var item in temp)
            {
                listResult.Add(item);
            }

            temp = _tasks.FindAll(x => x.Status == "Complete" || x.Status == "Выполнено");
            foreach (var item in temp)
            {
                listResult.Add(item);
            }

            tasks = listResult;
        }

        public void OnSortByPriority()
        {
            List<Classes.Task> listResult = new List<Classes.Task>();
            List<Classes.Task> temp = new List<Classes.Task>();

            temp = _tasks.FindAll(x => x.Priority == "Very Important" || x.Priority == "Важно");
            foreach (var item in temp)
            {
                listResult.Add(item);
            }

            temp = _tasks.FindAll(x => x.Priority == "Normal" || x.Priority == "Нормально");
            foreach (var item in temp)
            {
                listResult.Add(item);
            }

            temp = _tasks.FindAll(x => x.Priority == "I tak soidet" || x.Priority == "И так сойдёт");
            foreach (var item in temp)
            {
                listResult.Add(item);
            }

            tasks = listResult;
        }

        public void OnSortByCategory()
        {
            tasks = _tasks.OrderBy(x => x.Category).ToList();
        }
        public void OnChangeLanguage()
        {

            Uri uri;
            switch (_style)
            {
                case 0:
                    uri = new Uri($"Resources/Dictionaries/ThemeLightLanguageRUS.xaml", UriKind.Relative);
                    _style++;
                    break;
                case 1:
                    uri = new Uri($"Resources/Dictionaries/ThemeLightLanguageENG.xaml", UriKind.Relative);
                    _style = 0;
                    break;
                default:
                    uri = new Uri($"Resources/Dictionaries/ThemeLightLanguageRUS.xaml", UriKind.Relative);
                    break;
            }
            var resourceDict = Application.LoadComponent(uri) as ResourceDictionary;
            Application.Current.Resources.Clear();
            Application.Current.Resources.MergedDictionaries.Add(resourceDict);
        }

        public void OnUndo()
        {
            if (_undoTasks.Count != 0)
            {
                _deletedTask = _undoTasks.Pop();
                _redoTasks.Push(new Classes.Task(_deletedTask));
                (new DataBase()).AddTask(_deletedTask);
                FromFile();
            }
        }


        public void OnRedo()
        {
            if (_redoTasks.Count != 0)
            {
                _deletedTask = _redoTasks.Pop();
                _undoTasks.Push(new Classes.Task(_deletedTask));
                (new DataBase()).RemoveTask(_deletedTask);
                FromFile();
            }
        }

        public void ChangeStyle()
        {
            Uri uri;
            switch (_style)
            {
                case 0:
                    uri = new Uri($"Resources/Dictionaries/ThemeLightLanguageRUS.xaml", UriKind.Relative);
                    _style++;
                    break;
                case 1:
                    uri = new Uri($"Resources/Dictionaries/ThemeDarkLanguageRUS.xaml", UriKind.Relative);
                    _style = 0;
                    break;
                default:
                    uri = new Uri($"Resources/Dictionaries/ThemeLightLanguageRUS.xaml", UriKind.Relative);
                    break;
            }
            var resourceDict = Application.LoadComponent(uri) as ResourceDictionary;
            Application.Current.Resources.Clear();
            Application.Current.Resources.MergedDictionaries.Add(resourceDict);
        }
        #endregion

        private void FromFile()
        {
            DataBase db = new DataBase();
            tasks = db.GetTasks();
        }
        
    }
}
