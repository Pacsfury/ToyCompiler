package main

Expr :: union {
    Token, ^iBinOp,
}

iBinOp :: struct {
    left: Expr,
    right: Expr,
    op: u8,
}

generateAst :: proc(input: [dynamic]Token) -> Expr {
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
