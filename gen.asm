.586
.model flat, stdcall
option casemap : none
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib
.const
arrLen = 8

frmt db "%5d", 0
scan_form db "%d",0

arr_str db 'Array:',0
num_str db 13,10,10,'Number: ',0
val_str db 0dh,'New value: ',0
changed_str db 0dh,'Changed value: ',0
.data
seed dd ?
arr dd arrLen dup (?)
arr_final db 0
num db 0
newVal db 0
.code
start:

part:
xor esi,esi
invoke crt_printf,addr arr_str
rdtsc
mov seed,eax
mov ecx,arrLen
mov edi,offset arr
cycle:
push ecx
mov eax,63
call RandomRange
sub eax,0
;stosd
mov arr_final[esi],al
inc si
;invoke crt_printf, addr frmt, dword ptr [edi - 4]
invoke crt_printf, addr frmt, dword ptr arr_final[esi-1]
pop ecx
loop cycle

invoke crt_printf,addr num_str
invoke crt_scanf,offset scan_form,offset num

invoke crt_printf,addr val_str
invoke crt_scanf,offset scan_form,offset newVal

xor eax,eax
mov al,num
mov dl,newVal
mov arr_final[eax],dl
mov dl,byte ptr arr_final[eax]

push edx
invoke crt_printf,addr changed_str
pop edx
invoke crt_printf,addr scan_form,edx

RandomRange proc uses edx
mov edx,eax
imul eax,seed, 08088405h
inc eax
mov seed,eax
mul edx
mov eax,edx
ret
RandomRange endp
end part

ret
end start
