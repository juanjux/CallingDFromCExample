#include "useexported.h"
#include <stdio.h>

int main() {
    printf("Hi from C!\n");
    initialize();

    struct MyStruct s = newStruct(1, "cfoo", 0);
    useStruct(s);
    printf("After useStruct, check changes:\n%s\n", toStr(s));

    struct MyStruct other = newStruct(2, "cbar", &s);
    useStruct(other);

    return 0;
}
