# Decryption Key Assembly

################################################################################
# Name:		Qingyang Lin
# Class:	CS2318 - 002, Fall 2017
# Subject:	Assignment 3 Part 2
# Date:		12/07/2017
################################################################################
#void CoutCstr(char cstr[]);
#void CoutCstrNL(char cstr[]);
#void CoutOneInt(int oneInt);
#void PopulateArray(int a[], int* usedPtr, int cap);
#void ShiftLeftBy1(int* firstElePtr, int* lastElePtr);
#void MakeAM1D(int a[], int* usedPtr);
#int  CalcTruncAvg(int a[], int used);
#void CalcA2A3(int truncAvg, int a1[], int a2[], int a3[], int* used1Ptr, int* used2Ptr, int* used3Ptr);
#void ProcArrays(int* used3Ptr, int a1[], int a2[], int a3[], int* used1Ptr, int* used2Ptr);
#void ShowArray(int a[], int used);
#void ShowArrayLabeled(int a[], int used, char label[]);
#
			.text
			.globl main
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#int main()
#{
###############################################################################
main:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t4: reply
# (usual ones for syscall & function call)
###############################################################################
#		int a1[12],
#		    a2[12],
#		    a3[12];
#		char reply;
#		int used1,
#		    used2,
#		    used3;
#		char begA1Str[]  = "beginning a1: ";
#		char am1dA1Str[] = "a1 (dups<=1): ";
#		char procA1Str[] = "processed a1: ";
#		char procA2Str[] = "          a2: ";
#		char procA3Str[] = "          a3: ";
#		char dlStr[]     = "================================";
#		char byeStr[]    = "bye...";

			# PROLOG:
			addiu $sp, $sp, -336
			sw $ra, 332($sp)
			sw $fp, 328($sp)
			addiu $fp, $sp, 336
			j begDataInitM				# "clutter-reduction" jump
endDataInitM:

			# BODY:
#		reply = 'y';
			li $t4, 'y'
#		goto WTest1;
			j WTest1
begW1:
#		PopulateArray(a1, &used1, 12);
			addi $a0, $sp, 184
			addi $a1, $sp, 180
			li $a2, 12
			jal PopulateArray
#		ShowArrayLabeled(a1, used1, begA1Str);
			addi $a0, $sp, 184
			lw $a1, 180($sp)
			addi $a2, $sp, 24
			jal ShowArrayLabeled
#		ProcArrays(&used3, a1, a2, a3, &used1, &used2);
			addi $a0, $sp, 172
			addi $a1, $sp, 184
			addi $a2, $sp, 232
			addi $a3, $sp, 280
			addi $t0, $sp, 180
			sw $t0, 16($sp)
			addi $t0, $sp, 176
			sw $t0, 20($sp)
			########## (4) ##########
			jal ProcArrays
#		ShowArrayLabeled(a1, used1, procA1Str);
			addi $a0, $sp, 184
			lw $a1, 180($sp)
			addi $a2, $sp, 46
			jal ShowArrayLabeled
#		ShowArrayLabeled(a2, used2, procA2Str);
			addi $a0, $sp, 232
			lw $a1, 176($sp)
			addi $a2, $sp, 61
			jal ShowArrayLabeled
#		ShowArrayLabeled(a3, used3, procA3Str);
			addi $a0, $sp, 280
			lw $a1, 172($sp)
			addi $a2, $sp, 76
			jal ShowArrayLabeled
#		cout << dacStr;
			addi $a0, $sp, 91
			jal CoutCstr
#		cin >> reply;
			li $v0, 12
			syscall
			move $t4, $v0				# $t4 is reply
			# newline to offset shortcoming of syscall #12
			li $v0, 11
			li $a0, '\n'
			syscall
#WTest1:	if (reply == 'n') goto xitW1;
#		if (reply != 'N') goto begW1;
WTest1:			li $t0, 'n'
			beq $t4, $t0, xitW1
			li $t0, 'N'
			bne $t4, $t0, begW1
endW1:
xitW1:
#		cout << dlStr << '\n';
			addi $a0, $sp, 137
			jal CoutCstrNL
#		cout << byeStr << '\n';
			addi $a0, $sp, 39
			jal CoutCstrNL
#		cout << dlStr << '\n';
			addi $a0, $sp, 137
			jal CoutCstrNL

			# EPILOG:
			lw $fp, 328($sp)
			lw $ra, 332($sp)
			addiu $sp, $sp, 336
#		return 0;
#}
			li $v0, 10
			syscall


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CoutCstr(char cstr[])
#{
###############################################################################
CoutCstr:
#################
# Register usage:
#################
# (usual ones for syscall)
###############################################################################
			# PROLOG:
								# no stack frame needed
			# BODY:
#		cout << cstr;
			li $v0, 4
			syscall

			# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CoutCstrNL(char cstr[])
#{
###############################################################################
CoutCstrNL:
#################
# Register usage:
#################
# (usual ones for syscall & function call)
###############################################################################
			# PROLOG:
			addiu $sp, $sp, -32
			sw $ra, 28($sp)
			sw $fp, 24($sp)
			addiu $fp, $sp, 32

			# BODY:
#		CoutCstr(cstr);
			jal CoutCstr
#		cout << '\n';
			li $a0, '\n'
			li $v0, 11
			syscall

			# EPILOG:
			lw $fp, 24($sp)
			lw $ra, 28($sp)
			addiu $sp, $sp, 32
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CoutOneInt(int oneInt)
#{
###############################################################################
CoutOneInt:
#################
# Register usage:
#################
# (usual ones for syscall)
###############################################################################
			# PROLOG:
								# no stack frame needed
			# BODY:
#		cout << oneInt;
			li $v0, 1
			syscall

			# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void PopulateArray(int a[], int* usedPtr, int cap)
#{
###############################################################################
PopulateArray:
#################
# Register usage:
#################
# $s1: hopPtr
# $t0: holder for a value/address
# $t1: another holder for a value/address
# $t2: yet another holder for a value/address
# $t4: reply
# (usual ones for syscall & function call)
###############################################################################
#		char reply;
#		char einStr[]    = "Enter integer #";
#		char moStr[]     = "Max of ";
#		char ieStr[]     = " ints entered...";
#		char emiStr[]    = "Enter more ints? (n or N = no, others = yes) ";
#		int *hopPtr;

			# PROLOG:
			addiu $sp, $sp, -120
			sw $ra, 116($sp)
			sw $fp, 112($sp)
			addiu $fp, $sp, 120

			j begDataInitPA				# "clutter-reduction" jump
endDataInitPA:
			sw $a1, 4($fp)				# usedPtr as received saved in caller's frame
			sw $a2, 8($fp)				# cap as received saved in caller's frame
			sw $s1, 16($sp)				# save $s1 (callee-saved)

			# BODY:
#		reply = 'y';
			li $t4, 'y'				# $t4 is reply
#		*usedPtr = 0;
			sw $0, 0($a1)				# $a1 still has usedPtr as received
#		hopPtr = a;
			move $s1, $a0				# $a0 still has a as received
#		goto WTest2;
			j WTest2
begW2:
#		CoutCstr(einStr);
			addi $a0, $sp, 24
			jal CoutCstr
#		CoutOneInt(*usedPtr + 1);
			lw $a1, 4($fp)				# usedPtr as received re-loaded into $a1
								# CoutCstr might have clobbered $a1
			lw $a0, 0($a1)				# $a0 has *usedPtr
			addi $a0, $a0, 1			# *usedPtr + 1 as arg1
			jal CoutOneInt
#		cout << ':' << ' ';
			li $v0, 11
			li $a0, ':'
			syscall
			li $a0, ' '
			syscall
#		cin >> *hopPtr;
			li $v0, 5
			syscall					# $v0 has user-entered int
			sw $v0, 0($s1)				# $s1 is hopPtr
#		++(*usedPtr);
			lw $a1, 4($fp)				# usedPtr as received re-loaded into $a1
								# CoutOneInt might have clobbered $a1
			lw $t1, 0($a1)				# $t1 has *usedPtr
			addi $t1, $t1, 1			# $t1 has *usedPtr + 1
			sw $t1, 0($a1)				# ++(*usedPtr)
#		++hopPtr;
			addi $s1, $s1, 4			# $s1 is hopPtr
#		if (*usedPtr >= cap) goto else1;
			lw $a2, 8($fp)				# cap as received re-loaded into $a2
								# CoutOneInt might have clobbered $a2
			bge $t1, $a2, else1			# if (*usedPtr >= cap) goto else1
								# $t1 still has up-to-date *usedPtr
begI1:
#		CoutCstr(emiStr);
			addi $a0, $sp, 48
			jal CoutCstr
#		cin >> reply;
			li $v0, 12
			syscall
			move $t4, $v0				# $t4 is reply
			# newline to offset shortcoming of syscall #12
			li $v0, 11
			li $a0, '\n'
			syscall
#		goto endI1;
			j endI1
else1:
#		CoutCstr(moStr);
			addi $a0, $sp, 40
			jal CoutCstr
#		CoutOneInt(cap);
			lw $a0, 8($fp)				# cap as received loaded into $a0
								# not using $a2 as CoutCstr might have clobbered it
			jal CoutOneInt
#		CoutCstr(ieStr);
			addi $a0, $sp, 94
			jal CoutCstr
#		cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#		reply = 'n';
			li $t4, 'n'				# $t4 is reply
endI1:
#WTest2:	if (reply == 'n') goto xitW2;
#		if (reply != 'N') goto begW2;
WTest2:			li $t0, 'n'
			beq $t4, $t0, xitW2
			li $t0, 'N'
			bne $t4, $t0, begW2
endW2:
xitW2:
			# EPILOG:
			lw $s1, 16($sp)				# restore $s1 (callee-saved)
			lw $fp, 112($sp)
			lw $ra, 116($sp)
			addiu $sp, $sp, 120
#		return;
#}
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ShowArray(int a[], int used)
#{
###############################################################################
ShowArray:
#################
# Register usage:
#################
# $t1: hopPtr
# $t9: endPtr
# $a1: used (as received)
# (usual ones for syscall & function call)
###############################################################################
			# PROLOG:
								# no stack frame needed

			# BODY:
#		int *hopPtr;
#		int *endPtr;

#		if (used <= 0) goto endI2;
			blez $a1, endI2
begI2:
#		hopPtr = a;
			move $t1, $a0
#		endPtr = a + used;
			move $t9, $a1				# $t9 has used
			sll $t9, $t9, 2				# $t9 has 4*used
			add $t9, $t9, $t1			# $t9 has &a[used]
begDW1:
#		cout << *hopPtr << ' ' << ' ';
			li $v0, 1
			lw $a0, 0($t1)				# $a0 has *hopPtr
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
			syscall
#		++hopPtr;
			addi $t1, $t1, 4
endDW1:
#DWTest1:	if (hopPtr < endPtr) goto begDW1;
DWTest1:		blt $t1, $t9, begDW1
endI2:
#		cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall

			# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra




#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ShowArrayLabeled(int a[], int used, char label[])
#{
###############################################################################
ShowArrayLabeled:
#################
# Register usage:
#################
# $t1: i
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################
			# PROLOG:
			addiu $sp, $sp, -32
			sw $ra, 28($sp)
			sw $fp, 24($sp)
			addiu $fp, $sp, 32

			sw $a0, 0($fp)				# a as received saved in caller's frame
			sw $a1, 4($fp)				# used as received saved in caller's frame

			# BODY:
#		CoutCstr(label);
			move $a0, $a2
			jal CoutCstr
#		ShowArray(a, used);
			lw $a0, 0($fp)				# a as received re-loaded into $a0
			lw $a1, 4($fp)				# used as received re-loaded into $a1
								# CoutCstr might have clobbered $a0 & $a1
			jal ShowArray

			# EPILOG:
			lw $fp, 24($sp)
			lw $ra, 28($sp)
			addiu $sp, $sp, 32
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ShiftLeftBy1(int* firstElePtr, int* lastElePtr)
#// shifts each element beginning @ firstElePtr & ending @ lastElePtr (inclusive)
#{
###############################################################################
ShiftLeftBy1:
#################
# Register usage:
#################
# $a1: lastElePtr (as received)
# $t1: elePtr
# $s1: valOfEle
###############################################################################
#		int* elePtr;
#		int valOfEle;

			# PROLOG:
			addiu $sp, $sp, -32
			sw $ra, 28($sp)
			sw $fp, 24($sp)
			addiu $fp, $sp, 32

			sw $s1, 0($sp)

			# BODY:
#		elePtr = firstElePtr;
			move $t1, $a0
#		goto FTest2;
			j FTest2
begF2:
#		valOfEle = *elePtr;
			lw $s1, 0($t1)
#		*(elePtr - 1) = valOfEle;
			sw $s1, -4($t1)
#		++elePtr;
			addi $t1, $t1, 4
FTest2:
#		if (elePtr <= lastElePtr) goto begF2;
			ble $t1, $a1 begF2
endF2:
#   }
			# EPILOG:
			lw $ra, 28($sp)
			lw $fp, 24($sp)
			lw $s1, 0($sp)
			addiu $sp, $sp, 32
			########## (15) ##########
#		return;
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void MakeAM1D(int a[], int* usedPtr)
#{
###############################################################################
MakeAM1D:
#################
# Register usage:
#################
# $t1: hopPtr1
# $t2: hopPtr2
# $t3: holder for a value/address
# $t4: another holder for a value/address
# $t8: endPtr1
# $t9: endPtr2
# $s1: found
# $v1: yet another holder for a value/address
###############################################################################
#		int found;
#		int* hopPtr1;
#		int* hopPtr2;
#		int* endPtr1;
#		int* endPtr2;

			# PROLOG:
			addiu $sp, $sp, -48
			sw $ra, 44($sp)
			sw $fp, 40($sp)
			addiu $fp, $sp, 48

			sw $a0, 0($fp)
			sw $a1, 4($fp)
			sw $s1, 16($sp)

			# BODY:
#		hopPtr1 = a;
			move $t1, $a0
#		endPtr1 = a + *usedPtr - 1;
			lw $t8, 0($a1)
			addi $t8, $t8, -1
			sll $t8, $t8, 2
			add $t8, $t8, $a0
#		goto WTest3;
			j WTest3
begW3:
#		found = 0;
			li $s1, 0
#		hopPtr2 = hopPtr1 + 1;
			addi $t2, $t1, 4
#		endPtr2 = a + *usedPtr;
			lw $t3, 4($fp)
			lw $t9, 0($t3)
			sll $t9, $t9, 2
			lw $t4, 0($fp)
			add $t9, $t9, $t4
#		goto FTest1;
			j FTest1
begF1:
#		if (*hopPtr2 != *hopPtr1) goto endI4;
			lw $t3, 0($t2)
			lw $t4, 0($t1)
			bne $t3, $t4, endI4
begI4:
#		if (found != 1) goto else5;
			li $t3, 1
			bne $s1, $t3, else5
begI5:
#		ShiftLeftBy1(hopPtr2 + 1, endPtr2 - 1);
			sw $t1, 24($sp)
			sw $t2, 28($sp)
			sw $t8, 32($sp)
			sw $t9, 36($sp)
			addi $a0, $t2, 4
			addi $a1, $t9, -4
			jal ShiftLeftBy1
			lw $t1, 24($sp)
			lw $t2, 28($sp)
			lw $t8, 32($sp)
			lw $t9, 36($sp)
#		--(*usedPtr);
			lw $t3, 4($fp)
			lw $t4, 0($t3)
			addi $t4, $t4, -1
			sw $t4, 0($t3)
#		--endPtr1;
			addi $t8, $t8, -4
#		--endPtr2;
			addi $t9, $t9, -4
#		--hopPtr2;
			addi $t2, $t2, -4
#		goto endI5;
			j endI5
else5:
#		++found;
			addi $s1, $s1, 1
endI5:
endI4:
#		++hopPtr2;
			addi $t2, $t2, 4
FTest1:
#		if (hopPtr2 < endPtr2) goto begF1;
			blt $t2, $t9, begF1
endF1:
#		++hopPtr1;
			addi $t1, $t1, 4
WTest3:
#		if (hopPtr1 < endPtr1) goto begW3;
			blt $t1, $t8, begW3
endW3:
			# EPILOG:
			lw $fp, 40($sp)
			lw $ra, 44($sp)
			lw $s1, 16($sp)
			addiu $sp, $sp, 48
			########## (54) ##########
#		return;
#}
			jr $ra





#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#int CalcTruncAvg(int a[], int used)
#{
###############################################################################
CalcTruncAvg:
#################
# Register usage:
#################
# $t0: sum
# $t1: hopPtr
# $t9: endPtr
# $v1: holder for a value/address
###############################################################################
#		int sum;
#		int* hopPtr;
#		int* endPtr;

#		sum = 0;
			li $t0, 0
#		hopPtr = a + used - 1;
			addi $v1, $a1, -1
			sll $v1, $v1, 2
			add $t1, $a0, $v1
#		endPtr = a;
			move $t9, $a0
begDW4:
#		sum += *hopPtr;
			lw $v1, 0($t1)
			add $t0, $t0, $v1
#		--hopPtr;
			addi $t1, $t1, -4
endDW4:
DWTest4:
#		if (hopPtr >= endPtr) goto begDW4;
			bge $t1, $t9, begDW4

#		return sum / used;
			div $t0, $a1
			mflo $v0
			########## (11) ##########
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
########################li $v0, 999999999
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CalcA2A3(int truncAvg, int a1[], int a2[], int a3[], int* used1Ptr, int* used2Ptr, int* used3Ptr)
#void CalcA2A3(         $a0,      $a1,      $a2,      $a3,       16($sp),       20($sp),       24($sp))
#{
###############################################################################
CalcA2A3:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: hopPtr1
# $t2: hopPtr2
# $t3: hopPtr3
# $t4: hopPtr11
# $t8: endPtr11
# $t9: endPtr1
# $v1: another holder for a value/address
###############################################################################
#		int* hopPtr1;
#		int* hopPtr2;
#		int* hopPtr3;
#		int* hopPtr11;
#		int* endPtr1;
#		int* endPtr11;

#		*used2Ptr = 0;
			lw $t0, 20($sp)
			sw $0, 0($t0)
#		*used3Ptr = 0;
			lw $t0, 24($sp)
			sw $0, 0($t0)
#		hopPtr2 = a2;
			move $t2, $a2
#		hopPtr3 = a3;
			move $t3, $a3

#		hopPtr1 = a1;
			move $t1, $a1
#		endPtr1 = a1 + *used1Ptr;
			lw $t0, 16($sp)
			lw $t9, 0($t0)
			sll $t9, $t9, 2
			add $t9, $t9, $a1
#		goto FTest3;
			j FTest3
begF3:
#		if (*hopPtr1 == truncAvg) goto endI8;
			lw $t0, 0($t1)
			beq $t0, $a0, endI8
begI8:
#		if (*hopPtr1 >= truncAvg) goto else9;
			bge $t0, $a0, else9
begI9:
#		*hopPtr2 = *hopPtr1;
			lw $t0, 0($t1)
			sw $t0, 0($t2)
#		++(*used2Ptr);
			lw $t0, 20($sp)
			lw $v1, 0($t0)
			addi $v1, $v1, 1
			sw $v1, 0($t0)
#		++hopPtr2;
			addi $t2, $t2, 4
#		goto endI9;
			j endI9
else9:
#		*hopPtr3 = *hopPtr1;
			lw $t0, 0($t1)
			sw $t0, 0($t3)
#		++(*used3Ptr);
			lw $t0, 24($sp)
			lw $v1, 0($t0)
			addi $v1, $v1, 1
			sw $v1, 0($t0)
#		++hopPtr3;
			addi $t3, $t3, 4
endI9:
#		hopPtr11 = hopPtr1 + 1;
			addi $t4, $t1, 4
#		endPtr11 = a1 + *used1Ptr;
			lw $t0, 16($sp)
			lw $t8, 0($t0)
			sll $t8, $t8, 2
			add $t8, $t8, $a1
#		goto FTest4;
			j FTest4
begF4:
#		*(hopPtr11 - 1) = *hopPtr11;
			lw $t0, 0($t4)
			sw $t0, -4($t4)
#		++hopPtr11;
			addi $t4, $t4, 4
FTest4:
#		if (hopPtr11 < endPtr11) goto begF4;
			blt $t4, $t8, begF4
endF4:
#		--(*used1Ptr);
			lw $t0, 16($sp)
			lw $v1, 0($t0)
			addi $v1, $v1, -1
			sw $v1, 0($t0)
#		--endPtr1;
			addi $t9, $t9, -4
#		--hopPtr1;
			addi $t1, $t1, -4
endI8:
#		++hopPtr1;
			addi $t1, $t1, 4
FTest3:
#		if (hopPtr1 < endPtr1) goto begF3;
			blt $t1, $t9, begF3
endF3:
#		if (*used1Ptr != 0) goto endIa;
			lw $t0, 16($sp)
			lw $v1, 0($t0)
			bne $v1, $0, endIa
begIa:
#		*(a1 + 0) = truncAvg;
			sw $a0, 0($a1)
#		++(*used1Ptr);
			lw $t0, 16($sp)
			lw $v1, 0($t0)
			addi $v1, $v1, 1
			sw $v1, 0($t0)
endIa:
			########## (54) ##########
#		return;
#}
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ProcArrays(int* used3Ptr, int a1[], int a2[], int a3[], int* used1Ptr, int* used2Ptr)
#void ProcArrays(          $a0,      $a1,      $a2,      $a3,       16($sp),       20($sp))
#{
###############################################################################
ProcArrays:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: truncAvg
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################
			# PROLOG:
			addiu $sp, $sp, -56
			sw $ra, 52($sp)
			sw $fp, 48($sp)
			addiu $fp, $sp, 56

			sw $a0, 0($fp)				# used3Ptr as received saved in caller's frame
			sw $a1, 4($fp)				# a1 as received saved in caller's frame
			sw $a2, 8($fp)				# a2 as received saved in caller's frame
			sw $a3, 12($fp)				# a3 as received saved in caller's frame

			# BODY:
#		int truncAvg;
#		char am1dA1Str[] = "a1 (dups<=1): ";
			j begDataInitPrAr			# "clutter-reduction" jump
endDataInitPrAr:
#		if (*used1Ptr <= 1) goto else3;
			lw $t0, 16($fp)				# $t0 has used1Ptr
			lw $v1, 0($t0)				# $v1 has *used1Ptr
			li $t0, 1					# $t0 has 1
			ble $v1, $t0, else3
begI3:
#		MakeAM1D(a1, used1Ptr);
			lw $a0, 4($fp)				# $a0 as a1 as arg1
			lw $a1, 16($fp)				# $a1 has used1Ptr as arg2
			########## (2) ##########
			jal MakeAM1D
#		ShowArrayLabeled(a1, *used1Ptr, am1dA1Str);
			lw $a0, 4($fp)				# $a0 has a1 as arg1
			lw $t0, 16($fp) 			# $t0 received used1Ptr
			lw $a1, 0($t0)				# $a1 has *used1Ptr as arg2
			addi $a2, $sp, 32			# $a2 has am1dA1Str as arg3
			########## (4) ##########
			jal ShowArrayLabeled
#		if (*used1Ptr <= 0) goto endI7;
			lw $t0, 16($fp)				# $t0 has used1Ptr received (via stack)
			lw $v1, 0($t0)				# $v1 has *used1Ptr
			blez $v1, endI7
begI7:
#		truncAvg = CalcTruncAvg(a1, *used1Ptr);
			lw $a0, 4($fp)				# $a0 has a1 as arg1
			lw $t0, 16($fp) 			# $t0 received used1Ptr
			lw $a1, 0($t0)				# $a1 has *used1Ptr as arg2
			########## (3) ##########
			jal CalcTruncAvg
			move $t1, $v0				# $t1 has truncAvg returned
			#j begDebugCalcTruncAvg			# uncomment this instruction if useful when debugging
endDebugCalcTruncAvg:
#		CalcA2A3(truncAvg, a1, a2, a3, used1Ptr, used2Ptr, used3Ptr);
			move $a0, $t1				# $a0 has truncAvg as arg1
			lw $a1, 4($fp)				# $a1 has a1 as arg2
			lw $a2, 8($fp)				# $a2 has a2 as arg3
			lw $a3, 12($fp)				# $a3 has a3 as arg4
			lw $v1, 16($fp)				# $v1 has used1Ptr
			sw $v1, 16($sp)				# used1Ptr as arg5
			lw $v1, 20($fp)				# $v1 has used2Ptr
			sw $v1, 20($sp)				# used1Ptr as arg6
			lw $v1, 0($fp)				# $v1 has used3Ptr
			sw $v1, 24($sp)				# used1Ptr as arg7
			########## (10) ##########
			jal CalcA2A3
endI7:
#		goto endI3;
			j endI3
else3:
#		ShowArrayLabeled(a1, *used1Ptr, am1dA1Str);
			lw $a0, 4($fp)				# a1 as received (saved on stack coming in) as arg1
			lw $t0, 16($fp)				# $t0 has used1Ptr received (via stack)
			lw $a1, 0($t0)				# *used1Ptr as arg2
			addi $a2, $sp, 32			# &am1dA1Str[0] as arg3
			jal ShowArrayLabeled
#		*used2Ptr = 0;
			lw $t0, 20($fp)				# $t0 has used2Ptr
			sw $0, 0($t0)
#		*used3Ptr = 0;
			lw $t0, 0($fp)				# used3Ptr as received saved in caller's frame
			sw $0, 0($t0)
endI3:
			# EPILOG:
			lw $fp, 48($sp)
			lw $ra, 52($sp)
			addiu $sp, $sp, 56
#}
			jr $ra



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main's string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitM:
			li $t0, 'b'
			sb $t0, 24($sp)
			li $t0, 'e'
			sb $t0, 25($sp)
			li $t0, 'g'
			sb $t0, 26($sp)
			li $t0, 'i'
			sb $t0, 27($sp)
			li $t0, 'n'
			sb $t0, 28($sp)
			li $t0, 'n'
			sb $t0, 29($sp)
			li $t0, 'i'
			sb $t0, 30($sp)
			li $t0, 'n'
			sb $t0, 31($sp)
			li $t0, 'g'
			sb $t0, 32($sp)
			li $t0, ' '
			sb $t0, 33($sp)
			li $t0, 'a'
			sb $t0, 34($sp)
			li $t0, '1'
			sb $t0, 35($sp)
			li $t0, ':'
			sb $t0, 36($sp)
			li $t0, ' '
			sb $t0, 37($sp)
			li $t0, '\0'
			sb $t0, 38($sp)
			li $t0, 'b'
			sb $t0, 39($sp)
			li $t0, 'y'
			sb $t0, 40($sp)
			li $t0, 'e'
			sb $t0, 41($sp)
			li $t0, '.'
			sb $t0, 42($sp)
			li $t0, '.'
			sb $t0, 43($sp)
			li $t0, '.'
			sb $t0, 44($sp)
			li $t0, '\0'
			sb $t0, 45($sp)
			li $t0, 'p'
			sb $t0, 46($sp)
			li $t0, 'r'
			sb $t0, 47($sp)
			li $t0, 'o'
			sb $t0, 48($sp)
			li $t0, 'c'
			sb $t0, 49($sp)
			li $t0, 'e'
			sb $t0, 50($sp)
			li $t0, 's'
			sb $t0, 51($sp)
			li $t0, 's'
			sb $t0, 52($sp)
			li $t0, 'e'
			sb $t0, 53($sp)
			li $t0, 'd'
			sb $t0, 54($sp)
			li $t0, ' '
			sb $t0, 55($sp)
			li $t0, 'a'
			sb $t0, 56($sp)
			li $t0, '1'
			sb $t0, 57($sp)
			li $t0, ':'
			sb $t0, 58($sp)
			li $t0, ' '
			sb $t0, 59($sp)
			li $t0, '\0'
			sb $t0, 60($sp)
			li $t0, ' '
			sb $t0, 61($sp)
			li $t0, ' '
			sb $t0, 62($sp)
			li $t0, ' '
			sb $t0, 63($sp)
			li $t0, ' '
			sb $t0, 64($sp)
			li $t0, ' '
			sb $t0, 65($sp)
			li $t0, ' '
			sb $t0, 66($sp)
			li $t0, ' '
			sb $t0, 67($sp)
			li $t0, ' '
			sb $t0, 68($sp)
			li $t0, ' '
			sb $t0, 69($sp)
			li $t0, ' '
			sb $t0, 70($sp)
			li $t0, 'a'
			sb $t0, 71($sp)
			li $t0, '2'
			sb $t0, 72($sp)
			li $t0, ':'
			sb $t0, 73($sp)
			li $t0, ' '
			sb $t0, 74($sp)
			li $t0, '\0'
			sb $t0, 75($sp)
			li $t0, ' '
			sb $t0, 76($sp)
			li $t0, ' '
			sb $t0, 77($sp)
			li $t0, ' '
			sb $t0, 78($sp)
			li $t0, ' '
			sb $t0, 79($sp)
			li $t0, ' '
			sb $t0, 80($sp)
			li $t0, ' '
			sb $t0, 81($sp)
			li $t0, ' '
			sb $t0, 82($sp)
			li $t0, ' '
			sb $t0, 83($sp)
			li $t0, ' '
			sb $t0, 84($sp)
			li $t0, ' '
			sb $t0, 85($sp)
			li $t0, 'a'
			sb $t0, 86($sp)
			li $t0, '3'
			sb $t0, 87($sp)
			li $t0, ':'
			sb $t0, 88($sp)
			li $t0, ' '
			sb $t0, 89($sp)
			li $t0, '\0'
			sb $t0, 90($sp)
			li $t0, 'D'
			sb $t0, 91($sp)
			li $t0, 'o'
			sb $t0, 92($sp)
			li $t0, ' '
			sb $t0, 93($sp)
			li $t0, 'a'
			sb $t0, 94($sp)
			li $t0, 'n'
			sb $t0, 95($sp)
			li $t0, 'o'
			sb $t0, 96($sp)
			li $t0, 't'
			sb $t0, 97($sp)
			li $t0, 'h'
			sb $t0, 98($sp)
			li $t0, 'e'
			sb $t0, 99($sp)
			li $t0, 'r'
			sb $t0, 100($sp)
			li $t0, ' '
			sb $t0, 101($sp)
			li $t0, 'c'
			sb $t0, 102($sp)
			li $t0, 'a'
			sb $t0, 103($sp)
			li $t0, 's'
			sb $t0, 104($sp)
			li $t0, 'e'
			sb $t0, 105($sp)
			li $t0, '?'
			sb $t0, 106($sp)
			li $t0, ' '
			sb $t0, 107($sp)
			li $t0, '('
			sb $t0, 108($sp)
			li $t0, 'n'
			sb $t0, 109($sp)
			li $t0, ' '
			sb $t0, 110($sp)
			li $t0, 'o'
			sb $t0, 111($sp)
			li $t0, 'r'
			sb $t0, 112($sp)
			li $t0, ' '
			sb $t0, 113($sp)
			li $t0, 'N'
			sb $t0, 114($sp)
			li $t0, ' '
			sb $t0, 115($sp)
			li $t0, '='
			sb $t0, 116($sp)
			li $t0, ' '
			sb $t0, 117($sp)
			li $t0, 'n'
			sb $t0, 118($sp)
			li $t0, 'o'
			sb $t0, 119($sp)
			li $t0, ','
			sb $t0, 120($sp)
			li $t0, ' '
			sb $t0, 121($sp)
			li $t0, 'o'
			sb $t0, 122($sp)
			li $t0, 't'
			sb $t0, 123($sp)
			li $t0, 'h'
			sb $t0, 124($sp)
			li $t0, 'e'
			sb $t0, 125($sp)
			li $t0, 'r'
			sb $t0, 126($sp)
			li $t0, 's'
			sb $t0, 127($sp)
			li $t0, ' '
			sb $t0, 128($sp)
			li $t0, '='
			sb $t0, 129($sp)
			li $t0, ' '
			sb $t0, 130($sp)
			li $t0, 'y'
			sb $t0, 131($sp)
			li $t0, 'e'
			sb $t0, 132($sp)
			li $t0, 's'
			sb $t0, 133($sp)
			li $t0, ')'
			sb $t0, 134($sp)
			li $t0, ' '
			sb $t0, 135($sp)
			li $t0, '\0'
			sb $t0, 136($sp)
			li $t0, '='
			sb $t0, 137($sp)
			li $t0, '='
			sb $t0, 138($sp)
			li $t0, '='
			sb $t0, 139($sp)
			li $t0, '='
			sb $t0, 140($sp)
			li $t0, '='
			sb $t0, 141($sp)
			li $t0, '='
			sb $t0, 142($sp)
			li $t0, '='
			sb $t0, 143($sp)
			li $t0, '='
			sb $t0, 144($sp)
			li $t0, '='
			sb $t0, 145($sp)
			li $t0, '='
			sb $t0, 146($sp)
			li $t0, '='
			sb $t0, 147($sp)
			li $t0, '='
			sb $t0, 148($sp)
			li $t0, '='
			sb $t0, 149($sp)
			li $t0, '='
			sb $t0, 150($sp)
			li $t0, '='
			sb $t0, 151($sp)
			li $t0, '='
			sb $t0, 152($sp)
			li $t0, '='
			sb $t0, 153($sp)
			li $t0, '='
			sb $t0, 154($sp)
			li $t0, '='
			sb $t0, 155($sp)
			li $t0, '='
			sb $t0, 156($sp)
			li $t0, '='
			sb $t0, 157($sp)
			li $t0, '='
			sb $t0, 158($sp)
			li $t0, '='
			sb $t0, 159($sp)
			li $t0, '='
			sb $t0, 160($sp)
			li $t0, '='
			sb $t0, 161($sp)
			li $t0, '='
			sb $t0, 162($sp)
			li $t0, '='
			sb $t0, 163($sp)
			li $t0, '='
			sb $t0, 164($sp)
			li $t0, '='
			sb $t0, 165($sp)
			li $t0, '='
			sb $t0, 166($sp)
			li $t0, '='
			sb $t0, 167($sp)
			li $t0, '='
			sb $t0, 168($sp)
			li $t0, '\0'
			sb $t0, 169($sp)
			j endDataInitM				# back to main

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# PopulateArray's string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitPA:
			li $t0, 'E'
			sb $t0, 24($sp)
			li $t0, 'n'
			sb $t0, 25($sp)
			li $t0, 't'
			sb $t0, 26($sp)
			li $t0, 'e'
			sb $t0, 27($sp)
			li $t0, 'r'
			sb $t0, 28($sp)
			li $t0, ' '
			sb $t0, 29($sp)
			li $t0, 'i'
			sb $t0, 30($sp)
			li $t0, 'n'
			sb $t0, 31($sp)
			li $t0, 't'
			sb $t0, 32($sp)
			li $t0, 'e'
			sb $t0, 33($sp)
			li $t0, 'g'
			sb $t0, 34($sp)
			li $t0, 'e'
			sb $t0, 35($sp)
			li $t0, 'r'
			sb $t0, 36($sp)
			li $t0, ' '
			sb $t0, 37($sp)
			li $t0, '#'
			sb $t0, 38($sp)
			li $t0, '\0'
			sb $t0, 39($sp)
			li $t0, 'M'
			sb $t0, 40($sp)
			li $t0, 'a'
			sb $t0, 41($sp)
			li $t0, 'x'
			sb $t0, 42($sp)
			li $t0, ' '
			sb $t0, 43($sp)
			li $t0, 'o'
			sb $t0, 44($sp)
			li $t0, 'f'
			sb $t0, 45($sp)
			li $t0, ' '
			sb $t0, 46($sp)
			li $t0, '\0'
			sb $t0, 47($sp)
			li $t0, 'E'
			sb $t0, 48($sp)
			li $t0, 'n'
			sb $t0, 49($sp)
			li $t0, 't'
			sb $t0, 50($sp)
			li $t0, 'e'
			sb $t0, 51($sp)
			li $t0, 'r'
			sb $t0, 52($sp)
			li $t0, ' '
			sb $t0, 53($sp)
			li $t0, 'm'
			sb $t0, 54($sp)
			li $t0, 'o'
			sb $t0, 55($sp)
			li $t0, 'r'
			sb $t0, 56($sp)
			li $t0, 'e'
			sb $t0, 57($sp)
			li $t0, ' '
			sb $t0, 58($sp)
			li $t0, 'i'
			sb $t0, 59($sp)
			li $t0, 'n'
			sb $t0, 60($sp)
			li $t0, 't'
			sb $t0, 61($sp)
			li $t0, 's'
			sb $t0, 62($sp)
			li $t0, '?'
			sb $t0, 63($sp)
			li $t0, ' '
			sb $t0, 64($sp)
			li $t0, '('
			sb $t0, 65($sp)
			li $t0, 'n'
			sb $t0, 66($sp)
			li $t0, ' '
			sb $t0, 67($sp)
			li $t0, 'o'
			sb $t0, 68($sp)
			li $t0, 'r'
			sb $t0, 69($sp)
			li $t0, ' '
			sb $t0, 70($sp)
			li $t0, 'N'
			sb $t0, 71($sp)
			li $t0, ' '
			sb $t0, 72($sp)
			li $t0, '='
			sb $t0, 73($sp)
			li $t0, ' '
			sb $t0, 74($sp)
			li $t0, 'n'
			sb $t0, 75($sp)
			li $t0, 'o'
			sb $t0, 76($sp)
			li $t0, ','
			sb $t0, 77($sp)
			li $t0, ' '
			sb $t0, 78($sp)
			li $t0, 'o'
			sb $t0, 79($sp)
			li $t0, 't'
			sb $t0, 80($sp)
			li $t0, 'h'
			sb $t0, 81($sp)
			li $t0, 'e'
			sb $t0, 82($sp)
			li $t0, 'r'
			sb $t0, 83($sp)
			li $t0, 's'
			sb $t0, 84($sp)
			li $t0, ' '
			sb $t0, 85($sp)
			li $t0, '='
			sb $t0, 86($sp)
			li $t0, ' '
			sb $t0, 87($sp)
			li $t0, 'y'
			sb $t0, 88($sp)
			li $t0, 'e'
			sb $t0, 89($sp)
			li $t0, 's'
			sb $t0, 90($sp)
			li $t0, ')'
			sb $t0, 91($sp)
			li $t0, ' '
			sb $t0, 92($sp)
			li $t0, '\0'
			sb $t0, 93($sp)
			li $t0, ' '
			sb $t0, 94($sp)
			li $t0, 'i'
			sb $t0, 95($sp)
			li $t0, 'n'
			sb $t0, 96($sp)
			li $t0, 't'
			sb $t0, 97($sp)
			li $t0, 's'
			sb $t0, 98($sp)
			li $t0, ' '
			sb $t0, 99($sp)
			li $t0, 'e'
			sb $t0, 100($sp)
			li $t0, 'n'
			sb $t0, 101($sp)
			li $t0, 't'
			sb $t0, 102($sp)
			li $t0, 'e'
			sb $t0, 103($sp)
			li $t0, 'r'
			sb $t0, 104($sp)
			li $t0, 'e'
			sb $t0, 105($sp)
			li $t0, 'd'
			sb $t0, 106($sp)
			li $t0, '.'
			sb $t0, 107($sp)
			li $t0, '.'
			sb $t0, 108($sp)
			li $t0, '.'
			sb $t0, 109($sp)
			li $t0, '\0'
			sb $t0, 110($sp)
			j endDataInitPA				# back to PopulateArray

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# ProcArrays' string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitPrAr:
			li $t0, 'a'
			sb $t0, 32($sp)
			li $t0, '1'
			sb $t0, 33($sp)
			li $t0, ' '
			sb $t0, 34($sp)
			li $t0, '('
			sb $t0, 35($sp)
			li $t0, 'd'
			sb $t0, 36($sp)
			li $t0, 'u'
			sb $t0, 37($sp)
			li $t0, 'p'
			sb $t0, 38($sp)
			li $t0, 's'
			sb $t0, 39($sp)
			li $t0, '<'
			sb $t0, 40($sp)
			li $t0, '='
			sb $t0, 41($sp)
			li $t0, '1'
			sb $t0, 42($sp)
			li $t0, ')'
			sb $t0, 43($sp)
			li $t0, ':'
			sb $t0, 44($sp)
			li $t0, ' '
			sb $t0, 45($sp)
			li $t0, '\0'
			sb $t0, 46($sp)
			j endDataInitPrAr			# back to ProcArrays

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#################### code for used during debugging ###########################
################## show TruncAvg after calling CalcTruncAvg ###################
begDebugCalcTruncAvg:
			li $v0, 11
			li $a0, '*'
			syscall
			syscall
			syscall
			syscall
			li $a0, 'T'
			syscall
			li $a0, 'r'
			syscall
			li $a0, 'u'
			syscall
			li $a0, 'n'
			syscall
			li $a0, 'c'
			syscall
			li $a0, 'A'
			syscall
			li $a0, 'v'
			syscall
			li $a0, 'g'
			syscall
			li $a0, ':'
			syscall
			li $a0, ' '
			syscall
			move $a0, $t1				# $t1 has TruncAvg
			li $v0, 1
			syscall
			li $v0, 11
			li $a0, '\n'
			syscall
			j endDebugCalcTruncAvg			# back to ProcArrays
###############################################################################
