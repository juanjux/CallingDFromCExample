import std.stdio: writeln;
import std.string: toStringz, fromStringz;
import std.conv: to;

alias cstring = immutable(char)*;

// This could also avoid linking using the D runtime and the GC just changing
// the writeln for printf (std.c.stdio) and the concatenations with snprintf
// (tested). In that case the C code doesn't need to call initalize and terminate...

extern(C)
{
    void initialize() {
        import core.runtime: Runtime;
        Runtime.initialize();
    }

    struct MyStruct
    {
        int a;
        cstring str;
        MyStruct* other;

        @trusted pure const nothrow
        const(cstring) toCString() {
            string ret = "a: " ~ a.to!string ~ "\n";
            if(str)
                ret ~= "str: " ~ str.fromStringz ~ "\n";

            if (other)
                ret ~= "other: " ~ "\n" ~ other.toCString.fromStringz;

            return ret.toStringz;
        }
    }

    @safe @nogc nothrow
    MyStruct newStruct(int a, cstring str, MyStruct* other) {
        return MyStruct(a, str, other);
    }

    // C wont see methods in structs (since it dosn't have that)
    // so we provide this proxy
    @safe pure nothrow
    cstring toStr(in MyStruct s) {
        return s.toCString();
    }

    void useStruct(ref MyStruct s) {
        writeln("Old int value: ", s.a);
        s.a *= 2;
        writeln("New int value: ", s.a);

        writeln("Old string value: ", s.str.fromStringz);
        s.str = (s.str.fromStringz ~ "_newstuffFromD").toStringz;
        writeln("New string value: ", s.str.fromStringz);

        if (s.other)
            writeln("Other struct:\n", s.other.toCString.fromStringz);
    }

}
