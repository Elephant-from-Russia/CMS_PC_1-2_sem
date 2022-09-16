include console.inc

COMMENT *

   Заготовка программы

*

.data
A DB 7, -3, 18, 40 ,55,-8,0
B DB 1, 2,7,3,4,5
AMAX DB ?
BMAX DB ?

.code

MAX PROC; procedure MAX(var x: Массив; n:longword; var m:byte);
    PUSH EBP
    MOV EBP,ESP
    PUSH ECX
    MOV ECX,[EBP+12]
    PUSH EAX
    MOV AL, -128
    PUSH EBX
    MOV EBX, [EBP+8]
    L : CMP [EBX+ECX-1], AL
    JLE SKIP
    MOV AL, [EBX+ECX-1]
    SKIP:LOUP L
    MOV EBX, [EBP+16]
    MOV [EBX],AL
    POP EBX
    POP EAX
    POP ECX
    POP EBP
    RET 12
    ENDP
Start:
   ClrScr
   ConsoleTitle "  аготовка программы"   
   
   PUSH DWORD PTR OFFSET C
   PUSH DWORD PTR 10
   PUSH DWPRD PTR 5
   CALL MAX
   
   MOVSX EAX,AMAX
   OUTI EAX


   MsgBox "Конец задачи","Повторить программу ?",MB_YESNO+MB_ICONQUESTION
   cmp  eax,IDYES
   je   Start
   exit
   end Start