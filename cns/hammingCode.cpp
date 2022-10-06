//============================================================================
// Name        : hammingcode.cpp
// Author      : Shreyash Halge
// Version     : 1.0.0
// Copyright   : 
// Description : Hamming code implementation. For more details, please refer to https://www.geeksforgeeks.org/hamming-code-in-computer-network/
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
    string sendData(string data);
	string addBits();
};

string Sender::sendData(string data){
    this->data=data;
    return addBits();
}

string Sender::addBits() {
	int r = 0;  // number of redundant bits
	int m = data.length();
	while(pow(2, r)<r+m+1) r++;

	int totalBits = m+r;
    string preparedData = "z"; // z is a dummy character
    int dataItr = m-1;
    for(int i=1; i<=totalBits; i++)
    {
        // if i is a power of 2
        if(!(i&(i-1))) {
            preparedData+='r';
        }
        else {
            preparedData+=data[dataItr--];
        }
    }

    bool rn[r] = {false};   // stores the redundant bits (false for even)
    for(int i=0; i<r; i++)
    {
        for(int j=pow(2, i); j<=totalBits; j++){ 
            // first condition checks if position is to used for calculation
            // second condition checks if it is set       
            if((j&(1<<i)) and preparedData[j]=='1') {
                rn[i] = !rn[i];
            }
            preparedData[pow(2, i)]=(rn[i]?'1':'0');
        }
    }

    return preparedData;
}

class Receiver {
	string data;
public:
    bool recieveData(string data);
	bool check(string rData);
	void displayData();
};

bool Receiver::recieveData(string data) {
    this->data=data;
    return check(data);
}

bool Receiver::check(string rData) {
    int r=0;
    int totalBits = rData.length();
    while(pow(2, r)<totalBits+1) r++;

    bool parities[r] = {false};
    for(int i=0; i<r; i++)
    {
        for(int j=pow(2, i); j<=totalBits; j++){
            if((j&(1<<i)) and rData[j]=='1'){
                parities[i] = !parities[i];
            }
            rData[pow(2, i)]=(parities[i]?'1':'0');
        }
    }

    // check if every element in rn is 0
    for(int i=0; i<r; i++)
        if(parities[i]) return false;
}

void Receiver::displayData() {
	cout << "Received Data: ";
    // print string data in reverse order and remove redundant bits
    for(int i=data.length()-1; i>0; i--)
    {
        if(i&(i-1)) cout << data[i];
    }
}

int main() {
    /* TestCase 1
        input: "1011001"
        output: Expected Transmitted Data: 1001100
                Actual Transmitted Data: 1001100
                Received Data: 1001
    */
    /* TestCase 2:
        input: "1001"
        output: Expected Transmitted Data: 1001100
                Actual Transmitted Data: 1001100
                Received Data: 1001
    */

    Sender s;
	Receiver r;

    string dataToSend; cin>>dataToSend;
	string transmittedData = s.sendData(dataToSend);

    cout << "Expected Transmitted Data: ";
    for(int i=transmittedData.length()-1; i>0; i--)
        cout << transmittedData[i];
    cout << endl;

    // uncomment for error
    // transmittedData[2]='0';

    cout << "Actual Transmitted Data: ";
    for(int i=transmittedData.length()-1; i>0; i--)
        cout << transmittedData[i];
    cout << endl;

	bool errorFree = r.recieveData(transmittedData);

	if(errorFree) r.displayData();
	// TODO: check which bit is erroneous and flip it to correct it
	else cout << "Data received is erroneous." << endl;
	return 0;
}
