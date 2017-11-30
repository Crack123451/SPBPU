using System;
using System.Runtime.InteropServices;

namespace LabaSysProg1
{
    class Exception
    {
        static void Main(string[] args)
        {
            Exception_DivideByZeroException();
            //Exception_IndexOutOfRangeException();
            //Exception_in_handler();
            //Exception_in_filter();
        }

        static void Exception_DivideByZeroException()
        {
            int result;
            int a = 10;
            int b = Int16.Parse(Console.ReadLine());
            try
            {
                result = a / b;
                Console.WriteLine("{0} / {1} = {2:0.##}", a, b, result);
            }
            catch (DivideByZeroException e)
            {
                Console.WriteLine(e);
            }
            Console.ReadKey();
        }

        static void Exception_IndexOutOfRangeException()
        {
            int[] mass = new int[3] { 0, 1, 2 };
            int i = Int16.Parse(Console.ReadLine());
            try
            {
                Console.WriteLine(mass[i]);
            }
            catch (IndexOutOfRangeException e)
            {
                Console.WriteLine(e);
            }
            Console.ReadKey();
        }
    
        static void Exception_in_handler()
        {
            int[] mass = new int[3] { 0, 1, 2 };
            int i = Int16.Parse(Console.ReadLine());
            int divider=Int16.Parse(Console.ReadLine());
            try
            {
                Console.WriteLine(mass[i]/divider);
            }
            catch (System.Exception)
            {
                Console.WriteLine(Marshal.GetExceptionCode());
            }
            Console.ReadKey();
        }

        static void Exception_in_filter()
        {
            int[] mass = new int[3] { 0, 1, 2 };
            int i = Int16.Parse(Console.ReadLine());
            int divider = Int16.Parse(Console.ReadLine());
            try
            {
                Console.WriteLine(mass[i] / divider);
            }
            catch (System.Exception)when (divider==0)
            {
                Console.WriteLine("divider=0");
                Console.WriteLine("Error: -1073741676");
            }
            catch (System.Exception) when (i>2)
            {
                Console.WriteLine("i>3");
                Console.WriteLine("Error: -532462766");
            }
            catch (System.Exception)
            {
                Console.WriteLine(Marshal.GetExceptionCode());
            }
            Console.ReadKey();
        }
    }
}