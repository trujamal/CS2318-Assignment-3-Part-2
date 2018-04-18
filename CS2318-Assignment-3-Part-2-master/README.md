# CS2318-Assignment-3-Part-2
How to get banned from the university step 1: take kohs class :)
<img src= "http://lactualite.com/assets/uploads/2017/05/istock-506476770~1024.jpg">


(Supplied Files)
Fill in the "holes" intentionally left in a3p3.asm (one of the supplied files) so that the completed program will work as illustrated by the sample test run result (a3p3test.txt, also one of the supplied files).
NOTE: This program is the Assignment 2 Part 3 program re-structured (and made modular) using functions.
IMPORTANT Specific Requirements  
(CAUTION: You will receive little or no credits if you don't observe these.)
	Must follow the function-call convention studied in class.
	In main:
-- Use of $s0 (a callee-saved register) for minInt MUST NOT be changed.   
(Entry corresponding to the above usage has already been entered for you under Register usage:)
	In PopulateArray12:
-- Use of $s0 (a callee-saved register) for intNum MUST NOT be changed.   
(Entry corresponding to the above usage has already been entered for you under Register usage:)
	In ProcArraysA:
-- MUST use $t1 (a caller-saved register) for hopPtr. 
-- MUST use $t9 (a caller-saved register) for endPtr. 
(Entries corresponding to the above usage have already been entered for you under Register usage:)
	When a function must save copies of its arguments that are received via registers, it must do so using the designated slots (according to function-call convention) in the caller's stack frame (NOT in some other available registers or memory locations).
	A function must NOT access memory locations (outside of its stack frame) through "back-door" means. 

In other words, there must NOT be any accesses of memory locations (outside of a function's own stack frame) that are inconsistent with function-call convention and/or the intent of the caller.
For the function-call convention studied, a function may access memory locations outside of it's own stack frame only under the following situations (talk to me if you think there are still others):
accessing designated slots in caller's frame to save copies of the first 4 arguments (which are passed via registers $a0 through $a3) where appropriate/needed.
(NOTE: According to convention, this part of caller's frame is allocated by caller not for its own use but for its callee to use where needed.)
accessing designated slots in caller's frame to retrieve 5th-and-beyond arguments (which are passed via the stack) where appropriate.
accessing other parts of the stack as intended by the caller, through address(es) passed to it by the caller.
Other points to note:
 		Assign03P3_StackFrameDetails.pdf (one of the supplied files) has all the stack frame designs. 
(You are strongly encouraged to do the stack frame designs yourself and then compare what you got with the supplied. This should serve as part of your preparation for the final exam.)
(You should at least study and understand the supplied.)
The stack frame designs were obtained taking into account various factors (local storage, register usage, function arguments, need for saving/restoring register contents, . . .).
They should therefore serve as good additional stack-frame-design examples.
(You MUST use the supplied designs when filling in the required code.)
	a3p3.cpp (one of the supplied files) is the corresponding program in C++ (written in the usual way) that should be useful for understanding the program logic.
a3p3_goto.cpp (one of the supplied files) is the corresponding program in C++ (re-written using goto) that is used to construct the program in MIPS AL.
	Except for PopulateArray12 (more on it to follow), each hole that you must fill is indicated by a comment line that looks like
####################(50)####################
The number within the parentheses indicates the number of statements used in my (first-cut, un-optimized) solution, not counting any labels that are placed on separate lines. 
It is not necessary that you use the same number of statements but something is probably amiss if you deviate too far from the number.
Below are the functions that have hole(s) in them: 
- main (in calls to PopulateArray12, PopulateArray34, ProcArraysA, and ProcArraysB) 
- ProcArraysA (just about the entire function) 
- ProcArraysB (just about the entire function) 
	For PopulateArray12, you are to add code that fulfills the saving and restoring responsibility associated with the use of $s0 (a callee-saved register) for intNum. 
TIPS: What code to add? Where to add it.
	I have decided to leave behind the entire register-usage documentation of my solution (listed under Register usage:, including those you are required to use in ProcArraysA and ProcArraysB). 
You should adopt the same register usage, both to save yourself some time and simplify my task of checking/grading your work.
	Most functions (including ProcArraysA and ProcArraysB, the code for which you must fill in) have "clobbering of caller-saved" code that looks like the following


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
deliberately inserted immediately before the functions return. 
You MUST leave such code alone; as indicated in the comment, if such code causes your program to not work properly, you have made some improper presumptions when filling in your code.
	When filling a hole that involves just about the entire function, you would want to intersperse your code among the commented-out C++ statements (like how I did for other functions).
You are to print and turn in hardcopy of the following (collate and staple them together with a cover page):
	Your completed program.

(It will be okay if you print until the page that contains begDataInitM: and leave out the rest of the string initialization code.)
	The test output (using your completed program) for at least the test cases included in a3p3test.out mentioned above.
Be sure to also email me your program (don't have to email me the test output).
	Be sure to read Programming Assignments - What/How to Submit on how to properly submit softcopies of your programs (especially in regard to the inclusion of subject lines in the specified format).

Helper Notes (you probably don't want to miss).
