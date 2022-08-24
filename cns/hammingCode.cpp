//============================================================================
// Name        : hammingcode.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
using namespace std;

int pow(int a, int b)
{
	int res=1;
	while(b--) res*=a;
	return res;
}

class Sender {
	string data;
public:
	Sender(string data);
	string addBits();
};

Sender::Sender(string data) {
	this->data=data;
}

string Sender::addBits() {
	cout << "addbits\n";
	int r = 0;  // number of redundant bits
	int m = data.length();
	cout << m << endl;
	while(pow(2, r)<r+m+1) r++;

	string preparedData();
	int totalBits = m+r;
	for(int i=0; i<r;i++) {
		preparedData[pow(2, i)]=-1;
	}

	int dataItr = 0;
	for(int i=0; i<totalBits; i++)
	{
		if(!(i&(i-1))) continue;
		preparedData[i]=data[dataItr];
		dataItr++;
	}

	cout << preparedData << endl;
}

class Receiver {
	string data;
public:
	bool check(string rData);
	void displayData();
};
bool Receiver::check(string rData) {

}

void Receiver::displayData() {
	cout << "Received Data: " << data << endl;
}

int main() {
	Sender s("1010110");
	cout << "good till here" << endl;
//	Receiver r;
	string transmittedData = s.addBits();
	cout <<"tr"<< endl;
//	bool errorFree = r.check(transmittedData);
//	if(errorFree) r.displayData();
//	else cout << "Data received is erroneous." << endl;
	return 0;
}
