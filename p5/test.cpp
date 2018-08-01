#include <iostream>
#include "dlist.h"
using namespace std;

int main(int argc, char *argv[])
{
    //INSERT_FRONT,REMOVE_FRONT checking
	int result = 0;

    Dlist<int> ilist;
    int *ip = new int(1);
    ilist.insertFront(ip);

    ip = ilist.removeFront();
    if(*ip != 1)
        result = -1;
    delete ip;

    if(!ilist.isEmpty()) result = -1;

	//INSERT_BACK,REMOVE_BACK checking
	ip = new int(1);
	int *ip2 = new int(2);
	ilist.insertBack(ip);
	ilist.insertBack(ip2);
	ip2 = ilist.removeBack();
	ip = ilist.removeBack();
	if ((*ip!=1)||(*ip2!=2)) result = -1;
	delete ip;
	delete ip2;
	if (!ilist.isEmpty()) result = -1;
	//COPY checking
	ip = new int(1);
	ip2 = new int(2);
	ilist.insertBack(ip);
	ilist.insertBack(ip2);
	Dlist<int> ilist2(ilist);
	ip2 = ilist2.removeBack();
	ip = ilist2.removeBack();
    if ((*ip!=1)||(*ip2!=2)) result = -1;
	delete ip;
	delete ip2;
	if (!ilist2.isEmpty()) result = -1;
	//ASSIGNMENT checking
	int *ip3 = new int(3);
	ilist2.insertFront(ip3);
	ilist2 = ilist;
	ip2 = ilist2.removeBack();
	ip = ilist2.removeBack();
    if ((*ip!=1)||(*ip2!=2)) result = -1;
	delete ip;
	delete ip2;
	if (!ilist2.isEmpty()) result = -1;	
	return result;

}
