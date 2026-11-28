package main

Expr :: union {
    Token, ^iBinOp, ^WriteString,
}

WriteString :: struct {
    value: string,
}

iBinOp :: struct {
    left: Expr,
    right: Expr,
    op: u8,
}

generateAst :: proc(input: [dynamic]Token) -> Expr {
    if len(input) >= 3 && input[0].type == .write && input[1].type == .string && input[2].type == .eof {
        node := new(WriteString, context.temp_allocator)
        node^ = WriteString{value = input[1].value}
        return node
    }

    if len(input) < 2 || input[0].type == tokens.eof {
        empty: Expr = Token{type = .eof}
        return empty
    }

    root: Expr = input[0]
    idx := 1
    for idx + 1 < len(input) && input[idx].type != tokens.eof {
        node := new(iBinOp, context.temp_allocator)
        node^ = iBinOp{
            left = root,
            right = input[idx + 1],
            op = input[idx].value[0],
        }
        root = node
        idx += 2
    }
    return root
}
