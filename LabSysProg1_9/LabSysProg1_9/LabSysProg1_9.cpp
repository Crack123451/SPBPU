#include "stdafx.h"
#include <Windows.h>
#include <iostream> 

using namespace std;
int main()
{
	_try
	{
		cout << "The try block finished." << endl;
	}
		_finally
	{
		cout << "The finally block finished." << endl;
	}
	system("pause");
	return 0;
}
