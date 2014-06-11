set disassembly-flavor intel
define hook-stop
print /x $eax
print /x $ebx
print /x $ecx
print /x $edx
print /x $esi
x/4xw $esi
disas
end
