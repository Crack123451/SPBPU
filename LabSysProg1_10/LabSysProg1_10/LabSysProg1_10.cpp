#include "stdafx.h"
#include <windows.h>
#include <iostream> 
#include <eh.h> 

using namespace std;

int main()
{
	int a = 10;
	int b = 0;

	_try
	{
		a = a / b;
	}
	_finally
	{
		// если блок try закончился нормально 
		if (!AbnormalTermination())
		{
			cout << "try was done." << endl;
		}
		else
			// иначе нечего освобождать 
			cout << "try wasn't done." << endl;
	}
	return 0;
}
