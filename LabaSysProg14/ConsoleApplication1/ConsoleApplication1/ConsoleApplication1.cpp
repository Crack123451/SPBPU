#include <windows.h>
#include <iostream> 

using namespace std;
int main()
{
	_try
	{
		RaiseException(	// вызываем исключение
			3221225620,            // код исключения деления на ноль
			0,                    // continuable exception 
			0, NULL);             // no arguments 
	}
		_except(EXCEPTION_EXECUTE_HANDLER)
	{
		DWORD ee = GetExceptionCode(); // получаем код исключения 

		if (ee == EXCEPTION_INT_DIVIDE_BY_ZERO)
			cout << "EXCEPTION_INT_DIVIDE_BY_ZERO code is " << ee << endl;
		else
			cout << "Some other exception" << ee << endl;
	}

	return 0;
}


/*
// ConsoleApplication1.cpp: определяет точку входа для консольного приложения.
//

#include <iostream>
#include "stdafx.h"
#include <windows.h>

using namespace std;

int main()
{
	int result;
	int a = 10;
	int b;
	cin >> b;
	try
	{
		result = a / b;
		cout << "Division numbers: " << result;
	}
	catch (EXCEPTION_EXECUTE_HANDLER)
	{
		DWORD ee = GetExceptionCode(); // получаем код исключения 
		cout <<ee << endl;
	}

    return 0;
}


/*		static void Main(string[] args)
		{
			//Exception_DivideByZeroException();
			//Exception_IndexOutOfRangeException();
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
			int[] mass = new int[3]{ 0, 1, 2 };
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
	}
}
*/