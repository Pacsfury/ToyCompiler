package main

tokens :: enum {
    add,
    sub,
    c_int,
    string,
    write,
    eof
}

Token :: struct {
    type: tokens,
    value: string
}
