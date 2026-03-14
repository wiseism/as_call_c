#include <stdio.h>
#include <stdlib.h>

extern int my_strlen(const char *str);

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <string>\n", argv[0]);
        fprintf(stderr, "Example: %s \"Hello World\"\n", argv[0]);
        return EXIT_FAILURE;
    }

    printf("The argument length is - %d\n", my_strlen(argv[1]));

    return 0;
}
