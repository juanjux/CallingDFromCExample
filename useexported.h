struct MyStruct
{
    int a;
    char *str;
    struct MyStruct *other;
};

extern struct MyStruct newStruct(int a, char* str, struct MyStruct* other);
extern void useStruct(struct MyStruct s);
extern char* toStr(struct MyStruct s);

extern void initialize(void);
