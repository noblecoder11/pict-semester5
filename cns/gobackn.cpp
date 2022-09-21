//============================================================================
// Name        : gobackn.cpp
// Author      : 31132_Shreyash
// Version     : 1.0.0
// Copyright   :
// Description : Go-Back-N ARQ
//============================================================================

#include <iostream>
using namespace std;

void goBackN(int i, int N, int totalFrames, int &totalTransmissions) {
	while(i<=totalFrames) {
		int z = 0;
		for(int j=i; j<i+N and j<=totalFrames; j++) {
			cout << "Sending Frame: " << j << endl;
		}

		for(int j=i; j<i+N and j<=totalFrames; j++) {
			int ack = rand()%2;
			if(ack) {
				cout << "Acknowledgment for frame " << j << endl;
				z++;

			} else {
				cout << "Frame " << j << " not received" << endl;
				cout << "Retransmitting..." << endl;
				break;
			}
		}
		cout << "\n";
		i+=z;
	}
}

int main() {

	cout << "Enter the frame size for Go Back N ARQ: ";
	int N; cin>>N;

	cout << "Enter total number of frames to be transmitted: ";
	int totalFrames; cin>>totalFrames;

	int totalTransmitted=0;

	goBackN(1, N, totalFrames, totalTransmitted);

	cout << "Total number of frames send and resent: " << totalTransmitted << endl;
	return 0;
}
