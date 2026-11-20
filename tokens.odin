package main

tokens :: enum {
    add,
    sub,
    c_int,
    eof
}

Token :: struct {
    type: tokens,
    value: string
}
