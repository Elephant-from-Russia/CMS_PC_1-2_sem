include console.inc

COMMENT *

   Заготовка программы

*

.data
    N = 9
    A DB 1,2,3,4,5,6,7,8,9
.code
;function CountP(var A: array; n:longword; P:byte):byte;
CountP proc
   PUSH EBP
   MOV EBP, ESP
   PUSH ECX
   PUSH EDX
   PUSH EBX
   MOV EDX, [EBP+8]
   MOV ECX, [EBP+12]
   MOV EAX, 0
L: CMP byte ptr[EDX][type A*ECX - type A], Bl
   JMP next
   INC EAX
next:
    LOOP L
    POP EBX
    POP EAX
    POP ECX 
    POP EBP
    RET 12
CountP endp
Start:
    ININT EAX 
    PUSH EAX
    PUSH N
    PUSH OFFSET A
    CALL CountP
    OUTI EAX
    exit
end Start