#include "stdafx.h"
#include <windows.h>
#include <iostream> 

using namespace std;
int main()
{
	_try
	{
		_try
		{
			RaiseException(EXCEPTION_ARRAY_BOUNDS_EXCEEDED, 0, 0, NULL);  
		}
		_except(GetExceptionCode() == EXCEPTION_ARRAY_BOUNDS_EXCEEDED ?
			EXCEPTION_EXECUTE_HANDLER : EXCEPTION_CONTINUE_SEARCH)
		{
			cout << "Exception: EXCEPTION_ARRAY_BOUNDS_EXCEEDED" << endl;
		}
		_try
		{
			RaiseException(EXCEPTION_INT_DIVIDE_BY_ZERO, 0, 0, NULL);
		}
		_except(GetExceptionCode() == EXCEPTION_ARRAY_BOUNDS_EXCEEDED ?
			EXCEPTION_EXECUTE_HANDLER : EXCEPTION_CONTINUE_SEARCH)
		{
			cout << "Exception: EXCEPTION_ARRAY_BOUNDS_EXCEEDED" << endl;
		}
	}
	_except(GetExceptionCode() == EXCEPTION_INT_DIVIDE_BY_ZERO ?
		EXCEPTION_EXECUTE_HANDLER : EXCEPTION_CONTINUE_SEARCH)
	{
		cout << "Exception: EXCEPTION_INT_DIVIDE_BY_ZERO" << endl;
	}
	system("pause");
	return 0;
}
