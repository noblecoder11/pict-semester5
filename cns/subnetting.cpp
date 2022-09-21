//============================================================================
// Name        : subnetting.cpp
// Author      : 31132_Shreyash
// Version     : 0.0.1
// Copyright   :
// Description : demonstrate sub-netting and finding subnet marks
//============================================================================

#include <bits/stdc++.h>
using namespace std;

int* split(string str, char del){
      string temp = "";
      string ip[4];
      for(int i=0; i<(int)str.size(); i++){
    	  if(str[i] != del){
    		  temp += str[i];
    	  } else{
    		  ip[i]=temp;
    		  int num=15;
    		  bitset<64>(num).to_string().substr(64 - 1- 1);
    		  cout << temp << " ";
              temp = "";
    	  }
      }
      cout << temp;
}

vector<string> calculateSubnet(string networkClass, string IP, int nsubnets) {

}

int main() {
	cout << "Choose class of network(Any/A/B/C/D): ";
	string networkClass; cin>>networkClass;
	cout << "Enter IP address: ";
	string IP; cin>>IP;
	cout << "Enter number of subnets required: ";
	int nsubnets; cin>>nsubnets;

	calculateSubnet(networkClass, IP, nsubnets);
	// return subnets, subnet mask, network addr, number of hosts
	return 0;
}
