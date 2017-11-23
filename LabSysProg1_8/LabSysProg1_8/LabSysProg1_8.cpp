#include "stdafx.h"
#include <Windows.h>
#include <iostream> 
#include <eh.h> 

using namespace std;

void se_trans_func(unsigned code, EXCEPTION_POINTERS *)
{
	throw code;
}

int main()
{
	int a = 10, b = 0;
	// устанавливаем функцию-транслятор 
	_set_se_translator(se_trans_func);
	// перехватываем структурное исключение средствами C++ 
	try
	{
		a /= b; // ошибка, деление на ноль 
	}
	catch (...)
	{
		cout << "Exception is" << endl;
	}
	return 0;
}
