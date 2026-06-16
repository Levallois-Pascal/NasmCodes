
; ==========================
; NASM 
;
; Hello world
;
; 2026-06-16
; 
; ==========================

; ==========================
; Compilation instructions
;
; nasm -f elf64 helloworld.asm -o helloworld.o
; ld helloworld.o -o helloworld
; 
;=========================== 

bits 64
global  _start

EXIT equ 60							; constant
RETLINE equ 0xA							; constant

section data
message db "Salut, comment ça va aujourd'hui ?", RETLINE  	; message to displau
messageLen equ $ - message					; calculates the length of the message


section .text
_start:
    mov rax, 1							; write
    mov rdi, 1							; stdout
    mov rsi, message						; message address
    mov rdx, messageLen						; message length
    syscall			

    mov rax, EXIT						; exit
    xor rdi, rdi						; 0
    syscall
