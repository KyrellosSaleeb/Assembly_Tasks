 format pe; console
 entry starting
 include 'win32ax.inc';includeing lib
 section '.code' code readable executable;divide the code into code and data

;Entry of the program
starting:
     mov ebx,[arrayNum]; moving arryNum into eax
     mov [Largest],ebx;largest element is the first one
     mov [Least],ebx;least element is the first one
     mov esi,0	;esi register =0
     mov edi,0	;edi register =0
     mov ecx,[counter]
     mov eax , 0
startloop:
	push ecx;push the element into register ecx
	push eax;push the element into register eax
	cinvoke printf, arrVar , [arrayNum+eax*4];print every element of array
	pop eax;remove element printed from eax
	pop ecx;remove element printed from ecx
	inc eax;icrement the ecx by 1
	loop startloop;if ecx = 0 endloop else dec ecx jmp startloop end print the content of array

cinvoke printf, emptyLine;printf new empty Line after accessing the array

largestLoop:
	cmp edi,[counter];compare if the value of counter > edi value
	jge FinalLargest;jump if that to FinalLargest to stop looping
	mov edx,[arrayNum+4*edi];access elements of array
	cmp edx,[Largest];compare if value of the current > largest
	jge condendlargest;if > so it is max number
	jnge condendleast;else is min number

condendlargest:
	mov [Largest],edx;taking the new value as max
	inc edi;increase edi value by 1
	jmp largestLoop;return to complete the array till the end

condendleast:
	cmp edx, [Least];comparing the new value as min or not
	jge continue;if not continue
	mov [Least],edx;if so take the value as min
	inc edi;increase edi value by 1
	jmp largestLoop;return to complete the array till the end


continue:
	inc edi;increase edi value by 1 to be skipped
	jmp largestLoop;return to complete the array till the end

leastLoop:
	 cmp edi,[counter];compare if the value of counter > edi value
	 jge leastLoop;jump if that to leastLoop to stop looping
	 mov edx,[arrayNum+4*edi];access elements of array
	 cmp edx,[Least];compare if value of the current < least
	 jnge Leastassign;if so jump to make it the min number
	 jge continue2;jump to skip the element


Leastassign:
	 mov [Least],edx;making the current of edx register as min number
	 inc edi;increase edi value by 1
	 jmp leastLoop;return to complete the array till the end

continue2:
	 inc edi;increase edi value by 1 to be skipped
	 jmp leastLoop;return to complete the array till the end

FinalLargest:
	 cinvoke printf, finalMaxNum,[Largest];print the max number
	 mov edi,0;return the edi value to 0 to new loop
	 jmp FinalLeast;jump to print the min number


FinalLeast:
	 cinvoke printf, finalMinNum,[Least];print the min number
	 cinvoke scanf, stopscreen ,anyVariable;to make the screen stop to see the printed values

Quit:

   invoke ExitProcess, 0;;to stop the program from execution

section '.data' data readable writeable;the second div which is data
arrayNum dd 5,8,1,6,7,2,8;array values according to assignment problem
counter dd 7;counter of the element of array
Largest dd ?;define the largest as anonymous variable
Least dd ?;define the least as anonymous variable
anyVariable dd ?; anyvariable as anonymous variable
arrVar dd ' %d ',0;define a variable the array to print it
finalMaxNum db 'The Largest (Max) Number Is: %i     <<<<<>>>>>     ',0;the variable finalMaxNum contains string
finalMinNum db 'The Least (Min) Number Is:  %i',0;the variable finalMinNum contains string
emptyLine db '',10,0;newline string
stopscreen dd '%i',0;variable to stop screen to see the printed lines


section '.idata' import data readable writeable;the second div which is data
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll';libraries for OS to the file execution
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf';printf and scanf libraries
import kernel32, ExitProcess,'ExitProcess';libary to exit from execution of the file