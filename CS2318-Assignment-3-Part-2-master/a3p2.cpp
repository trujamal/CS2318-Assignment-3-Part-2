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
                   char dacStr[]   = "Do another case? (n or N = no, others = yes) ";
                   char dlStr[]    = "================================";
                   char byeStr[]   = "bye...";

                   do
                   {
                      PopulateArray12(12, a1, a2, &used1, &used2);
                      cout << endl;
                      ShowArrayLabeled(a1, used1, begA1Str);
                      ShowArrayLabeled(a2, used2, comA2Str);
                      if (used1 > 0 || used2 > 0)
                      {
                         minInt = PopulateArray34(a1, a2, a3, a4, used1, used2, &used3, &used4);
                      }
                      else
                      {
                         used3 = 0;
                         used4 = 0;
                      }
                      ShowArrayLabeled(a3, used3, comA3Str);
                      ShowArrayLabeled(a4, used4, comA4Str);
                      if (used1 > 0 || used2 > 0)
                      {
                         ProcArraysA(a1, a2, a3, a4,
                                     &used1, &used2, used3, used4);
                         ShowArrayLabeled(a1, used1, cpaA1Str);
                         ShowArrayLabeled(a2, used2, comA2Str);
                         ShowArrayLabeled(a3, used3, comA3Str);
                         ShowArrayLabeled(a4, used4, comA4Str);
                         ProcArraysB(minInt, a1, a2, a3, a4,
                                     used1, used2, &used3, &used4);
                      }
                      ShowArrayLabeled(a1, used1, proA1Str);
                      ShowArrayLabeled(a2, used2, comA2Str);
                      ShowArrayLabeled(a3, used3, comA3Str);
                      ShowArrayLabeled(a4, used4, comA4Str);
                      cout << endl;
                      cout << dacStr;
                      cin >> reply;
                      cout << endl;
                   }
                   while (reply != 'n' && reply != 'N');

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
                   while (reply != 'y' && reply != 'Y')
                   {
                      ++intNum;
                      CoutCstr(einStr);
                      CoutOneInt(intNum);
                      cout << ':' << ' ';
                      cin >> oneInt;
                      if (intNum & 1)
                      {
                         a1[*used1Ptr] = oneInt;
                         ++(*used1Ptr);
                      }
                      else
                      {
                         a2[*used2Ptr] = oneInt;
                         ++(*used2Ptr);
                      }
                      if (intNum == cap)
                      {
                         CoutCstr(moStr);
                         CoutOneInt(cap);
                         CoutCstr(ieStr);
                         cout << endl;
                         reply = 'y';
                      }
                      else
                      {
                         CoutCstr(eaiStr);
                         cin >> reply;
                      }
                   }
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
                   if (used1 > 0)
                   {
                      minInt = *hopPtr1;
                   }
                   else
                   {
                      minInt = *hopPtr2;
                   }
                   while (hopPtr1 < endPtr1 && hopPtr2 < endPtr2)
                   {
                      while (hopPtr1 < endPtr1)
                      {
                         oneInt = *hopPtr1;
                         if (oneInt < minInt)
                         {
                            minInt = oneInt;
                         }
                         if ( (oneInt & 1) == 0 ) break;
                         *hopPtr3 = oneInt;
                         ++(*used3Ptr);
                         ++hopPtr1;
                         ++hopPtr3;
                      }
                      while (hopPtr2 < endPtr2)
                      {
                         oneInt = *hopPtr2;
                         if (oneInt < minInt)
                         {
                            minInt = oneInt;
                         }
                         if ( (oneInt & 1) != 0 ) break;
                         *hopPtr4 = oneInt;
                         ++(*used4Ptr);
                         ++hopPtr2;
                         ++hopPtr4;
                      }
                      if (hopPtr1 < endPtr1 && hopPtr2 < endPtr2)
                      {
                         *hopPtr3 = *hopPtr2;
                         *hopPtr4 = *hopPtr1;
                         ++(*used3Ptr);
                         ++(*used4Ptr);
                         ++hopPtr1;
                         ++hopPtr2;
                         ++hopPtr3;
                         ++hopPtr4;
                      }
                   }
                   while (hopPtr1 < endPtr1)
                   {
                      oneInt = *hopPtr1;
                      if (oneInt < minInt)
                      {
                         minInt = oneInt;
                      }
                      if ( (oneInt & 1) != 0 )
                      {
                         *hopPtr3 = oneInt;
                         ++(*used3Ptr);
                         ++hopPtr3;
                      }
                      else
                      {
                         *hopPtr4 = oneInt;
                         ++(*used4Ptr);
                         ++hopPtr4;
                      }
                      ++hopPtr1;
                   }
                   while (hopPtr2 < endPtr2)
                   {
                      oneInt = *hopPtr2;
                      if (oneInt < minInt)
                      {
                         minInt = oneInt;
                      }
                      if ( (oneInt & 1) != 0 )
                      {
                         *hopPtr3 = oneInt;
                         ++(*used3Ptr);
                         ++hopPtr3;
                      }
                      else
                      {
                         *hopPtr4 = oneInt;
                         ++(*used4Ptr);
                         ++hopPtr4;
                      }
                      ++hopPtr2;
                   }
                   return minInt;
}


void InsertSortedND(int intArr[], int* usedPtr, int oneInt)
{
   int* probePtr;
   for (probePtr = intArr + (*usedPtr); probePtr > intArr; --probePtr)
   {
      if ( *(probePtr - 1) <= oneInt ) break;
      *probePtr = *(probePtr - 1);
   }
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
                   while (hopPtr < endPtr)
                   {
                      InsertSortedND(a1, used1Ptr, *hopPtr);
                      ++hopPtr;
                   }
                   hopPtr = a4;
                   endPtr = a4 + used4;
                   while (hopPtr < endPtr)
                   {
                      InsertSortedND(a2, used2Ptr, *hopPtr);
                      ++hopPtr;
                   }
}

void ProcArraysB(int minInt, int a1[], int a2[], int a3[], int a4[],
                 int used1, int used2, int* used3Ptr, int* used4Ptr)
{
                   *used3Ptr = 0;
                   *used4Ptr = 0;
                   if ( (minInt & 1) != 0)
                   {
                      MergeCopy12(a3, a1, a2, used1, used2);
                      *used3Ptr = used1 + used2;
                   }
                   else
                   {
                      MergeCopy12(a4, a1, a2, used1, used2);
                      *used4Ptr = used1 + used2;
                   }
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
                   while (hopPtr1 < endPtr1 && hopPtr2 < endPtr2)
                   {
                      if (*hopPtr1 < *hopPtr2)
                      {
                         *hopPtr = *hopPtr1;
                         ++hopPtr1;
                      }
                      else
                      {
                         *hopPtr = *hopPtr2;
                         ++hopPtr2;
                      }
                      ++hopPtr;
                   }
                   while (hopPtr1 < endPtr1)
                   {
                      *hopPtr = *hopPtr1;
                      ++hopPtr1;
                      ++hopPtr;
                   }
                   while (hopPtr2 < endPtr2)
                   {
                      *hopPtr = *hopPtr2;
                      ++hopPtr2;
                      ++hopPtr;
                   }
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
                   for (i = 0; i < used; ++i)
                   {
                      cout << array[i] << ' ' << ' ';
                   }
                   cout << endl;
}

void ShowArrayLabeled(const int array[], int used, const char label[])
{
                   CoutCstr(label);
                   ShowArray(array, used);
}
