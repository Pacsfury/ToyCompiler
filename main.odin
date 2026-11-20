package main

import "core:fmt"
import "core:os"
import "core:strings"

main :: proc() {
    buf: [256]byte
    fmt.print("Write the code here: \n")
    
    n, err := os.read(os.stdin, buf[:])
    if err != nil {
        fmt.eprintln("Error reading input: ", err)
        return
    }
    generateAsm(generateAst(tokenize(strings.trim_space(string(buf[:n])))))
}
