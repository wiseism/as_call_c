#include <stdio.h>

void print_hello(void) {
    printf("Hello from C function!\n");
}

void print_number(int num) {
    printf("Number from assembly: %d\n", num);
}

int add_numbers(int a, int b) {
    return a + b;
}

void print_string(const char *str) {
    printf("String from assembly: %s\n", str);
}
