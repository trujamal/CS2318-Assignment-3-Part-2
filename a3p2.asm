################################################################################
# Name:    <your name>
# Class:   CS2318-26?, Spring 2018
# Subject: Assignment 3 Part 2
# Date:    <turn-in date>
################################################################################
#void PopulateArray12(int cap, int a1[], int a2[], int* used1Ptr, int* used2Ptr);
#int  PopulateArray34(int a1[], int a2[], int a3[], int a4[], int used1, int used2, int* used3Ptr, int* used4Ptr);
#void InsertSortedND(int intArr[], int* usedPtr, int oneInt);
#void ProcArraysA(int a1[], int a2[], int a3[], int a4[],
#                 int* used1Ptr, int* used2Ptr, int used3, int used4);
#void ProcArraysB(int minInt, int a1[], int a2[], int a3[], int a4[],
#                 int used1, int used2, int* used3Ptr, int* used4Ptr);
#void MergeCopy12(int intArr[], int a1[], int a2[], int used1, int used2);
#void CoutCstr(const char cstr[]);
#void CoutCstrNL(const char cstr[]);
#void CoutOneInt(int oneInt);
#void ShowArray(const int a[], int size);
#void ShowArrayLabeled(const int array[], int used, const char label[]);
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
# $s0: minInt
# $t0: holder for a value/address
# $t6: reply
# (usual ones for syscall & function call)
###############################################################################
#                   int a1[12],
#                       a2[12],
#                       a3[12],
#                       a4[12];
#                   char reply;
#                   int used1,
#                       used2,
#                       used3,
#                       used4,
#                       minInt;
#                   char begA1Str[] = "beginning a1: ";
#                   char cpaA1Str[] = "chkPointA a1: ";
#                   char proA1Str[] = "processed a1: ";
#                   char comA2Str[] = "          a2: ";
#                   char comA3Str[] = "          a3: ";
#                   char comA4Str[] = "          a4: ";
#                   char dacStr[]    = "Do another case? (n or N = no, others = yes) ";
#                   char dlStr[]     = "================================";
#                   char byeStr[]    = "bye...";

			# PROLOG
			addiu $sp, $sp, -432
			sw $ra, 428($sp)
			sw $fp, 424($sp)
			addiu $fp, $sp, 432
			sw $s0, 36($sp)					# save $s0 (callee-saved)
			j begDataInitM					# "clutter-reduction" jump
endDataInitM:

			# BODY:
#                 //do
begDW_m:#//         {
#                      PopulateArray12(12, a1, a2, &used1, &used2);

			li $a0, 12
			addi $a1, $sp, 232
			addi $a2, $sp, 280
			addi $a3, $sp, 228
			addi $t0, $sp, 224
			sw $t0, 16($sp) # Can't be lw due to going into overflow
			# Section Correct Above
			####################(6)####################

			jal PopulateArray12
#                      cout << endl;
			li $a0, '\n'
			li $v0, 11
			syscall
#                      ShowArrayLabeled(a1, used1, begA1Str);
			addi $a0, $sp, 232
			lw $a1, 228($sp)
			addi $a2, $sp, 40
			jal ShowArrayLabeled
#                      ShowArrayLabeled(a2, used2, comA2Str);
			addi $a0, $sp, 280
			lw $a1, 224($sp)
			addi $a2, $sp, 85
			jal ShowArrayLabeled

#                    //if (used1 > 0 || used2 > 0)
#                      if (used1 > 0) goto begI1_m;
			lw $t0, 228($sp)				# $t0 has used1
			bgtz $t0, begI1_m
#                      if (used2 <= 0) goto else1_m;
			lw $t0, 224($sp)				# $t0 has used2
			blez $t0, else1_m
begI1_m:#//            {
#     minInt = PopulateArray34(a1, a2, a3, a4, used1, used2, &used3, &used4);
####################(12)####################

			#a1-a4
			addi $a0, $sp, 232 # Register a1
			addi $a1, $sp, 280 # Register a2
			addi $a2, $sp, 328 # Register a3
			addi $a3, $sp, 376 # Register a4

			#used1, used2
			addi $t1, $sp, 228 # Register used1
			addi $t2, $sp, 224 # Register used2

			#&used3, &used4
			addi $t0, $sp, 220 # used3 unwrapped
			sw $t0, 24($sp) # arg7
			addi $t0, $sp, 216 #used4 unwrapped
			sw $t0, 28($sp) #arg8

			# move $s0, $v0 # Moving
			jal PopulateArray34

			move $s0, $v0
#                      goto endI1_m;
			j endI1_m
#//                    }
else1_m:#//            else
#//                    {
#                         used3 = 0;
			sw $0, 220($sp)
#                         used4 = 0;
			sw $0, 216($sp)
endI1_m:#//            }
#                      ShowArrayLabeled(a3, used3, comA3Str);
			addi $a0, $sp, 328
			lw $a1, 220($sp)
			addi $a2, $sp, 100
			jal ShowArrayLabeled
#                      ShowArrayLabeled(a4, used4, comA4Str);
			addi $a0, $sp, 376
			lw $a1, 216($sp)
			addi $a2, $sp, 115
			jal ShowArrayLabeled
#                    //if (used1 > 0 || used2 > 0)
#                      if (used1 > 0) goto begI2_m;
			lw $t0, 228($sp)				# $t0 has used1
			bgtz $t0, begI2_m
#                      if (used2 <= 0) goto endI2_m;
			lw $t0, 224($sp)				# $t0 has used2
			blez $t0, endI2_m
begI2_m:#//            {
#                         ProcArraysA(a1, a2, a3, a4, &used1, &used2, used3, used4);
			####################(12)####################
				#a1-a4
			addi $a0, $sp, 232 # Register a1
			addi $a1, $sp, 280 # Register a2
			addi $a2, $sp, 328 # Register a3
			addi $a3, $sp, 376 # Register a4

			#$used1, $used2
			addi $t0, $sp, 228 # used1
			lw $t0, 16($sp) # argument 5, # Using lw for &

			addi $t0, $sp, 224 # used2
			lw $t0, 20($sp) # argument 6

			#used3, used4
			addi $t0, $sp, 220 # used3 unwrapped
			sw $t0, 24($sp) # argument 7

			addi $t0, $sp, 216 #used4 unwrapped
			sw $t0, 28($sp) # argument 8

			jal ProcArraysA
#                         ShowArrayLabeled(a1, used1, cpaA1Str);
			addi $a0, $sp, 232
			lw $a1, 228($sp)
			addi $a2, $sp, 55
			jal ShowArrayLabeled
#                         ShowArrayLabeled(a2, used2, comA2Str);
			addi $a0, $sp, 280
			lw $a1, 224($sp)
			addi $a2, $sp, 85
			jal ShowArrayLabeled
#                         ShowArrayLabeled(a3, used3, comA3Str);
			addi $a0, $sp, 328
			lw $a1, 220($sp)
			addi $a2, $sp, 100
			jal ShowArrayLabeled
#                         ShowArrayLabeled(a4, used4, comA4Str);
			addi $a0, $sp, 376
			lw $a1, 216($sp)
			addi $a2, $sp, 115
			jal ShowArrayLabeled

#                         ProcArraysB(minInt, a1, a2, a3, a4, used1, used2, &used3, &used4);

			####################(14)####################
			#minInt
			move $a0, $s0

			#a1-a4
			addi $a1, $sp, 232 # Register a1
			addi $a2, $sp, 280 # Register a2
			addi $a3, $sp, 328 # Register a3
			addi $t0, $sp, 376 # Register a4
			sw $t0, 16($sp) # argument 5

			#used1, used2
			addi $t0, $sp, 228 # used1
			sw $t0, 20($sp) # argument 6

			addi $t0, $sp, 224 # used2
			sw $t0, 24($sp) # argument 7

			#&used3, &used4
			addi $t0, $sp, 220 # used3 unwrapped
			lw $t0, 28($sp) # argument 8, Possibly use lw instead of sw

			addi $t0, $sp, 216 #used4 unwrapped
			lw $t0, 32($sp) # argument 9, Possibly use lw instead of sw

			jal ProcArraysB
endI2_m:#//            }
#                      ShowArrayLabeled(a1, used1, proA1Str);
			addi $a0, $sp, 232
			lw $a1, 228($sp)
			addi $a2, $sp, 70
			jal ShowArrayLabeled
#                      ShowArrayLabeled(a2, used2, comA2Str);
			addi $a0, $sp, 280
			lw $a1, 224($sp)
			addi $a2, $sp, 85
			jal ShowArrayLabeled
#                      ShowArrayLabeled(a3, used3, comA3Str);
			addi $a0, $sp, 328
			lw $a1, 220($sp)
			addi $a2, $sp, 100
			jal ShowArrayLabeled
#                      ShowArrayLabeled(a4, used4, comA4Str);
			addi $a0, $sp, 376
			lw $a1, 216($sp)
			addi $a2, $sp, 115
			jal ShowArrayLabeled
#                      cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#                      cout << dacStr;
			li $v0, 4
			addi $a0, $sp, 130
			syscall
#                      cin >> reply;
			li $v0, 12
			syscall
			move $t6, $v0					# $t6 is reply
			# newline to offset shortcoming of syscall #12
			#li $v0, 11
			#li $a0, '\n'
			#syscall
#                      cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#//                 }
#                 //while (reply != 'n' && reply != 'N');
DWTest_m:
#               ////if (reply != 'n' && reply != 'N') goto begDW_m;
#                   if (reply == 'n') goto xitDW_m;
			li $t0, 'n'
			beq $t6, $t0, xitDW_m
#                   if (reply != 'N') goto begDW_m;
			li $t0, 'N'
			bne $t6, $t0, begDW_m
xitDW_m:

#                   CoutCstrNL(dlStr);
			addi $a0, $sp, 176
			jal CoutCstrNL
#                   CoutCstrNL(byeStr);
			addi $a0, $sp, 209
			jal CoutCstrNL
#                   CoutCstrNL(dlStr);
			addi $a0, $sp, 176
			jal CoutCstrNL

			# EPILOG:
			lw $s0, 36($sp)					# restore $s0 (callee-saved)
			lw $fp, 424($sp)
			lw $ra, 428($sp)
			addiu $sp, $sp, 432
#                   return 0;
#}
			li $v0, 10
			syscall

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void PopulateArray12(int cap, int a1[], int a2[], int* used1Ptr, int* used2Ptr)
#                         $a0       $a1       $a2            $a3
#{
###############################################################################
PopulateArray12:
#################
# Register usage:
#################
# $s0: intNum
# $t0: holder for a value/address
# $t1: another holder for a value/address
# $t2: yet another holder for a value/address
# $t6: reply
# $t7: oneInt
# (usual ones for syscall & function call)
###############################################################################
#                   char einStr[] = "Enter integer #";
#                   char moStr[]  = "Max of ";
#                   char ieStr[]  = " ints entered...";
#                   char eaiStr[] = "End adding ints? (y or Y = yes, others = no) ";
					# PROLOG:
			addiu $sp, $sp, -120
			sw $ra, 116($sp)
			sw $fp, 112($sp)
			addiu $fp, $sp, 120
			j begDataInitPA12				# "clutter-reduction" jump
endDataInitPA12:
			sw $a0, 0($fp)					# cap as received saved in caller's frame
			sw $a1, 4($fp)					# a1 as received saved in caller's frame
			sw $a2, 8($fp)					# a2 as received saved in caller's frame
			sw $a3, 12($fp)					# used1Ptr as received saved in caller's frame
###########
#                   char reply;
#                   int oneInt;
#                   int intNum = 0;
			li $s0, 0
#                   *used1Ptr = 0;
			sw $0, 0($a3)
#                   *used2Ptr = 0;
			lw $t0, 16($fp)
			sw $0, 0($t0)
#                   CoutCstr(eaiStr);
			addi $a0, $sp, 44
			jal CoutCstr
#                   cin >> reply;
			li $v0, 12
			syscall
			move $t6, $v0					# $t6 is reply
			# newline to offset shortcoming of syscall #12
			li $v0, 11
			li $a0, '\n'
			syscall
#                   goto WTest_PA12;
			j WTest_PA12
#                 //while (reply != 'y' && reply != 'Y')
begW_PA12: #//       {
#                      ++intNum;
			addi $s0, $s0, 1
#                      CoutCstr(einStr);
			addi $a0, $sp, 20
			jal CoutCstr
#                      CoutOneInt(intNum);
			move $a0, $s0
			jal CoutOneInt
#                      cout << ':' << ' ';
			li $v0, 11
			li $a0, ':'
			syscall
			li $a0, ' '
			syscall
#                      cin >> oneInt;
			li $v0, 5
			syscall
			move $t7, $v0

#                    //if ( (intNum & 1) != 0 )
#                      if ( (intNum & 1) == 0 ) goto else1_PA12;
			andi $t0, $s0, 1
			beqz $t0, else1_PA12
begI1_PA12:#//         {
#                         a1[*used1Ptr] = oneInt;
			lw $a1, 4($fp)					# a1 as received re-loaded into $a1
			lw $a3, 12($fp)					# used1Ptr as received re-loaded into $a2
			 						# CoutCstr/CoutOneInt might have clobbered $a1 & $a3
			lw $t1, 0($a3)					# $t1 has *used1Ptr
			sll $t2, $t1, 2					# $t2 has (*used1Ptr) * 4
			add $t2, $t2, $a1				# $t2 has &a1[*used1Ptr]
			sw $v0, 0($t2)
#                         ++(*used1Ptr);
			addi $t1, $t1, 1				# $t1 has *used1Ptr + 1
			sw $t1, 0($a3)
#                      goto endI1_PA12;
			j endI1_PA12
#//                    }
else1_PA12:#//         else
#//                    {
#                         a2[*used2Ptr] = oneInt;
			lw $a2, 8($fp)					# a2 as received re-loaded into $a2
			 						# CoutCstr/CoutOneInt might have clobbered $a2
			lw $t0, 16($fp)					# $t0 has used2Ptr (received via stack)
			lw $t1, 0($t0)					# $t1 has *used2Ptr
			sll $t2, $t1, 2					# $t2 has (*used2Ptr) * 4
			add $t2, $t2, $a2				# $t2 has &a2[*used2Ptr]
			sw $v0, 0($t2)
#                         ++(*used2Ptr);
			addi $t1, $t1, 1				# $t1 has *used2Ptr + 1
			sw $t1, 0($t0)
endI1_PA12:#//         }
#                    //if (intNum == cap)
#                      if (intNum != cap) goto else2_PA12;
			lw $a0, 0($fp)					# cap as received re-loaded into $a0
			 						# CoutCstr/CoutOneInt might have clobbered $a0
			bne $s0, $a0, else2_PA12
begI2_PA12:#//                 {
#                         CoutCstr(moStr);
			addi $a0, $sp, 36
			jal CoutCstr
#                         CoutOneInt(cap);
			lw $a0, 0($fp)					# cap as received re-loaded into $a0
									# functions previously called might have clobbered it
			jal CoutOneInt
#                         CoutCstr(ieStr);
			addi $a0, $sp, 90
			jal CoutCstr
#                         cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#                         reply = 'y';
			li $t6, 'y'					# $t6 is reply
#                      goto endI2_PA12;
			j endI2_PA12
#//                    }
else2_PA12:#//         else
#//                    {
#                         CoutCstr(eaiStr);
			addi $a0, $sp, 44
			jal CoutCstr
#                         cin >> reply;
			li $v0, 12
			syscall
			move $t6, $v0					# $t6 is reply
					# newline to offset shortcoming of syscall #12
					li $v0, 11
					li $a0, '\n'
					syscall
endI2_PA12:#//         }
#//                 }
WTest_PA12:
#               ////if (reply != 'y' && reply != 'Y') goto begW_PA12;
#                   if (reply == 'y') goto xitW_PA12;
			li $t0, 'y'
			beq $t6, $t0, xitW_PA12
#                   if (reply != 'Y') goto begW_PA12;
			li $t0, 'Y'
			bne $t6, $t0, begW_PA12
xitW_PA12:
			# EPILOG:
			lw $fp, 112($sp)
			lw $ra, 116($sp)
			addiu $sp, $sp, 120
#                   return;
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
#int PopulateArray34(int a1[], int a2[], int a3[], int a4[], int used1, int used2, int* used3Ptr, int* used4Ptr)
#                         $a0       $a1       $a2       $a3    16($sp)    20($sp)        24($sp)        28($sp)
#{
###############################################################################
PopulateArray34:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: hopPtr1
# $t2: hopPtr2
# $t3: hopPtr3
# $t4: hopPtr3
# $t6: minInt
# $t7: oneInt
# $t8: endPtr2
# $t9: endPtr1
# $v1: another holder for a value/address
# (usual ones for function call)
###############################################################################
			# PROLOG:
					 				# no stack frame needed
			# BODY:
#                   int* hopPtr1 = a1;
			move $t1, $a0
#                   int* hopPtr2 = a2;
			move $t2, $a1
#                   int* hopPtr3 = a3;
			move $t3, $a2
#                   int* hopPtr4 = a4;
			move $t4, $a3
#                   int* endPtr1 = a1 + used1;
			lw $t9, 16($sp)					# $t9 has used1 rec'd via stack
			sll $t9, $t9, 2
			add $t9, $t9, $a0
#                   int* endPtr2 = a2 + used2;
			lw $t8, 20($sp)					# $t8 has used2 rec'd via stack
			sll $t8, $t8, 2
			add $t8, $t8, $a1
#                   int  oneInt;
#                   int  minInt;
#                   *used3Ptr = 0;
			lw $t0, 24($sp)
			sw $0, 0($t0)
#                   *used4Ptr = 0;
			lw $t0, 28($sp)
			sw $0, 0($t0)

#                 //if (used1 > 0)
#                   if (used1 <= 0) goto else1_PA34;
			lw $t0, 16($sp)					# $t0 has used1 rec'd via stack
			blez $t0, else1_PA34
begI1_PA34:#//                 {
#                      minInt = *hopPtr1;
			lw $t6, 0($t1)					# $t6 is minInt
#                   goto endI1_PA34;
			j endI1_PA34
#//                 }
else1_PA34:#//      else
#//                 {
#                      minInt = *hopPtr2;
			lw $t6, 0($t2)					# $t6 is minInt
endI1_PA34:#//      }

#                   goto WTest1_PA34;
			j WTest1_PA34
#                 //while (hopPtr1 < endPtr1 && hopPtr2 < endPtr2)
begW1_PA34:#//      {
#                      goto WTest2_PA34;
			j WTest2_PA34
#                    //while (hopPtr1 < endPtr1)
begW2_PA34:#//         {
#                         oneInt = *hopPtr1;
			lw $t7, 0($t1)					# $t7 is oneInt
#                       //if (oneInt < minInt)
#                         if (oneInt >= minInt) goto endI2_PA34;
			bge $t7, $t6, endI2_PA34
begI2_PA34:#//            {
#                            minInt = oneInt;
			move $t6, $t7
endI2_PA34:#//            }
#                       //if ( (oneInt & 1) == 0 ) break;
#                         if ( (oneInt & 1) == 0 ) goto brkI3_PA34;
			andi $t0, $t7, 1
			beqz $t0, brkI3_PA34
#                         *hopPtr3 = oneInt;
			sw $t7, 0($t3)
#                         ++(*used3Ptr);
			lw $t0, 24($sp)					# $t0 has used3Ptr
			lw $v1, 0($t0)					# $v1 has *used3Ptr
			addi $v1, $v1, 1				# $v1 has *used3Ptr + 1
			sw $v1, 0($t0)
#                         ++hopPtr1;
			addi $t1, $t1, 4
#                         ++hopPtr3;
			addi $t3, $t3, 4
#//                    }
WTest2_PA34:
#                      if (hopPtr1 < endPtr1) goto begW2_PA34;
			blt $t1, $t9, begW2_PA34
brkI3_PA34:
#                      goto WTest3_PA34;
			j WTest3_PA34
#                    //while (hopPtr2 < endPtr2)
begW3_PA34:#//         {
#                         oneInt = *hopPtr2;
			lw $t7, 0($t2)
#                       //if (oneInt < minInt)
#                         if (oneInt >= minInt) goto endI5_PA34;
			bge $t7, $t6, endI5_PA34
begI5_PA34:#//            {
#                            minInt = oneInt;
			move $t6, $t7
endI5_PA34:#//            }
#                       //if ( (oneInt & 1) != 0 ) break;
#                         if ( (oneInt & 1) != 0 ) goto brkI5_PA34;
			andi $t0, $t7, 1
			bnez $t0, brkI5_PA34
#                         *hopPtr4 = oneInt;
			sw $t7, 0($t4)
#                         ++(*used4Ptr);
			lw $t0, 28($sp)					# $t0 has used4Ptr
			lw $v1, 0($t0)					# $v1 has *used4Ptr
			addi $v1, $v1, 1				# $v1 has *used4Ptr + 1
			sw $v1, 0($t0)
#                         ++hopPtr2;
			addi $t2, $t2, 4
#                         ++hopPtr4;
			addi $t4, $t4, 4
#//                    }
WTest3_PA34:
#                      if (hopPtr2 < endPtr2) goto begW3_PA34;
			blt $t2, $t8, begW3_PA34
brkI5_PA34:
#                    //if (hopPtr1 < endPtr1 && hopPtr2 < endPtr2)
#                      if (hopPtr1 >= endPtr1) goto endI6_PA34;
			bge $t1, $t9, endI6_PA34
#                      if (hopPtr2 >= endPtr2) goto endI6_PA34;
			bge $t2, $t8, endI6_PA34
begI6_PA34:#//                    {
#                         *hopPtr3 = *hopPtr2;
			lw $t0, 0($t2)
			sw $t0, 0($t3)
#                         *hopPtr4 = *hopPtr1;
			lw $t0, 0($t1)
			sw $t0, 0($t4)
#                         ++(*used3Ptr);
			lw $t0, 24($sp)					# $t0 has used3Ptr
			lw $v1, 0($t0)					# $v1 has *used3Ptr
			addi $v1, $v1, 1				# $v1 has *used3Ptr + 1
			sw $v1, 0($t0)
#                         ++(*used4Ptr);
			lw $t0, 28($sp)					# $t0 has used4Ptr
			lw $v1, 0($t0)					# $v1 has *used4Ptr
			addi $v1, $v1, 1				# $v1 has *used4Ptr + 1
			sw $v1, 0($t0)
#                         ++hopPtr1;
			addi $t1, $t1, 4
#                         ++hopPtr2;
			addi $t2, $t2, 4
#                         ++hopPtr3;
			addi $t3, $t3, 4
#                         ++hopPtr4;
			addi $t4, $t4, 4
endI6_PA34:#//         }
#//                 }
WTest1_PA34:
#               ////if (hopPtr1 < endPtr1 && hopPtr2 < endPtr2) goto begW1_PA34;
#                   if (hopPtr1 >= endPtr1) goto xitW1_PA34;
			bge $t1, $t9, xitW1_PA34
#                   if (hopPtr2 < endPtr2) goto begW1_PA34;
			blt $t2, $t8, begW1_PA34
xitW1_PA34:
#                   goto WTest4_PA34;
			j WTest4_PA34
#                   //while (hopPtr1 < endPtr1)
begW4_PA34:#//        {
#                      oneInt = *hopPtr1;
			lw $t7, 0($t1)					# $t7 is oneInt
#                    //if (oneInt < minInt)
#                      if (oneInt >= minInt) goto endI7_PA34;
			bge $t7, $t6, endI7_PA34
begI7_PA34:#//         {
#                         minInt = oneInt;
			move $t6, $t7
endI7_PA34:#//         }
#                    //if ( (oneInt & 1) != 0 )
#                      if ( (oneInt & 1) == 0 ) goto else8_PA34;
			andi $t0, $t7, 1
			beqz $t0, else8_PA34
begI8_PA34:#//         {
#                         *hopPtr3 = oneInt;
			sw $t7, 0($t3)
#                         ++(*used3Ptr);
			lw $t0, 24($sp)					# $t0 has used3Ptr
			lw $v1, 0($t0)					# $v1 has *used3Ptr
			addi $v1, $v1, 1				# $v1 has *used3Ptr + 1
			sw $v1, 0($t0)
#                         ++hopPtr3;
			addi $t3, $t3, 4
#                      goto endI8_PA34;
			j endI8_PA34
#//                    }
else8_PA34:#//         else
#//                    {
#                         *hopPtr4 = oneInt;
			sw $t7, 0($t4)
#                         ++(*used4Ptr);
			lw $t0, 28($sp)					# $t0 has used4Ptr
			lw $v1, 0($t0)					# $v1 has *used4Ptr
			addi $v1, $v1, 1				# $v1 has *used4Ptr + 1
			sw $v1, 0($t0)
#                         ++hopPtr4;
			addi $t4, $t4, 4
endI8_PA34:#//         }
#                      ++hopPtr1;
			addi $t1, $t1, 4
#//                 }
WTest4_PA34:
#                   if (hopPtr1 < endPtr1) goto begW4_PA34;
			blt $t1, $t9, begW4_PA34

#                   goto WTest5_PA34;
			j WTest5_PA34
#                 //while (hopPtr2 < endPtr2)
begW5_PA34:#//      {
#                      oneInt = *hopPtr2;
			lw $t7, 0($t2)
#                    //if (oneInt < minInt)
#                      if (oneInt >= minInt) goto endI9_PA34;
			bge $t7, $t6 endI9_PA34
begI9_PA34:#//         {
#                         minInt = oneInt;
			move $t6, $t7
endI9_PA34:#//         }
#                    //if ( (oneInt & 1) != 0 )
#                      if ( (oneInt & 1) == 0 ) goto else10_PA34;
			andi $t0, $t7, 1
			beqz $t0, else10_PA34
begI10_PA34:#//        {
#                         *hopPtr3 = oneInt;
			sw $t7, 0($t3)
#                         ++(*used3Ptr);
			lw $t0, 24($sp)					# $t0 has used3Ptr
			lw $v1, 0($t0)					# $v1 has *used3Ptr
			addi $v1, $v1, 1				# $v1 has *used3Ptr + 1
			sw $v1, 0($t0)
#                         ++hopPtr3;
			addi $t3, $t3, 4
#                      goto endI10_PA34;
			j endI10_PA34
#//                    }
else10_PA34:#//        else
#//                    {
#                         *hopPtr4 = oneInt;
			sw $t7, 0($t4)
#                         ++(*used4Ptr);
			lw $t0, 28($sp)					# $t0 has used4Ptr
			lw $v1, 0($t0)					# $v1 has *used4Ptr
			addi $v1, $v1, 1				# $v1 has *used4Ptr + 1
			sw $v1, 0($t0)
#                         ++hopPtr4;
			addi $t4, $t4, 4
endI10_PA34:#//        }
#                      ++hopPtr2;
			addi $t2, $t2, 4
#//                 }
WTest5_PA34:
#                   if (hopPtr2 < endPtr2) goto begW5_PA34;
			blt $t2, $t8, begW5_PA34
					# EPILOG:
#                   return minInt;
#}
			move $v0, $t6
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
#			li $v0, 999999999				# don't want to clobber return value
			li $v1, 999999999
#########################################
			jr $ra


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void InsertSortedND(int intArr[], int* usedPtr, int oneInt)
#                             $a0           $a1         $a2
#{
###############################################################################
InsertSortedND:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: probePtr
# $v1: another holder for a value/address
# (usual ones for function call)
###############################################################################
			# PROLOG:
					 				# no stack frame needed
			# BODY:
#                   int* probePtr;
#                   probePtr = intArr + (*usedPtr);
			lw $t1, 0($a1)					# $t1 now has *usedPtr
			sll $t1, $t1, 2					# $t1 now has (*usedPtr)*4
			add $t1, $t1, $a0				# $t1 now has &intArr[*usedPtr]
#                   goto FTest_ISND;
			j FTest_ISND
#                 //for (probePtr = intArr + (*usedPtr); probePtr > intArr; --probePtr)
begF_ISND:#//       {
#                    //if ( *(probePtr - 1) <= oneInt ) break;
#                      if ( *(probePtr - 1) <= oneInt ) goto brkI_ISND;
			lw $t0, -4($t1)					# $t0 has *(probePtr - 1)
			ble $t0, $a2, brkI_ISND
#                      *probePtr = *(probePtr - 1);
			sw $t0, 0($t1)
#                   --probePtr;
			addi $t1, $t1, -4
#//                 }
FTest_ISND:
#                   if (probePtr > intArr) goto begF_ISND;
			bgt $t1, $a0, begF_ISND
brkI_ISND:
#                   *probePtr = oneInt;
			sw $a2, 0($t1)
#                   *usedPtr = *usedPtr + 1;
			lw $t0, 0($a1)					# $t0 now has *usedPtr
			addi $t0, $t0, 1				# $t0 now has *usedPtr + 1
			sw $t0, 0($a1)
#}
			# EPILOG:
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
#void ProcArraysA(int a1[], int a2[], int a3[], int a4[], int* used1Ptr, int* used2Ptr, int used3, int used4)
#                      $a0       $a1       $a2       $a3        16($fp)        20($fp)    24($fp)    28($fp)
#{
###############################################################################
ProcArraysA:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: hopPtr (must preserve across call to InsertSortedND)
# $t9: endPtr (must preserve across call to InsertSortedND)
# $v1: another holder for a value/address
# (usual ones for syscall & function call)
###############################################################################

			####################(46)####################

			# PROLOG:
			addiu $sp ,$sp, -32
			sw $ra, 28($sp)
			sw $fp, 24($sp)
			addiu $fp, $sp, 32

			sw $a0, 0($fp)				# a1 as received saved in caller's frame
			sw $a1, 4($fp)				# a2 as received saved in caller's frame
			sw $a2, 8($fp)				# a3 as received saved in caller's frame
			sw $a3, 12($fp)				# a4 as received saved in caller's frame
			# BODY:
#                   *used1Ptr = 0;
			lw $t0, 16($fp)
			sw $0, 0($t0)
#                   *used2Ptr = 0;
			lw $t0, 20($fp) # sp vs fp
			sw $0, 0($t0)
#                   int* hopPtr = a3;
			move $t1, $a2 # Possilby correct
#                   int* endPtr = a3 + used3;
			sw $t9, 24($fp) # sp vs fp
			sll $t9, $t9, 2
			add $t9, $t9, $t1

#                   goto WTest1_PAA;
			j WTest1_PAA
#                 //while (hopPtr < endPtr)
begW1_PAA:#       //{
#                      InsertSortedND(a1, used1Ptr, *hopPtr);
			lw $a0, 232($sp) # a1
			lw $t0, 16($fp) #used2ptr
			lw $s1, 0($t1) # Can be lw or sw
			jal InsertSortedND
#                      ++hopPtr;
			addi $t1, $t1, 4
#//                 }
WTest1_PAA:
#                   if (hopPtr < endPtr) goto begW1_PAA;
			blt $t1, $t9, begW1_PAA
#                   hopPtr = a4;
			move $t1, $a3
#                   endPtr = a4 + used4;
			sw $t9, 28($fp) # sp vs fp
			sll $t9, $t9, 2
			add $t9, $t9, $t1
#                   goto WTest2_PAA;
			j WTest2_PAA
#                 //while (hopPtr < endPtr)
begW2_PAA:#       //{
#                      InsertSortedND(a2, used2Ptr, *hopPtr);
			lw $a1, 280($sp) # a2
			lw $t0, 20($fp) #used2ptr
			lw $s1, 0($t1) # Can be lw or sw
			jal InsertSortedND
#                      ++hopPtr;
			addi $t1, $t1, 4
#//                 }
WTest2_PAA:
#                   if (hopPtr < endPtr) goto begW2_PAA;
			blt $t1, $t9, begW2_PAA
			# EPILOG:
			sw $fp, 24($sp)
			sw $ra, 28($sp)
			addiu $fp, $sp, 32
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


#*********************************************************************************************************************************************************************************************************
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ProcArraysB(int minInt, int a1[], int a2[], int a3[], int a4[], int used1, int used2, int* used3Ptr, int* used4Ptr)
#                        $a0       $a1       $a2       $a3   16($fp)    20($fp)    24($fp)        28($fp)        32($fp)
#{
###############################################################################
ProcArraysB:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: another holder for a value/address
# $t2: yet another holder for a value/address
# $t3: still yet another holder for a value/address
# $t4: still yet another holder for a value/address
# (usual ones for syscall & function call)
###############################################################################

			####################(46)####################

			# PROLOG:
			addiu $sp ,$sp, -31
			sw $ra, 28($sp)
			sw $fp, 24($sp)
			addiu $fp, $sp, 31

			sw $a0, 0($fp)				# minInt as received saved in caller's frame
			sw $a1, 4($fp)				# a1 as received saved in caller's frame
			sw $a2, 8($fp)				# a2 as received saved in caller's frame
			sw $a3, 12($fp)				# a3 as received saved in caller's frame
			sw $t0, 16($fp)				# a4 as received saved in caller's frame

			sw $t1, 20($fp)				# used1 as received saved in caller's frame
			sw $t2, 24($fp)				# used2 as received saved in caller's frame
			sw $t3, 28($fp)				# used3Ptr as received saved in caller's frame
			sw $t4, 32($fp)				# used4Ptr as received saved in caller's frame
			# BODY:
#                   *used3Ptr = 0;
			lw $t3, 28($sp)
			sw $0, 0($t3)
#                   *used4Ptr = 0;
			lw $t4, 32($sp)
			sw $0, 0($t4)
#                 //if ( (minInt & 1) != 0)
#                   if ( (minInt & 1) == 0) goto else_PAB;
			andi $a0, $a0, 1
			beqz $t0, else_PAB
begI_PAB:#//        {
#                      MergeCopy12(a3, a1, a2, used1, used2);
			lw $a3, 12($fp)
			lw $a1, 4($fp)
			lw $a2, 8($fp)
			lw $t1, 20($fp)
			lw $t2, 24($fp)
			jal MergeCopy12
#                      *used3Ptr = used1 + used2;
			sw $t3, 24($sp)
			sll $t3, $t3, 2
			add $t3, $t3, $t1

#                   goto endI_PAB;
			j endI_PAB
#//                 }
else_PAB:#//        else
#//                 {
#                      MergeCopy12(a4, a1, a2, used1, used2);
			lw $t0, 16($fp)
			lw $a1, 4($fp)
			lw $a2, 8($fp)
			lw $t1, 20($fp)
			lw $t2, 24($fp)
			jal MergeCopy12
#                      *used4Ptr = used1 + used2;
			sw $t4, 24($sp)
			sll $t4, $t4, 2
			add $t4, $t4, $t1

endI_PAB:#//        }
			# EPILOG:\
			sw $fp, 24($sp)
			sw $ra, 28($sp)
			addiu $fp, $sp, 31
#                   return;
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
#void MergeCopy12(int intArr[], int a1[], int a2[], int used1, int used2)
#                          $a0       $a1       $a2        $a3    16($sp)
#{
###############################################################################
MergeCopy12:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: hopPtr1
# $t2: hopPtr2
# $t5: hopPtr
# $t8: endPtr2
# $t9: endPtr1
# $v1: another holder for a value/address
# (usual ones for function call)
###############################################################################
			# PROLOG:
			 		 				# no stack frame needed
			# BODY:
#                   int *hopPtr,
#                       *hopPtr1,
#                       *hopPtr2,
#                       *endPtr1,
#                       *endPtr2;
#                   hopPtr = intArr;
			move $t5, $a0
#                   hopPtr1 = a1;
			move $t1, $a1
#                   hopPtr2 = a2;
			move $t2, $a2
#                   endPtr1 = a1 + used1;
			sll $t9, $a3, 2					# $t9 has 4*used1
			add $t9, $t9, $t1
#                   endPtr2 = a2 + used2;
			lw $t8, 16($sp)					# $t8 has used2 received via stack
			sll $t8, $t8, 2					# $t8 has 4*used2
			add $t8, $t8, $t2
#                   goto WTest1_MC12;
			j WTest1_MC12
#                 //while (hopPtr1 < endPtr1 && hopPtr2 < endPtr2)
begW1_MC12:#//      {
#                    //if (*hopPtr1 < *hopPtr2)
#                      if (*hopPtr1 >= *hopPtr2) goto else_MC12;
			lw $t0, 0($t1)					# $t0 has *hopPtr1
			lw $v1, 0($t2)					# $v1 has *hopPtr2
			bge $t0, $v1, else_MC12
begI_MC12:#//          {
#                         *hopPtr = *hopPtr1;
			sw $t0, 0($t5)
#                         ++hopPtr1;
			addi $t1, $t1, 4
#                      goto endI_MC12;
			j endI_MC12
#//                    }
else_MC12:#//          else
#//                    {
#                         *hopPtr = *hopPtr2;
			sw $v1, 0($t5)
#                         ++hopPtr2;
			addi $t2, $t2, 4
endI_MC12:#//          }
#                      ++hopPtr;
			addi $t5, $t5, 4
#//                 }
WTest1_MC12:
#               ////if (hopPtr1 < endPtr1 && hopPtr2 < endPtr2) goto begW1_MC12;
#                   if (hopPtr1 >= endPtr1) goto xitW1_MC12;
			bge $t1, $t9, xitW1_MC12
#                   if (hopPtr2 < endPtr2) goto begW1_MC12;
			blt $t2, $t8, begW1_MC12
xitW1_MC12:

#                   goto WTest2_MC12;
			j WTest2_MC12
#                 //while (hopPtr1 < endPtr1)
begW2_MC12:#//      {
#                      *hopPtr = *hopPtr1;
			lw $t0, 0($t1)					# $t0 has *hopPtr1
			sw $t0, 0($t5)
#                      ++hopPtr1;
			addi $t1, $t1, 4
#                      ++hopPtr;
			addi $t5, $t5, 4
#//                 }
WTest2_MC12:
#                   if (hopPtr1 < endPtr1) goto begW2_MC12;
			blt $t1, $t9, begW2_MC12

#                   goto WTest3_MC12;
			j WTest3_MC12
#                 //while (hopPtr2 < endPtr2)
begW3_MC12:#//      {
#                      *hopPtr = *hopPtr2;
			lw $v1, 0($t2)					# $v1 has *hopPtr2
			sw $v1, 0($t5)
#                      ++hopPtr2;
			addi $t2, $t2, 4
#                      ++hopPtr;
			addi $t5, $t5, 4
#//                 }
WTest3_MC12:
#                   if (hopPtr2 < endPtr2) goto begW3_MC12;
			blt $t2, $t8, begW3_MC12

#}
			# EPILOG:
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
#void CoutCstr(const char cstr[])
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
#   cout << cstr;
			li $v0, 4
			syscall
#}
			# EPILOG:
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
#void CoutCstrNL(const char cstr[])
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
#   CoutCstr(cstr);
			jal CoutCstr
#   cout << '\n';
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
#   cout << oneInt;
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
#void ShowArray(const int array[], int used)
#{
###############################################################################
ShowArray:
#################
# Register usage:
#################
# $t1: i
# $v1: holder for a value/address
# $a1: used (as received)
# (usual ones for syscall)
###############################################################################
#                   int i;
			# PROLOG:
			 						# no stack frame needed
			sw $a0, 0($sp)					# array as received saved in caller's frame
			# BODY:
#                   i = 0;
			li $t1, 0					# $t1 is i
#                   goto FTest_SA;
			j FTest_SA
begF_SA:
#                      cout << array[i] << ' ' << ' ';
			li $v0, 1
			sll $v1, $t1, 2					# $v1 has i*4
			lw $a0, 0($sp)					# array as received re-loaded into $a0
			add $a0, $a0, $v1				# $a0 has &array[i]
			lw $a0, 0($a0)					# $a0 has array[i]
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
			syscall
#                   ++i;
			addi $t1, $t1, 1
FTest_SA:
#                   if (i < used) goto begF_SA;
			blt $t1, $a1, begF_SA

#                   cout << endl;
			li $v0, 11
			li $a0, '\n'
			syscall
#}
			# EPILOG:
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
#void ShowArrayLabeled(const int array[], int used, const char label[])
#{
###############################################################################
ShowArrayLabeled:
#################
# Register usage:
#################
# (usual ones for function call)
###############################################################################
			# PROLOG:
			addiu $sp, $sp, -32
			sw $ra, 28($sp)
			sw $fp, 24($sp)
			addiu $fp, $sp, 32

			sw $a0, 0($fp)					# array as received saved in caller's frame
			sw $a1, 4($fp)					# used as received saved in caller's frame
			# BODY:
#                   CoutCstr(label);
			move $a0, $a2
			jal CoutCstr
#                   ShowArray(array, used);
			lw $a0, 0($fp)					# array as received re-loaded into $a0
			lw $a1, 4($fp)					# used as received re-loaded into $a1
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
# main's string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitM:
			li $t0, 'b'
			sb $t0, 40($sp)
			li $t0, 'e'
			sb $t0, 41($sp)
			li $t0, 'g'
			sb $t0, 42($sp)
			li $t0, 'i'
			sb $t0, 43($sp)
			li $t0, 'n'
			sb $t0, 44($sp)
			li $t0, 'n'
			sb $t0, 45($sp)
			li $t0, 'i'
			sb $t0, 46($sp)
			li $t0, 'n'
			sb $t0, 47($sp)
			li $t0, 'g'
			sb $t0, 48($sp)
			li $t0, ' '
			sb $t0, 49($sp)
			li $t0, 'a'
			sb $t0, 50($sp)
			li $t0, '1'
			sb $t0, 51($sp)
			li $t0, ':'
			sb $t0, 52($sp)
			li $t0, ' '
			sb $t0, 53($sp)
			li $t0, '\0'
			sb $t0, 54($sp)
			li $t0, 'c'
			sb $t0, 55($sp)
			li $t0, 'h'
			sb $t0, 56($sp)
			li $t0, 'k'
			sb $t0, 57($sp)
			li $t0, 'P'
			sb $t0, 58($sp)
			li $t0, 'o'
			sb $t0, 59($sp)
			li $t0, 'i'
			sb $t0, 60($sp)
			li $t0, 'n'
			sb $t0, 61($sp)
			li $t0, 't'
			sb $t0, 62($sp)
			li $t0, 'A'
			sb $t0, 63($sp)
			li $t0, ' '
			sb $t0, 64($sp)
			li $t0, 'a'
			sb $t0, 65($sp)
			li $t0, '1'
			sb $t0, 66($sp)
			li $t0, ':'
			sb $t0, 67($sp)
			li $t0, ' '
			sb $t0, 68($sp)
			li $t0, '\0'
			sb $t0, 69($sp)
			li $t0, 'p'
			sb $t0, 70($sp)
			li $t0, 'r'
			sb $t0, 71($sp)
			li $t0, 'o'
			sb $t0, 72($sp)
			li $t0, 'c'
			sb $t0, 73($sp)
			li $t0, 'e'
			sb $t0, 74($sp)
			li $t0, 's'
			sb $t0, 75($sp)
			li $t0, 's'
			sb $t0, 76($sp)
			li $t0, 'e'
			sb $t0, 77($sp)
			li $t0, 'd'
			sb $t0, 78($sp)
			li $t0, ' '
			sb $t0, 79($sp)
			li $t0, 'a'
			sb $t0, 80($sp)
			li $t0, '1'
			sb $t0, 81($sp)
			li $t0, ':'
			sb $t0, 82($sp)
			li $t0, ' '
			sb $t0, 83($sp)
			li $t0, '\0'
			sb $t0, 84($sp)
			li $t0, ' '
			sb $t0, 85($sp)
			li $t0, ' '
			sb $t0, 86($sp)
			li $t0, ' '
			sb $t0, 87($sp)
			li $t0, ' '
			sb $t0, 88($sp)
			li $t0, ' '
			sb $t0, 89($sp)
			li $t0, ' '
			sb $t0, 90($sp)
			li $t0, ' '
			sb $t0, 91($sp)
			li $t0, ' '
			sb $t0, 92($sp)
			li $t0, ' '
			sb $t0, 93($sp)
			li $t0, ' '
			sb $t0, 94($sp)
			li $t0, 'a'
			sb $t0, 95($sp)
			li $t0, '2'
			sb $t0, 96($sp)
			li $t0, ':'
			sb $t0, 97($sp)
			li $t0, ' '
			sb $t0, 98($sp)
			li $t0, '\0'
			sb $t0, 99($sp)
			li $t0, ' '
			sb $t0, 100($sp)
			li $t0, ' '
			sb $t0, 101($sp)
			li $t0, ' '
			sb $t0, 102($sp)
			li $t0, ' '
			sb $t0, 103($sp)
			li $t0, ' '
			sb $t0, 104($sp)
			li $t0, ' '
			sb $t0, 105($sp)
			li $t0, ' '
			sb $t0, 106($sp)
			li $t0, ' '
			sb $t0, 107($sp)
			li $t0, ' '
			sb $t0, 108($sp)
			li $t0, ' '
			sb $t0, 109($sp)
			li $t0, 'a'
			sb $t0, 110($sp)
			li $t0, '3'
			sb $t0, 111($sp)
			li $t0, ':'
			sb $t0, 112($sp)
			li $t0, ' '
			sb $t0, 113($sp)
			li $t0, '\0'
			sb $t0, 114($sp)
			li $t0, ' '
			sb $t0, 115($sp)
			li $t0, ' '
			sb $t0, 116($sp)
			li $t0, ' '
			sb $t0, 117($sp)
			li $t0, ' '
			sb $t0, 118($sp)
			li $t0, ' '
			sb $t0, 119($sp)
			li $t0, ' '
			sb $t0, 120($sp)
			li $t0, ' '
			sb $t0, 121($sp)
			li $t0, ' '
			sb $t0, 122($sp)
			li $t0, ' '
			sb $t0, 123($sp)
			li $t0, ' '
			sb $t0, 124($sp)
			li $t0, 'a'
			sb $t0, 125($sp)
			li $t0, '4'
			sb $t0, 126($sp)
			li $t0, ':'
			sb $t0, 127($sp)
			li $t0, ' '
			sb $t0, 128($sp)
			li $t0, '\0'
			sb $t0, 129($sp)
			li $t0, 'D'
			sb $t0, 130($sp)
			li $t0, 'o'
			sb $t0, 131($sp)
			li $t0, ' '
			sb $t0, 132($sp)
			li $t0, 'a'
			sb $t0, 133($sp)
			li $t0, 'n'
			sb $t0, 134($sp)
			li $t0, 'o'
			sb $t0, 135($sp)
			li $t0, 't'
			sb $t0, 136($sp)
			li $t0, 'h'
			sb $t0, 137($sp)
			li $t0, 'e'
			sb $t0, 138($sp)
			li $t0, 'r'
			sb $t0, 139($sp)
			li $t0, ' '
			sb $t0, 140($sp)
			li $t0, 'c'
			sb $t0, 141($sp)
			li $t0, 'a'
			sb $t0, 142($sp)
			li $t0, 's'
			sb $t0, 143($sp)
			li $t0, 'e'
			sb $t0, 144($sp)
			li $t0, '?'
			sb $t0, 145($sp)
			li $t0, ' '
			sb $t0, 146($sp)
			li $t0, '('
			sb $t0, 147($sp)
			li $t0, 'n'
			sb $t0, 148($sp)
			li $t0, ' '
			sb $t0, 149($sp)
			li $t0, 'o'
			sb $t0, 150($sp)
			li $t0, 'r'
			sb $t0, 151($sp)
			li $t0, ' '
			sb $t0, 152($sp)
			li $t0, 'N'
			sb $t0, 153($sp)
			li $t0, ' '
			sb $t0, 154($sp)
			li $t0, '='
			sb $t0, 155($sp)
			li $t0, ' '
			sb $t0, 156($sp)
			li $t0, 'n'
			sb $t0, 157($sp)
			li $t0, 'o'
			sb $t0, 158($sp)
			li $t0, ','
			sb $t0, 159($sp)
			li $t0, ' '
			sb $t0, 160($sp)
			li $t0, 'o'
			sb $t0, 161($sp)
			li $t0, 't'
			sb $t0, 162($sp)
			li $t0, 'h'
			sb $t0, 163($sp)
			li $t0, 'e'
			sb $t0, 164($sp)
			li $t0, 'r'
			sb $t0, 165($sp)
			li $t0, 's'
			sb $t0, 166($sp)
			li $t0, ' '
			sb $t0, 167($sp)
			li $t0, '='
			sb $t0, 168($sp)
			li $t0, ' '
			sb $t0, 169($sp)
			li $t0, 'y'
			sb $t0, 170($sp)
			li $t0, 'e'
			sb $t0, 171($sp)
			li $t0, 's'
			sb $t0, 172($sp)
			li $t0, ')'
			sb $t0, 173($sp)
			li $t0, ' '
			sb $t0, 174($sp)
			li $t0, '\0'
			sb $t0, 175($sp)
			li $t0, '='
			sb $t0, 176($sp)
			li $t0, '='
			sb $t0, 177($sp)
			li $t0, '='
			sb $t0, 178($sp)
			li $t0, '='
			sb $t0, 179($sp)
			li $t0, '='
			sb $t0, 180($sp)
			li $t0, '='
			sb $t0, 181($sp)
			li $t0, '='
			sb $t0, 182($sp)
			li $t0, '='
			sb $t0, 183($sp)
			li $t0, '='
			sb $t0, 184($sp)
			li $t0, '='
			sb $t0, 185($sp)
			li $t0, '='
			sb $t0, 186($sp)
			li $t0, '='
			sb $t0, 187($sp)
			li $t0, '='
			sb $t0, 188($sp)
			li $t0, '='
			sb $t0, 189($sp)
			li $t0, '='
			sb $t0, 190($sp)
			li $t0, '='
			sb $t0, 191($sp)
			li $t0, '='
			sb $t0, 192($sp)
			li $t0, '='
			sb $t0, 193($sp)
			li $t0, '='
			sb $t0, 194($sp)
			li $t0, '='
			sb $t0, 195($sp)
			li $t0, '='
			sb $t0, 196($sp)
			li $t0, '='
			sb $t0, 197($sp)
			li $t0, '='
			sb $t0, 198($sp)
			li $t0, '='
			sb $t0, 199($sp)
			li $t0, '='
			sb $t0, 200($sp)
			li $t0, '='
			sb $t0, 201($sp)
			li $t0, '='
			sb $t0, 202($sp)
			li $t0, '='
			sb $t0, 203($sp)
			li $t0, '='
			sb $t0, 204($sp)
			li $t0, '='
			sb $t0, 205($sp)
			li $t0, '='
			sb $t0, 206($sp)
			li $t0, '='
			sb $t0, 207($sp)
			li $t0, '\0'
			sb $t0, 208($sp)
			li $t0, 'b'
			sb $t0, 209($sp)
			li $t0, 'y'
			sb $t0, 210($sp)
			li $t0, 'e'
			sb $t0, 211($sp)
			li $t0, '.'
			sb $t0, 212($sp)
			li $t0, '.'
			sb $t0, 213($sp)
			li $t0, '.'
			sb $t0, 214($sp)
			li $t0, '\0'
			sb $t0, 215($sp)
					j endDataInitM				# back to main


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# PopulateArray12's string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitPA12:
			li $t0, 'E'
			sb $t0, 20($sp)
			li $t0, 'n'
			sb $t0, 21($sp)
			li $t0, 't'
			sb $t0, 22($sp)
			li $t0, 'e'
			sb $t0, 23($sp)
			li $t0, 'r'
			sb $t0, 24($sp)
			li $t0, ' '
			sb $t0, 25($sp)
			li $t0, 'i'
			sb $t0, 26($sp)
			li $t0, 'n'
			sb $t0, 27($sp)
			li $t0, 't'
			sb $t0, 28($sp)
			li $t0, 'e'
			sb $t0, 29($sp)
			li $t0, 'g'
			sb $t0, 30($sp)
			li $t0, 'e'
			sb $t0, 31($sp)
			li $t0, 'r'
			sb $t0, 32($sp)
			li $t0, ' '
			sb $t0, 33($sp)
			li $t0, '#'
			sb $t0, 34($sp)
			li $t0, '\0'
			sb $t0, 35($sp)
			li $t0, 'M'
			sb $t0, 36($sp)
			li $t0, 'a'
			sb $t0, 37($sp)
			li $t0, 'x'
			sb $t0, 38($sp)
			li $t0, ' '
			sb $t0, 39($sp)
			li $t0, 'o'
			sb $t0, 40($sp)
			li $t0, 'f'
			sb $t0, 41($sp)
			li $t0, ' '
			sb $t0, 42($sp)
			li $t0, '\0'
			sb $t0, 43($sp)
			li $t0, 'E'
			sb $t0, 44($sp)
			li $t0, 'n'
			sb $t0, 45($sp)
			li $t0, 'd'
			sb $t0, 46($sp)
			li $t0, ' '
			sb $t0, 47($sp)
			li $t0, 'a'
			sb $t0, 48($sp)
			li $t0, 'd'
			sb $t0, 49($sp)
			li $t0, 'd'
			sb $t0, 50($sp)
			li $t0, 'i'
			sb $t0, 51($sp)
			li $t0, 'n'
			sb $t0, 52($sp)
			li $t0, 'g'
			sb $t0, 53($sp)
			li $t0, ' '
			sb $t0, 54($sp)
			li $t0, 'i'
			sb $t0, 55($sp)
			li $t0, 'n'
			sb $t0, 56($sp)
			li $t0, 't'
			sb $t0, 57($sp)
			li $t0, 's'
			sb $t0, 58($sp)
			li $t0, '?'
			sb $t0, 59($sp)
			li $t0, ' '
			sb $t0, 60($sp)
			li $t0, '('
			sb $t0, 61($sp)
			li $t0, 'y'
			sb $t0, 62($sp)
			li $t0, ' '
			sb $t0, 63($sp)
			li $t0, 'o'
			sb $t0, 64($sp)
			li $t0, 'r'
			sb $t0, 65($sp)
			li $t0, ' '
			sb $t0, 66($sp)
			li $t0, 'Y'
			sb $t0, 67($sp)
			li $t0, ' '
			sb $t0, 68($sp)
			li $t0, '='
			sb $t0, 69($sp)
			li $t0, ' '
			sb $t0, 70($sp)
			li $t0, 'y'
			sb $t0, 71($sp)
			li $t0, 'e'
			sb $t0, 72($sp)
			li $t0, 's'
			sb $t0, 73($sp)
			li $t0, ','
			sb $t0, 74($sp)
			li $t0, ' '
			sb $t0, 75($sp)
			li $t0, 'o'
			sb $t0, 76($sp)
			li $t0, 't'
			sb $t0, 77($sp)
			li $t0, 'h'
			sb $t0, 78($sp)
			li $t0, 'e'
			sb $t0, 79($sp)
			li $t0, 'r'
			sb $t0, 80($sp)
			li $t0, 's'
			sb $t0, 81($sp)
			li $t0, ' '
			sb $t0, 82($sp)
			li $t0, '='
			sb $t0, 83($sp)
			li $t0, ' '
			sb $t0, 84($sp)
			li $t0, 'n'
			sb $t0, 85($sp)
			li $t0, 'o'
			sb $t0, 86($sp)
			li $t0, ')'
			sb $t0, 87($sp)
			li $t0, ' '
			sb $t0, 88($sp)
			li $t0, '\0'
			sb $t0, 89($sp)
			li $t0, ' '
			sb $t0, 90($sp)
			li $t0, 'i'
			sb $t0, 91($sp)
			li $t0, 'n'
			sb $t0, 92($sp)
			li $t0, 't'
			sb $t0, 93($sp)
			li $t0, 's'
			sb $t0, 94($sp)
			li $t0, ' '
			sb $t0, 95($sp)
			li $t0, 'e'
			sb $t0, 96($sp)
			li $t0, 'n'
			sb $t0, 97($sp)
			li $t0, 't'
			sb $t0, 98($sp)
			li $t0, 'e'
			sb $t0, 99($sp)
			li $t0, 'r'
			sb $t0, 100($sp)
			li $t0, 'e'
			sb $t0, 101($sp)
			li $t0, 'd'
			sb $t0, 102($sp)
			li $t0, '.'
			sb $t0, 103($sp)
			li $t0, '.'
			sb $t0, 104($sp)
			li $t0, '.'
			sb $t0, 105($sp)
			li $t0, '\0'
			sb $t0, 106($sp)
			j endDataInitPA12				# back to PopulateArray12
