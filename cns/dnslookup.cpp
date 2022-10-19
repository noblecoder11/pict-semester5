#include <bits/stdc++.h>
using namespace std;

bool isIP(string s){
    replace(s.begin(), s.end(), '.', '0');
    for(int i=0; i<s.length(); i++){
        if(!isdigit(s[i])) return false;
    }
    return true;
}

map<string, string> dnsTable;

void registerDomain(string domain, string ip){
	dnsTable[domain]=ip;
}

string dnsLookup(string s){
    if(isIP(s)){
        for(auto x: dnsTable){
            if(x.second==s) return x.first;
        }
        return "No record found.";
    }
    if(dnsTable[s]=="") return "No record found.";
	return dnsTable[s];
}

int main() {
	registerDomain("google.com", "109.12.123.76");
	registerDomain("facebook.com", "188.41.12.1");
	registerDomain("pict.edu", "105.203.65.125");
	registerDomain("medium.com", "203.55.230.140");
	
	while(true){
	    cout << "\nMAIN MENU\n1. Register Domain\n2. DNS Lookup\n3. Exit\n";
    	int choice;
    	cin>>choice;
    	
    	if(choice==1){
    		cout << "Enter domain name you need: ";
    		string domain; cin>>domain;
    		cout << "Enter ip address: ";
    		string ip; cin>>ip;
    		registerDomain(domain, ip);
    	}
    	else if(choice==2){
    		cout << "Enter the search query(IP/domain name): ";
    		string search; cin>>search;
    		string res = dnsLookup(search);
    		cout << "Result: " << res << endl;
    	}
    	else if(choice==3){
    	    cout << "Exiting..." << endl;
    	    break;
    	}
	}
	
	return 0;
}
