#include <iostream>
#include <random>
#include <cmath>

using namespace std;

int main() {

        int exponent = 0;
        int userAnswer = 0;
        int answer = 0;

        int array[5] = {};
        int index = 0;
        bool same = true;

        bool again = true;
        string againInput = "";

        // Setting up random # Generator
        random_device rd;
        mt19937 gen(rd());
        uniform_int_distribution<> dist (0, 20); // range of numbers to be generated

        while (again) {

                // this is in place so questions don't repeat often
                same = true;

                while (same) {
                        // generate the exponent for question
                        exponent = dist(gen);
                        // cout << "Exponent is : " << exponent << endl; // for debugging purposes

                        // check array history to see if this question was asked recently
                        for(int looker = 0; looker < sizeof(array)/sizeof(int); looker++) {
                                // cout << "Array looker is: " << array[looker] << endl; // for debugging purposes
                                if (array[looker] == exponent) {
                                        same = true; // remains true
                                        break;
                                } else {
                                        same = false;
                                }
                        }
                }

                if (index < 5) {
                        array[index] = exponent;
                        index++;
                } else {
                        index = 0;
                        array[index] = exponent;
                }

                // cout << "Exponent is " << exponent;

                cout << endl << "What is the value of 2^" << exponent << ": ";
                cin >> userAnswer;

                answer = pow(2, exponent);

                if (userAnswer == answer) {
                        cout << "Correct!" << endl;
                } else {
                        cout << "No, the answer is " << answer << endl;
                }

                cout << endl << "Again? (y/n): ";
                cin >> againInput;
                if (againInput != "y") {
                        again = false;
                }

        }

}

