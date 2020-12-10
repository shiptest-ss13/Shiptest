#include <iostream>
#include <string>
#include "md5.h"
using namespace std;

string obfs_by_key(string str = "", string key = "")
{
	string result = "";
	key = md5(key);
	for (unsigned int i = 0; i < str.length(); i++) {
		int keyPtr = (i % key.length());
		result = result + static_cast<char>((str[i] + key[keyPtr]) - 96);
	}
	return result;
}

string deobfs_by_key(string str = "", string key = "")
{
	string result = "";
	key = md5(key);
	for (unsigned int i = 0; i < str.length(); i++) {
		int keyPtr = (i % key.length());
		result = result + static_cast<char>((str[i] - key[keyPtr]) + 96);
	}
	return result;
}

int main() {
	short opt = 0;
	cout << "1 for obfustication, 2 for deobfustication: ";
	cin >> opt;
	cin.ignore(numeric_limits<streamsize>::max(), '\n');
	if (opt == 1) {
		string str = "";
		string key = "";
		string fallback = "";
		cout << "Enter string to obfusticate: ";
		getline(cin, str);
		cout << "Enter key to obfusticate by (such as the world.URL of a certain BYOND server): ";
		getline(cin, key);
		cout << "And finally the fallback/target word (case sensitive!): ";
		getline(cin, fallback);
		cout << "Generated entry for obf_string_list: " << endl;
		cout << "list(\"\", \"" << obfs_by_key(str, key) << "\", \"" << md5(md5(key) + str) << "\", \"" << fallback << "\")";
	}
	else if (opt == 2) {
		string str = "";
		string key = "";
		cout << "Enter string to deobfusticate: ";
		getline(cin, str);
		cout << "Enter key to deobfusticate by: ";
		getline(cin, key);
		cout << "Deobfusticated string: " << endl;
		cout << deobfs_by_key(str, key);
	}
	cin >> opt;
	return 0;
}
