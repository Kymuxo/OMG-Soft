using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace OMG_Soft
{
    public class Command : ICommand
    {
        public event EventHandler CanExecuteChanged;

        private Action _execute;

        public Command(Action execute)
        {
            _execute = execute;
        }

        public bool CanExecute(object paramerts)
        {
            return true;
        }

        public void Execute(object parametrs)
        {
            _execute?.Invoke();
        }
    }
}
