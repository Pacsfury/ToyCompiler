# ToyCompiler
A toy compiler from a custom lang to assembly to test Odin (nothing special nor big)

---

## What is ToyCompiler?

ToyCompiler is just a simple compiler in order to learn basic Odin. It's not intended for real use, and it's always experimental and unprofessional.

## What can it do right now?

ToyCompiler can parse and generate assembly for addition and subtraction and write "string".

## Examples

```
1+41-34
```

Generates

```assembly
.intel_syntax noprefix
.global _start
_start:
mov rax, 1
push rax
mov rax, 41
pop rbx
add rax, rbx
push rax
mov rax, 34
pop rbx
sub rbx, rax
mov rax, rbx

mov rbx, rax
mov rax, 60
xor rdi, rdi
syscall
```

Which evaluates to eight.
