using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LabaSysProg13
{
    class Program
    {
        static void Main(string[] args)
        {
            int[] mass = new int[3] { 0, 1, 2 };
            int i = Int16.Parse(Console.ReadLine());
            int divider = Int16.Parse(Console.ReadLine());
            try
            {
                Console.WriteLine(Metod(mass,divider,i));
            }
            catch (DivideByZeroException)
            {
                Console.WriteLine("Error! divider=0");
            }
            catch (IndexOutOfRangeException)
            {
                Console.WriteLine("Error! i>2");
            }
            Console.ReadKey();
        }

        static public int Metod (int[] mass, int divider, int i)
        {
            if (divider==0)
                throw new DivideByZeroException();
            if (i > 2)
                throw new IndexOutOfRangeException();
            return mass[i] / divider;
        }
    }
}
