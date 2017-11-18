#include <stdio.h>

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
			cout << "EXCEPTION_INT_DIVIDE_BY_ZERO code is "<< ee <<endl;
		else
			cout << "Some other exception" << ee << endl;
	}
	return 0;
}
