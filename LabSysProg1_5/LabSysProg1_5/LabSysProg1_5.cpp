#include "stdafx.h"
#include <windows.h>
#include <iostream> 

using namespace std;


LONG filterNew(PEXCEPTION_POINTERS pExceptionInfo)
{
	cout << "New filter-function is called." << endl;
	cout << "Exception code = " << hex << pExceptionInfo->ExceptionRecord->ExceptionCode << endl;
	return	EXCEPTION_EXECUTE_HANDLER;
}

int main()
{
	LPTOP_LEVEL_EXCEPTION_FILTER filterOld; 
	filterOld = SetUnhandledExceptionFilter((LPTOP_LEVEL_EXCEPTION_FILTER)filterNew); // установили новую функцию-фильтр необраб. исключений filterOld
	cout << "Old filter-function address = " << hex <<  filterOld << endl; // вывели адрес старой функции-фильтра
	cout << "New filter-function address = " << hex << filterNew << endl; // вывели адрес новой функции-фильтра
	// hex - ввод/вывод в шестнадцатеричной системе счисления
	/*RaiseException(
		EXCEPTION_ARRAY_BOUNDS_EXCEEDED,
		0,                    // continuable exception 
		0, NULL);
	*/
	system("pause");
	return 0x0;
}
