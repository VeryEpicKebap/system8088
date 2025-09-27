BITS 16
ORG 0x7C00
start:
    mov si,version
char:
    lodsb
    cmp al,0
    je load
    mov ah,0Eh
    mov bh,0
    mov bl,7
    int 10h
    jmp char

load:
    mov ah,0Eh
    mov al,0Dh
    int 10h
    mov al,0Ah
    int 10h
    mov si,loadmsg
loadm:
    lodsb
    cmp al,0
    je nl
    mov ah,0Eh
    mov bh,0
    mov bl,7
    int 10h
    jmp loadm
nl:
    mov ah,0Eh
    mov al,0Dh
    int 10h
    mov al,0Ah
    int 10h
    mov al,0Dh
    int 10h
    mov al,0Ah
    int 10h
    xor ax,ax
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov sp,7C00h
    mov [drive],dl
    mov ax,1000h
    mov es,ax
    xor bx,bx
    mov ah,2
    mov al,8
    mov ch,0
    mov cl,2
    mov dh,0
    mov dl,[drive]
    int 13h
    jc $
    jmp 1000h:0

drive db 0
version db '// System8088 Bootloader (Rev. 2.00) //',0
loadmsg db 'loading kernel...',0
times 510-($-$$) db 0
dw 0AA55h