include console.inc

COMMENT *

   Заготовка программы

*

.data
C DD ?

.code
SUM_KV PROC ; proccedure(a,b:longint; var c:longiht)
    PUSH EBP
    MOV EBP, ESP
    PUSH EAX
    PUSH ESI
    MOV EAX, [EBP+8]
    ADD EAX, [EBP+12]
    SHL EAX, 1
    MOV ESI, [EBP+16]
    MOV [ESI], EAX
    POP ESI
    POP EAX
    POP EBP
    RET 12
    SUM_KV ENDP
Start:
   PUSH DWORD PTR OFFSET C
   PUSH DWORD PTR 10
   PUSH DWPRD PTR 5
   CALL SUM_KV
   OUTI C

   MsgBox "Конец задачи","Повторить программу ?",MB_YESNO+MB_ICONQUESTION
   cmp  eax,IDYES
   je   Start
   exit
   end Start