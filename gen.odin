package main

import "core:fmt"
import "core:os"

 generateAsm :: proc(tree: Expr) {
    assembly := fmt.tprintf(".intel_syntax noprefix\n.global _start\n_start:\n%v\nmov rbx, rax\nmov rax, 60\nxor rdi, rdi\nsyscall", generateExprAsm(tree))
    fmt.println(assembly)
    os.write_entire_file("output.asm", transmute([]u8)assembly)
}

generateExprAsm :: proc(tree: Expr) -> string {
    switch node in tree {
    case Token:
        switch node.type {
        case .c_int:
            return fmt.tprintf("mov rax, %v\n", node.value)
        case .eof:
            return "; empty expression\n"
        case .add:
            return "; addition operator without operands\n"
        case .sub:
            return "; subtraction operator without operands\n"
        }
    case ^iBinOp:
        if node == nil {
            return "; invalid binary expression\n"
        }

        left_assembly := generateExprAsm(node^.left)
        right_assembly := generateExprAsm(node^.right)
        switch node^.op {
        case '+':
            return fmt.tprintf("%vpush rax\n%vpop rbx\nadd rax, rbx\n", left_assembly, right_assembly)
        case '-':
            return fmt.tprintf("%vpush rax\n%vpop rbx\nsub rbx, rax\nmov rax, rbx\n", left_assembly, right_assembly)
        case:
            return "; unsupported binary operator\n"
        }
    }
    return "; invalid expression\n"
}
