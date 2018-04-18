#include <iostream>
using namespace std;

void PopulateArray12(int cap, int a1[], int a2[], int* used1Ptr, int* used2Ptr);
int  PopulateArray34(int a1[], int a2[], int a3[], int a4[], int used1, int used2, int* used3Ptr, int* used4Ptr);
void InsertSortedND(int intArr[], int* usedPtr, int oneInt);
void ProcArraysA(int a1[], int a2[], int a3[], int a4[],
                 int* used1Ptr, int* used2Ptr, int used3, int used4);
void ProcArraysB(int minInt, int a1[], int a2[], int a3[], int a4[],
                 int used1, int used2, int* used3Ptr, int* used4Ptr);
void MergeCopy12(int intArr[], int a1[], int a2[], int used1, int used2);
void CoutCstr(const char cstr[]);
void CoutCstrNL(const char cstr[]);
void CoutOneInt(int oneInt);
void ShowArray(const int a[], int size);
void ShowArrayLabeled(const int array[], int used, const char label[]);

int main()
{
                   int a1[12],
                       a2[12],
                       a3[12],
                       a4[12];
                   char reply;
                   int used1,
                       used2,
                       used3,
                       used4,
                       minInt;
                   char begA1Str[] = "beginning a1: ";
                   char cpaA1Str[] = "chkPointA a1: ";
                   char proA1Str[] = "processed a1: ";
                   char comA2Str[] = "          a2: ";
                   char comA3Str[] = "          a3: ";
                   char comA4Str[] = "          a4: ";
                   char dacStr[]    = "Do another case? (n or N = no, others = yes) ";
                   char dlStr[]     = "================================";
                   char byeStr[]    = "bye...";

                 //do
begDW_m://         {
                      PopulateArray12(12, a1, a2, &used1, &used2);
                      cout << endl;
                      ShowArrayLabeled(a1, used1, begA1Str);
                      ShowArrayLabeled(a2, used2, comA2Str);
                    //if (used1 > 0 || used2 > 0)
                      if (used1 > 0) goto begI1_m;
                      if (used2 <= 0) goto else1_m;
begI1_m://            {
                         minInt = PopulateArray34(a1, a2, a3, a4, used1, used2, &used3, &used4);
                      goto endI1_m;
//                    }
else1_m://            else
//                    {
                         used3 = 0;
                         used4 = 0;
endI1_m://            }
                      ShowArrayLabeled(a3, used3, comA3Str);
                      ShowArrayLabeled(a4, used4, comA4Str);
                    //if (used1 > 0 || used2 > 0)
                      if (used1 > 0) goto begI2_m;
                      if (used2 <= 0) goto endI2_m;
begI2_m://            {
                         ProcArraysA(a1, a2, a3, a4,
                                     &used1, &used2, used3, used4);
                         ShowArrayLabeled(a1, used1, cpaA1Str);
                         ShowArrayLabeled(a2, used2, comA2Str);
                         ShowArrayLabeled(a3, used3, comA3Str);
                         ShowArrayLabeled(a4, used4, comA4Str);
                         ProcArraysB(minInt, a1, a2, a3, a4,
                                     used1, used2, &used3, &used4);
endI2_m://            }
                      ShowArrayLabeled(a1, used1, proA1Str);
                      ShowArrayLabeled(a2, used2, comA2Str);
                      ShowArrayLabeled(a3, used3, comA3Str);
                      ShowArrayLabeled(a4, used4, comA4Str);
                      cout << endl;
                      cout << dacStr;
                      cin >> reply;
                      cout << endl;
//                 }
                 //while (reply != 'n' && reply != 'N');
DWTest_m:
               ////if (reply != 'n' && reply != 'N') goto begDW_m;
                   if (reply == 'n') goto xitDW_m;
                   if (reply != 'N') goto begDW_m;
xitDW_m:

                   CoutCstrNL(dlStr);
                   CoutCstrNL(byeStr);
                   CoutCstrNL(dlStr);

                   return 0;
}

void PopulateArray12(int cap, int a1[], int a2[], int* used1Ptr, int* used2Ptr)
{
                   char einStr[] = "Enter integer #";
                   char moStr[]  = "Max of ";
                   char ieStr[]  = " ints entered...";
                   char eaiStr[] = "End adding ints? (y or Y = yes, others = no) ";
                   char reply;
                   int oneInt;
                   int intNum = 0;
                   *used1Ptr = 0;
                   *used2Ptr = 0;
                   CoutCstr(eaiStr);
                   cin >> reply;
                   goto WTest_PA12;
                 //while (reply != 'y' && reply != 'Y')
begW_PA12://       {
                      ++intNum;
                      CoutCstr(einStr);
                      CoutOneInt(intNum);
                      cout << ':' << ' ';
                      cin >> oneInt;
                    //if ( (intNum & 1) != 0 )
                      if ( (intNum & 1) == 0 ) goto else1_PA12;
begI1_PA12://         {
                         a1[*used1Ptr] = oneInt;
                         ++(*used1Ptr);
                      goto endI1_PA12;
//                    }
else1_PA12://         else
//                    {
                         a2[*used2Ptr] = oneInt;
                         ++(*used2Ptr);
endI1_PA12://         }
                    //if (intNum == cap)
                      if (intNum != cap) goto else2_PA12;
begI2_PA12://                 {
                         CoutCstr(moStr);
                         CoutOneInt(cap);
                         CoutCstr(ieStr);
                         cout << endl;
                         reply = 'y';
                      goto endI2_PA12;
//                    }
else2_PA12://         else
//                    {
                         CoutCstr(eaiStr);
                         cin >> reply;
endI2_PA12://         }
//                 }
WTest_PA12:
               ////if (reply != 'y' && reply != 'Y') goto begW_PA12;
                   if (reply == 'y') goto xitW_PA12;
                   if (reply != 'Y') goto begW_PA12;
xitW_PA12:
                   return;
}

int PopulateArray34(int a1[], int a2[], int a3[], int a4[], int used1, int used2, int* used3Ptr, int* used4Ptr)
{
                   int* hopPtr1 = a1;
                   int* hopPtr2 = a2;
                   int* hopPtr3 = a3;
                   int* hopPtr4 = a4;
                   int* endPtr1 = a1 + used1;
                   int* endPtr2 = a2 + used2;
                   int  oneInt;
                   int  minInt;
                   *used3Ptr = 0;
                   *used4Ptr = 0;

                 //if (used1 > 0)
                   if (used1 <= 0) goto else1_PA34;
begI1_PA34://                 {
                      minInt = *hopPtr1;
                   goto endI1_PA34;
//                 }
else1_PA34://      else
//                 {
                      minInt = *hopPtr2;
endI1_PA34://      }

                   goto WTest1_PA34;
                 //while (hopPtr1 < endPtr1 && hopPtr2 < endPtr2)
begW1_PA34://      {
                      goto WTest2_PA34;
                    //while (hopPtr1 < endPtr1)
begW2_PA34://         {
                         oneInt = *hopPtr1;
                       //if (oneInt < minInt)
                         if (oneInt >= minInt) goto endI2_PA34;
begI2_PA34://            {
                            minInt = oneInt;
endI2_PA34://            }
                       //if ( (oneInt & 1) == 0 ) break;
                         if ( (oneInt & 1) == 0 ) goto brkI3_PA34;
                         *hopPtr3 = oneInt;
                         ++(*used3Ptr);
                         ++hopPtr1;
                         ++hopPtr3;
//                    }
WTest2_PA34:
                      if (hopPtr1 < endPtr1) goto begW2_PA34;
brkI3_PA34:
                      goto WTest3_PA34;
                    //while (hopPtr2 < endPtr2)
begW3_PA34://         {
                         oneInt = *hopPtr2;
                       //if (oneInt < minInt)
                         if (oneInt >= minInt) goto endI5_PA34;
begI5_PA34://            {
                            minInt = oneInt;
endI5_PA34://            }
                       //if ( (oneInt & 1) != 0 ) break;
                         if ( (oneInt & 1) != 0 ) goto brkI5_PA34;
                         *hopPtr4 = oneInt;
                         ++(*used4Ptr);
                         ++hopPtr2;
                         ++hopPtr4;
//                    }
WTest3_PA34:
                      if (hopPtr2 < endPtr2) goto begW3_PA34;
brkI5_PA34:
                    //if (hopPtr1 < endPtr1 && hopPtr2 < endPtr2)
                      if (hopPtr1 >= endPtr1) goto endI6_PA34;
                      if (hopPtr2 >= endPtr2) goto endI6_PA34;
begI6_PA34://                    {
                         *hopPtr3 = *hopPtr2;
                         *hopPtr4 = *hopPtr1;
                         ++(*used3Ptr);
                         ++(*used4Ptr);
                         ++hopPtr1;
                         ++hopPtr2;
                         ++hopPtr3;
                         ++hopPtr4;
endI6_PA34://         }
//                 }
WTest1_PA34:
               ////if (hopPtr1 < endPtr1 && hopPtr2 < endPtr2) goto begW1_PA34;
                   if (hopPtr1 >= endPtr1) goto xitW1_PA34;
                   if (hopPtr2 < endPtr2) goto begW1_PA34;
xitW1_PA34:
                   goto WTest4_PA34;
                   //while (hopPtr1 < endPtr1)
begW4_PA34://        {
                      oneInt = *hopPtr1;
                    //if (oneInt < minInt)
                      if (oneInt >= minInt) goto endI7_PA34;
begI7_PA34://         {
                         minInt = oneInt;
endI7_PA34://         }
                    //if ( (oneInt & 1) != 0 )
                      if ( (oneInt & 1) == 0 ) goto else8_PA34;
begI8_PA34://         {
                         *hopPtr3 = oneInt;
                         ++(*used3Ptr);
                         ++hopPtr3;
                      goto endI8_PA34;
//                    }
else8_PA34://         else
//                    {
                         *hopPtr4 = oneInt;
                         ++(*used4Ptr);
                         ++hopPtr4;
endI8_PA34://         }
                      ++hopPtr1;
//                 }
WTest4_PA34:
                   if (hopPtr1 < endPtr1) goto begW4_PA34;

                   goto WTest5_PA34;
                 //while (hopPtr2 < endPtr2)
begW5_PA34://      {
                      oneInt = *hopPtr2;
                    //if (oneInt < minInt)
                      if (oneInt >= minInt) goto endI9_PA34;
begI9_PA34://         {
                         minInt = oneInt;
endI9_PA34://         }
                    //if ( (oneInt & 1) != 0 )
                      if ( (oneInt & 1) == 0 ) goto else10_PA34;
begI10_PA34://        {
                         *hopPtr3 = oneInt;
                         ++(*used3Ptr);
                         ++hopPtr3;
                      goto endI10_PA34;
//                    }
else10_PA34://        else
//                    {
                         *hopPtr4 = oneInt;
                         ++(*used4Ptr);
                         ++hopPtr4;
endI10_PA34://        }
                      ++hopPtr2;
//                 }
WTest5_PA34:
                   if (hopPtr2 < endPtr2) goto begW5_PA34;

                   return minInt;
}


void InsertSortedND(int intArr[], int* usedPtr, int oneInt)
{
                   int* probePtr;
                   probePtr = intArr + (*usedPtr);
                   goto FTest_ISND;
                 //for (probePtr = intArr + (*usedPtr); probePtr > intArr; --probePtr)
begF_ISND://       {
                    //if ( *(probePtr - 1) <= oneInt ) break;
                      if ( *(probePtr - 1) <= oneInt ) goto brkI_ISND;
                      *probePtr = *(probePtr - 1);
                   --probePtr;
//                 }
FTest_ISND:
                   if (probePtr > intArr) goto begF_ISND;
brkI_ISND:
                   *probePtr = oneInt;
                   *usedPtr = *usedPtr + 1;
}

void ProcArraysA(int a1[], int a2[], int a3[], int a4[],
                 int* used1Ptr, int* used2Ptr, int used3, int used4)
{
                   *used1Ptr = 0;
                   *used2Ptr = 0;
                   int* hopPtr = a3;
                   int* endPtr = a3 + used3;

                   goto WTest1_PAA;
                 //while (hopPtr < endPtr)
begW1_PAA:       //{
                      InsertSortedND(a1, used1Ptr, *hopPtr);
                      ++hopPtr;
//                 }
WTest1_PAA:
                   if (hopPtr < endPtr) goto begW1_PAA;

                   hopPtr = a4;
                   endPtr = a4 + used4;
                   goto WTest2_PAA;
                 //while (hopPtr < endPtr)
begW2_PAA:       //{
                      InsertSortedND(a2, used2Ptr, *hopPtr);
                      ++hopPtr;
//                 }
WTest2_PAA:
                   if (hopPtr < endPtr) goto begW2_PAA;
}

void ProcArraysB(int minInt, int a1[], int a2[], int a3[], int a4[],
                 int used1, int used2, int* used3Ptr, int* used4Ptr)
{
                   *used3Ptr = 0;
                   *used4Ptr = 0;
                 //if ( (minInt & 1) != 0)
                   if ( (minInt & 1) == 0) goto else_PAB;
begI_PAB://        {
                      MergeCopy12(a3, a1, a2, used1, used2);
                      *used3Ptr = used1 + used2;
                   goto endI_PAB;
//                 }
else_PAB://        else
//                 {
                      MergeCopy12(a4, a1, a2, used1, used2);
                      *used4Ptr = used1 + used2;
endI_PAB://        }
                   return;
}

void MergeCopy12(int intArr[], int a1[], int a2[], int used1, int used2)
{
                   int *hopPtr,
                       *hopPtr1,
                       *hopPtr2,
                       *endPtr1,
                       *endPtr2;
                   hopPtr = intArr;
                   hopPtr1 = a1;
                   hopPtr2 = a2;
                   endPtr1 = a1 + used1;
                   endPtr2 = a2 + used2;

                   goto WTest1_MC12;
                 //while (hopPtr1 < endPtr1 && hopPtr2 < endPtr2)
begW1_MC12://      {
                    //if (*hopPtr1 < *hopPtr2)
                      if (*hopPtr1 >= *hopPtr2) goto else_MC12;
begI_MC12://          {
                         *hopPtr = *hopPtr1;
                         ++hopPtr1;
                      goto endI_MC12;
//                    }
else_MC12://          else
//                    {
                         *hopPtr = *hopPtr2;
                         ++hopPtr2;
endI_MC12://          }
                      ++hopPtr;
//                 }
WTest1_MC12:
               ////if (hopPtr1 < endPtr1 && hopPtr2 < endPtr2) goto begW1_MC12;
                   if (hopPtr1 >= endPtr1) goto xitW1_MC12;
                   if (hopPtr2 < endPtr2) goto begW1_MC12;
xitW1_MC12:

                   goto WTest2_MC12;
                 //while (hopPtr1 < endPtr1)
begW2_MC12://      {
                      *hopPtr = *hopPtr1;
                      ++hopPtr1;
                      ++hopPtr;
//                 }
WTest2_MC12:
                   if (hopPtr1 < endPtr1) goto begW2_MC12;

                   goto WTest3_MC12;
                 //while (hopPtr2 < endPtr2)
begW3_MC12://      {
                      *hopPtr = *hopPtr2;
                      ++hopPtr2;
                      ++hopPtr;
//                 }
WTest3_MC12:
                   if (hopPtr2 < endPtr2) goto begW3_MC12;
}

void CoutCstr(const char cstr[])
{
                   cout << cstr;
}

void CoutCstrNL(const char cstr[])
{
                   CoutCstr(cstr);
                   cout << '\n';
}

void CoutOneInt(int oneInt)
{
                   cout << oneInt;
}

void ShowArray(const int array[], int used)
{
                   int i;
                   i = 0;
                   goto FTest_SA;
begF_SA:
                      cout << array[i] << ' ' << ' ';
                   ++i;
FTest_SA:
                   if (i < used) goto begF_SA;

                   cout << endl;
}

void ShowArrayLabeled(const int array[], int used, const char label[])
{
                   CoutCstr(label);
                   ShowArray(array, used);
}
