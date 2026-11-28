package main

import "core:fmt"

tokenize :: proc(src: string) -> [dynamic]Token {
    tokens := make([dynamic]Token, context.temp_allocator)
    
    i := 0
    for i < len(src) {
        c := src[i]
        switch c {
        case ' ', '\t', '\n', '\r':
            i += 1
        case '+':
            append(&tokens, Token{type = .add, value = src[i:i+1]})
            i += 1
        case '-':
            append(&tokens, Token{type = .sub, value = src[i:i+1]})
            i += 1
                case '0'..='9':
            start := i
            for i < len(src) && src[i] >= '0' && src[i] <= '9' {
                i += 1
            }
            append(&tokens, Token{type = .c_int, value = src[start:i]})
        case '"':
            start := i + 1
            i += 1
            for i < len(src) && src[i] != '"' {
                i += 1
            }
            append(&tokens, Token{type = .string, value = src[start:i]})
            if i < len(src) {
                i += 1
            }
        case 'a'..='z', 'A'..='Z', '_':
            start := i
            for i < len(src) && ((src[i] >= 'a' && src[i] <= 'z') || (src[i] >= 'A' && src[i] <= 'Z') || (src[i] >= '0' && src[i] <= '9') || src[i] == '_') {
                i += 1
            }
            if src[start:i] == "write" {
                append(&tokens, Token{type = .write, value = src[start:i]})
            }
        case:
            i += 1
        }
    }
        append(&tokens, Token{type = .eof})
    return tokens

}
