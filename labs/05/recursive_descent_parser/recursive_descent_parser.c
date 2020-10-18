#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

/***************************
Example:
Grammar:
E -> T | T  + E
T -> int | int * T| ( E ) 
***************************/

char l;

bool E();
bool E_alpha();

bool T();
bool T_alpha_1();
bool T_alpha_2();
bool T_alpha_3();

void error(){
	printf("Error\n");
	exit(-1);
}

// Match function
bool match(char t) {
    if (l == t) {
        l = getchar();
		return true;
    }
    else {
        return false;
		error();
    }
}

// Definition of T' as per the given production
bool T_alpha_1() {
    bool aux;
    if (aux == match('i') && match('n') && match('t')) {
        return true;
    }
    else {
        return false;
    }
}

// Definition of T' as per the given production
bool T_alpha_2() {
    if (match('*') && T()) {
        return true;
    }
    else {
        return false;
    }
}

// Definition of T' as per the given production
bool T_alpha_3() {
    bool aux;
    if (match('(') && E() && match(')')) {
        return true;
    }
    else {
        return false;
    }
}

// Definition of T as per the given production
bool T() {
    if (l == '(') {
        if (T_alpha_3()) {
            return true;
        }
        else {
            return false;
            error();
        }    
    }
    else {
        if (T_alpha_1()) {
            if (l == '*') {
                if (T_alpha_2()) {
                    return true;
                }
                else {
                    return false;
                }
            }
            return true;
        }
        else {
            return false;
        }
        return false;
    }
}

// Definition of E as per the given production
bool E_alpha() {
    if (T()) {
        return true;
    }
    else {
        return false;
    }
}

// Definition of E, as per the given production
bool E() {
    if (E_alpha()) {
        if (l == '+') {
            if (match('+') && E()) {
                return true;
            }
            else {
                return false;
                error();
            }
        }
        return true;
    }
    else {
        return false;
        error();
    }
}

int main() {
    do {
        l = getchar();
		// E is a start symbol.
	    E();
    } while (l != '\n' && l != EOF);
    if (l == '\n') {
        printf("Parsing Successful\n");
    }
}