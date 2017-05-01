data segment
  arr dw 1D41H, 1FC8H, 2546H, 5D8CH, 980FH, 7F57H, 0B31H, 741CH, 3D8DH, 9A6CH, 163EH, 820AH, 2DDCH, 6A65H, 66D6H, 2904H, 2971H, 7DB4H, 52B3H, 46BAH, 1D99H, 76A1H, 49B1H, 9981H, 883DH, 0109H, 12C9H, 6B95H, 6337H, 6432H, 03A0H, 94D5H, 8148H, 33FEH, 23D9H, 9E1CH, 4B79H, 0616H, 6C85H, 8AEDH, 5B1DH, 2C23H, 213BH, 568FH, 1767H, 1868H, 648AH, 346BH, 5D56H, 9276H
ends

stack segment
    dw   128  dup(0)
ends

code segment
	assume cs:code,ds:data,ss:stack
start:   
    MOV DX,SP     ;stack 越界判断
	MOV AX,DATA
	MOV DS,AX
	
	XOR SI,SI
	MOV AX,[SI]   
	MOV DI,98     
	
	PUSH SI
	PUSH DI
	
first:	
	CMP  AX,[SI]
	JBE last 
	CMP SI,DI
    JAE FINISH   ;以上两个判断相当于while中的两个判断
	INC SI
	INC SI
	JMP  first

last:  
    CMP [DI],AX
    JBE SWAP
    CMP SI,DI
    JAE FINISH      ;以上两个判断相当于while中的两个判断
    DEC DI
    DEC DI 
    JMP last

SWAP:
    CMP SI,DI
    JAE FINISH
    
    MOV BX,[SI]
    MOV CX,[DI]
    MOV [DI],BX 
    MOV [SI],CX 
    

    JMP first
   
FINISH:  
    CMP DX,SP
    JBE back       ;stack 越界判断
    POP DI
    POP AX
    CMP AX,SI
    JAE FA
    PUSH AX  
    MOV BX,SI
    SUB BX,2
    PUSH BX
FA:   
    CMP SI,DI
    JAE FB 
    MOV BX,SI
    add BX,2
    PUSH BX
    PUSH DI 
FB:  
    CMP DX,SP    
    JBE back 		 ;stack瓒婄晫鍒ゆ柇
    POP DI
    POP SI
    PUSH SI
    PUSH DI 
    MOV AX,[SI] 
    JMP first 
    
  
back:
mov ax, 4c00h
int 21h  

ends
end start  