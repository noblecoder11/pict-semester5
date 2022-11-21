// Code by Shreyash Halge
#include<bits/stdc++.h>
using namespace std;
#define FRAME_SIZE 4

void fifo(vector<int> pages){
    int faults=0;
    int nextReplacementIndex=0;
    vector<int>inMemory(FRAME_SIZE, -1);

    for(int i=0; i<pages.size(); i++){
        for(auto x: inMemory) cout << x << " "; cout << endl;

        int pageToFind = pages[i];
        bool found = false;
        for(int j=0; j<FRAME_SIZE; j++){
            if(inMemory[j]==pageToFind) {
                cout << pageToFind << ": hit\n\n";
                found = true; break;
            }
        }
        if(found) continue;

        // if not found
        cout << pageToFind << ": miss\n\n";
        faults++;
        inMemory[nextReplacementIndex]=pageToFind;
        nextReplacementIndex = (nextReplacementIndex+1)%FRAME_SIZE;
    }

    cout << "Total number of faults: " << faults << endl;
}

int findOptimal(vector<int>inMemory, vector<int> pages, int curr){
    int index=0;
    int longestDist=0;
    
    for(int i=0; i<FRAME_SIZE; i++){
        int dist=INT_MAX;
        for(int j=curr+1; j<pages.size(); j++){
            if(inMemory[i]==pages[j]) { dist = j-curr; break;}
        }
        if(dist>longestDist){
            longestDist=dist;
            index=i;
        }
    }
    return index;
}

void opr(vector<int> pages){
    int faults=0;
    int nextReplacementIndex=0;

    vector<int>inMemory(FRAME_SIZE, -1);
    for(int i=0; i<pages.size(); i++){
        for(auto x : inMemory) cout << x << " "; cout << endl;
        int pageToFind = pages[i];
        bool found = false;
        for(int j=0; j<FRAME_SIZE; j++){
            if(inMemory[j]==pageToFind) {
                cout << i << ": hit\n\n";
                found = true; break;
            }
        }
        if(found) continue;

        // if not found
        cout << i << ": miss\n\n";
        faults++;
        nextReplacementIndex = findOptimal(inMemory, pages, i);
        inMemory[nextReplacementIndex]=pageToFind;
    }

    cout << "Total number of faults: " << faults << endl;
}

int findLRU(vector<int>inMemory, vector<int> pages, int curr){
    int index=0;
    int longestDist=0;
    for(int i=0; i<FRAME_SIZE; i++){
        int dist=INT_MAX;
        for(int j=curr-1; j>=0; j--){
            if(inMemory[i]==pages[j]) { dist = curr-j; break;}
        }
        if(dist>longestDist){
            longestDist=dist;
            index=i;
        }
    }
    return index;
}

void lru(vector<int> pages){
    int faults=0;
    int nextReplacementIndex=0;
    vector<int>inMemory(FRAME_SIZE, -1);
    for(int i=0; i<pages.size(); i++){
        for(auto x : inMemory) cout << x << " "; cout << endl;
        
        int pageToFind = pages[i];
        bool found = false;
        for(int j=0; j<FRAME_SIZE; j++){
            if(inMemory[j]==pageToFind) {
                cout << pageToFind << ": hit\n\n";
                found = true; break;
            }
        }
        if(found) continue;

        // if not found
        cout << pageToFind << ": miss\n\n";
        faults++;
        nextReplacementIndex = findLRU(inMemory, pages, i);
        inMemory[nextReplacementIndex]=pageToFind;
    }

    cout << "Total number of faults: " << faults << endl;
}

int main(){
    int n;
    cout << "Enter the number of pages: "; 
    cin>>n;

    vector<int> pages(n);
    for(int i=0; i<n; i++){
        cout << "Enter page: "; 
        cin>>pages[i];
    }

    int choice;
    while(choice){
        cout << "\n1. FIFO\n2. OPR\n3. LRU\n0. Exit\n";
        cout << "\nEnter your choice: "; cin>>choice;

        switch (choice)
        {
        case 1:
            fifo(pages);
            break;
        case 2:
            opr(pages);
            break;
        case 3:
            lru(pages);
            break;
        case 0:
            break;
        default:
            cout << "Enter a valid choice" << endl;
            break;
        }
    }

    
}
