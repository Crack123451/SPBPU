#include "stdafx.h"
#include <windows.h>
#include <iostream> 

using namespace std;
int main()
{
	int a=100;
	int b;
	cout <<"a=100/b. Enter number b: ";
	cin >> b;
	_try
	{
		if (b == 0)
		{
			cout << "Exited throught _leave"<< endl;
			_leave;
		}			
		cout << "a/b=" << (a / b) << endl;
	}
	_except(EXCEPTION_EXECUTE_HANDLER)
	{
		cout << "Finded exception: EXCEPTION_INT_DIVIDE_BY_ZERO" << endl;
	}
	system("pause");
	return 0;
}

// РАБОЧАЯ ПРОГРАММА ДЛЯ GOTO
/*#include "stdafx.h"
#include <windows.h>
#include <iostream> 

using namespace std;
int main()
{
	int a=100;
	int b;
	cout <<"a=100/b. Enter number b: ";
	cin >> b;
	_try
	{
		if (a != 0)
		{
			cout << "a/b=" << (a / b) << endl;
			cout << "exit through _goto" << endl;
			goto exit_try; // выходим их блока 
		}
		else
			a = a / b;
	}
		_except(EXCEPTION_EXECUTE_HANDLER)
	{
		cout << "Finded exception: EXCEPTION_INT_DIVIDE_BY_ZERO" << endl;
	}
	cout << "Exited from _except" << endl;
exit_try: system("pause");
	return 0;
}
*/